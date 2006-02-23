Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602230909o674853f6h7b9e01488c0c4d49@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2572_11464.1140714597626"
Subject: [Bluez-devel] [DBUS PATCH]LastSeen
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
Date: Thu, 23 Feb 2006 14:09:57 -0300

------=_Part_2572_11464.1140714597626
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the patch to add the last seen service.

I saw that I you implemented the SDP skeleton. At least, it seems to
be more interesting than these mechanical patches :) SDP is most
important feature missing on D-Bus API.


Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_2572_11464.1140714597626
Content-Type: text/x-patch; name=last-seen01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek15a8x7
Content-Disposition: attachment; filename="last-seen01.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.11
diff -u -r1.11 dbus-device.c
--- hcid/dbus-device.c	23 Feb 2006 12:48:51 -0000	1.11
+++ hcid/dbus-device.c	23 Feb 2006 17:00:14 -0000
@@ -533,8 +533,35 @@
 
 static DBusMessage* handle_dev_last_seen_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessageIter iter;
+	DBusMessage *reply;
+	char filename[PATH_MAX + 1];
+	char addr[18], *addr_ptr, *str;
+
+	get_device_address(dbus_data->dev_id, addr, sizeof(addr));
+
+	snprintf(filename, PATH_MAX, "%s/%s/lastseen", STORAGEDIR, addr);
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &addr_ptr);
+
+	str = textfile_get(filename, addr_ptr);
+
+	if (!str) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | ENXIO);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &str,
+				 	DBUS_TYPE_INVALID);
+
+	free(str);
+
+failed:
+	return reply;
 }
 
 static DBusMessage* handle_dev_last_used_req(DBusMessage *msg, void *data)



------=_Part_2572_11464.1140714597626--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
