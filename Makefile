#!/usr/bin/make -f

# Adjust according to the number CPU cores to use for parallel build.
# Default: Number of processors in /proc/cpuinfo, if present, or 1.
NR_CPU := $(shell [ -f /proc/cpuinfo ] && grep -c '^processor\s*:' /proc/cpuinfo || echo 1)
BB_NUMBER_THREADS ?= $(NR_CPU)
PARALLEL_MAKE ?= -j $(NR_CPU)

XSUM ?= md5sum

BUILD_DIR = $(CURDIR)/builds/$(DISTRO)/$(MACHINE)
TOPDIR = $(BUILD_DIR)
DL_DIR = $(CURDIR)/sources
SSTATE_DIR = $(CURDIR)/builds/$(DISTRO)/sstate-cache
TMPDIR = $(TOPDIR)/tmp
DEPDIR = $(TOPDIR)/.deps
MACHINEBUILD = $(MACHINE)
export MACHINEBUILD

ifeq ($(MACHINEBUILD),tm2t)
brands=dags
else ifeq ($(MACHINEBUILD),tmnano)
brands=dags
else ifeq ($(MACHINEBUILD),tmnano2t)
brands=dags
else ifeq ($(MACHINEBUILD),tmsingle)
brands=dags
else ifeq ($(MACHINEBUILD),tmtwin)
brands=dags
else ifeq ($(MACHINEBUILD),iqonios100hd)
brands=dags
else ifeq ($(MACHINEBUILD),iqonios200hd)
brands=dags
else ifeq ($(MACHINEBUILD),roxxs200hd)
brands=dags
else ifeq ($(MACHINEBUILD),mediaart200hd)
brands=dags
else ifeq ($(MACHINEBUILD),iqonios300hd)
brands=dags
else ifeq ($(MACHINEBUILD),force1)
brands=dags
else ifeq ($(MACHINEBUILD),optimussos1plus)
brands=dags
else ifeq ($(MACHINEBUILD),optimussos2plus)
brands=dags
else ifeq ($(MACHINEBUILD),optimussos3plus)
brands=dags
else ifeq ($(MACHINEBUILD),optimussos1)
brands=dags
else ifeq ($(MACHINEBUILD),optimussos2)
brands=dags
else ifeq ($(MACHINEBUILD),mediabox)
brands=dags 
else ifeq ($(MACHINEBUILD),quadbox2400)
brands=skylake 
else ifeq ($(MACHINEBUILD),mutant2400)
brands=skylake
else ifeq ($(MACHINEBUILD),classm)
brands=odin
else ifeq ($(MACHINEBUILD),axodin)
brands=odin
else ifeq ($(MACHINEBUILD),caxodin)
brands=odin
else ifeq ($(MACHINEBUILD),saxodin)
brands=odin
else ifeq ($(MACHINEBUILD),axodinc)
brands=odin
else ifeq ($(MACHINEBUILD),starsatlx)
brands=odin
else ifeq ($(MACHINEBUILD),genius)
brands=odin
else ifeq ($(MACHINEBUILD),evo)
brands=odin
else ifeq ($(MACHINEBUILD),geniuse3hd)
brands=odin
else ifeq ($(MACHINEBUILD),evoe3hd)
brands=odin
else ifeq ($(MACHINEBUILD),axase3)
brands=odin
else ifeq ($(MACHINEBUILD),axase3c)
brands=odin
else ifeq ($(MACHINEBUILD),maram9)
brands=odin
else ifeq ($(MACHINEBUILD),ventonhdx)
brands=ini
else ifeq ($(MACHINEBUILD),sezam5000hd)
brands=ini
else ifeq ($(MACHINEBUILD),beyonwizt3)
brands=ini
else ifeq ($(MACHINEBUILD),sezam1000hd)
brands=ini
else ifeq ($(MACHINEBUILD),sezammarvel)
brands=ini
else ifeq ($(MACHINEBUILD),xpeedlx)
brands=ini
else ifeq ($(MACHINEBUILD),xpeedlx3)
brands=ini
else ifeq ($(MACHINEBUILD),mbmini)
brands=ini
else ifeq ($(MACHINEBUILD),atemio5x00)
brands=ini
else ifeq ($(MACHINEBUILD),atemio6000)
brands=ini
else ifeq ($(MACHINEBUILD),atemio6100)
brands=ini
else ifeq ($(MACHINEBUILD),atemio6200)
brands=ini
else ifeq ($(MACHINEBUILD),atemionemesis)
brands=ini
else ifeq ($(MACHINEBUILD),mbtwin)
brands=ini
else ifeq ($(MACHINEBUILD),dcube)
brands=cube
else ifeq ($(MACHINEBUILD),mkcube)
brands=cube
else ifeq ($(MACHINEBUILD),ultima)
brands=cube
else ifeq ($(MACHINEBUILD),xp1000mk)
brands=xp
else ifeq ($(MACHINEBUILD),xp1000max)
brands=xp
else ifeq ($(MACHINEBUILD),sf8)
brands=xp
else ifeq ($(MACHINEBUILD),xp1000plus)
brands=xp
else ifeq ($(MACHINEBUILD),sogno8800hd)
brands=blackbox
else ifeq ($(MACHINEBUILD),uniboxhde)
brands=blackbox
else ifeq ($(MACHINEBUILD),enfinity)
brands=entwopia
else ifeq ($(MACHINEBUILD),marvel1)
brands=entwopia
else ifeq ($(MACHINEBUILD),vuduo)
brands=vuplus
else ifeq ($(MACHINEBUILD),vuduo2)
brands=vuplus
else ifeq ($(MACHINEBUILD),vuuno)
brands=vuplus
else ifeq ($(MACHINEBUILD),vusolo2)
brands=vuplus
else ifeq ($(MACHINEBUILD),vusolo)
brands=vuplus
else ifeq ($(MACHINEBUILD),vuultimo)
brands=vuplus
else ifeq ($(MACHINEBUILD),vuzero)
brands=vuplus
else ifeq ($(MACHINEBUILD),vusolose)
brands=vuplus
else ifeq ($(MACHINEBUILD),vusolo4k)
brands=vuplus
else ifeq ($(MACHINEBUILD),gb800se)
brands=gigablue
else ifeq ($(MACHINEBUILD),gb800seplus)
brands=gigablue
else ifeq ($(MACHINEBUILD),gbipbox)
brands=gigablue
else ifeq ($(MACHINEBUILD),gb800solo)
brands=gigablue
else ifeq ($(MACHINEBUILD),gb800ue)
brands=gigablue
else ifeq ($(MACHINEBUILD),gb800ueplus)
brands=gigablue
else ifeq ($(MACHINEBUILD),gbquad)
brands=gigablue
else ifeq ($(MACHINEBUILD),gbquadplus)
brands=gigablue
else ifeq ($(MACHINEBUILD),dm800)
brands=dream
else ifeq ($(MACHINEBUILD),dm7020hd)
brands=dream
else ifeq ($(MACHINEBUILD),dm7080)
brands=dream
else ifeq ($(MACHINEBUILD),formuler1)
brands=formuler
else ifeq ($(MACHINEBUILD),formuler3)
brands=formuler
else ifeq ($(MACHINEBUILD),et4x00)
brands=xtrend
else ifeq ($(MACHINEBUILD),bre2ze)
brands=entwopia
else ifeq ($(MACHINEBUILD),sparktriplex)
brands=fulan
else ifeq ($(MACHINEBUILD),sparkreloaded)
brands=fulan
else ifeq ($(MACHINEBUILD),sparkone)
brands=fulan
else ifeq ($(MACHINEBUILD),arguspingulux)
brands=fulan
else ifeq ($(MACHINEBUILD),twinboxlcd)
brands=ceryon
else ifeq ($(MACHINEBUILD),sf208)
brands=ceryon
else ifeq ($(MACHINEBUILD),sf228)
brands=ceryon
else ifeq ($(MACHINEBUILD),odin2hybrid)
brands=ceryon
else ifeq ($(MACHINEBUILD),odinplus)
brands=ceryon
else ifeq ($(MACHINEBUILD),opticumtt)
brands=ini
else ifeq ($(MACHINEBUILD),xpeedlxcs2)
brands=ultramini
else ifeq ($(MACHINEBUILD),xpeedlxcc)
brands=ultramini
else ifeq ($(MACHINEBUILD),xpeedlxpro)
brands=ini
else ifeq ($(MACHINEBUILD),osmini)
brands=xcore
else ifeq ($(MACHINEBUILD),osminiplus)
brands=xcore
else ifeq ($(MACHINEBUILD),triplex)
brands=ax
else ifeq ($(MACHINEBUILD),spycat)
brands=xcore
else ifeq ($(MACHINEBUILD),spycatmini)
brands=xcore
else ifeq ($(MACHINEBUILD),e4hd)
brands=ceryon
else ifeq ($(MACHINEBUILD),sf3038)
brands=broadmedia
else ifeq ($(MACHINEBUILD),sf108)
brands=tripledot
else ifeq ($(MACHINEBUILD),sf98)
brands=tripledot
else ifeq ($(MACHINEBUILD),mutant51)
brands=gfutures
else ifeq ($(MACHINEBUILD),ax51)
brands=gfutures
endif

