Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602221142qedbca67k616f1f05c435d179@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9940_15073796.1140637366969"
Subject: [Bluez-devel] [DBUS PATCH] GetAlias crash
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
Date: Wed, 22 Feb 2006 16:42:46 -0300

------=_Part_9940_15073796.1140637366969
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

The GetAlias is crashing when the requested device alias doesn't
belongs to "aliases" file.

Now, the  daemon is returning the same error message used in the
RemoteAlias: "Error org.bluez.Error: No such device or address".
Is it ok?

The "err" casting to a positive value is a little bit uggly. If you
prefer another approach, fell free to change or let me know that I can
change. :)

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_9940_15073796.1140637366969
Content-Type: text/x-patch; name=get-alias-crash.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejzvfikk
Content-Disposition: attachment; filename="get-alias-crash.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.7
diff -u -r1.7 dbus-device.c
--- hcid/dbus-device.c	22 Feb 2006 17:43:28 -0000	1.7
+++ hcid/dbus-device.c	22 Feb 2006 19:29:59 -0000
@@ -182,19 +182,26 @@
 	DBusMessage *reply;
 	char str[249], *str_ptr = str, *addr_ptr;
 	bdaddr_t bdaddr;
+	int err;
 
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_get_basic(&iter, &addr_ptr);
 
 	str2ba(addr_ptr, &bdaddr);
 
-	get_device_alias(dbus_data->dev_id, &bdaddr, str, sizeof(str));
+	err = get_device_alias(dbus_data->dev_id, &bdaddr, str, sizeof(str));
+
+	if (err < 0) {
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | -err);
+		goto failed;
+	}
 
 	reply = dbus_message_new_method_return(msg);
 
 	dbus_message_append_args(reply, DBUS_TYPE_STRING, &str_ptr,
 					DBUS_TYPE_INVALID);
 
+failed:
 	return reply;
 }
 

------=_Part_9940_15073796.1140637366969--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
