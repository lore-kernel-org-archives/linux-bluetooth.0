Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 46/60] Process received command in base to previous request sent
Date: Thu, 22 Jul 2010 10:56:39 +0200
Message-Id: <1279789001-4587-28-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-27-git-send-email-santoscadenas@gmail.com>
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
 <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-12-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-13-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-14-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-15-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-16-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-17-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-18-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-19-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-20-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-21-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-22-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-23-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-24-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-25-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-26-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-27-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 18220bc..3f3268b 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1254,6 +1254,12 @@ static gboolean check_err_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	mcap4B_rsp *rsp;
 	char *msg;
 
+	if (cmd[0] == MCAP_ERROR_RSP) {
+		msg = "MCAP_ERROR_RSP received";
+		close = TRUE;
+		goto fail;
+	}
+
 	/* Check if the response matches with the last request */
 	if ((rlen < MIN_RSP_LEN) || ((mcl->lcmd[0] + 1) != cmd[0])) {
 		msg = "Protocol error";
@@ -1492,11 +1498,7 @@ static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	gboolean close;
 	RELEASE_TIMER(mcl);
 
-	switch (cmd[0]) {
-	case MCAP_ERROR_RSP:
-		error("MCAP_ERROR_RSP received");
-		close = TRUE;
-		break;
+	switch (mcl->lcmd[0] + 1) {
 	case MCAP_MD_CREATE_MDL_RSP:
 		close = process_md_create_mdl_rsp(mcl, cmd, len);
 		break;
-- 
1.6.3.3

