Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 7 Oct 2007 14:40:32 -0400
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20071007184032.GZ7430@cathedrallabs.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [RFC][PATCH 3/4] add support to fake HID devices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This patch adds support to fake HID devices. Instead of registering with
kernel, the fake HID will be handled in user level and an uinput device
will be created in order to get the events into input layer.

--- input.orig/device.c	2007-10-07 12:06:04.000000000 -0400
+++ input/device.c	2007-10-07 12:06:04.000000000 -0400
@@ -53,6 +53,7 @@
 #include "manager.h"
 #include "storage.h"
 #include "bluetooth_ids.h"
+#include "fake_hid.h"
 
 #define INPUT_DEVICE_INTERFACE	"org.bluez.input.Device"
 
@@ -60,34 +61,6 @@
 
 #define UPDOWN_ENABLED		1
 
-struct fake_input {
-	GIOChannel	*io;
-	int		rfcomm; /* RFCOMM socket */
-	int		uinput;	/* uinput socket */
-	uint8_t		ch;	/* RFCOMM channel number */
-	gboolean 	(*connect)(struct device *idev);
-	int		(*disconnect)(struct device *idev);
-	int		(is_connected)(struct device *idev);
-};
-
-struct device {
-	bdaddr_t		src;
-	bdaddr_t		dst;
-	char			*name;
-	uint8_t			major;
-	uint8_t			minor;
-	uint16_t		product;
-	uint16_t		vendor;
-	struct fake_input	*fake;
-	DBusMessage		*pending_connect;
-	DBusConnection		*conn;
-	char			*path;
-	int			ctrl_sk;
-	int			intr_sk;
-	guint			ctrl_watch;
-	guint			intr_watch;
-};
-
 GSList *devices = NULL;
 
 static struct device *device_new(bdaddr_t *src, bdaddr_t *dst, uint8_t subclass)
