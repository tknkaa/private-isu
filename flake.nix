{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      packages.${system} = {
        hello = pkgs.hello;
        default = self.packages.${system}.hello;
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.apacheHttpd
          pkgs.percona-toolkit
          pkgs.sysstat
          pkgs.k6
        ];
      };

    };
}
