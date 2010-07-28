Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 14/16] Response with invalid operation when an invalid request is received
Date: Wed, 28 Jul 2010 10:07:31 +0200
Message-Id: <1280304453-9328-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304453-9328-1-git-send-email-sancane@gmail.com>
References: <1280304232-2939-6-git-send-email-santoscadenas@gmail.com>
 <1280304453-9328-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index df75752..f5f60ee 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1164,7 +1164,15 @@ resp:
 
 static void invalid_req_state(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Implements invalid_req_state */
+	uint16_t mdlr;
+
+	error("Invalid cmd received (op code = %d) in state %d", cmd[0],
+								mcl->state);
+	/* Get previously mdlid sent to generate an appropriate
+	 * response if it is possible */
+	mdlr = len < sizeof(mcap_md_req) ? MCAP_MDLID_RESERVED :
+					ntohs(((mcap_md_req *)cmd)->mdl);
+	mcap_send_cmd(mcl, cmd[0]+1, MCAP_INVALID_OPERATION, mdlr, NULL, 0);
 }
 
 /* Function used to process commands depending of MCL state */
-- 
1.6.3.3

