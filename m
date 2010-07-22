Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 34/60] Add macro to get minimum command length for respones
Date: Thu, 22 Jul 2010 10:56:27 +0200
Message-Id: <1279789001-4587-16-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-15-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

Minimum length responses are provided using a new macro to avoid using
magic numbers in source code.
---
 mcap/mcap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 6031bd4..d3c92dc 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -35,6 +35,7 @@
 
 #define RESPONSE_TIMER	2	/* seconds */
 #define MAX_CACHED	10	/* 10 devices */
+#define MIN_RSP_LEN	4	/* 4 Bytes */
 
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
@@ -1191,7 +1192,7 @@ static gboolean check_err_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	char *msg;
 
 	/* Check if the response matches with the last request */
-	if ((rlen < 4) || ((mcl->lcmd[0] + 1) != cmd[0])) {
+	if ((rlen < MIN_RSP_LEN) || ((mcl->lcmd[0] + 1) != cmd[0])) {
 		msg = "Protocol error";
 		close = TRUE;
 		goto fail;
@@ -1349,7 +1350,7 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 
 	abrt_cb(gerr, user_data);
 
-	if ((len >= 4) && (rsp->rc == MCAP_INVALID_MDL)) {
+	if ((len >= MIN_RSP_LEN) && (rsp->rc == MCAP_INVALID_MDL)) {
 		mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 		g_free(mdl);
 	}
-- 
1.6.3.3