BBLAYERS ?= \
	$(CURDIR)/meta-openembedded/meta-oe \
	$(CURDIR)/meta-openembedded/meta-multimedia \
	$(CURDIR)/meta-openembedded/meta-networking \
	$(CURDIR)/meta-openembedded/meta-filesystems \
	$(CURDIR)/meta-openembedded/meta-python \
	$(CURDIR)/openembedded-core/meta \
	$(CURDIR)/meta-oe-alliance/meta-oe \
	$(CURDIR)/meta-local \
	$(CURDIR)/meta-oe-alliance/meta-brands/meta-$(brands) \

CONFFILES = \
	$(TOPDIR)/env.source \
	$(TOPDIR)/conf/$(DISTRO).conf \
	$(TOPDIR)/conf/bblayers.conf \
	$(TOPDIR)/conf/local.conf \
	$(TOPDIR)/conf/site.conf

CONFDEPS = \
	$(DEPDIR)/.env.source.$(BITBAKE_ENV_HASH) \
	$(DEPDIR)/.$(DISTRO).conf.$($(DISTRO)_CONF_HASH) \
	$(DEPDIR)/.bblayers.conf.$(BBLAYERS_CONF_HASH) \
	$(DEPDIR)/.local.conf.$(LOCAL_CONF_HASH)

