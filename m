Return-Path: <cyrus@holtmann.org>
Message-ID: <478E13ED.3060506@access-company.com>
Date: Wed, 16 Jan 2008 15:25:49 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------090108050807030402000804"
Subject: [Bluez-devel] UNITINFO and SUBUNITINFO in avrcp
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

This is a multi-part message in MIME format.
--------------090108050807030402000804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

This little patch enables support of UNITINFO and SUBUNITINFO commands 
in audio service.
The implementation is not very useful itself but it is mandatory in AVRCP.

PTS has some test cases to check for it.

Comments are welcome!

Frédéric.

--------------090108050807030402000804
Content-Type: text/x-patch;
 name="unitinfo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unitinfo.patch"

diff --git a/audio/control.c b/audio/control.c
index bb3f2bf..5eb1053 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -643,6 +643,19 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		ret = write(session->sock, buf, packet_size);
 	}
 
+	if (avctp->packet_type == AVCTP_PACKET_SINGLE &&
+		   avctp->cr == AVCTP_COMMAND &&
+		   avctp->pid == htons(AV_REMOTE_SVCLASS_ID) &&
+		   avrcp->code == CTYPE_STATUS &&
+		   (avrcp->opcode == OP_UNITINFO
+		   	|| avrcp->opcode == OP_SUBUNITINFO)) {
+		avctp->cr = AVCTP_RESPONSE;
+		avrcp->code = CTYPE_STABLE;
+		debug("reply to %s", avrcp->opcode == OP_UNITINFO ?
+				"OP_UNITINFO" : "OP_SUBUNITINFO");
+		ret = write(session->sock, buf, packet_size);
+	}
+
 	return TRUE;
 
 failed:

--------------090108050807030402000804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------090108050807030402000804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090108050807030402000804--
