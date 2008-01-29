Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 00:12:20 -0500
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080129051220.GC14674@jake.ruivo.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH 2/4] add connect,
	disconnect and is_connected methods to	fake_input
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

This patch adds three methods to fake_input structure, in order to
prepare fake_hid support addition.

---
 input/device.c |   68 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 25 deletions(-)

--- a/input/device.c	2008-01-28 23:33:25.000000000 -0500
+++ b/input/device.c	2008-01-28 23:33:27.000000000 -0500
@@ -65,6 +65,9 @@ struct fake_input {
 	int		rfcomm; /* RFCOMM socket */
 	int		uinput;	/* uinput socket */
 	uint8_t		ch;	/* RFCOMM channel number */
+	gboolean 	(*connect)(struct device *idev);
+	int		(*disconnect)(struct device *idev);
+	int		(is_connected)(struct device *idev);
 };
 
 struct device {
@@ -761,6 +764,26 @@ failed:
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
@@ -769,22 +792,8 @@ static int disconnect(struct device *ide
 	int ctl, err;
 
 	/* Fake input disconnect */
-	if (fake) {
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
-	}
+	if (fake)
+		return fake->disconnect(idev);
 
 	/* Standard HID disconnect */
 	if (idev->ctrl_sk >= 0) {
@@ -837,12 +846,8 @@ static int is_connected(struct device *i
 	int ctl;
 
 	/* Fake input */
-	if (fake) {
-		if (fake->io)
-			return 1;
-		else
-			return 0;
-	}
+	if (fake)
+		return fake->is_connected(idev);
 
 	/* Standard HID */
 	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
@@ -871,6 +876,7 @@ static DBusHandlerResult device_connect(
 					DBusMessage *msg, void *data)
 {
 	struct device *idev = data;
+	struct fake_input *fake = idev->fake;
 
 	if (idev->pending_connect)
 		return error_in_progress(conn, msg,
@@ -882,11 +888,11 @@ static DBusHandlerResult device_connect(
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
@@ -1120,6 +1126,15 @@ int input_device_register(DBusConnection
 	return err;
 }
 
+static int fake_is_connected(struct device *idev)
+{
+	struct fake_input *fake = idev->fake;
+
+	if (fake->io)
+		return 1;
+	return 0;
+}
+
 int fake_input_register(DBusConnection *conn, bdaddr_t *src,
 			bdaddr_t *dst, uint8_t ch, const char **ppath)
 {
@@ -1144,6 +1159,9 @@ int fake_input_register(DBusConnection *
 
 	idev->fake = g_new0(struct fake_input, 1);
 	idev->fake->ch = ch;
+	idev->fake->connect = rfcomm_connect;
+	idev->fake->disconnect = fake_disconnect;
+	idev->fake->is_connected = fake_is_connected;
 
 	err = register_path(conn, path, idev);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