GIT ?= git
GIT_REMOTE := $(shell $(GIT) remote)
GIT_USER_NAME := $(shell $(GIT) config user.name)
GIT_USER_EMAIL := $(shell $(GIT) config user.email)

hash = $(shell echo $(1) | $(XSUM) | awk '{print $$1}')

.DEFAULT_GOAL := all
all: init
	@echo
	@echo "Openembedded for the oe-alliance environment has been initialized"
	@echo "properly. Now you can start building your image, by doing either:"
	@echo
	@echo "MACHINE=xpeedlx DISTRO=opennfr make image"
	@echo "	or"
	@echo "cd $(BUILD_DIR) ; source env.source ; bitbake $(DISTRO)-image"
	@echo

$(BBLAYERS):
	[ -d $@ ] || $(MAKE) $(MFLAGS) update

setupmbuild:
ifeq ($(MACHINEBUILD),tm2t)
MACHINE=dags1
MACHINEBUILD=tm2t
else ifeq ($(MACHINEBUILD),tmnano)
MACHINE=dags1
MACHINEBUILD=tmnano
else ifeq ($(MACHINEBUILD),tmnano2t)
MACHINE=dags1
MACHINEBUILD=tmnano2t
else ifeq ($(MACHINEBUILD),tmsingle)
MACHINE=dags1
MACHINEBUILD=tmsingle
else ifeq ($(MACHINEBUILD),tmtwin)
MACHINE=dags1
MACHINEBUILD=tmtwin
else ifeq ($(MACHINEBUILD),iqonios100hd)
MACHINE=dags1
MACHINEBUILD=iqonios100hd
else ifeq ($(MACHINEBUILD),iqonios200hd)
MACHINE=dags2
MACHINEBUILD=iqonios200hd
else ifeq ($(MACHINEBUILD),roxxs200hd)
MACHINE=dags2
MACHINEBUILD=roxxs200hd
else ifeq ($(MACHINEBUILD),mediaart200hd)
MACHINE=dags2
MACHINEBUILD=mediaart200hd
else ifeq ($(MACHINEBUILD),iqonios300hd)
MACHINE=dags7335
MACHINEBUILD=iqonios300hd
else ifeq ($(MACHINEBUILD),force1)
MACHINE=dags7356
MACHINEBUILD=force1
else ifeq ($(MACHINEBUILD),optimussos1plus)
MACHINE=dags7356
MACHINEBUILD=optimussos1plus
else ifeq ($(MACHINEBUILD),optimussos2plus)
MACHINE=dags7356
MACHINEBUILD=optimussos2plus
else ifeq ($(MACHINEBUILD),optimussos3plus)
MACHINE=dags7356
MACHINEBUILD=optimussos3plus
else ifeq ($(MACHINEBUILD),optimussos1)
MACHINE=dags7335
MACHINEBUILD=optimussos1
else ifeq ($(MACHINEBUILD),optimussos2)
MACHINE=dags7335
MACHINEBUILD=optimussos2
else ifeq ($(MACHINEBUILD),mediabox)
MACHINE=dags1
MACHINEBUILD=mediabox
else ifeq ($(MACHINEBUILD),quadbox2400)
MACHINE=hd2400
MACHINEBUILD=quadbox2400
else ifeq ($(MACHINEBUILD),mutant2400)
MACHINE=hd2400
MACHINEBUILD=mutant2400
else ifeq ($(MACHINEBUILD),classm)
MACHINE=odinm7
MACHINEBUILD=classm
else ifeq ($(MACHINEBUILD),saxodin)
MACHINE=odinm7
MACHINEBUILD=axodin
else ifeq ($(MACHINEBUILD),caxodin)
MACHINE=odinm7
MACHINEBUILD=axodin
else ifeq ($(MACHINEBUILD),axodin)
MACHINE=odinm7
MACHINEBUILD=axodin
else ifeq ($(MACHINEBUILD),axodinc)
MACHINE=odinm7
MACHINEBUILD=axodinc
else ifeq ($(MACHINEBUILD),starsatlx)
MACHINE=odinm7
MACHINEBUILD=starsatlx
else ifeq ($(MACHINEBUILD),genius)
MACHINE=odinm7
MACHINEBUILD=genius
else ifeq ($(MACHINEBUILD),evo)
MACHINE=odinm7
MACHINEBUILD=evo
else ifeq ($(MACHINEBUILD),geniuse3hd)
MACHINE=e3hd
MACHINEBUILD=geniuse3hd
else ifeq ($(MACHINEBUILD),evoe3hd)
MACHINE=e3hd
MACHINEBUILD=evoe3hd
else ifeq ($(MACHINEBUILD),axase3)
MACHINE=e3hd
MACHINEBUILD=axase3
else ifeq ($(MACHINEBUILD),axase3c)
MACHINE=e3hd
MACHINEBUILD=axase3c
else ifeq ($(MACHINEBUILD),maram9)
MACHINE=odinm9
MACHINEBUILD=maram9
else ifeq ($(MACHINEBUILD),ventonhdx)
MACHINE=inihdx
MACHINEBUILD=ventonhdx
else ifeq ($(MACHINEBUILD),sezam5000hd)
MACHINE=inihdx
MACHINEBUILD=sezam5000hd
else ifeq ($(MACHINEBUILD),beyonwizt3)
MACHINE=inihdx
MACHINEBUILD=beyonwizt3
else ifeq ($(MACHINEBUILD),sezam1000hd)
MACHINE=inihde
MACHINEBUILD=sezam1000hd
else ifeq ($(MACHINEBUILD),sezammarvel)
MACHINE=inihdp
MACHINEBUILD=sezammarvel
else ifeq ($(MACHINEBUILD),xpeedlx)
MACHINE=inihde
MACHINEBUILD=xpeedlx
else ifeq ($(MACHINEBUILD),xpeedlx3)
MACHINE=inihdp
MACHINEBUILD=xpeedlx3
else ifeq ($(MACHINEBUILD),mbmini)
MACHINE=inihde
MACHINEBUILD=mbmini
else ifeq ($(MACHINEBUILD),atemio5x00)
MACHINE=inihde
MACHINEBUILD=atemio5x00
else ifeq ($(MACHINEBUILD),atemio6000)
MACHINE=inihde2
MACHINEBUILD=atemio6000
else ifeq ($(MACHINEBUILD),atemio6100)
MACHINE=inihde2
MACHINEBUILD=atemio6100
else ifeq ($(MACHINEBUILD),atemio6200)
MACHINE=inihde2
MACHINEBUILD=atemio6200
else ifeq ($(MACHINEBUILD),atemionemesis)
MACHINE=inihdp
MACHINEBUILD=atemionemesis
else ifeq ($(MACHINEBUILD),mbtwin)
MACHINE=inihdx
MACHINEBUILD=mbtwin
else ifeq ($(MACHINEBUILD),mixosf5)
MACHINE=ebox5000
MACHINEBUILD=mixosf5
else ifeq ($(MACHINEBUILD),gi9196m)
MACHINE=ebox5000
MACHINEBUILD=gi9196m
else ifeq ($(MACHINEBUILD),mixosf5mini)
MACHINE=ebox5100
MACHINEBUILD=mixosf5mini
else ifeq ($(MACHINEBUILD),gi9196lite)
MACHINE=ebox5100
MACHINEBUILD=gi9196lite
else ifeq ($(MACHINEBUILD),mixosf7)
MACHINE=ebox7358
MACHINEBUILD=mixosf7
else ifeq ($(MACHINEBUILD),mixoslumi)
MACHINE=eboxlumi
MACHINEBUILD=mixoslumi
else ifeq ($(MACHINEBUILD),dcube)
MACHINE=cube
MACHINEBUILD=dcube
else ifeq ($(MACHINEBUILD),mkcube)
MACHINE=cube
MACHINEBUILD=mkcube
else ifeq ($(MACHINEBUILD),ultima)
MACHINE=cube
MACHINEBUILD=ultima
else ifeq ($(MACHINEBUILD),xp1000mk)
MACHINE=xp1000
MACHINEBUILD=xp1000mk
else ifeq ($(MACHINEBUILD),xp1000max)
MACHINE=xp1000
MACHINEBUILD=xp1000max
else ifeq ($(MACHINEBUILD),sf8)
MACHINE=xp1000
MACHINEBUILD=sf8
else ifeq ($(MACHINEBUILD),xp1000plus)
MACHINE=xp1000
MACHINEBUILD=xp1000plus
else ifeq ($(MACHINEBUILD),sogno8800hd)
MACHINE=blackbox7405
MACHINEBUILD=sogno8800hd
else ifeq ($(MACHINEBUILD),uniboxhde)
MACHINE=blackbox7405
MACHINEBUILD=uniboxhde
else ifeq ($(MACHINEBUILD),enfinity)
MACHINE=ew7358
MACHINEBUILD=enfinity
else ifeq ($(MACHINEBUILD),marvel1)
MACHINE=ew7358
MACHINEBUILD=marvel1
else ifeq ($(MACHINEBUILD),bre2ze)
MACHINE=ew7362
MACHINEBUILD=bre2ze
else ifeq ($(MACHINEBUILD),amiko8900)
MACHINE=spark
MACHINEBUILD=amiko8900
else ifeq ($(MACHINEBUILD),sognorevolution)
MACHINE=spark
MACHINEBUILD=sognorevolution
else ifeq ($(MACHINEBUILD),arguspingulux)
MACHINE=spark
MACHINEBUILD=arguspingulux
else ifeq ($(MACHINEBUILD),arguspinguluxmini)
MACHINE=spark
MACHINEBUILD=arguspinguluxmini
else ifeq ($(MACHINEBUILD),arguspinguluxplus)
MACHINE=spark
MACHINEBUILD=arguspinguluxplus
else ifeq ($(MACHINEBUILD),sparkreloaded)
MACHINE=spark
MACHINEBUILD=sparkreloaded
else ifeq ($(MACHINEBUILD),fulanspark1)
MACHINE=spark
MACHINEBUILD=fulanspark1
else ifeq ($(MACHINEBUILD),sabsolo)
MACHINE=spark
MACHINEBUILD=sabsolo
else ifeq ($(MACHINEBUILD),sparklx)
MACHINE=spark
MACHINEBUILD=sparklx
else ifeq ($(MACHINEBUILD),gis8120)
MACHINE=spark
MACHINEBUILD=gis8120
else ifeq ($(MACHINEBUILD),amikoalien)
MACHINE=spark7162
MACHINEBUILD=amikoalien
else ifeq ($(MACHINEBUILD),sognotriple)
MACHINE=spark7162
MACHINEBUILD=sognotriple
else ifeq ($(MACHINEBUILD),sparktriplex)
MACHINE=spark7162
MACHINEBUILD=sparktriplex
else ifeq ($(MACHINEBUILD),sabtriple)
MACHINE=spark7162
MACHINEBUILD=sabtriple
else ifeq ($(MACHINEBUILD),giavatar)
MACHINE=spark7162
MACHINEBUILD=giavatar
else ifeq ($(MACHINEBUILD),sparkone)
MACHINE=spark7162
MACHINEBUILD=sparkone
else ifeq ($(MACHINEBUILD),twinboxlcd)
MACHINE=7100s
MACHINEBUILD=twinboxlcd
else ifeq ($(MACHINEBUILD),sf208)
MACHINE=7210s
MACHINEBUILD=sf208
else ifeq ($(MACHINEBUILD),sf228)
MACHINE=7210s
MACHINEBUILD=sf228
else ifeq ($(MACHINEBUILD),odin2hybrid)
MACHINE=7300s
MACHINEBUILD=odin2hybrid
else ifeq ($(MACHINEBUILD),odinplus)
MACHINE=7400s
MACHINEBUILD=odinplus
else ifeq ($(MACHINEBUILD),opticumtt)
MACHINE=inihde2
MACHINEBUILD=opticumtt
else ifeq ($(MACHINEBUILD),gb800se)
MACHINE=gb7325
MACHINEBUILD=gb800se
else ifeq ($(MACHINEBUILD),gb800ue)
MACHINE=gb7325
MACHINEBUILD=gb800ue
else ifeq ($(MACHINEBUILD),gb800seplus)
MACHINE=gb7358
MACHINEBUILD=gb800seplus
else ifeq ($(MACHINEBUILD),gb800ueplus)
MACHINE=gb7358
MACHINEBUILD=gb800ueplus
else ifeq ($(MACHINEBUILD),gbipbox)
MACHINE=gb7358
MACHINEBUILD=gbipbox
else ifeq ($(MACHINEBUILD),gbultrase)
MACHINE=gb7362
MACHINEBUILD=gbultrase
else ifeq ($(MACHINEBUILD),gbultraue)
MACHINE=gb7362
MACHINEBUILD=gbultraue
else ifeq ($(MACHINEBUILD),gbquad)
MACHINE=gb7356
MACHINEBUILD=gbquad
else ifeq ($(MACHINEBUILD),gbquadplus)
MACHINE=gb7356
MACHINEBUILD=gbquadplus
else ifeq ($(MACHINEBUILD),gbx1)
MACHINE=gb7362
MACHINEBUILD=gbx1
else ifeq ($(MACHINEBUILD),gbx3)
MACHINE=gb7362
MACHINEBUILD=gbx3
else ifeq ($(MACHINEBUILD),xpeedlxcs2)
MACHINE=ultramini
MACHINEBUILD=xpeedlxcs2
else ifeq ($(MACHINEBUILD),xpeedlxcc)
MACHINE=ultramini
MACHINEBUILD=xpeedlxcc
else ifeq ($(MACHINEBUILD),xpeedlxpro)
MACHINE=inihde2
MACHINEBUILD=xpeedlxpro
else ifeq ($(MACHINEBUILD),osmini)
MACHINE=xc7362
MACHINEBUILD=osmini
else ifeq ($(MACHINEBUILD),osminiplus)
MACHINE=xc7362
MACHINEBUILD=osminiplus
else ifeq ($(MACHINEBUILD),triplex)
MACHINE=triplex
MACHINEBUILD=triplex
else ifeq ($(MACHINEBUILD),spycat)
MACHINE=xc7362
MACHINEBUILD=spycat
else ifeq ($(MACHINEBUILD),spycatmini)
MACHINE=xc7362
MACHINEBUILD=spycatmini
else ifeq ($(MACHINEBUILD),e4hd)
MACHINE=7000s
MACHINEBUILD=e4hd
else ifeq ($(MACHINEBUILD),sf3038)
MACHINE=g300
MACHINEBUILD=sf3038
else ifeq ($(MACHINEBUILD),sf108)
MACHINE=vg5000
MACHINEBUILD=sf108
else ifeq ($(MACHINEBUILD),sf98)
MACHINE=yh7362
MACHINEBUILD=sf98
else ifeq ($(MACHINEBUILD),mutant51)
MACHINE=hd51
MACHINEBUILD=mutant51
else ifeq ($(MACHINEBUILD),ax51)
MACHINE=hd51
MACHINEBUILD=ax51
endif

