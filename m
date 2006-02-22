Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602221010m44b865a5qf2750e11e6ecc4de@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7941_26900574.1140631841251"
Subject: [Bluez-devel] [DBUS PATCH]RemoteAlias
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
Date: Wed, 22 Feb 2006 15:10:41 -0300

------=_Part_7941_26900574.1140631841251
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,


here is the patch that implements the RemoteAlias.

What should be the reply message when the alias is not found?
This patch returns"org.bluez.Error: No such device or address", is it ok?

Regards,
Caudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_7941_26900574.1140631841251
Content-Type: text/x-patch; name=remote_alias01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejzs6bkm
Content-Disposition: attachment; filename="remote_alias01.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.6
diff -u -r1.6 dbus-device.c
--- hcid/dbus-device.c	21 Feb 2006 23:55:19 -0000	1.6
+++ hcid/dbus-device.c	22 Feb 2006 18:04:38 -0000
@@ -538,8 +538,41 @@
 
 static DBusMessage* handle_dev_remote_alias_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	struct hci_dbus_data *dbus_data = data;
+	DBusConnection *connection = get_dbus_connection();
+	DBusMessageIter iter;
+	DBusMessage *reply;
+	DBusMessage *signal;
+	char str[249], *str_ptr = str, *addr_ptr;
+	bdaddr_t bdaddr;
+	int err;
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &addr_ptr);
+
+	str2ba(addr_ptr, &bdaddr);
+
+	err = get_device_alias(dbus_data->dev_id, &bdaddr, str, sizeof(str));
+
+	if (err < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | -err);
+		goto failed;
+	}
+
+	signal = dev_signal_factory(dbus_data->dev_id, DEV_SIG_REMOTE_ALIAS,
+						DBUS_TYPE_STRING, &addr_ptr,
+						DBUS_TYPE_STRING, &str_ptr,
+						DBUS_TYPE_INVALID);
+	if (signal) {
+		dbus_connection_send(connection, signal, NULL);
+		dbus_connection_flush(connection);
+		dbus_message_unref(signal);
+	}
+
+	reply = dbus_message_new_method_return(msg);
+failed:
+	return reply;
+
 }
 
 static DBusMessage* handle_dev_remote_name_req(DBusMessage *msg, void *data)

------=_Part_7941_26900574.1140631841251--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
