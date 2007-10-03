Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Wed, 3 Oct 2007 10:19:06 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6/tAHuJM6xZm/vJ"
Message-Id: <200710031019.06334.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] FindAdapter try #2
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

--Boundary-00=_6/tAHuJM6xZm/vJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

Should be code standard compliant now ;)

-Denis

--Boundary-00=_6/tAHuJM6xZm/vJ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="find_adapter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="find_adapter.patch"

Index: manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/manager.c,v
retrieving revision 1.6
diff -u -5 -r1.6 manager.c
--- manager.c	26 Sep 2007 13:56:30 -0000	1.6
+++ manager.c	3 Oct 2007 00:16:30 -0000
@@ -99,10 +99,54 @@
 					DBUS_TYPE_INVALID);
 
 	return send_message_and_unref(conn, reply);
 }
 
+static int find_by_address(const char *str)
+{
+	struct hci_dev_list_req *dl;
+	struct hci_dev_req *dr;
+	bdaddr_t ba;
+	int i, sk;
+	int devid = -1;
+	
+	sk = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (sk < 0)
+		return -1;
+
+	dl = g_malloc0(HCI_MAX_DEV * sizeof(*dr) + sizeof(*dl));
+
+	dl->dev_num = HCI_MAX_DEV;
+	dr = dl->dev_req;
+
+	if (ioctl(sk, HCIGETDEVLIST, dl) < 0)
+		goto out;
+
+	dr = dl->dev_req;
+	str2ba(str, &ba);
+
+	for (i = 0; i < dl->dev_num; i++, dr++) {
+		struct hci_dev_info di;
+
+		if (hci_devinfo(dr->dev_id, &di) < 0)
+			continue;
+
+		if (hci_test_bit(HCI_RAW, &di.flags))
+			continue;
+
+		if (!bacmp(&ba, &di.bdaddr)) {
+			devid = dr->dev_id;
+			break;
+		}
+	}
+
+out:
+	g_free(dl);
+	close(sk);
+	return devid;
+}
+
 static DBusHandlerResult find_adapter(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
 	char path[MAX_PATH_LENGTH], *path_ptr = path;
@@ -113,11 +157,18 @@
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &pattern,
 				DBUS_TYPE_INVALID))
 		return error_invalid_arguments(conn, msg);
 
-	dev_id = hci_devid(pattern);
+	/* hci_devid() would make sense to use here, except it
+	   is restricted to devices which are up */
+	if (!strncmp(pattern, "hci", 3) && strlen(pattern) >= 4) {
+		dev_id = atoi(pattern + 3);
+	} else {
+		dev_id = find_by_address(pattern);
+	}
+
 	if (dev_id < 0)
 		return error_no_such_adapter(conn, msg);
 
 	if (hci_devinfo(dev_id, &di) < 0)
 		return error_no_such_adapter(conn, msg);

--Boundary-00=_6/tAHuJM6xZm/vJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--Boundary-00=_6/tAHuJM6xZm/vJ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_6/tAHuJM6xZm/vJ--