initialize: init

init: setupmbuild $(BBLAYERS) $(CONFFILES)

image: init
	@. $(TOPDIR)/env.source && cd $(TOPDIR) && bitbake $(DISTRO)-image

update:
	@echo 'Updating Git repositories...'
	@HASH=`$(XSUM) $(MAKEFILE_LIST)`; \
	if [ -n "$(GIT_REMOTE)" ]; then \
		$(GIT) pull --ff-only || $(GIT) pull --rebase; \
	fi; \
	if [ "$$HASH" != "`$(XSUM) $(MAKEFILE_LIST)`" ]; then \
		echo 'Makefile changed. Restarting...'; \
		$(MAKE) $(MFLAGS) --no-print-directory $(MAKECMDGOALS); \
	else \
		$(GIT) submodule sync && \
		$(GIT) submodule update --init && \
		cd meta-oe-alliance  && \
		if [ -n "$(GIT_REMOTE)" ]; then \
			$(GIT) submodule sync && \
			$(GIT) submodule update --init; \
		fi; \
		echo "The oe-alliance is now up-to-date." ; \
		cd .. ; \
	fi

.PHONY: all image init initialize update usage machinebuild

BITBAKE_ENV_HASH := $(call hash, \
	'BITBAKE_ENV_VERSION = "0"' \
	'CURDIR = "$(CURDIR)"' \
	'MACHINEBUILD2 = "${MACHINEBUILD}"' \
	)

