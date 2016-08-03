Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH BlueZ RESEND v2] tools: Fix recevied/received typos
Date: Wed,  3 Aug 2016 16:36:53 -0700
Message-Id: <20160803233653.23666-1-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

ubcsp.c is one of the files changed, and it has CRLF line endings. The
normal git-format-patch, git-send-email, git-am flow does not handle
CRLF well.

I'm sending using "git send-email --transfer-encoding=3Dquoted-printable"
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
=20
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
=20
 	syslog(LOG_INFO,"Receiving ...");
 	while ((len =3D read(sk, buf, data_size)) > 0)
-		syslog(LOG_INFO, "Recevied %d bytes", len);
+		syslog(LOG_INFO, "Received %d bytes", len);
 }
=20
 static void recv_mode(int sk)
diff --git a/tools/ubcsp.c b/tools/ubcsp.c
index b3f883a..cd17d48 100644
--- a/tools/ubcsp.c
+++ b/tools/ubcsp.c
@@ -351,14 +351,14 @@ bad_match_loop:
 =0D
 /*************************************************************************=
****/=0D
 /**                                                                       =
  **/=0D
-/** ubcsp_recevied_packet                                                 =
  **/=0D
+/** ubcsp_received_packet                                                 =
  **/=0D
 /**                                                                       =
  **/=0D
 /** This function is called when we have a SLIP END octet and a full      =
  **/=0D
 /** packet header and possibly data in the receive packet                 =
  **/=0D
 /**                                                                       =
  **/=0D
 /*************************************************************************=
****/=0D
 =0D
-static uint8 ubcsp_recevied_packet (void)=0D
+static uint8 ubcsp_received_packet (void)=0D
 {=0D
 	static uint8=0D
 		receive_crc,=0D
@@ -1107,7 +1107,7 @@ uint8 ubcsp_poll (uint8 *activity)
 				{=0D
 					/* process the received packet */=0D
 =0D
-					*activity |=3D ubcsp_recevied_packet ();=0D
+					*activity |=3D ubcsp_received_packet ();=0D
 =0D
 					if (*activity & UBCSP_PACKET_ACK)=0D
 					{=0D
--=20
2.9.2

