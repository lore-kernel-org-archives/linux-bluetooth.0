Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 7 Oct 2007 14:40:28 -0400
From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20071007184028.GY7430@cathedrallabs.org>
MIME-Version: 1.0
Subject: [Bluez-devel] [RFC][PATCH 2/4] add connect,
	disconnect and is_connected methods	to fake_input
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

--- input.orig/device.c	2007-10-06 23:35:10.000000000 -0400
+++ input/device.c	2007-10-06 23:55:38.000000000 -0400
@@ -65,6 +65,9 @@
 	int		rfcomm; /* RFCOMM socket */
 	int		uinput;	/* uinput socket */
 	uint8_t		ch;	/* RFCOMM channel number */
+	gboolean 	(*connect)(struct device *idev);
+	int		(*disconnect)(struct device *idev);
+	int		(is_connected)(struct device *idev);
 };
 
 struct device {
@@ -761,6 +764,26 @@
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
@@ -769,22 +792,8 @@
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
@@ -837,12 +846,8 @@
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
@@ -871,6 +876,7 @@
 					DBusMessage *msg, void *data)
 {
 	struct device *idev = data;
+	struct fake_input *fake = idev->fake;
 
 	if (idev->pending_connect)
 		return err_connection_failed(conn, msg, "Connection in progress");
@@ -881,10 +887,10 @@
 	idev->pending_connect = dbus_message_ref(msg);
 
 	/* Fake input device */
-	if (idev->fake) {
-		if (rfcomm_connect(idev) < 0) {
+	if (fake) {
+		if (fake->connect(idev) < 0) {
 			const char *str = strerror(errno);
-			error("RFCOMM connect failed: %s(%d)", str, errno);
+			error("Connect failed: %s(%d)", str, errno);
 			dbus_message_unref(idev->pending_connect);
 			idev->pending_connect = NULL;
 			return err_connection_failed(conn, msg, str);
@@ -1117,6 +1123,15 @@
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
@@ -1141,6 +1156,9 @@
 
 	idev->fake = g_new0(struct fake_input, 1);
 	idev->fake->ch = ch;
+	idev->fake->connect = rfcomm_connect;
+	idev->fake->disconnect = fake_disconnect;
+	idev->fake->is_connected = fake_is_connected;
 
 	err = register_path(conn, path, idev);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
