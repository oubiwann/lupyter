IPY_CFG_DIR = ~/.ipython
IPY_KERN_DIR = $(IPY_CFG_DIR)/kernels
LUPY_DIR = $(IPY_KERN_DIR)/lupyter
LUPY = ipython-lfe
LUPY_FULL = $(LUPY_DIR)/$(LUPY)
LUPY_JSON = $(LUPY_DIR)/kernel.json
LUPY_VENV = ./.venv-lupy

setup: $(LUPY_DIR) $(LUPY_FULL) $(LFETOOL) $(REBAR) $(LUPY_VENV)

$(LUPY_DIR):
	mkdir -p $(LUPY_DIR)

$(LUPY_FULL):
	cp bin/$(LUPY) $(LUPY_FULL)

$(LUPY_JSON):
	sed 's|HOME|'${HOME}'|' resources/kernel.json > $(LUPY_JSON)

venv:
	-sudo pip install virtualenv

$(LUPY_VENV): venv
	virtualenv $(LUPY_VENV)

console:
	$(LUPY_VENV)/bin/activate && \
	jupyter-console --kernel=lfe

notebook:
	$(LUPY_VENV)/bin/activate && \
	jupyter-notebook --kernel=lfe
