Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/4] Enable input/sixpair build (but no installation)
Date: Fri, 30 Dec 2011 15:26:10 -0400
Message-Id: <1325273171-24698-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"sixpair" is a standalone tool to manage PS3 controllers. It was the
only tool not being built by default.

To build it, it is necessary to check for libusb-1.0 (besides the
existing libusb 0.1 check). The check is optional, and sixpair will not
be built if libusb-1.0 headers are not installed.
---

I personally never used this tool. So I'm not sure if the best approach is to
completely remove it instead. If that's the case, let me know so I send a patch
removing the .c file instead.

 .gitignore     |    1 +
 Makefile.tools |   10 ++++++++++
 acinclude.m4   |    5 +++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index badd1a0..0c5ef15 100644
--- a/.gitignore
+++ b/.gitignore
@@ -46,6 +46,7 @@ sbc/sbcinfo
 sbc/sbctester
 
 attrib/gatttool
+input/sixpair
 tracer/hcitrace
 tools/avctrl
 tools/avinfo
diff --git a/Makefile.tools b/Makefile.tools
index eea1a9b..400ed1b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -63,6 +63,16 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 attrib_gatttool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @READLINE_LIBS@
 endif
 
+if SIXPAIR
+noinst_PROGRAMS += input/sixpair
+
+input_sixpair_CFLAGS = $(AM_CFLAGS) @USB10_CFLAGS@
+input_sixpair_SOURCES = input/sixpair.c src/storage.c src/storage.h \
+			src/textfile.c src/textfile.h src/glib-helper.c \
+			src/glib-helper.h
+input_sixpair_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @USB10_LIBS@
+endif
+
 dist_man_MANS += tools/rfcomm.1 tools/l2ping.8 \
 			tools/hciattach.8 tools/hciconfig.8 \
 			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1
diff --git a/acinclude.m4 b/acinclude.m4
index 4c72fee..f2a4845 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -141,6 +141,10 @@ AC_DEFUN([AC_PATH_USB], [
 	AC_CHECK_LIB(usb, usb_interrupt_read, dummy=yes,
 		AC_DEFINE(NEED_USB_INTERRUPT_READ, 1,
 			[Define to 1 if you need the usb_interrupt_read() function.]))
+
+	PKG_CHECK_MODULES(USB10, libusb-1.0, usb10_found=yes, usb10_found=no)
+	AC_SUBST(USB10_CFLAGS)
+	AC_SUBST(USB10_LIBS)
 ])
 
 AC_DEFUN([AC_PATH_UDEV], [
@@ -427,6 +431,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(PCMCIA, test "${pcmcia_enable}" = "yes")
 	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" = "yes" && test "${usb_found}" = "yes" && test "${udev_found}" = "yes")
 	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" = "yes" && test "${usb_found}" = "yes")
+	AM_CONDITIONAL(SIXPAIR, test "${usb10_found}" = "yes")
 	AM_CONDITIONAL(DATAFILES, test "${datafiles_enable}" = "yes")
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
-- 
1.7.0.4