@@ -1339,13 +1312,18 @@
 int input_device_connadd(bdaddr_t *src, bdaddr_t *dst)
 {
 	struct device *idev;
+	struct fake_hid *fake_hid;
 	int err;
 
 	idev = find_device(src, dst);
 	if (!idev)
 		return -ENOENT;
 
-	err = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
+	fake_hid = is_fake_hid(idev);
+	if (fake_hid)
+		err = fake_hid_connadd(idev, fake_hid);
+	else
+		err = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
 	if (err < 0) {
 		close(idev->ctrl_sk);
 		close(idev->intr_sk);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ input/fake_hid.h	2007-10-07 12:06:04.000000000 -0400
@@ -0,0 +1,20 @@
+#ifndef FAKE_HID_H
+#define FAKE_HID_H
+#include <glib.h>
+struct device;
+struct fake_hid;
+
+struct fake_hid {
+	uint16_t vendor;
+	uint16_t product;
+	gboolean (*connect)(struct device *idev);
+	int (*disconnect)(struct device *idev);
+	int (*is_connected)(struct device *idev);
+	gboolean (*event)(GIOChannel *chan, GIOCondition cond, gpointer data);
+	int (*setup_uinput)(struct device *idev, struct fake_hid *fake_hid);
+};
+
+struct fake_hid *is_fake_hid(struct device *idev);
+int fake_hid_connadd(struct device *idev, struct fake_hid *fake_hid);
+#endif	/* FAKE_HID_H */
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ input/fake_hid.c	2007-10-07 12:12:21.000000000 -0400
@@ -0,0 +1,90 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hidp.h>
+#include <bluetooth/l2cap.h>
+#include "logging.h"
+#include "bluetooth_ids.h"
+#include "device.h"
+#include "fake_hid.h"
+
+#define FAKE_HID_ENTRY(v, p, c, d, i, e, s) { \
+	.vendor = BLUETOOTH_VENDOR_ID_##v, \
+	.product = BLUETOOTH_DEVICE_ID_##p, \
+	.connect = c, \
+	.disconnect = d, \
+	.is_connected = i, \
+	.event = e, \
+	.setup_uinput = s, \
+	}
+
+static gboolean fake_hid_common_connect(struct device *idev)
+{
+	return TRUE;
+}
+
+static int fake_hid_common_disconnect(struct device *idev)
+{
+	return 0;
+}
+
+static int fake_hid_common_is_connected(struct device *idev)
+{
+	return 1;
+}
+
+static struct fake_hid fake_hid_table[] = {
+	{ },
+};
+
+static inline int fake_hid_match_device(struct device *idev,
+					struct fake_hid *fhid)
+{
+	return idev->vendor == fhid->vendor &&
+	       idev->product == fhid->product;
+}
+
+struct fake_hid *is_fake_hid(struct device *idev)
+{
+	int i;
+
+	for (i = 0; fake_hid_table[i].vendor != 0; i++)
+		if (fake_hid_match_device(idev, &fake_hid_table[i]))
+			return &fake_hid_table[i];
+
+	return NULL;
+}
+
+int fake_hid_connadd(struct device *idev, struct fake_hid *fake_hid)
+{
+	struct fake_input *fake;
+
+	fake = malloc(sizeof(struct fake_input));
+	if (fake == NULL)
+		return ENOMEM;
+	memset(fake, 0, sizeof(struct fake_input));
+
+	fake->connect = fake_hid->connect;
+	fake->disconnect = fake_hid->disconnect;
+	fake->is_connected = fake_hid->is_connected;
+	idev->fake = fake;
+
+	if (fake_hid->setup_uinput(idev, fake_hid)) {
+		error("Error setting up uinput");
+		free(fake);
+		idev->fake = NULL;
+		return 1;
+	}
+
+	fake->io = g_io_channel_unix_new(idev->intr_sk);
+	g_io_channel_set_close_on_unref(fake->io, TRUE);
+	g_io_add_watch(fake->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) fake_hid->event, fake);
+
+	return 0;
+}
+
--- input.orig/device.h	2007-10-07 12:04:19.000000000 -0400
+++ input/device.h	2007-10-07 12:06:04.000000000 -0400
@@ -24,6 +24,34 @@
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13
 
+struct device {
+	bdaddr_t		src;
+	bdaddr_t		dst;
+	char			*name;
+	uint8_t			major;
+	uint8_t			minor;
+	uint16_t		product;
+	uint16_t		vendor;
+	struct fake_input	*fake;
+	DBusMessage		*pending_connect;
+	DBusConnection		*conn;
+	char			*path;
+	int			ctrl_sk;
+	int			intr_sk;
+	guint			ctrl_watch;
+	guint			intr_watch;
+};
+
+struct fake_input {
+	GIOChannel	*io;
+	int		rfcomm; /* RFCOMM socket */
+	int		uinput;	/* uinput socket */
+	uint8_t		ch;	/* RFCOMM channel number */
+	gboolean 	(*connect)(struct device *idev);
+	int		(*disconnect)(struct device *idev);
+	int		(*is_connected)(struct device *idev);
+};
+
 int input_device_register(DBusConnection *conn, bdaddr_t *src, bdaddr_t *dst,
 			struct hidp_connadd_req *hidp, const char **ppath);
 int fake_input_register(DBusConnection *conn, bdaddr_t *src,
Index: input/Makefile.am
===================================================================
--- input.orig/Makefile.am	2007-10-07 12:06:04.000000000 -0400
+++ input/Makefile.am	2007-10-07 12:06:04.000000000 -0400
@@ -13,7 +13,8 @@
 bluetoothd_service_input_SOURCES = main.c \
 	manager.h manager.c error.h error.c \
 	server.h server.c device.h device.c \
-	storage.h storage.c bluetooth_ids.h
+	storage.h storage.c bluetooth_ids.h \
+	fake_hid.c fake_hid.h
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
