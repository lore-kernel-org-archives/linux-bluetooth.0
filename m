Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 1 Jun 2007 18:34:55 +0200
From: Andreas Gaufer <Andreas.Gaufer@bluecellnetworks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Message-ID: <20070601183455.76998305@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Fix broken behavior with
	EVT_REMOTE_NAME_REQ_COMPLETE
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi, 

the included patch tries to fix broken behavior of hci_send_req from the bluez-libs package.

The function returns data from a EVT_REMOTE_NAME_REQ_COMPLETE event to a
call from hci_read_remote_name_with_clock_offset without checking if the
event parameter BD_ADDR equals the bdaddr that was requested.

This problem shows if multiple processes use the same hci-device to do
remote name requests at the same time. In this scenario all processes
receive data from the first request-complete-event that occurs after
there call. This data is only correct for one of them, all others get
wrong data.

The patch tries to avoid that by comparing the events parameter BD_ADDR
with the bdaddr of the request. If they match the data is returned, if
they don't further events are processed.

Since my experience in writing C is very limited i would appreciate
detailed review and feedback on how this could be done better.

Greetings

Andy



Index: hci.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/hci.c,v
retrieving revision 1.103
diff -u -r1.103 hci.c
--- hci.c	13 Feb 2007 14:44:47 -0000	1.103
+++ hci.c	1 Jun 2007 16:09:01 -0000
@@ -962,6 +962,8 @@
 	while (try--) {
 		evt_cmd_complete *cc;
 		evt_cmd_status   *cs;
+		evt_remote_name_req_complete *rn;
+		remote_name_req_cp *cp;
 
 		if (to) {
 			struct pollfd p;
@@ -1026,6 +1028,21 @@
 			memcpy(r->rparam, ptr, r->rlen);
 			goto done;
 
+		case EVT_REMOTE_NAME_REQ_COMPLETE:
+
+			if (hdr->evt != r->event)
+				break;
+
+			r->rlen = MIN(len, r->rlen);
+			memcpy(r->rparam, ptr, r->rlen);
+
+			rn = r->rparam;
+			cp = r->cparam;
+
+			if (bacmp(&rn->bdaddr,&cp->bdaddr) == 0)
+				goto done;
+			continue;
+
 		default:
 			if (hdr->evt != r->event)
 				break;



Example Situation:

************* before patch *******************

TESTHOST:~# hcitool name 00:1B:33:39:48:EE & hcitool name 00:15:A0:85:2F:FB &  hcitool name 00:15:83:B9:EE:E5 &
[1] 24876
[2] 24877
[3] 24878
TESTHOST:~# N73
N73
N73

[1]   Done                    hcitool name 00:1B:33:39:48:EE
[2]-  Done                    hcitool name 00:15:A0:85:2F:FB
[3]+  Done                    hcitool name 00:15:83:B9:EE:E5

************* after patch *******************

TESTHOST:~# hcitool name 00:1B:33:39:48:EE & hcitool name 00:15:A0:85:2F:FB &  hcitool name 00:15:83:B9:EE:E5 &
[1] 25688
[2] 25689
[3] 25690
TESTHOST:~# N73
N70
obextester-0

[1]   Done                    hcitool name 00:1B:33:39:48:EE
[2]-  Done                    hcitool name 00:15:A0:85:2F:FB
[3]+  Done                    hcitool name 00:15:83:B9:EE:E5




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
