Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 26 Sep 2007 22:43:37 -0400
From: Tim Hentenaar <tth@one.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070926224337.6210e251@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_L_bc9w1O3W+9RLjOWav4Q+y
Subject: [Bluez-devel] [PATCH] Dinovo Mediapad LCD support in Input service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--MP_L_bc9w1O3W+9RLjOWav4Q+y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hello all,

Here is a patch against bluez-utils 3.19 to enable support for the
Dinovo Mediapad LCD. Originally, I implemented this in hidd, but since
hidd is "dead" I've revised my patch. 

This patch also addresses a bug in common/dbus.c where a pointer goes
unchecked and caused a segfault or two during my testing.

Regards,

Tim
--MP_L_bc9w1O3W+9RLjOWav4Q+y
Content-Type: text/x-patch; name=input.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=input.patch

diff -ru bluez-utils-3.19/common/dbus.c bluez-utils-3.19/common/dbus.c
--- bluez-utils-3.19/common/dbus.c	2007-06-23 18:55:58.000000000 -0400
+++ bluez-utils-3.19/common/dbus.c	2007-09-26 01:13:05.688764887 -0400
@@ -524,8 +524,10 @@
 
 	dbus_watch_handle(watch, flags);
 
-	if (dbus_connection_get_dispatch_status(info->conn) == DBUS_DISPATCH_DATA_REMAINS)
-		g_timeout_add(DISPATCH_TIMEOUT, message_dispatch_cb, info->conn);
+	if (info) {
+		if (dbus_connection_get_dispatch_status(info->conn) == DBUS_DISPATCH_DATA_REMAINS)
+			g_timeout_add(DISPATCH_TIMEOUT, message_dispatch_cb, info->conn);
+	}
 
 	return TRUE;
 }
diff -ru bluez-utils-3.19/input/Makefile.am bluez-utils-3.19/input/Makefile.am
--- bluez-utils-3.19/input/Makefile.am	2007-05-09 02:40:43.000000000 -0400
+++ bluez-utils-3.19/input/Makefile.am	2007-09-22 18:50:03.676128422 -0400
@@ -2,8 +2,10 @@
 if INPUTSERVICE
 if CONFIGFILES
 confdir = $(sysconfdir)/bluetooth
+conf_DATA = input.service 
 
-conf_DATA = input.service
+dbusdir = $(sysconfdir)/dbus-1/system.d
+dbus_DATA = dinovo.conf
 endif
 
 servicedir = $(libdir)/bluetooth
@@ -12,7 +14,8 @@
 
 bluetoothd_service_input_SOURCES = main.c \
 	manager.h manager.c error.h error.c \
-	server.h server.c device.h device.c storage.h storage.c
+	server.h server.c device.h device.c storage.h storage.c \
+	logitech_mediapad.c
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
@@ -22,6 +25,6 @@
 
 INCLUDES = -I$(top_srcdir)/common
 
-EXTRA_DIST = input.service input-api.txt test-input
+EXTRA_DIST = input.service dinovo.conf input-api.txt test-input
 
 MAINTAINERCLEANFILES = Makefile.in
diff -ru bluez-utils-3.19/input/Makefile.in bluez-utils-3.19/input/Makefile.in
--- bluez-utils-3.19/input/Makefile.in	2007-09-16 04:10:09.000000000 -0400
+++ bluez-utils-3.19/input/Makefile.in	2007-09-22 18:54:43.556077871 -0400
@@ -45,16 +45,18 @@
 mkinstalldirs = $(install_sh) -d
 CONFIG_HEADER = $(top_builddir)/config.h
 CONFIG_CLEAN_FILES =
-am__installdirs = "$(DESTDIR)$(servicedir)" "$(DESTDIR)$(confdir)"
+am__installdirs = "$(DESTDIR)$(servicedir)" "$(DESTDIR)$(confdir)" \
+	"$(DESTDIR)$(dbusdir)"
 servicePROGRAMS_INSTALL = $(INSTALL_PROGRAM)
 PROGRAMS = $(service_PROGRAMS)
 am__bluetoothd_service_input_SOURCES_DIST = main.c manager.h manager.c \
 	error.h error.c server.h server.c device.h device.c storage.h \
-	storage.c
+	storage.c logitech_mediapad.c
 @INPUTSERVICE_TRUE@am_bluetoothd_service_input_OBJECTS =  \
 @INPUTSERVICE_TRUE@	main.$(OBJEXT) manager.$(OBJEXT) \
 @INPUTSERVICE_TRUE@	error.$(OBJEXT) server.$(OBJEXT) \
-@INPUTSERVICE_TRUE@	device.$(OBJEXT) storage.$(OBJEXT)
+@INPUTSERVICE_TRUE@	device.$(OBJEXT) storage.$(OBJEXT) \
+@INPUTSERVICE_TRUE@	logitech_mediapad.$(OBJEXT)
 bluetoothd_service_input_OBJECTS =  \
 	$(am_bluetoothd_service_input_OBJECTS)
 bluetoothd_service_input_LDADD = $(LDADD)
@@ -81,7 +83,8 @@
   esac;
 am__strip_dir = `echo $$p | sed -e 's|^.*/||'`;
 confDATA_INSTALL = $(INSTALL_DATA)
-DATA = $(conf_DATA)
+dbusDATA_INSTALL = $(INSTALL_DATA)
+DATA = $(conf_DATA) $(dbus_DATA)
 ETAGS = etags
 CTAGS = ctags
 DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
@@ -214,18 +217,21 @@
 top_builddir = @top_builddir@
 top_srcdir = @top_srcdir@
 @CONFIGFILES_TRUE@@INPUTSERVICE_TRUE@confdir = $(sysconfdir)/bluetooth
