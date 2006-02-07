Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602070534h7c56eb0ck9dcf80b30896cd46@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1946_14939260.1139319258520"
Subject: [Bluez-devel] [DBUS]Cleanup
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
Date: Tue, 7 Feb 2006 11:34:18 -0200

------=_Part_1946_14939260.1139319258520
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,


This patch fix two issues:
1. Suppose a scenario where there more than one adapter attached. If
the user removes the default device, the hcid is not updating the
default!

2. The scan mode doesn't need be configured. It's already being
changed in the configure_device function in the main.c file.


Regards,
Claudio.

--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_1946_14939260.1139319258520
Content-Type: text/x-patch; name=cleanup01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eje2pqqb
Content-Disposition: attachment; filename="cleanup01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-07 08:12:06.000000000 -0200
+++ bluez-utils-cvs-cleanup/hcid/dbus.c	2006-02-07 08:13:33.000000000 -0200
@@ -1057,10 +1057,8 @@
 
 	ret = unregister_device_path(path);
 
-	/* FIXME: If there are any devices left after this removal the default
-	 * device should be changed to one of them */
 	if (ret && default_dev == id)
-		default_dev = -1;
+		default_dev = hci_get_route(NULL);
 
 	return ret;
 }
@@ -1921,8 +1919,6 @@
 {
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
-	struct hci_dev_info di;
-	struct hci_dev_req dr;
 	int sk = -1;
 
 	/* Create and bind HCI socket */
@@ -1941,18 +1937,6 @@
 		goto failed;
 	}
 
-	if (ioctl(sk, HCIGETDEVINFO, (void *) &di) >= 0 &&
-					!hci_test_bit(HCI_RAW, &di.flags)) {
-		dr.dev_id  = dbus_data->dev_id;
-		dr.dev_opt = SCAN_PAGE | SCAN_INQUIRY; /* piscan */
-		if (ioctl(sk, HCISETSCAN, (unsigned long) &dr) < 0) {
-			syslog(LOG_ERR, "Can't set scan mode on hci%d: %s (%d)",
-					dbus_data->dev_id, strerror(errno), errno);
-			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-			goto failed;
-		}
-	}
-
 	reply = dbus_message_new_method_return(msg);
 
 failed:

------=_Part_1946_14939260.1139319258520--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
