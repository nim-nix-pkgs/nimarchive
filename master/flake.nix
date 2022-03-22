{
  description = ''libarchive wrapper for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimarchive-master.flake = false;
  inputs.src-nimarchive-master.owner = "genotrance";
  inputs.src-nimarchive-master.ref   = "master";
  inputs.src-nimarchive-master.repo  = "nimarchive";
  inputs.src-nimarchive-master.type  = "github";
  
  inputs."nimterop".owner = "nim-nix-pkgs";
  inputs."nimterop".ref   = "master";
  inputs."nimterop".repo  = "nimterop";
  inputs."nimterop".dir   = "v0_6_13";
  inputs."nimterop".type  = "github";
  inputs."nimterop".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimterop".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimarchive-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimarchive-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}