Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Mar 2008 11:06:43 -0400
From: Aristeu Rozanski <aris@ruivo.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080313150643.GI8969@cathedrallabs.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH 1/2 v011] add support to fake HID devices
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

---
 input/Makefile.am |    3 +-
 input/device.c    |   58 ++++++++++++++++++++++++++++++++++++----------------
 input/device.h    |   12 ++++++++++
 input/fakehid.c   |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 input/fakehid.h   |   18 ++++++++++++++++
 5 files changed, 132 insertions(+), 19 deletions(-)

--- a/input/device.c	2008-03-13 10:07:06.000000000 -0400
+++ b/input/device.c	2008-03-13 11:03:44.000000000 -0400
@@ -52,6 +52,7 @@
 #include "error.h"
 #include "manager.h"
 #include "storage.h"
+#include "fakehid.h"
 
 #define INPUT_DEVICE_INTERFACE	"org.bluez.input.Device"
 
@@ -63,16 +64,6 @@
 
 struct device;
 
-struct fake_input {
-	int		flags;
-	GIOChannel	*io;
-	int		rfcomm; /* RFCOMM socket */
-	int		uinput;	/* uinput socket */
-	uint8_t		ch;	/* RFCOMM channel number */
-	gboolean	(*connect)(struct device *idev);
-	int		(*disconnect)(struct device *idev);
-};
-
 struct device {
 	bdaddr_t		src;
 	bdaddr_t		dst;
@@ -1336,24 +1327,47 @@ int input_device_close_channels(bdaddr_t
 	return 0;
 }
 
+static gboolean fake_hid_connect(struct device *dev)
+{
+	struct fake_hid *fhid = dev->fake->priv;
+
+	return fhid->connect(dev->fake);
+}
+
+static int fake_hid_disconnect(struct device *dev)
+{
+	struct fake_hid *fhid = dev->fake->priv;
+
+	return fhid->disconnect(dev->fake);
+}
+
 int input_device_connadd(bdaddr_t *src, bdaddr_t *dst)
 {
 	struct device *idev;
+	struct fake_hid *fake_hid;
+	struct fake_input *fake = NULL;
 	int err;
 
 	idev = find_device(src, dst);
 	if (!idev)
 		return -ENOENT;
 
-	err = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
-	if (err < 0) {
-		close(idev->ctrl_sk);
-		close(idev->intr_sk);
-		idev->ctrl_sk = -1;
-		idev->intr_sk = -1;
+	fake_hid = get_fake_hid(idev->vendor, idev->product);
+	if (fake_hid) {
+		fake = g_try_new0(struct fake_input, 1)
+		if (!fake) {
+			err = -ENOMEM;
+			goto error;
+		}
 
-		return err;
-	}
+		fake->connect = fake_hid_connect;
+		fake->disconnect = fake_hid_disconnect;
+		fake->priv = fake_hid;
+		err = fake_hid_connadd(fake, idev->intr_sk, fake_hid);
+	} else
+		err = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
+	if (err < 0)
+		goto error;
 
 	idev->intr_watch = create_watch(idev->intr_sk, intr_watch_cb, idev);
 	idev->ctrl_watch = create_watch(idev->ctrl_sk, ctrl_watch_cb, idev);
@@ -1363,4 +1377,12 @@ int input_device_connadd(bdaddr_t *src, 
 			"Connected",
 			DBUS_TYPE_INVALID);
 	return 0;
+error:
+	close(idev->ctrl_sk);
+	close(idev->intr_sk);
+	idev->ctrl_sk = -1;
+	idev->intr_sk = -1;
+	if (fake)
+		gfree(fake);
+	return err;
 }
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/input/fakehid.h	2008-03-13 10:07:11.000000000 -0400
@@ -0,0 +1,18 @@
+#ifndef FAKEHID_H
+#define FAKEHID_H
+#include <glib.h>
+struct fake_hid;
+struct fake_input;
+
+struct fake_hid {
+	uint16_t vendor;
+	uint16_t product;
+	gboolean (*connect)(struct fake_input *fake_input);
+	int (*disconnect)(struct fake_input *fake_input);
+	gboolean (*event)(GIOChannel *chan, GIOCondition cond, gpointer data);
+	int (*setup_uinput)(struct fake_input *fake, struct fake_hid *fake_hid);
+};
+struct fake_hid *get_fake_hid(uint16_t vendor, uint16_t product);
+int fake_hid_connadd(struct fake_input *fake, int intr_sk,
+		     struct fake_hid *fake_hid);
+#endif	/* FAKEHID_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/input/fakehid.c	2008-03-13 10:37:46.000000000 -0400
@@ -0,0 +1,60 @@
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
+#include "device.h"
+#include "fakehid.h"
+
+static gboolean fake_hid_common_connect(struct fake_input *fake)
+{
+	return TRUE;
+}
+
+static int fake_hid_common_disconnect(struct fake_input *fake)
+{
+	return 0;
+}
+
+static struct fake_hid fake_hid_table[] = {
+	{ },
+};
+
+static inline int fake_hid_match_device(uint16_t vendor, uint16_t product,
+					struct fake_hid *fhid)
+{
+	return vendor == fhid->vendor && product == fhid->product;
+}
+
+struct fake_hid *get_fake_hid(uint16_t vendor, uint16_t product)
+{
+	int i;
+
+	for (i = 0; fake_hid_table[i].vendor != 0; i++)
+		if (fake_hid_match_device(vendor, product, &fake_hid_table[i]))
+			return &fake_hid_table[i];
+
+	return NULL;
+}
+
+int fake_hid_connadd(struct fake_input *fake, int intr_sk,
+		     struct fake_hid *fake_hid)
+{
+	if (fake_hid->setup_uinput(fake, fake_hid)) {
+		error("Error setting up uinput");
+		return ENOMEM;
+	}
+
+	fake->io = g_io_channel_unix_new(intr_sk);
+	g_io_channel_set_close_on_unref(fake->io, TRUE);
+	g_io_add_watch(fake->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) fake_hid->event, fake);
+
+	return 0;
+}
+
--- a/input/device.h	2008-03-13 10:07:06.000000000 -0400
+++ b/input/device.h	2008-03-13 10:47:50.000000000 -0400
@@ -24,6 +24,18 @@
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13
 
+struct device;
+struct fake_input {
+	int		flags;
+	GIOChannel	*io;
+	int		uinput;	/* uinput socket */
+	int		rfcomm; /* RFCOMM socket */
+	uint8_t		ch;	/* RFCOMM channel number */
+	gboolean 	(*connect) (struct device *dev);
+	int		(*disconnect) (struct device *dev);
+	void		*priv;
+};
+
 int input_device_register(DBusConnection *conn, bdaddr_t *src, bdaddr_t *dst,
 			struct hidp_connadd_req *hidp, const char **ppath);
 int fake_input_register(DBusConnection *conn, bdaddr_t *src,
--- a/input/Makefile.am	2008-03-13 10:07:05.000000000 -0400
+++ b/input/Makefile.am	2008-03-13 10:07:11.000000000 -0400
@@ -12,7 +12,8 @@ service_PROGRAMS = bluetoothd-service-in
 
 bluetoothd_service_input_SOURCES = main.c \
 	manager.h manager.c \
-	server.h server.c device.h device.c storage.h storage.c
+	server.h server.c device.h device.c storage.h storage.c \
+	fakehid.c fakehid.h
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
