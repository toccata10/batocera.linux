################################################################################
#
# rtl8188fu
#
################################################################################

RTL8188FU_VERSION = f5df53df6e1e0f4c4d38df412ec35cd96c06cf23
RTL8188FU_SITE = $(call github,kelebek333,rtl8188fu,$(RTL8188FU_VERSION))
RTL8188FU_LICENSE = GPL-2.0
RTL8188FU_LICENSE_FILES = LICENSE

RTL8188FU_MODULE_MAKE_OPTS = \
	CONFIG_RTL8188FU=m \
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
		-Wno-error"

define RTL8188FU_MAKE_SUBDIR
        (cd $(@D); ln -s . rtl8188fu)
endef

define RTL8188FU_INSTALL_FIRMWARE
	$(INSTALL) -D -m 644 $(@D)/firmware/rtl8188fufw.bin \
		$(TARGET_DIR)/lib/firmware/rtlwifi/rtl8188fufw.bin
endef

RTL8188FU_PRE_CONFIGURE_HOOKS += RTL8188FU_MAKE_SUBDIR
RTL8188FU_POST_INSTALL_TARGET_HOOKS += RTL8188FU_INSTALL_FIRMWARE

$(eval $(kernel-module))
$(eval $(generic-package))
