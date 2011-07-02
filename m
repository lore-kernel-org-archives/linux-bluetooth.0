Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] build: Rename configfiles option to datafiles
Date: Sat,  2 Jul 2011 00:35:10 -0300
Message-Id: <1309577712-3828-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of passing --[disable|enable]-configfiles, now we use
--[disable|enable]-datafiles as not all of the files are installed for
configuration but are rather data files.
---
 Makefile.am    |    6 +++---
 Makefile.tools |    2 +-
 acinclude.m4   |    8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e320105..2268890 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,7 +23,7 @@ includedir = @includedir@/bluetooth
 
 include_HEADERS =
 
-if CONFIGFILES
+if DATAFILES
 dbusdir = $(sysconfdir)/dbus-1/system.d
 
 dbus_DATA = src/bluetooth.conf
@@ -270,7 +270,7 @@ CLEANFILES += $(builtin_files)
 
 man_MANS = src/bluetoothd.8
 
-if CONFIGFILES
+if DATAFILES
 conf_DATA += src/main.conf
 endif
 
@@ -301,7 +301,7 @@ audio_libasound_module_ctl_bluetooth_la_LDFLAGS = -module -avoid-version #-expor
 audio_libasound_module_ctl_bluetooth_la_LIBADD = lib/libbluetooth.la @ALSA_LIBS@
 audio_libasound_module_ctl_bluetooth_la_CFLAGS = @ALSA_CFLAGS@
 
-if CONFIGFILES
+if DATAFILES
 alsaconfdir = $(datadir)/alsa
 
 alsaconf_DATA = audio/bluetooth.conf
diff --git a/Makefile.tools b/Makefile.tools
index bec10b5..1cd8c9e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -1,6 +1,6 @@
 
 if TOOLS
-if CONFIGFILES
+if DATAFILES
 conf_DATA += tools/rfcomm.conf
 endif
 
diff --git a/acinclude.m4 b/acinclude.m4
index a37959a..089d775 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -206,7 +206,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	hid2hci_enable=no
 	dfutool_enable=no
 	udevrules_enable=yes
-	configfiles_enable=yes
+	datafiles_enable=yes
 	telephony_driver=dummy
 	maemo6_enable=no
 	sap_driver=dummy
@@ -325,8 +325,8 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		udevrules_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(configfiles, AC_HELP_STRING([--enable-configfiles], [install Bluetooth configuration files]), [
-		configfiles_enable=${enableval}
+	AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--enable-datafiles], [install Bluetooth configuration and data files]), [
+		datafiles_enable=${enableval}
 	])
 
 	AC_ARG_ENABLE(debug, AC_HELP_STRING([--enable-debug], [enable compiling with debugging information]), [
@@ -403,7 +403,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" = "yes" && test "${usb_found}" = "yes" && test "${udev_found}" = "yes")
 	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" = "yes" && test "${usb_found}" = "yes")
 	AM_CONDITIONAL(UDEVRULES, test "${udevrules_enable}" = "yes")
-	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
+	AM_CONDITIONAL(DATAFILES, test "${datafiles_enable}" = "yes")
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 ])
-- 
1.7.6

