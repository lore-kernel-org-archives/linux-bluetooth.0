Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 45/60] Fix double reconnection problem using the same mdlid
Date: Thu, 22 Jul 2010 10:56:38 +0200
Message-Id: <1279789001-4587-27-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-26-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index a2cfa8c..18220bc 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1076,6 +1076,12 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
 						MCAP_INVALID_MDL, mdl_id);
 		return;
+	} else if (mdl->state == MDL_WAITING || mdl->state == MDL_DELETING ) {
+		/* Creation request arrives for a MDL that is being managed
+		* at current moment */
+		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_MDL_BUSY,
+									mdl_id);
+		return;
 	}
 
 	/* Callback to upper layer */
-- 
1.6.3.3