-@CONFIGFILES_TRUE@@INPUTSERVICE_TRUE@conf_DATA = input.service
+@CONFIGFILES_TRUE@@INPUTSERVICE_TRUE@conf_DATA = input.service 
+@CONFIGFILES_TRUE@@INPUTSERVICE_TRUE@dbusdir = $(sysconfdir)/dbus-1/system.d
+@CONFIGFILES_TRUE@@INPUTSERVICE_TRUE@dbus_DATA = dinovo.conf
 @INPUTSERVICE_TRUE@servicedir = $(libdir)/bluetooth
 @INPUTSERVICE_TRUE@bluetoothd_service_input_SOURCES = main.c \
 @INPUTSERVICE_TRUE@	manager.h manager.c error.h error.c \
-@INPUTSERVICE_TRUE@	server.h server.c device.h device.c storage.h storage.c
+@INPUTSERVICE_TRUE@	server.h server.c device.h device.c storage.h storage.c \
+@INPUTSERVICE_TRUE@	logitech_mediapad.c
 
 @INPUTSERVICE_TRUE@LDADD = $(top_builddir)/common/libhelper.a \
 @INPUTSERVICE_TRUE@		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
 
 AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@
 INCLUDES = -I$(top_srcdir)/common
-EXTRA_DIST = input.service input-api.txt test-input
+EXTRA_DIST = input.service dinovo.conf input-api.txt test-input
 MAINTAINERCLEANFILES = Makefile.in
 all: all-am
 
@@ -300,6 +306,7 @@
 
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/device.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/error.Po@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/logitech_mediapad.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/main.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/manager.Po@am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/server.Po@am__quote@
@@ -348,6 +355,23 @@
 	  echo " rm -f '$(DESTDIR)$(confdir)/$$f'"; \
 	  rm -f "$(DESTDIR)$(confdir)/$$f"; \
 	done
+install-dbusDATA: $(dbus_DATA)
+	@$(NORMAL_INSTALL)
+	test -z "$(dbusdir)" || $(MKDIR_P) "$(DESTDIR)$(dbusdir)"
+	@list='$(dbus_DATA)'; for p in $$list; do \
+	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
+	  f=$(am__strip_dir) \
+	  echo " $(dbusDATA_INSTALL) '$$d$$p' '$(DESTDIR)$(dbusdir)/$$f'"; \
+	  $(dbusDATA_INSTALL) "$$d$$p" "$(DESTDIR)$(dbusdir)/$$f"; \
+	done
+
+uninstall-dbusDATA:
+	@$(NORMAL_UNINSTALL)
+	@list='$(dbus_DATA)'; for p in $$list; do \
+	  f=$(am__strip_dir) \
+	  echo " rm -f '$(DESTDIR)$(dbusdir)/$$f'"; \
+	  rm -f "$(DESTDIR)$(dbusdir)/$$f"; \
+	done
 
 ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
 	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
@@ -427,7 +451,7 @@
 check: check-am
 all-am: Makefile $(PROGRAMS) $(DATA)
 installdirs:
-	for dir in "$(DESTDIR)$(servicedir)" "$(DESTDIR)$(confdir)"; do \
+	for dir in "$(DESTDIR)$(servicedir)" "$(DESTDIR)$(confdir)" "$(DESTDIR)$(dbusdir)"; do \
 	  test -z "$$dir" || $(MKDIR_P) "$$dir"; \
 	done
 install: install-am
@@ -476,7 +500,8 @@
 
 info-am:
 
-install-data-am: install-confDATA install-servicePROGRAMS
+install-data-am: install-confDATA install-dbusDATA \
+	install-servicePROGRAMS
 
 install-dvi: install-dvi-am
 
@@ -512,7 +537,8 @@
 
 ps-am:
 
-uninstall-am: uninstall-confDATA uninstall-servicePROGRAMS
+uninstall-am: uninstall-confDATA uninstall-dbusDATA \
+	uninstall-servicePROGRAMS
 
 .MAKE: install-am install-strip
 
@@ -521,15 +547,16 @@
 	distclean-compile distclean-generic distclean-libtool \
 	distclean-tags distdir dvi dvi-am html html-am info info-am \
 	install install-am install-confDATA install-data \
-	install-data-am install-dvi install-dvi-am install-exec \
-	install-exec-am install-html install-html-am install-info \
-	install-info-am install-man install-pdf install-pdf-am \
-	install-ps install-ps-am install-servicePROGRAMS install-strip \
-	installcheck installcheck-am installdirs maintainer-clean \
+	install-data-am install-dbusDATA install-dvi install-dvi-am \
+	install-exec install-exec-am install-html install-html-am \
+	install-info install-info-am install-man install-pdf \
+	install-pdf-am install-ps install-ps-am \
+	install-servicePROGRAMS install-strip installcheck \
+	installcheck-am installdirs maintainer-clean \
 	maintainer-clean-generic mostlyclean mostlyclean-compile \
 	mostlyclean-generic mostlyclean-libtool pdf pdf-am ps ps-am \
 	tags uninstall uninstall-am uninstall-confDATA \
-	uninstall-servicePROGRAMS
+	uninstall-dbusDATA uninstall-servicePROGRAMS
 
 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.
diff -ru bluez-utils-3.19/input/device.c bluez-utils-3.19/input/device.c
--- bluez-utils-3.19/input/device.c	2007-09-02 12:26:35.000000000 -0400
+++ bluez-utils-3.19/input/device.c	2007-09-22 22:19:31.160308530 -0400
@@ -52,6 +52,7 @@
 #include "error.h"
 #include "manager.h"
 #include "storage.h"