$(TOPDIR)/env.source: $(DEPDIR)/.env.source.$(BITBAKE_ENV_HASH)
	@echo 'Generating $@'
	@echo 'export BB_ENV_EXTRAWHITE="MACHINE DISTRO MACHINEBUILD"' > $@
	@echo 'export MACHINE' >> $@
	@echo 'export DISTRO' >> $@
	@echo 'export MACHINEBUILD' >> $@
	@echo 'export PATH=$(CURDIR)/openembedded-core/scripts:$(CURDIR)/bitbake/bin:$${PATH}' >> $@

$(DISTRO)_CONF_HASH := $(call hash, \
	'$(DISTRO)_CONF_VERSION = "1"' \
	'CURDIR = "$(CURDIR)"' \
	'BB_NUMBER_THREADS = "$(BB_NUMBER_THREADS)"' \
	'PARALLEL_MAKE = "$(PARALLEL_MAKE)"' \
	'DL_DIR = "$(DL_DIR)"' \
	'SSTATE_DIR = "$(SSTATE_DIR)"' \
	'TMPDIR = "$(TMPDIR)"' \
	)

$(TOPDIR)/conf/$(DISTRO).conf: $(DEPDIR)/.$(DISTRO).conf.$($(DISTRO)_CONF_HASH)
	@echo 'Generating $@'
	@test -d $(@D) || mkdir -p $(@D)
	@echo 'SSTATE_DIR = "$(SSTATE_DIR)"' >> $@
	@echo 'TMPDIR = "$(TMPDIR)"' >> $@
	@echo 'BB_GENERATE_MIRROR_TARBALLS = "1"' >> $@
	@echo 'BBINCLUDELOGS = "yes"' >> $@
	@echo 'CONF_VERSION = "1"' >> $@
	@echo 'EXTRA_IMAGE_FEATURES = "debug-tweaks"' >> $@
	@echo 'USER_CLASSES = "buildstats"' >> $@
	@echo '#PRSERV_HOST = "localhost:0"' >> $@


