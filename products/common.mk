# Generic product
PRODUCT_NAME := 4.4
PRODUCT_BRAND := 4.4
PRODUCT_DEVICE := generic

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# STK: overlay common to all devices with telephony
ifneq ($(filter aosplus_mako aosplus_hammerhead,$(TARGET_PRODUCT)),)
# Build SimToolKit
PRODUCT_PACKAGES += \
    Stk
endif

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/aosplus/overlay/common

# Latin IME lib
PRODUCT_COPY_FILES += \
    vendor/aosplus/proprietary/common/system/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# AOSPLUS ADDS
PRODUCT_PACKAGES += \
    UpdateCenter \
    About \
    Lightbulb \
    Wallpapers

#Nova launcher
PRODUCT_COPY_FILES += \
    vendor/aosplus/prebuilt/apk/NovaLauncher.apk:system/app/NovaLauncher.apk

#Multi-user
PRODUCT_PROPERTY_OVERRIDES += \
    fw.max_users=5

# AOSPLUS 4.4 UpdateCenter
PRODUCT_VERSION_MAJOR = 4.4.2
PRODUCT_VERSION_MINOR = stable
PRODUCT_VERSION_MAINTENANCE = 1.0
ifdef AOSPLUS_BUILD_EXTRA
    AOSPLUS_POSTFIX := -$(AOSPLUS_BUILD_EXTRA)
endif
ifndef AOSPLUS_BUILD_TYPE
    AOSPLUS_BUILD_TYPE := OFFICIAL
    PLATFORM_VERSION_CODENAME := OFFICIAL
    AOSPLUS_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Set all versions
AOSPLUS_VERSION := aosplus-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(AOSPLUS_BUILD_TYPE)$(AOSPLUS_POSTFIX)
AOSPLUS_MOD_VERSION := aosplus-$(PRODUCT_DEVICE)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(AOSPLUS_BUILD_TYPE)$(AOSPLUS_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    Javierd.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.Javierd.version=$(AOSPLUS_VERSION) \
    ro.modversion=$(AOSPLUS_MOD_VERSION)
