Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 28/60] Solve a non initialized memory segmentation fault
Date: Thu, 22 Jul 2010 10:56:21 +0200
Message-Id: <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 7098a8d..cf92368 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1412,6 +1412,7 @@ static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	mcap4B_rsp *rsp;
 	GError *gerr = NULL;
 
+	rsp = (mcap4B_rsp *)cmd;
 	/* Check if the response matches with the last request */
 	if ((cmd[0] != MCAP_ERROR_RSP) && ((mcl->lcmd[0] + 1) != cmd[0]))
 		goto close_mcl;
@@ -1419,8 +1420,6 @@ static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	if (len < 4)
 		goto close_mcl;
 
-	rsp = (mcap4B_rsp *)cmd;
-
 	if (rsp->rc == MCAP_REQUEST_NOT_SUPPORTED) {
 		DBG("Remote does not support opcodes");
 		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_REQUEST_NOT_SUPPORTED,
-- 
1.6.3.3

