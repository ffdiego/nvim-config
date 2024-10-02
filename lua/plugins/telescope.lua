return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

    local is_inside_work_tree = {}

    local project_files = function()
      local cwd = vim.fn.getcwd()
      if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
      is_inside_work_tree[cwd] = vim.v.shell_error == 0
      end

      if is_inside_work_tree[cwd] then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end

		vim.keymap.set("n", "<leader>p", project_files, {})
		vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
	end,
}
