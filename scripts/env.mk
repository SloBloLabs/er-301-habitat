include scripts/utils.mk

SDKPATH ?= er-301

PROFILE ?= testing

ifndef ARCH
  SYSTEM_NAME := $(shell uname -s)
  ifeq ($(SYSTEM_NAME),Linux)
    ARCH = linux
  else ifeq ($(SYSTEM_NAME),Darwin)
    ARCH = darwin
  else
    $(error Unsupported system $(SYSTEM_NAME))
  endif
endif

ifeq ($(ARCH),am335x)
  ifeq ($(shell uname -s),Darwin)
    HOMEBREW_PREFIX := $(shell if [ -d /opt/homebrew ]; then echo /opt/homebrew; else echo /usr/local; fi)
    TI_INSTALL_DIR ?= $(HOMEBREW_PREFIX)
  else
    TI_INSTALL_DIR ?= $(HOME)/ti
  endif
  include $(SDKPATH)/scripts/am335x.mk
endif

ifeq ($(ARCH),linux)
  include $(SDKPATH)/scripts/linux.mk
endif

ifeq ($(ARCH),darwin)
  include $(SDKPATH)/scripts/darwin.mk
endif
