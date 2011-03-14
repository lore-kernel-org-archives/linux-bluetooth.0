Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] network: Fix for TP_BNEP_CTRL_BV_01_C qualification test
Date: Mon, 14 Mar 2011 14:18:26 +0100
Message-ID: <1300108706-22998-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this fix network plugin will correctly respond on unknown
BNEP control command.
---
 network/server.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/network/server.c b/network/server.c
index 7c63c3e..d1da8a9 100644
--- a/network/server.c
+++ b/network/server.c
@@ -394,6 +394,21 @@ static gboolean bnep_setup(GIOChannel *chan,
 		return FALSE;
 	}
 
+	/* Highest known Control command ID
+	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06 */
+	if (req->type == BNEP_CONTROL &&
+				req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+		uint8_t pkt[3];
+
+		pkt[0] = BNEP_CONTROL;
+		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
+		pkt[2] = req->ctrl;
+
+		send(sk, pkt, sizeof(pkt), 0);
+
+		return FALSE;
+	}
+
 	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
 		return FALSE;
 
-- 
1.7.0.4

On behalf of ST-Ericsson.
/Lukasz