+#include "logitech_mediapad.h"
 
 #define INPUT_DEVICE_INTERFACE	"org.bluez.input.Device"
 
@@ -64,6 +65,7 @@
 	int		rfcomm; /* RFCOMM socket */
 	int		uinput;	/* uinput socket */
 	uint8_t		ch;	/* RFCOMM channel number */
+	gpointer	misc;	/* Misc. Device-dependant state data */
 };
 
 struct device {
@@ -174,11 +176,11 @@
 	ioctl(fd, UI_SET_EVBIT, EV_KEY);
 	ioctl(fd, UI_SET_EVBIT, EV_REL);
 	ioctl(fd, UI_SET_EVBIT, EV_REP);
+	ioctl(fd, UI_SET_EVBIT, EV_LED);
 
-	ioctl(fd, UI_SET_KEYBIT, KEY_UP);
-	ioctl(fd, UI_SET_KEYBIT, KEY_PAGEUP);
-	ioctl(fd, UI_SET_KEYBIT, KEY_DOWN);
-	ioctl(fd, UI_SET_KEYBIT, KEY_PAGEDOWN);
+	for (err=KEY_RESERVED;err <= KEY_UNKNOWN;err++) 
+		ioctl(fd,UI_SET_KEYBIT,err);
+	err = 0;
 
 	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
 		err = errno;
@@ -621,9 +623,10 @@
 	}
 
 	err = ioctl(ctl, HIDPCONNADD, &req);
+
 cleanup:
 	close(ctl);
-
+	
 	if (req.rd_data)
 		free(req.rd_data);
 
@@ -665,12 +668,15 @@
 	}
 
 	idev->intr_sk = isk;
+
 	err = hidp_connadd(&idev->src, &idev->dst, idev->ctrl_sk, idev->intr_sk, idev->name);
+
 	if (err < 0)
 		goto failed;
 
 	idev->intr_watch = create_watch(idev->intr_sk, intr_watch_cb, idev);
 	idev->ctrl_watch = create_watch(idev->ctrl_sk, ctrl_watch_cb, idev);
