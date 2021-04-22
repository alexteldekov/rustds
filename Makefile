.PHONY: all playbook

all: playbook

playbook:
	ansible-playbook -i hosts install/rustds.yml -K
