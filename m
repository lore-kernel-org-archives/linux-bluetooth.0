Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] profiles/network: Use send ctrl rsp to unknown BNEP ctrl cmd
Date: Thu, 19 Feb 2015 15:16:36 +0100
Message-Id: <1424355399-10015-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use dedicated control response function instead of assembling and
sending raw packet over socket.
---
 profiles/network/server.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index ebbe056..37bfba4 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -307,14 +307,10 @@ static gboolean bnep_setup(GIOChannel *chan,
 	/* Highest known Control command ID
 	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
 	if (req->type == BNEP_CONTROL &&
-				req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
-		uint8_t pkt[3];
-
-		pkt[0] = BNEP_CONTROL;
-		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
-		pkt[2] = req->ctrl;
-
-		send(sk, pkt, sizeof(pkt), 0);
+					req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+		error("cmd not understood");
+		bnep_send_ctrl_rsp(sk, BNEP_CONTROL, BNEP_CMD_NOT_UNDERSTOOD,
+								req->ctrl);
 
 		return FALSE;
 	}
-- 
1.9.3

