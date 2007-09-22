Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 22 Sep 2007 18:49:02 +0100
Message-Id: <1190483342.7150.224.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Claudio Takahasi <cktakahasi@gmail.com>, marcel@holtmann.org
Subject: [Bluez-devel] [PATCH] Attempt bonding with keyboards.
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

My Nokia SU-8W keyboard will never attempt to reconnect to the computer
after a power cycle unless we actually pair with it. With the input
service as it currently stands, we don't -- so it works once, but then
next time I want to use it I need to go through the whole search and
'add new input device' process again (and the bluetooth-properties
applet crashes when you try to add a device which already exists, which
is not so cute).

This patch makes the input service attempt bonding with new keyboards.
It will ignore errors though -- if bonding fails, it still goes ahead
and connects as before.

I've tested this with the two input devices I have to hand -- both with
successful pairing and when I allow pairing to fail. It would be
interesting to test it on the keyboards which have problems with
pairing.

A critical pair of eyes over my first attempt at using dbus probably
wouldn't go amiss. :)

diff --git a/input/manager.c b/input/manager.c
index 5dfb064..f1d25dc 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -415,6 +415,29 @@ failed:
 	return FALSE;
 }
 
+static void create_bonding_reply(DBusPendingCall *call, void *data)
+{
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	struct pending_req *pr = data;
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		error("CreateBonding failed: %s(%s)",
+					derr.name, derr.message);
+		/* But ignore the error */
+	}
+
+	dbus_message_unref(reply);
+
+	if (l2cap_connect(&pr->src, &pr->dst, L2CAP_PSM_HIDP_CTRL,
+				(GIOFunc) control_connect_cb, pr) < 0) {
+		int err = errno;
+		error("L2CAP connect failed:%s (%d)", strerror(err), err);
+		err_connection_failed(pr->conn, pr->msg, strerror(err));
+	}
+}
+
 static void finish_sdp_transaction(bdaddr_t *dba) 
 {
 	char address[18], *addr_ptr = address;
@@ -450,6 +473,34 @@ static void finish_sdp_transaction(bdaddr_t *dba)
 	dbus_message_unref(reply);
 }
 
+static int start_bonding_attempt(DBusPendingCall *call, struct pending_req *pr)
+{
+	DBusPendingCall *pending;
+	DBusMessage *msg;
+	char address[18], *addr_ptr = address;
+
+	msg = dbus_message_new_method_call("org.bluez", pr->adapter_path,
+					   "org.bluez.Adapter", "CreateBonding");
+	if (!msg) {
+		error("Unable to allocate new method call");
+		err_not_supported(pr->conn, pr->msg);
+		return -1;
+	}
+
+	ba2str(&pr->dst, address);
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &addr_ptr, DBUS_TYPE_INVALID);
+	if (dbus_connection_send_with_reply(pr->conn, msg, &pending, -1) == FALSE) {
+		error("Can't send D-Bus message.");
+		err_not_supported(pr->conn, pr->msg);
+		dbus_message_unref(msg);
+		return -1;
+	}
+	dbus_pending_call_set_notify(pending, create_bonding_reply, pr, NULL);
+	dbus_pending_call_unref(pending);
+	dbus_message_unref(msg);
+	return 0;
+}
+
 static void hid_record_reply(DBusPendingCall *call, void *data)
 {
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
@@ -457,6 +508,7 @@ static void hid_record_reply(DBusPendingCall *call, void *data)
 	DBusError derr;
 	uint8_t *rec_bin;
 	int len, scanned;
+	sdp_data_t *pdlist;
 
 	dbus_error_init(&derr);
 	if (dbus_set_error_from_message(&derr, reply)) {
@@ -493,13 +545,19 @@ static void hid_record_reply(DBusPendingCall *call, void *data)
 		goto fail;
 	}
 
-	if (l2cap_connect(&pr->src, &pr->dst, L2CAP_PSM_HIDP_CTRL,
-				(GIOFunc) control_connect_cb, pr) < 0) {
-		int err = errno;
-		error("L2CAP connect failed:%s (%d)", strerror(err), err);
-		err_connection_failed(pr->conn, pr->msg, strerror(err));
-		goto fail;
-
+	pdlist = sdp_data_get(pr->hid_rec, SDP_ATTR_HID_DEVICE_SUBCLASS);
+	if (pdlist && (pdlist->val.uint8 & 0x40)) {
+		if (start_bonding_attempt(call, pr))
+			goto fail;
+	} else {
+		/* No encryption -- connect control channel */
+		if (l2cap_connect(&pr->src, &pr->dst, L2CAP_PSM_HIDP_CTRL,
+				  (GIOFunc) control_connect_cb, pr) < 0) {
+			int err = errno;
+			error("L2CAP connect failed:%s (%d)", strerror(err), err);
+			err_connection_failed(pr->conn, pr->msg, strerror(err));
+			goto fail;
+		}
 	}
 	dbus_message_unref(reply);
 


-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
