Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602221048o5b5fd952qdb7aee98d246a511@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8642_22537098.1140634086704"
Subject: [Bluez-devel] [DBUS PATCH] BondingRemoved signal
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
Date: Wed, 22 Feb 2006 15:48:06 -0300

------=_Part_8642_22537098.1140634086704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

here is the patch to send the BondingRemoved signal.
Considering that we will need review the condition to send the signal
I put a tag "FIXME:" to track this issue, but feel free to remove if
you think that this is not relevant.


Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_8642_22537098.1140634086704
Content-Type: text/x-patch; name=bonding_removed01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejztgc2s
Content-Disposition: attachment; filename="bonding_removed01.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.7
diff -u -r1.7 dbus-device.c
--- hcid/dbus-device.c	22 Feb 2006 17:43:28 -0000	1.7
+++ hcid/dbus-device.c	22 Feb 2006 18:40:59 -0000
@@ -792,8 +792,10 @@
 static DBusMessage* handle_dev_remove_bonding_req(DBusMessage *msg, void *data)
 {
 	struct hci_dbus_data *dbus_data = data;
+	DBusConnection *connection = get_dbus_connection();
 	DBusMessageIter iter;
 	DBusMessage *reply;
+	DBusMessage *signal;
 	char filename[PATH_MAX + 1];
 	char addr[18], *addr_ptr;
 	struct hci_conn_info_req *cr;
@@ -813,6 +815,16 @@
 
 	/* Delete the link key from storage */
 	textfile_del(filename, addr_ptr);
+	
+	/* FIXME: which condition must be verified before send the signal */
+	signal = dev_signal_factory(dbus_data->dev_id, DEV_SIG_BONDING_REMOVED,
+						DBUS_TYPE_STRING, &addr_ptr,
+						DBUS_TYPE_INVALID);
+	if (signal) {
+		dbus_connection_send(connection, signal, NULL);
+		dbus_connection_flush(connection);
+		dbus_message_unref(signal);
+	}
 
 	str2ba(addr_ptr, &bdaddr);
 


------=_Part_8642_22537098.1140634086704--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
