	{
  pkgs,
  astronvim,
  ...
}:
###############################################################################
#
#  AstroNvim's configuration and all its dependencies(lsp, formatter, etc.)
#
#e#############################################################################
{
  #xdg.configFile = {
    # astronvim's config
    #"nvim".source = astronvim;

    # my custom astronvim config, astronvim will load it after base config
    # https://github.com/AstroNvim/AstroNvim/blob/v3.32.0/lua/astronvim/bootstrap.lua#L15-L16
    #"astronvim/lua/user".source = ./astronvim_user;
  #};

  nixpkgs.config = {
    programs.npm.npmrc = ''
      prefix = ''${HOME}/.npm-global
    '';
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;
      extraPackages = with pkgs; [];

      #configFile.source = ../../dotfiles/.config/nvim;

      # currently we use lazy.nvim as neovim's package manager, so comment this one.
      # plugins = with pkgs.vimPlugins; [
      #   # search all the plugins using https://search.nixos.org/packages
      # ];
    };
  };
  home = {

    file.".config/nvim" = {
      source = ../../dotfiles/.config/nvim;
      # source = /home/sultan/dotfiles/.config/nvim;
      recursive = true;
    };

    packages = with pkgs;
      [
        #-- c/c++
        cmake
        gnumake
        checkmake
        gcc # c/c++ compiler, required by nvim-treesitter!

        #-- Optional Requirements:
        gdu # disk usage analyzer, required by AstroNvim
        ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
	      verible

        fd
        go
      ];
  };
}
