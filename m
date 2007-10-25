Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20071025120653.5a89aebe@localhost.localdomain>
References: <20071025120653.5a89aebe@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-4DBnwmdHOqe/3duGIatW"
Date: Fri, 26 Oct 2007 01:04:47 +0200
Message-Id: <1193353487.6184.307.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Fix broken EVT_REMOTE_NAME_REQ_COMPLETE
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-4DBnwmdHOqe/3duGIatW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andreas,

> I'm sending this bluez-libs patch for the third time now and i wonder why
> you do not include it. If there is anything wrong with it please let me know
> so I can learn.
> 
> Please look at 
> 
> http://article.gmane.org/gmane.linux.bluez.devel/13859
> http://thread.gmane.org/gmane.linux.bluez.devel/12491
> 
> We did extensive testing and rolled that patch into production
> environment already and there is another independent user (Matthias
> Becker) who confirmed its usefulness.

I know, but I still don't think that you should use the raw HCI socket
in this way. The D-Bus API will take care of name resolving for you in
the background and it is doing always the right thing. However I decided
to simply apply a modified patch (see attachment). You assign return
values in the case where they are not used. That makes no sense.

Regards

Marcel


--=-4DBnwmdHOqe/3duGIatW
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

? src/.deps
? src/.libs
? src/Makefile
? src/Makefile.in
? src/bluetooth.lo
? src/hci.lo
? src/libbluetooth.la
? src/sdp.lo
Index: src/hci.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/hci.c,v
retrieving revision 1.109
diff -u -r1.109 hci.c
--- src/hci.c	5 Oct 2007 11:23:35 -0000	1.109
+++ src/hci.c	25 Oct 2007 22:59:34 -0000
@@ -1009,7 +1009,9 @@
 	try = 10;
 	while (try--) {
 		evt_cmd_complete *cc;
-		evt_cmd_status   *cs;
+		evt_cmd_status *cs;
+		evt_remote_name_req_complete *rn;
+		remote_name_req_cp *cp;
 
 		if (to) {
 			struct pollfd p;
@@ -1074,6 +1076,20 @@
 			memcpy(r->rparam, ptr, r->rlen);
 			goto done;
 
+		case EVT_REMOTE_NAME_REQ_COMPLETE:
+			if (hdr->evt != r->event)
+				break;
+
+			rn = r->rparam;
+			cp = r->cparam;
+
+			if (bacmp(&rn->bdaddr, &cp->bdaddr))
+				continue;
+
+			r->rlen = MIN(len, r->rlen);
+			memcpy(r->rparam, ptr, r->rlen);
+			goto done;
+
 		default:
 			if (hdr->evt != r->event)
 				break;

--=-4DBnwmdHOqe/3duGIatW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=-4DBnwmdHOqe/3duGIatW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-4DBnwmdHOqe/3duGIatW--
