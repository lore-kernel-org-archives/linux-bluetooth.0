Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Feb 2008 22:55:20 -0500
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080212035520.GA12258@cathedrallabs.org>
References: <20080212030659.GC17385@jake.ruivo.org>
MIME-Version: 1.0
In-Reply-To: <20080212030659.GC17385@jake.ruivo.org>
Subject: [Bluez-devel] [PATCH 2/4] input/device: add support to
	connect/disconnect	methods (v4)
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

This patch adds two methods to fake_input structure, in order to
prepare for fake_hid support.

---
 input/device.c |   61 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

--- a/input/device.c	2008-02-11 22:28:39.000000000 -0500
+++ b/input/device.c	2008-02-11 22:53:04.000000000 -0500
@@ -59,11 +59,16 @@
 
 #define UPDOWN_ENABLED		1
 
+#define FI_FLAG_CONNECTED	1
+
 struct fake_input {
+	int		flags;
 	GIOChannel	*io;
 	int		rfcomm; /* RFCOMM socket */
 	int		uinput;	/* uinput socket */
 	uint8_t		ch;	/* RFCOMM channel number */
+	gboolean	(*connect)(struct device *idev);
+	int		(*disconnect)(struct device *idev);
 };
 
 struct device {
@@ -759,6 +764,26 @@ failed:
 	return FALSE;
 }
 
+static int fake_disconnect(struct device *idev)
+{
+	struct fake_input *fake = idev->fake;
+
+	if (!fake->io)
+		return -ENOTCONN;
+
+	g_io_channel_close(fake->io);
+	g_io_channel_unref(fake->io);
+	fake->io = NULL;
+
+	if (fake->uinput >= 0) {
+		ioctl(fake->uinput, UI_DEV_DESTROY);
+		close(fake->uinput);
+		fake->uinput = -1;
+	}
+
+	return 0;
+}
+
 static int disconnect(struct device *idev, uint32_t flags)
 {
 	struct fake_input *fake = idev->fake;
@@ -768,20 +793,10 @@ static int disconnect(struct device *ide
 
 	/* Fake input disconnect */
 	if (fake) {
-		if (!fake->io)
-			return -ENOTCONN;
-
-		g_io_channel_close(fake->io);
-		g_io_channel_unref(fake->io);
-		fake->io = NULL;
-
-		if (fake->uinput >= 0) {
-			ioctl(fake->uinput, UI_DEV_DESTROY);
-			close(fake->uinput);
-			fake->uinput = -1;
-		}
-
-		return 0;
+		err = fake->disconnect(idev);
+		if (err == 0)
+			fake->flags &= ~FI_FLAG_CONNECTED;
+		return err;
 	}
 
 	/* Standard HID disconnect */
@@ -835,12 +850,8 @@ static int is_connected(struct device *i
 	int ctl;
 
 	/* Fake input */
-	if (fake) {
-		if (fake->io)
-			return 1;
-		else
-			return 0;
-	}
+	if (fake)
+		return fake->flags & FI_FLAG_CONNECTED;
 
 	/* Standard HID */
 	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
@@ -869,6 +880,7 @@ static DBusHandlerResult device_connect(
 					DBusMessage *msg, void *data)
 {
 	struct device *idev = data;
+	struct fake_input *fake = idev->fake;
 
 	if (idev->pending_connect)
 		return error_in_progress(conn, msg,
@@ -880,16 +892,17 @@ static DBusHandlerResult device_connect(
 	idev->pending_connect = dbus_message_ref(msg);
 
 	/* Fake input device */
-	if (idev->fake) {
-		if (rfcomm_connect(idev) < 0) {
+	if (fake) {
+		if (fake->connect(idev) < 0) {
 			int err = errno;
 			const char *str = strerror(err);
-			error("RFCOMM connect failed: %s(%d)", str, err);
+			error("Connect failed: %s(%d)", str, err);
 			dbus_message_unref(idev->pending_connect);
 			idev->pending_connect = NULL;
 			return error_connection_attempt_failed(conn,
 					msg, err);
 		}
+		fake->flags |= FI_FLAG_CONNECTED;
 		return DBUS_HANDLER_RESULT_HANDLED;
 	}
 
@@ -1142,6 +1155,8 @@ int fake_input_register(DBusConnection *
 
 	idev->fake = g_new0(struct fake_input, 1);
 	idev->fake->ch = ch;
+	idev->fake->connect = rfcomm_connect;
+	idev->fake->disconnect = fake_disconnect;
 
 	err = register_path(conn, path, idev);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
