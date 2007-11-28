Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 28 Nov 2007 14:14:41 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20071128191441.GL24494@cathedrallabs.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH 2/2] utils/input: add support to fake HID
	devices
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

Devices like the PS3 Blu-Ray remote controller reports themselves as HID
devices but they don't implement the HID protocol correctly. This patch
adds support to implement suport for "fake" HID devices. The patch
adding support to PS3 Blu-Ray remote controller will be sent after the
keymap problems are sorted out.

---
 input/Makefile.am |    2 -
 input/device.c    |   36 ++++-----------------
 input/device.h    |   28 ++++++++++++++++
 input/fake_hid.c  |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 input/fake_hid.h  |   20 ++++++++++++
 5 files changed, 146 insertions(+), 30 deletions(-)

--- a/input/device.c	2007-11-28 11:56:38.000000000 -0500
+++ b/input/device.c	2007-11-28 11:56:39.000000000 -0500
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
@@ -1342,13 +1315,18 @@ int input_device_close_channels(bdaddr_t
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
+++ b/input/fake_hid.h	2007-11-28 11:56:39.000000000 -0500
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
+++ b/input/fake_hid.c	2007-11-28 11:56:39.000000000 -0500
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
--- a/input/device.h	2007-11-28 11:56:35.000000000 -0500
+++ b/input/device.h	2007-11-28 11:56:39.000000000 -0500
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
--- a/input/Makefile.am	2007-11-28 11:56:37.000000000 -0500
+++ b/input/Makefile.am	2007-11-28 11:56:39.000000000 -0500
@@ -13,7 +13,7 @@ service_PROGRAMS = bluetoothd-service-in
 bluetoothd_service_input_SOURCES = main.c \
 	manager.h manager.c \
 	server.h server.c device.h device.c storage.h storage.c \
-	bluetooth_ids.h
+	bluetooth_ids.h fake_hid.c fake_hid.h
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
