Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH BlueZ RESEND] tools: Fix recevied/received typos
Date: Wed,  3 Aug 2016 16:33:43 -0700
Message-Id: <20160803233343.23515-1-mathew.j.martineau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

ubcsp.c is one of the files changed, and it has CRLF line endings. The
normal git-format-patch, git-send-email, git-am flow does not handle
CRLF well.

I'm sending using "git send-email --transfer-encoding=quoted-printable"
in order to make git-am happy. You'll need to make sure your email
client saves the raw message correctly, and git-am will print whitespace
warnings even though the patch is applied.

Mat

---
 tools/l2test.c  | 2 +-
 tools/scotest.c | 2 +-
 tools/ubcsp.c   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index d4e3ae6..1819423 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -830,7 +830,7 @@ static void dump_mode(int sk)
 			return;
 		}
 
-		syslog(LOG_INFO, "Recevied %d bytes", len);
+		syslog(LOG_INFO, "Received %d bytes", len);
 		hexdump(buf, len);
 	}
 }
diff --git a/tools/scotest.c b/tools/scotest.c
index 596e403..f894c24 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -265,7 +265,7 @@ static void dump_mode(int sk)
 
 	syslog(LOG_INFO,"Receiving ...");
 	while ((len = read(sk, buf, data_size)) > 0)
-		syslog(LOG_INFO, "Recevied %d bytes", len);
+		syslog(LOG_INFO, "Received %d bytes", len);
 }
 
 static void recv_mode(int sk)
diff --git a/tools/ubcsp.c b/tools/ubcsp.c
index b3f883a..cd17d48 100644
--- a/tools/ubcsp.c
+++ b/tools/ubcsp.c
@@ -351,14 +351,14 @@ bad_match_loop:
 
 /*****************************************************************************/
 /**                                                                         **/
-/** ubcsp_recevied_packet                                                   **/
+/** ubcsp_received_packet                                                   **/
 /**                                                                         **/
 /** This function is called when we have a SLIP END octet and a full        **/
 /** packet header and possibly data in the receive packet                   **/
 /**                                                                         **/
 /*****************************************************************************/
 
-static uint8 ubcsp_recevied_packet (void)
+static uint8 ubcsp_received_packet (void)
 {
 	static uint8
 		receive_crc,
@@ -1107,7 +1107,7 @@ uint8 ubcsp_poll (uint8 *activity)
 				{
 					/* process the received packet */
 
-					*activity |= ubcsp_recevied_packet ();
+					*activity |= ubcsp_received_packet ();
 
 					if (*activity & UBCSP_PACKET_ACK)
 					{
-- 
2.9.2

