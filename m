Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 23 Jan 2007 15:42:03 +0000
From: Stephen Crane <jscrane@maths.tcd.ie>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070123154203.GA30435@salmon.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Subject: [Bluez-devel] marshalling SDP_URL_STR
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello again,
It looks as if these types aren't being marshalled properly in the SDP
library. (They should be treated identically to SDP_TEXT_STR.)

The current code causes 1 byte too many to be allocated to them in the
marshalled form which results in garbage when it is read out of the
buffer.

The attached patch treats them the same as SDP_TEXT_STR, aside from the
DTD of course.

Cheers,
Steve

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sdp.c.patch"

Index: sdp.c
===================================================================
RCS file: /cvsroot/bluez/libs/src/sdp.c,v
retrieving revision 1.70
diff -u -r1.70 sdp.c
--- sdp.c	9 Nov 2006 21:25:30 -0000	1.70
+++ sdp.c	23 Jan 2007 15:38:33 -0000
@@ -741,15 +741,11 @@
 	case SDP_TEXT_STR8:
 	case SDP_TEXT_STR16:
 	case SDP_TEXT_STR32:
-		src = (unsigned char *)d->val.str;
-		data_size = d->unitSize - sizeof(uint8_t);
-		sdp_set_seq_len(seqp, data_size);
-		break;
 	case SDP_URL_STR8:
 	case SDP_URL_STR16:
 	case SDP_URL_STR32:
 		src = (unsigned char *)d->val.str;
-		data_size = strlen(d->val.str);
+		data_size = d->unitSize - sizeof(uint8_t);
 		sdp_set_seq_len(seqp, data_size);
 		break;
 	case SDP_SEQ8:

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--r5Pyd7+fXNt84Ff3--
