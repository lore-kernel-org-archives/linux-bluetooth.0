Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2] pand: Fix for TP_BNEP_CTRL_BV_01_C qualification test
Date: Fri, 4 Mar 2011 19:41:55 +0100
Message-ID: <1299264115-10702-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this fix pand will correctly respond on
unknown BNEP control command
---
 compat/bnep.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/compat/bnep.c b/compat/bnep.c
index 24bf7e3..99b3ecb 100644
--- a/compat/bnep.c
+++ b/compat/bnep.c
@@ -231,6 +231,22 @@ int bnep_accept_connection(int sk, uint16_t role, char *dev)
 		return -1;
 
 	req = (void *) pkt;
+
+	 /*
+	 * Highest known Control command ID
+	 * is BNEP_FILTER_MULT_ADDR_RSP = 0x06
+	 */
+	if (req->type == BNEP_CONTROL &&
+			req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+		uint8_t pkt[3];
+		pkt[0] = BNEP_CONTROL;
+		pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
+		pkt[2] = req->ctrl;
+
+		send(sk, pkt, sizeof(*pkt), 0);
+		return -1;
+	}
+
 	if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
 		return -1;
 
-- 
1.7.0.4
On behalf ST-Ericsson
/Lukasz
