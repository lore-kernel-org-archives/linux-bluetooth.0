Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602201155u3b3177b6w7c057368d542119b@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_10408_8971999.1140465342741"
Subject: [Bluez-devel] [DBUS PATCH] ListBondings
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
Date: Mon, 20 Feb 2006 16:55:42 -0300

------=_Part_10408_8971999.1140465342741
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

This is the patch to list bonded devices.

Do you have suggestions/comments?

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_10408_8971999.1140465342741
Content-Type: text/x-patch; name=list-bondings01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejx0zejk
Content-Disposition: attachment; filename="list-bondings01.patch"

--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-15 15:44:38.000000000 -0200
+++ bluez-utils-cvs-list-bondings/hcid/dbus-device.c	2006-02-20 13:46:54.000000000 -0300
@@ -41,6 +41,15 @@
 
 #include "textfile.h"
 
+
+static void append_bonding_devices(char *key, char *value, void *data)
+{
+	DBusMessageIter *iter = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &key);
+
+}
+
 static char *get_peer_name(const bdaddr_t *local, const bdaddr_t *peer)
 {
 	char filename[PATH_MAX + 1], addr[18];
@@ -729,8 +738,30 @@
 
 static DBusMessage* handle_dev_list_bondings_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	char filename[PATH_MAX + 1];
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter array_iter;
+	char addr[18];
+
+	get_device_address(dbus_data->dev_id, addr, sizeof(addr));
+
+	snprintf(filename, PATH_MAX, "%s/%s/linkkeys", STORAGEDIR, addr);
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+						DBUS_TYPE_STRING_AS_STRING, &array_iter);
+
+
+	textfile_foreach(filename, &append_bonding_devices, &array_iter);
+
+	dbus_message_iter_close_container(&iter, &array_iter);
+
+	return reply;
+
 }
 
 static DBusMessage* handle_dev_has_bonding_req(DBusMessage *msg, void *data)

------=_Part_10408_8971999.1140465342741--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
