Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 35/60] Remove magic number to check commands of 5 Bytes
Date: Thu, 22 Jul 2010 10:56:28 +0200
Message-Id: <1279789001-4587-17-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-16-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index d3c92dc..f408cbf 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1262,7 +1262,7 @@ static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
 	if (gerr)
 		goto fail;
 
-	if (len < 5) {
+	if (len < sizeof(mcap5B_rsp)) {
 		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
 							"Protocol error");
 		close = TRUE;
-- 
1.6.3.3

