{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          pythonPackages = pkgs.python310Packages;

          recolorPackage = pythonPackages.buildPythonPackage {
            src = ./.;
            version = "1.0";
            pname = "recolor";

            propagatedBuildInputs = with pythonPackages; [
              colormath
              tqdm
              pillow
            ];

          };

        in

        {
          # This generates a overlay
          # You should consume this in your flake if you want recolor.
          overlayAttrs = {
            inherit (config.packages) recolor;
          };
          packages.recolor = recolorPackage;

        };
    };
}