LOCAL_CONF_HASH := $(call hash, \
	'LOCAL_CONF_VERSION = "0"' \
	'CURDIR = "$(CURDIR)"' \
	'TOPDIR = "$(TOPDIR)"' \
	)

$(TOPDIR)/conf/local.conf: $(DEPDIR)/.local.conf.$(LOCAL_CONF_HASH)
	@echo 'Generating $@'
	@test -d $(@D) || mkdir -p $(@D)
	@echo 'TOPDIR = "$(TOPDIR)"' > $@
	@echo 'MACHINE = "$(MACHINE)"' >> $@
	@echo 'require $(TOPDIR)/conf/$(DISTRO).conf' >> $@

$(TOPDIR)/conf/site.conf: $(CURDIR)/site.conf
	@ln -s ../../../../site.conf $@

$(CURDIR)/site.conf:
	@echo 'SCONF_VERSION = "1"' >> $@
	@echo 'BB_NUMBER_THREADS = "$(BB_NUMBER_THREADS)"' >> $@
	@echo 'PARALLEL_MAKE = "$(PARALLEL_MAKE)"' >> $@
	@echo 'BUILD_OPTIMIZATION = "-march=native -O2 -pipe"' >> $@
	@echo 'DL_DIR = "$(DL_DIR)"' >> $@
	@echo 'INHERIT += "rm_work"' >> $@

BBLAYERS_CONF_HASH := $(call hash, \
	'BBLAYERS_CONF_VERSION = "0"' \
	'CURDIR = "$(CURDIR)"' \
	'BBLAYERS = "$(BBLAYERS)"' \
	)

$(TOPDIR)/conf/bblayers.conf: $(DEPDIR)/.bblayers.conf.$(BBLAYERS_CONF_HASH)
	@echo 'Generating $@'
	@test -d $(@D) || mkdir -p $(@D)
	@echo 'LCONF_VERSION = "4"' >> $@
	@echo 'BBFILES = ""' >> $@
	@echo 'BBLAYERS = "$(BBLAYERS)"' >> $@

$(CONFDEPS):
	@test -d $(@D) || mkdir -p $(@D)
	@$(RM) $(basename $@).*
	@touch $@  
