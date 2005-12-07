Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Corrections in hciattach code
Message-ID: <A35A8D03A748B34A9DA2AB0335A3F93D408958@rfsdmail.internal.rfmd.com>
From: "Jatin Nahar" <jnahar@rfmd.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Tue, 6 Dec 2005 18:21:04 -0800

Marcel,

Here it is...

--- hciattach_old.c	2005-12-06 13:15:22.000000000 -0800
+++ hciattach.c	2005-12-06 13:16:15.000000000 -0800
@@ -688,7 +688,7 @@
 	}
=20
 	/* Send initialization command */
-	if (write(fd, cmd, 9) !=3D 9) {
+	if (write(fd, cmd, 10) !=3D 10) {
 		perror("Failed to write init command");
 		return -1;
 	}
@@ -720,15 +720,15 @@
 		return -1;
 	}
=20
-	// we probably got the reply. Now we must send the "soft reset":
+	// we probably got the reply. Now we must send the "soft reset":
which
+	// is standard HCI RESET.
 	cmd[0] =3D HCI_COMMAND_PKT;	// it's a command packet
-	cmd[1] =3D 0x0B;			// OCF 0x0B	=3D param access
set=09
-	cmd[2] =3D 0xfc;			// OGF bx111111 =3D vendor
specific
-	cmd[3] =3D 0x01;			// 1 byte of data following=20
-	cmd[4] =3D 0x03;			// HCI Reset Subcommand
+	cmd[1] =3D 0x03;			=09
+	cmd[2] =3D 0x0c;	=09
+	cmd[3] =3D 0x00;	=09
 		=09
-	// Send initialization command
-	if (write(fd, cmd, 5) !=3D 5) {
+	// Send HCI RESET command
+	if (write(fd, cmd, 4) !=3D 4) {
 		perror("Can't write Silicon Wave reset cmd.");
 		return -1;
 	}

Thanks,
Jatin=20

> The hciattach code when used with swave option (RFMD) would not work=20
> since there are 2 bugs in that code, infact it will return with=20
> "Initialization timeout" every single time. Here are fixes for those=20
> (let me know if you would like me to send that to you in some other=20
> form). The base file used for the diff is hciattach.c in=20
> bluez-utils-2.22.

send them in unified diff format.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