+
 	dbus_connection_emit_signal(idev->conn,
 			idev->path,
 			INPUT_DEVICE_INTERFACE,
@@ -1318,13 +1324,22 @@
 int input_device_connadd(bdaddr_t *src, bdaddr_t *dst)
 {
 	struct device *idev;
-	int err;
+	int err = 0;
 
 	idev = find_device(src, dst);
 	if (!idev)
 		return -ENOENT;
 
-	err = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
+	if (!strcmp(idev->name,"Logitech Bluetooth Mediapad") || !strcmp(idev->name,"Logitech Mediapad")) {
+		idev->fake         = g_new0(struct fake_input,1); err = 0;
+		idev->fake->uinput = uinput_create(idev->name);
+		idev->fake->misc   = logitech_mediapad_init(idev->intr_sk,idev->fake->uinput); 
+		idev->fake->io     = g_io_channel_unix_new(idev->intr_sk);
+		g_io_channel_set_close_on_unref(idev->fake->io, TRUE);
+		g_io_add_watch(idev->fake->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			      (GIOFunc) logitech_mediapad_io_cb, idev->fake->misc);
+	} else err = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
+
 	if (err < 0) {
 		close(idev->ctrl_sk);
 		close(idev->intr_sk);
diff -ru bluez-utils-3.19/input/dinovo.conf bluez-utils-3.19/input/dinovo.conf
--- bluez-utils-3.19/input/dinovo.conf	2007-09-22 18:53:10.450772102 -0400
+++ bluez-utils-3.19/input/dinovo.conf	2007-09-22 18:48:37.771232981 -0400
@@ -0,0 +1,18 @@
+<!-- This configuration file specifies the required security policies
+     for the Logitech Dinovo MediaPad driver. -->
+
+<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
+ "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+<busconfig>
+  <!-- ../system.conf have denied everything, so we just punch some holes -->
+
+  <policy user="root">
+    <allow own="com.hentenaar.Dinovo.MediaPad"/>
+  </policy>
+
+  <policy at_console="true">
+    <allow send_path="/com/hentenaar"/>
+    <allow send_destination="com.hentenaar.Dinovo.MediaPad" />
+    <allow receive_sender="com.hentenaar.Dinovo.MediaPad"/>
+  </policy>
+</busconfig>
diff -ru bluez-utils-3.19/input/logitech_mediapad.c bluez-utils-3.19/input/logitech_mediapad.c
--- bluez-utils-3.19/input/logitech_mediapad.c	2007-09-22 18:53:15.871080988 -0400
+++ bluez-utils-3.19/input/logitech_mediapad.c	2007-09-26 22:10:37.120496939 -0400
@@ -0,0 +1,571 @@
+/************************ Logitech Mediapad Driver ********************************
+ *     (C) 2006-2007 Tim Hentenaar <tim@hentenaar.com>                            *
+ *     Licensed under the GNU General Public License.                             *
+ *     The latest version of this work is available at http://hentenaar.com       *
+ *                                                                                *
+ *     Updates:                                                                   *
+ *     		Thanks to Glen Rolle for suggesting the single-line write         *
+ *     		mode, and for showing me a better method for writing chars        *
+ *     		>= 0x80 from python.
+ *                                                                                *
+ *     Notes:                                                                     *
+ *		1) The i18n for the device isn't currently supported.             *
+ *			The way that the i18n works, is that when the device      *
+ *			connects, the Winblows app retrieves the respective       *
+ *			strings from the device and verifies/updates them.        *
+ *                                                                                *
+ *			Simple enough to do, but I'll worry about it later.       *
+ *		2) The '000' key actually sends 3 0's and is not a special key.   *
+ *		3) The "Copy calulator result to clipboard" requires an           *
+ *		   activation packet that I haven't isolated to date.             *
+ *              4) Git-R-Done!                                                    *
+ **********************************************************************************/
+
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <time.h>
+#include <glib.h>
+#include <syslog.h>
+
+#include "uinput.h"
+#include "logging.h"
+#include "dbus.h"
+
+/* LCD Line Flags */
+#define LCD_LINE_DISPLAY	0x10
+#define LCD_LINE_SCROLL		0x20
+#define LCD_LINE_INIT		0x01
+#define LCD_2_BUFFERS		0x02
+#define LCD_3_BUFFERS		0x03
+
+/* Icons */
+#define LCD_ICON_EMAIL		0x01
+#define LCD_ICON_IM		0x02
+#define LCD_ICON_MUTE		0x04
+#define LCD_ICON_ALERT		0x08
+#define LCD_ICON_ON		0x01
+#define LCD_ICON_BLINK		0x02
+
+/* Speaker / LED */
+#define LCD_LOW_BEEP		0x01
+#define LCD_LONG_BEEP		0x02
+#define LCD_SHORT_BEEP		0x03
+
+/* Modes */
+#define MODE_NUM		0x00
+#define MODE_NAV		0x01
+
+/* DBus Path */
+#define MP_DBUS_PATH		"com.hentenaar.Dinovo.MediaPad"
+#define MP_DBUS_SIGNAL_PATH	"/com/hentenaar/Dinovo/MediaPad"
+
+/* Mediapad State */
+struct mp_state {
+	int mode;
+	int discard_keyup;
+	int prev_key;
+	int icons;
+	int uinput;
+	int sock;
+	DBusConnection *db_conn;
+};
+
+/* Mediapad Command */
+struct mpcmd {	
+	char    command[22];
+	uint8_t len;
+};
+
+static struct mpcmd clscr[] = { /* Clear the screen */
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x10, 0x00, 0x01, 0x00 }, 8},										
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},										
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }, 21}, 
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},										
+	{{ 0 }, 0}
+};
+
+static struct mpcmd write_icons[] = { /* Set Icons (0 = off) */
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }, 21}
+};
+
+static struct mpcmd write_ledspk[] = { /* LED / Speaker Control */
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x50, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x50, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
+static struct mpcmd write_clock[] = { /* Set the clock */ 
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x31, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x32, 0x02, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x33, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
+static struct mpcmd write_lcd[] = { /* Write text to the LCD */ 
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x01, 0x01, 0x01 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x22, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x23, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x24, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x25, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x26, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x27, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x28, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
+static struct mpcmd write_lcd_single[] = { /* Write a single line of text to the LCD */ 
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x10, 0x10, 0x10 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x22, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x10, 0x10, 0x10 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
+#define N_LCDW_CMDS	14
+#define N_LCDS_CMDS	8
+
+#define inject_key(X,Y,Z) send_event(X,EV_KEY,Y,Z)
+
+static const char *introspect_ret = 
+"<!DOCTYPE node PUBLIC \"-//freedesktop//DTD D-BUS Object Introspection 1.0//EN\" \"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd\">\n"
+"        <node name=\"/com/hentenaar/Dinovo/MediaPad\">\n"
+"          <interface name=\"com.hentenaar.Dinovo.MediaPad\">\n"
+"            <method name=\"BlinkOrBeep\">\n"
+"              <!-- beep_type: 0 (none) | 1 (low beep) | 2 (beep-beep) | 3 (short beep)\n"
+"                   blink:     0 (no)   | 1 (yes) -->\n"
+"              <arg name=\"beep_type\" type=\"u\" direction=\"in\"/>\n"
+"              <arg name=\"blink\"     type=\"u\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"SetIndicator\">\n"
+"              <!-- indicator: 1 (email) | 2 (IM) | 4 (Mute) | 8 (Alert)\n"
+"                   show:      0 (hide)  | 1 (solid) | 2 (blink) -->\n"
+"              <arg name=\"indicator\" type=\"u\" direction=\"in\"/>\n"
+"              <arg name=\"show\"      type=\"u\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"SyncClock\" />\n"
+"            <method name=\"WriteText\">\n"
+"              <!-- Max Length: 144 -->\n"
+"              <arg name=\"text\" type=\"s\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"WriteLine\">\n"
+"              <!-- Max Length: 48 -->\n"
+"              <arg name=\"lineno\" type=\"u\" direction=\"in\"/>\n"
+"              <arg name=\"text\"   type=\"s\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"WriteTextBin\">\n"
+"              <!-- Max Length: 144 -->\n"
+"              <arg name=\"text\" type=\"ai\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"WriteLineBin\">\n"
+"              <!-- Max Length: 48 -->\n"
+"              <arg name=\"lineno\" type=\"u\"  direction=\"in\"/>\n"
+"              <arg name=\"text\"   type=\"ai\" direction=\"in\"/>\n"
+"           </method>\n"
+"         </interface>\n"
+"       </node>\n";
+
+static DBusHandlerResult logitech_mediapad_msg(DBusConnection *conn, DBusMessage *msg, void *data);
+static const DBusObjectPathVTable mp_vtable = {
+	.message_function = &logitech_mediapad_msg,
+	.unregister_function = NULL
+};
+
+
+static void send_event(int fd, uint16_t type, uint16_t code, int32_t value) {
+	struct uinput_event event;
+	int err;
+
+	memset(&event, 0, sizeof(event));
+	event.type	= type;
+	event.code	= code;
+	event.value	= value;
+
+	err = write(fd, &event, sizeof(event));
+}
+
+static unsigned char translate_key(int mode, unsigned char key) {
+	switch(key) {
+		case 0x54: return KEY_KPSLASH;
+		case 0x55: return KEY_KPASTERISK;
+		case 0x56: return KEY_KPMINUS;
+		case 0x57: return KEY_KPPLUS;
+		case 0x58: return KEY_KPENTER;
+		case 0x59: return (mode != 0) ? KEY_OPEN      : KEY_1;
+		case 0x5a: return (mode != 0) ? KEY_LEFTMETA  : KEY_2;
+		case 0x5b: return (mode != 0) ? KEY_UNDO      : KEY_3;	/* Even though it should be KEY_CLOSE (non-existant) */
+		case 0x5c: return (mode != 0) ? KEY_LEFT      : KEY_4;
+		case 0x5d: return (mode != 0) ? KEY_DOWN      : KEY_5;
+		case 0x5e: return (mode != 0) ? KEY_RIGHT     : KEY_6;
+		case 0x5f: return (mode != 0) ? KEY_BACK      : KEY_7;
+		case 0x60: return (mode != 0) ? KEY_UP        : KEY_8;
+		case 0x61: return (mode != 0) ? KEY_FORWARD   : KEY_9;
+		case 0x62: return KEY_0;
+		case 0x63: return KEY_DOT;
+	}
+	return KEY_UNKNOWN;
+}
+
+static int clear_screen(int sock) {
+	int i = 0, x = 0;
+	while (clscr[i].len != 0) { x = write(sock,clscr[i].command,clscr[i].len); i++; }
+	if (x == -1) return 0;
+	return 1;
+}
+
+static int set_lcd_indicator(int sock, uint8_t indicator, int blink) {
+	struct mpcmd lcdwi; uint8_t on = (blink >= 1) ? ((blink == 2) ? LCD_ICON_BLINK : LCD_ICON_ON) : 0; int sel = 5;
+
+	if (sock < 4 || indicator == 0) return 0;
+	memcpy(&lcdwi,write_icons,sizeof(struct mpcmd));
+	while ((indicator & 1) == 0) { sel++; indicator >>= 1; }
+	while (indicator & 1) { lcdwi.command[sel++] = on; indicator >>= 1; }
+	if (write(sock,lcdwi.command,lcdwi.len) < 0) return 0;
+	return 1;
+}
+
+static int beep_or_blink(int sock, uint8_t beep, uint8_t blink) {
+	struct mpcmd bbeep[3]; int i = 0; int x = 0;
+
+	if (sock < 4) return 0;
+	memcpy(bbeep,write_ledspk,sizeof(struct mpcmd)*3);
+
+	if (beep)  bbeep[1].command[5] = (beep & 3);
+	if (blink) bbeep[1].command[6] = 1;
+	while (bbeep[i].len != 0) { x = write(sock,bbeep[i].command,bbeep[i].len); i++; }
+	if (x == -1) return 0;
+	return 1;
+}
+
+static int set_clock(int sock) {
+	struct mpcmd setclk[4]; struct tm tx; time_t tim = 0; int i = 0, x=0;
+
+	if (sock < 4) return 0;
+	memcpy(setclk,write_clock,sizeof(struct mpcmd)*4);
+	time(&tim); localtime_r(&tim,&tx);
+	setclk[0].command[5] = (char)(tx.tm_sec);
+	setclk[0].command[6] = (char)(tx.tm_min);
+	setclk[0].command[7] = (char)(tx.tm_hour);
+	setclk[1].command[6] = (char)(tx.tm_mday);
+	setclk[1].command[7] = (char)(tx.tm_mon);
+	setclk[2].command[5] = (char)(tx.tm_year - 100);
+	
+	while (setclk[i].len != 0) { x = write(sock,setclk[i].command,setclk[i].len); i++; }
+	if (x == -1) return 0;
+	return 1;
+}
+
+static int write_lcd_text(int sock, char *text) {
+	char lines[16*9]; struct mpcmd *lcdw = NULL; int q = 0; 
+	uint32_t i = 0,z = 0,line = 0; uint8_t f1 = LCD_LINE_DISPLAY, f2 = LCD_LINE_DISPLAY, f3 = LCD_LINE_DISPLAY;
+
+	if (!text || sock < 4) return 0;
+	memset(lines,0x20,16*9); z = (strlen(text) > 16*9) ? 16*9 : strlen(text);
+	for (i=0;i<z;i+=16) {
+		line = i / 16;
+		memcpy(lines+(16*line),text+i,((z-i) < 16) ?  (z-i) : 16);
+	}
+
+	lcdw = g_new0(struct mpcmd,N_LCDW_CMDS);
+	memcpy(lcdw,write_lcd,sizeof(struct mpcmd)*N_LCDW_CMDS);
+	
+	/* Copy the line text */
+	memcpy(lcdw[3].command+5,lines,16);        
+	memcpy(lcdw[4].command+5,lines+(16*3),16);
+	memcpy(lcdw[5].command+5,lines+(16*6),16);
+	memcpy(lcdw[6].command+5,lines+16,16);
+	memcpy(lcdw[7].command+5,lines+(16*4),16);
+	memcpy(lcdw[8].command+5,lines+(16*7),16);
+	memcpy(lcdw[9].command+5,lines+(16*2),16);
+	memcpy(lcdw[10].command+5,lines+(16*5),16);
+	memcpy(lcdw[11].command+5,lines+(16*8),16);
+
+	/* Autoscrolling */
+	if (z > 16*3) { 
+		f1 |= LCD_LINE_SCROLL | LCD_2_BUFFERS; f2 |= LCD_LINE_SCROLL | LCD_2_BUFFERS; f3 |= LCD_LINE_SCROLL | LCD_2_BUFFERS;
+		if (z > 16*6) { f1 &= 0xF0; f1 |= LCD_3_BUFFERS; f2 &= 0xF0; f2 |= LCD_3_BUFFERS;  f3 &= 0xF0; f3 |= LCD_3_BUFFERS; }
+	}
+
+	lcdw[12].command[5] = f1;
+	lcdw[12].command[6] = f2;
+	lcdw[12].command[7] = f3;		
+	i = 0; while (lcdw[i].len != 0) { q = write(sock,lcdw[i].command,lcdw[i].len); i++; } g_free(lcdw);
+	if (q == -1) return 0;
+	return 1;
+}	
+
+static int write_lcd_line(int sock, char *text, int lineno) {
+	char lines[16*3]; struct mpcmd *lcdw = NULL; int q = 0; uint32_t i = 0,z = 0,line = 0; uint8_t f = LCD_LINE_DISPLAY;
+
+	if (!text || sock < 4) return 0; lineno = (lineno > 3) ? 3 : (lineno <= 0) ? 1 : lineno;
+	memset(lines,0x20,16*3); z = (strlen(text) > 16*3) ? 16*3 : strlen(text);
+	for (i=0;i<z;i+=16) {
+		line = i / 16;
+		memcpy(lines+(16*line),text+i,((z-i) < 16) ?  (z-i) : 16);
+	}
+
+	lcdw = g_new0(struct mpcmd,N_LCDS_CMDS); 
+	memcpy(lcdw,write_lcd_single,sizeof(struct mpcmd)*N_LCDS_CMDS);
+	
+	/* Copy the line text */
+	memcpy(lcdw[3].command+5,lines,16);        
+	memcpy(lcdw[4].command+5,lines+16,16);
+	memcpy(lcdw[5].command+5,lines+(16*2),16);
+
+	/* Adjust the buffer numbers */
+	*(lcdw[3].command+4) = 0x20 + 3*(lineno-1);
+	*(lcdw[4].command+4) = 0x21 + 3*(lineno-1);
+	*(lcdw[5].command+4) = 0x22 + 3*(lineno-1);
+
+	/* Adjust flags */
+	if (z > 16) {
+		f |= LCD_LINE_SCROLL | LCD_2_BUFFERS;
+		if (z > 16*2) { f &= 0xF0; f |= LCD_3_BUFFERS; }
+	}
+
+	/* Write the text */
+	lcdw[1].command[4 + lineno] = LCD_LINE_INIT;
+	i = 0; while (lcdw[i].len != 0) { q = write(sock,lcdw[i].command,lcdw[i].len); i++; } g_free(lcdw);
+	if (q == -1) return 0;
+	else return 1;
+}		
+
+static DBusHandlerResult logitech_mediapad_msg(DBusConnection *conn, DBusMessage *msg, void *data) {
+	dbus_uint32_t u1,u2,u3; DBusMessageIter db_args,db_sub; DBusMessage *db_msg_reply; DBusError db_err;
+	struct mp_state *mp = (struct mp_state *)data; char *interface;
+
+	interface = (char *)dbus_message_get_interface(msg);
+
+	if (strlen(interface) == 35 && !strncmp(interface,"org.freedesktop.DBus.Introspectable",35)) {
+		if (!(db_msg_reply = dbus_message_new_method_return(msg)))
+			return DBUS_HANDLER_RESULT_NEED_MEMORY;
+		dbus_message_append_args(db_msg_reply, DBUS_TYPE_STRING, &introspect_ret, DBUS_TYPE_INVALID);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	if (!mp) {
+		info("mp is NULL!");
+		dbus_message_unref(msg);
+		dbus_connection_unref(conn);
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	}
+
+	if (dbus_message_is_method_call(msg,MP_DBUS_PATH,"BlinkOrBeep")) {
+		/* BlinkOrBeep(beep_type, blink) 
+		 * 	[beep_type := 0 (none) | 1 (low beep) | 2 (beep-beep) | 3 (short beep) ] 
+		 *	[blink     := 0 (no)   | 1 (yes) ]
+		 */
+	
+		dbus_error_init(&db_err);
+		dbus_message_get_args(msg,&db_err,DBUS_TYPE_UINT32,&u1,DBUS_TYPE_UINT32,&u2,DBUS_TYPE_INVALID);
+		if (dbus_error_is_set(&db_err)) {
+			error("logitech_mediapad: BlinkOrBeep: unable to get args! (%s)",db_err.message);
+		} else beep_or_blink(mp->sock,u1,u2);
+		dbus_error_free(&db_err);
+
+		db_msg_reply = dbus_message_new_method_return(msg);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	if (dbus_message_is_method_call(msg,MP_DBUS_PATH,"WriteText")) {
+		/* WriteText(text) Max Length: 144 */ 
+		if (dbus_message_iter_init(msg,&db_args)) {
+			if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_STRING) {
+				dbus_message_iter_get_basic(&db_args,&interface);
+				if (interface && strlen(interface) > 0) write_lcd_text(mp->sock,interface);
+			}
+		}
+		db_msg_reply = dbus_message_new_method_return(msg);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	if (dbus_message_is_method_call(msg,MP_DBUS_PATH,"WriteLine")) {
+		/* WriteLine(lineno, text) Max Length: 48 */ 
+		if (dbus_message_iter_init(msg,&db_args)) {
+			if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32) dbus_message_iter_get_basic(&db_args,&u1);
+			if (dbus_message_iter_has_next(&db_args)) {
+				dbus_message_iter_next(&db_args);
+				if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_STRING) {
+					dbus_message_iter_get_basic(&db_args,&interface);
+					if (interface && strlen(interface) > 0) write_lcd_line(mp->sock,interface,u1);
+				}
+			}
+		}
+		db_msg_reply = dbus_message_new_method_return(msg);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	if (dbus_message_is_method_call(msg,MP_DBUS_PATH,"WriteTextBin")) {
+		/* WriteTextBin(chars) Max Length: 144 */ 
+		if (dbus_message_iter_init(msg,&db_args)) {
+			if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_ARRAY) {
+				dbus_message_iter_recurse(&db_args,&db_sub);
+				if ((interface = g_new0(char,1+(16*9)))) {
+					for (u1=0;u1<=16*9;u1++) {
+						dbus_message_iter_get_basic(&db_sub,&u2);
+						interface[u1] = (char)u2;
+						if (dbus_message_iter_has_next(&db_sub)) dbus_message_iter_next(&db_sub);
+						else break;
+					} 
+					if (u1 > 0) write_lcd_text(mp->sock,interface); 
+					g_free(interface);
+				}
+			}
+		}
+		db_msg_reply = dbus_message_new_method_return(msg);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	if (dbus_message_is_method_call(msg,MP_DBUS_PATH,"WriteLineBin")) {
+		/* WriteLineBin(lineno, chars) Max Length: 48 */ 
+		if (dbus_message_iter_init(msg,&db_args)) {
+			if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32) dbus_message_iter_get_basic(&db_args,&u1);
+			if (dbus_message_iter_has_next(&db_args)) {
+				dbus_message_iter_next(&db_args);
+				if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_ARRAY) {
+					dbus_message_iter_recurse(&db_args,&db_sub);
+					if ((interface = g_new0(char,1+(16*3)))) {
+						for (u3=0;u3<=16*3;u3++) {
+							dbus_message_iter_get_basic(&db_sub,&u2);
+							interface[u3] = (char)u2;
+							if (dbus_message_iter_has_next(&db_sub)) dbus_message_iter_next(&db_sub);
+							else break;
+						} 
+						if (u3 > 0) write_lcd_line(mp->sock,interface,u1); g_free(interface);
+					}
+				}
+			}
+		}
+		db_msg_reply = dbus_message_new_method_return(msg);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	if (dbus_message_is_method_call(msg,MP_DBUS_PATH,"SetIndicator")) {
+		/* SetIndicator(indicator, blink) 
+		 *	[ indicator := see LCD_ICON_* above ]
+		 *	[ blink     := 0 (off) | 1 (on) | >= 2 (blink) ] 
+		 */ 
+		
+		dbus_error_init(&db_err);
+		dbus_message_get_args(msg,&db_err,DBUS_TYPE_UINT32,&u1,DBUS_TYPE_UINT32,&u2,DBUS_TYPE_INVALID);
+		if (dbus_error_is_set(&db_err)) {
+			error("logitech_mediapad: SetIndicator: unable to get args! (%s)",db_err.message);
+		} else set_lcd_indicator(mp->sock,u1,u2);
+		dbus_error_free(&db_err);
+
+		db_msg_reply = dbus_message_new_method_return(msg);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	if (dbus_message_is_method_call(msg,MP_DBUS_PATH,"SyncClock")) {
+		/* SyncClock() */
+		set_clock(mp->sock);
+		db_msg_reply = dbus_message_new_method_return(msg);
+		return send_message_and_unref(conn,db_msg_reply);
+	}
+
+	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+}
+
+gpointer logitech_mediapad_init(int isk, int uinput_fd) {
+	struct mp_state *mp = g_new0(struct mp_state,1); 
+	int on_dbus = 0,ln = 0; DBusConnection *db_conn = NULL; DBusError db_err; 
+
+	mp->uinput = uinput_fd;
+	mp->sock   = isk;
+	sleep(3); set_clock(isk);
+
+	/* Get-on-D-Bus :P */
+	dbus_error_init(&db_err);
+	db_conn = dbus_bus_get(DBUS_BUS_SYSTEM,&db_err);
+	if (db_conn) {
+		on_dbus = 1;
+		dbus_connection_set_exit_on_disconnect(db_conn,FALSE);
+		setup_dbus_with_main_loop(db_conn);
+		
+		/* Set our name */
+		ln = dbus_bus_request_name(db_conn,MP_DBUS_PATH,DBUS_NAME_FLAG_REPLACE_EXISTING,&db_err);
+		if (dbus_error_is_set(&db_err)) {
+			info("db_err was set! (%s: %s)\n",db_err.name,db_err.message ? db_err.message : "Out of Memory?");
+			on_dbus = 0; dbus_connection_unref(db_conn); db_conn = NULL;
+		} else if (ln != DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER) info("Unable to own...\n");
+	} else info("db_conn is NULL!\n");
+	dbus_error_free(&db_err);
+
+	if (on_dbus) {
+		mp->db_conn = db_conn;
+		if (!dbus_connection_register_object_path(db_conn,MP_DBUS_SIGNAL_PATH,&mp_vtable,mp)) 
+			error("Unable to register object path!");
+	}
+
+	return (gpointer)mp;
+}
+
+gboolean logitech_mediapad_io_cb(GIOChannel *chan, GIOCondition cond, gpointer data) {
+	int ln = 0, isk = 0; char buf[26]; struct mp_state *mp = (struct mp_state *)data;
+
+	isk = g_io_channel_unix_get_fd(chan);
+
+	if (cond == G_IO_IN) {
+		memset(buf,0,26);
+		if ((ln = read(isk, buf, sizeof(buf))) <= 0) { 
+			g_free(buf);
+			g_io_channel_unref(chan);
+			return FALSE;
+		} 
+
+		if (buf[1] == 0x03) { /* Special Keys */
+			/* e9 = vol up, ea = vol down, e2 = mute, b5 = ffwd, b6 = rew, b7 = stop, cd = play/pause */
+			if (buf[2] == (char)0x83 && buf[3] == 0x02) { 
+				clear_screen(isk); 
+				if (mp->icons & LCD_ICON_MUTE) { mp->icons = LCD_ICON_MUTE; set_lcd_indicator(isk, LCD_ICON_MUTE, 1); }
+			}
+			if (buf[2] == (char)0x00 && buf[3] == 0x00) { 
+				if (mp->prev_key != 0) { inject_key(mp->uinput,mp->prev_key,0); mp->prev_key = 0; } 
+				if (mp->discard_keyup) mp->discard_keyup = 0; 
+				else mp->mode = 0; 
+			}
+			if (buf[2] == (char)0x83 && buf[3] == 0x01) { mp->prev_key = KEY_PHONE; inject_key(mp->uinput,mp->prev_key,1); }
+			if (buf[2] == (char)0xb5 && buf[3] == 0x00) { mp->prev_key = KEY_NEXTSONG;     mp->discard_keyup = 1; inject_key(mp->uinput,mp->prev_key,1); }
+			if (buf[2] == (char)0xb6 && buf[3] == 0x00) { mp->prev_key = KEY_PREVIOUSSONG; mp->discard_keyup = 1; inject_key(mp->uinput,mp->prev_key,1); }
+			if (buf[2] == (char)0xb7 && buf[3] == 0x00) { mp->prev_key = KEY_STOP;         inject_key(mp->uinput,mp->prev_key,1); }
+			if (buf[2] == (char)0xcd && buf[3] == 0x00) { mp->prev_key = KEY_PLAYPAUSE;    inject_key(mp->uinput,mp->prev_key,1); }
+			if (buf[2] == (char)0xe2 && buf[3] == 0x00) { mp->prev_key = KEY_MUTE;         inject_key(mp->uinput,mp->prev_key,1); 
+								      mp->icons    = ((mp->icons & LCD_ICON_MUTE) != 0) ? 
+								     		      (mp->icons & ~LCD_ICON_MUTE) : (mp->icons | LCD_ICON_MUTE); 
+								     set_lcd_indicator(isk, LCD_ICON_MUTE, ((mp->icons & LCD_ICON_MUTE) != 0) ? 1 : 0); }
+			if (buf[2] == (char)0xe9 && buf[3] == 0x00) { mp->prev_key = KEY_VOLUMEUP;     inject_key(mp->uinput,mp->prev_key,1); 
+								      mp->icons    = (mp->icons & ~LCD_ICON_MUTE); set_lcd_indicator(isk, LCD_ICON_MUTE, 0); }
+			if (buf[2] == (char)0xea && buf[3] == 0x00) { mp->prev_key = KEY_VOLUMEDOWN;   inject_key(mp->uinput,mp->prev_key,1); 
+								      mp->icons    = (mp->icons & ~LCD_ICON_MUTE); set_lcd_indicator(isk, LCD_ICON_MUTE, 0); }
+		} else if (buf[1] == 0x01 && buf[2] == 0x00) {
+			if (buf[4] == 0x53 && buf[5] == 0x00) { mp->mode = 1; mp->prev_key = 0; } /* NAV key */
+			else if (buf[4] == 0x00 && buf[5] == 0x00 && mp->prev_key != 0) inject_key(mp->uinput,mp->prev_key,0);
+			else if (buf[4] != 0x00) { mp->prev_key = translate_key(mp->mode,buf[4] & 0x7f); inject_key(mp->uinput,mp->prev_key,1); }
+		} else if (buf[1] == 0x11 && buf[2] == 0x0a) { /* Calculator Result */
+			/*
+			 cwtmp = &buf[4]; while (*cwtmp && *cwtmp == 0x20) cwtmp++;
+			 syslog(LOG_WARNING,"Got Calc result");
+			 */
+		}
+	} else {
+		if (mp->db_conn) {
+			dbus_connection_unregister_object_path(mp->db_conn,MP_DBUS_PATH);
+			dbus_connection_unref(mp->db_conn); 
+		}
+		g_free(mp); 
+		return FALSE; 
+	}
+	return TRUE;
+}
+
diff -ru bluez-utils-3.19/input/logitech_mediapad.h bluez-utils-3.19/input/logitech_mediapad.h
--- bluez-utils-3.19/input/logitech_mediapad.h	2007-09-22 19:03:39.610625879 -0400
+++ bluez-utils-3.19/input/logitech_mediapad.h	2007-09-22 19:04:34.101731150 -0400
@@ -0,0 +1,7 @@
+#ifndef LOGITECH_MEDIAPAD_H
+#define LOGITECH_MEDIAPAD_H
+
+gpointer logitech_mediapad_init(int isk, int uinput_fd);
+gboolean logitech_mediapad_io_cb(GIOChannel *chan, GIOCondition cond, gpointer data);
+
+#endif

--MP_L_bc9w1O3W+9RLjOWav4Q+y
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--MP_L_bc9w1O3W+9RLjOWav4Q+y
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--MP_L_bc9w1O3W+9RLjOWav4Q+y--
