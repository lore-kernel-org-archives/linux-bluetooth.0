Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051023210620.GA14179@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Subject: [Bluez-devel] hci_send_req and EVT_CMD_STATUS
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
Date: Mon, 24 Oct 2005 00:06:20 +0300


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

I see that you changed hci_send_req so that it will never return
cmd_status events with non-zero status (instead the function fails with
EIO). If this was intentional (the fix I sent would have allowed getting
the cmd status event in all circumstanses), please apply the attached
patch since checking for rp.status after hci_send_req has successfully
returned is unecessary.

Johan

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmd-status.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.31
diff -u -r1.31 dbus.c
--- dbus.c	22 Oct 2005 13:03:41 -0000	1.31
+++ dbus.c	23 Oct 2005 19:55:39 -0000
@@ -1374,12 +1374,6 @@
 		goto failed;
 	}
 
-	if (rp.status) {
-		syslog(LOG_ERR, "Inquiry command failed with status 0x%02X", rp.status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + EIO);
-		goto failed;
-	}
-
 	reply = dbus_message_new_method_return(msg);
 
 failed:
@@ -1496,12 +1490,6 @@
 		goto failed;
 	}
 
-	if (rp.status) {
-		syslog(LOG_ERR, "Remote name command failed with status 0x%02X", rp.status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + EIO);
-		goto failed;
-	}
-
 	reply = dbus_message_new_method_return(msg);
 
 failed:
@@ -1655,12 +1643,6 @@
 		goto failed;
 	}
 
-	if (rp.status) {
-		syslog(LOG_ERR, "Authentication command failed with status 0x%02X", rp.status);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + EIO);
-		goto failed;
-	}
-
 failed:
 	if (sock >= 0)
 		close(sock);

--HlL+5n6rz5pIUxbD--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
