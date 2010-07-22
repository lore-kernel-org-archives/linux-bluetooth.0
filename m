Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 27/60] Fix wrong response code rejecting reconnections
Date: Thu, 22 Jul 2010 10:56:20 +0200
Message-Id: <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 43b215b..7098a8d 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1024,7 +1024,7 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 
 	if (rsp != MCAP_SUCCESS) {
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id);
+		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, rsp, mdl_id);
 		return;
 	}
 
-- 
1.6.3.3

