Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-keTmQumiRJ061cQjRpwU"
Message-Id: <1126826943.17881.20.camel@wyatt.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Palm hotsync over BT
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
Date: Fri, 16 Sep 2005 00:29:03 +0100


--=-keTmQumiRJ061cQjRpwU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Apart from submitting a patch (attached below), I wanted to ask about
the PALMOS and HOTSYNC SDP records that sdptool can now add. First of
all, what is the difference between those two?

If I understood well Marcel's mail[1], one could now sync a Palm over
Bluetooth by doing:
- sdptool add HOTSYNC
- adding an rfcomm connection to the Palm
- using pilot-link or other Palm software using the just created rfcomm
device as the serial device

And the mail mentioned above was to avoid having to create an rfcomm
connection by hand. Am I even close?

Cheers

[1]: http://thread.gmane.org/gmane.linux.bluez.devel/5542
---
Bastien Nocera <hadess@hadess.net> 


--=-keTmQumiRJ061cQjRpwU
Content-Disposition: attachment; filename=sdptool-add-palmos.patch
Content-Type: text/x-patch; name=sdptool-add-palmos.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: sdptool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/sdptool.c,v
retrieving revision 1.34
diff -u -p -r1.34 sdptool.c
--- sdptool.c	19 Aug 2005 14:40:45 -0000	1.34
+++ sdptool.c	15 Sep 2005 23:20:01 -0000
@@ -2197,7 +2197,7 @@ static int add_palmos(sdp_session_t *ses
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, (void *) hotsync_uuid);
+	sdp_uuid128_create(&svclass_uuid, (void *) palmos_uuid);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 

--=-keTmQumiRJ061cQjRpwU--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
