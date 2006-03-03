Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0603030534k54fd1485u4f079a155b72c4@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8375_18469351.1141392843583"
Subject: [Bluez-devel] [DBUS PATCH] cleanup
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 3 Mar 2006 10:34:03 -0300

------=_Part_8375_18469351.1141392843583
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is a patch to fix some error handling standard. I changed the
function handle_dev_get_remote_name, get_peer_name is not necessary
anymore because now it is possible use the function
get_device_address.

Regards,
Claudio

--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_8375_18469351.1141392843583
Content-Type: text/x-patch; name=cleanup01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ekcd49ig
Content-Disposition: attachment; filename="cleanup01.patch"

Index: hcid/dbus-adapter.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-adapter.c,v
retrieving revision 1.2
diff -u -r1.2 dbus-adapter.c
--- hcid/dbus-adapter.c	27 Feb 2006 10:24:55 -0000	1.2
+++ hcid/dbus-adapter.c	3 Mar 2006 13:23:25 -0000
@@ -63,17 +63,6 @@
 	"wearable"
 };
 
-static char *get_peer_name(const bdaddr_t *local, const bdaddr_t *peer)
-{
-	char filename[PATH_MAX + 1], addr[18];
-
-	ba2str(local, addr);
-	snprintf(filename, PATH_MAX, "%s/%s/names", STORAGEDIR, addr);
-
-	ba2str(peer, addr);
-	return textfile_get(filename, addr);
-}
-
 static DBusMessage *handle_dev_get_address_req(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
@@ -463,10 +452,8 @@
 		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
 
 	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-	}
+	if (dd < 0)
+		return error_no_such_device(msg);
 
 	if (hci_read_class_of_dev(dd, cls, 1000) < 0) {
 		syslog(LOG_ERR, "Can't read class of device on hci%d: %s(%d)",
@@ -520,10 +507,8 @@
 	int dd, i;
 
 	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-	}
+	if (dd < 0)
+		return error_no_such_device(msg);
 
 	if (hci_read_class_of_dev(dd, cls, 1000) < 0) {
 		syslog(LOG_ERR, "Can't read class of device on hci%d: %s(%d)",
@@ -689,24 +674,25 @@
 
 static DBusMessage *handle_dev_get_remote_name_req(DBusMessage *msg, void *data)
 {
+	char filename[PATH_MAX + 1], addr[18];
 	struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
 	const char *str_bdaddr;
 	char *name;
-	bdaddr_t bdaddr;
-	struct hci_dev_info di;
+	int err;
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &str_bdaddr,
 							DBUS_TYPE_INVALID);
 
-	str2ba(str_bdaddr, &bdaddr);
+	err = get_device_address(dbus_data->dev_id, addr, sizeof(addr));
+	if (err < 0)
+		return error_generic(msg, -err);
 
-	if (hci_devinfo(dbus_data->dev_id, &di) < 0) {
-		syslog(LOG_ERR, "Can't get device info");
-		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-	}
 
-	name = get_peer_name(&di.bdaddr, &bdaddr);
+	snprintf(filename, PATH_MAX, "%s/%s/names", STORAGEDIR, addr);
+
+	name = textfile_get(filename, str_bdaddr);
+
 	if (!name)
 		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_RECORD_NOT_FOUND);
 
@@ -903,7 +889,7 @@
 	cr->type = ACL_LINK;
 
 	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
 		goto done;
 	}
 
@@ -922,7 +908,7 @@
 	if (hci_send_req(dd, &rq, 100) < 0) {
 		syslog(LOG_ERR, "Unable to send authentication request: %s (%d)",
 							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
 		goto done;
 	}
 
@@ -1174,7 +1160,7 @@
 	if (hci_send_req(dd, &rq, 100) < 0) {
 		syslog(LOG_ERR, "Unable to start inquiry: %s (%d)",
 							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
 		goto failed;
 	}
 
@@ -1207,13 +1193,13 @@
 	if (hci_send_req(dd, &rq, 100) < 0) {
 		syslog(LOG_ERR, "Sending cancel inquiry failed: %s (%d)",
 							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
 		goto failed;
 	}
 
 	if (status) {
 		syslog(LOG_ERR, "Cancel inquiry failed with status 0x%02x", status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET + status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | status);
 		goto failed;
 	}
 
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.39
diff -u -r1.39 dbus.h
--- hcid/dbus.h	27 Feb 2006 10:24:55 -0000	1.39
+++ hcid/dbus.h	3 Mar 2006 13:23:26 -0000
@@ -252,19 +252,13 @@
 #define BLUEZ_EFUTURE_OFFSET		(0x00040000)
 
 /* D-Bus error code, class BLUEZ_EDBUS_OFFSET */
-#define BLUEZ_EDBUS_UNKNOWN_METHOD	(0x01 + BLUEZ_EDBUS_OFFSET)
-#define BLUEZ_EDBUS_WRONG_SIGNATURE	(0x02 + BLUEZ_EDBUS_OFFSET)
-#define BLUEZ_EDBUS_WRONG_PARAM		(0x03 + BLUEZ_EDBUS_OFFSET)
-#define BLUEZ_EDBUS_RECORD_NOT_FOUND	(0x04 + BLUEZ_EDBUS_OFFSET)
-#define BLUEZ_EDBUS_NO_MEM   		(0x05 + BLUEZ_EDBUS_OFFSET)
-#define BLUEZ_EDBUS_CONN_NOT_FOUND	(0x06 + BLUEZ_EDBUS_OFFSET)
-#define BLUEZ_EDBUS_UNKNOWN_PATH	(0x07 + BLUEZ_EDBUS_OFFSET)
-#define BLUEZ_EDBUS_NOT_IMPLEMENTED	(0x08 + BLUEZ_EDBUS_OFFSET)
-
-/* D-Bus error code, class BLUEZ_ESYSTEM_OFFSET */
-#define BLUEZ_ESYSTEM_ENODEV		(ENODEV + BLUEZ_ESYSTEM_OFFSET)
-
-/* BLUEZ_DBUS_ERR_NO_MEMORY */
-#define BLUEZ_DBUS_ERR_NO_MEMORY_STR	"No memory"
+#define BLUEZ_EDBUS_UNKNOWN_METHOD	(0x01 | BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_WRONG_SIGNATURE	(0x02 | BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_WRONG_PARAM		(0x03 | BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_RECORD_NOT_FOUND	(0x04 | BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_NO_MEM   		(0x05 | BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_CONN_NOT_FOUND	(0x06 | BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_UNKNOWN_PATH	(0x07 | BLUEZ_EDBUS_OFFSET)
+#define BLUEZ_EDBUS_NOT_IMPLEMENTED	(0x08 | BLUEZ_EDBUS_OFFSET)
 
 #endif /* __H_BLUEZ_DBUS_H__ */


------=_Part_8375_18469351.1141392843583--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
