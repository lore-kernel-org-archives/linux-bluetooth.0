Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/3] build: Remove udevrules option
Date: Sat,  2 Jul 2011 00:35:11 -0300
Message-Id: <1309577712-3828-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1309577712-3828-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309577712-3828-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the new datafiles options instead.
---
 Makefile.am  |   14 ++++++--------
 acinclude.m4 |    6 ------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2268890..cb3ae91 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -336,7 +336,7 @@ EXTRA_DIST += audio/bluetooth.conf
 
 include Makefile.tools
 
-if UDEVRULES
+if DATAFILES
 rulesdir = @UDEV_DIR@/rules.d
 
 udev_files = scripts/bluetooth.rules
@@ -346,7 +346,11 @@ udev_files += scripts/bluetooth-hid2hci.rules
 endif
 
 if PCMCIA
+udevdir = @UDEV_DIR@
+
 udev_files += scripts/bluetooth-serial.rules
+
+dist_udev_SCRIPTS = scripts/bluetooth_serial
 endif
 
 rules_DATA = $(foreach file,$(udev_files), scripts/97-$(notdir $(file)))
@@ -357,12 +361,6 @@ CLEANFILES += $(rules_DATA)
 EXTRA_DIST += scripts/bluetooth.rules \
 		scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules
 
-if PCMCIA
-udevdir = @UDEV_DIR@
-
-dist_udev_SCRIPTS = scripts/bluetooth_serial
-endif
-
 EXTRA_DIST += doc/manager-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
@@ -388,7 +386,7 @@ pkgconfigdir = $(libdir)/pkgconfig
 
 pkgconfig_DATA = bluez.pc
 
-DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules
+DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles
 
 DISTCLEANFILES = $(pkgconfig_DATA)
 
diff --git a/acinclude.m4 b/acinclude.m4
index 089d775..67ee1a4 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -205,7 +205,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	pcmcia_enable=no
 	hid2hci_enable=no
 	dfutool_enable=no
-	udevrules_enable=yes
 	datafiles_enable=yes
 	telephony_driver=dummy
 	maemo6_enable=no
@@ -321,10 +320,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		test_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(udevrules, AC_HELP_STRING([--enable-udevrules], [install Bluetooth udev rules]), [
-		udevrules_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--enable-datafiles], [install Bluetooth configuration and data files]), [
 		datafiles_enable=${enableval}
 	])
@@ -402,7 +397,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(PCMCIA, test "${pcmcia_enable}" = "yes")
 	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" = "yes" && test "${usb_found}" = "yes" && test "${udev_found}" = "yes")
 	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" = "yes" && test "${usb_found}" = "yes")
-	AM_CONDITIONAL(UDEVRULES, test "${udevrules_enable}" = "yes")
 	AM_CONDITIONAL(DATAFILES, test "${datafiles_enable}" = "yes")
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
-- 
1.7.6

