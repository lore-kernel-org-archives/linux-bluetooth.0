Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Check source_id before to call to g_source_remove function
Date: Mon,  6 Sep 2010 10:19:32 +0200
Message-Id: <1283761172-7384-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 17e16d8..7dc06ba 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -44,9 +44,11 @@
 
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
-#define RELEASE_TIMER(__mcl) do {	\
-	g_source_remove(__mcl->tid);	\
-	__mcl->tid = 0;			\
+#define RELEASE_TIMER(__mcl) do {		\
+	if (__mcl->tid)	{			\
+		g_source_remove(__mcl->tid);	\
+		__mcl->tid = 0;			\
+	}					\
 } while(0)
 
 struct connect_mcl {
@@ -227,7 +229,10 @@ static void shutdown_mdl(struct mcap_mdl *mdl)
 {
 	mdl->state = MDL_CLOSED;
 
-	g_source_remove(mdl->wid);
+	if (mdl->wid) {
+		g_source_remove(mdl->wid);
+		mdl->wid = 0;
+	}
 
 	if (mdl->dc) {
 		g_io_channel_shutdown(mdl->dc, TRUE, NULL);
@@ -678,9 +683,7 @@ static void close_mcl(struct mcap_mcl *mcl, gboolean cache_requested)
 {
 	gboolean save = ((!(mcl->ctrl & MCAP_CTRL_FREE)) && cache_requested);
 
-	if (mcl->tid) {
-		RELEASE_TIMER(mcl);
-	}
+	RELEASE_TIMER(mcl);
 
 	if (mcl->cc) {
 		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
@@ -688,7 +691,11 @@ static void close_mcl(struct mcap_mcl *mcl, gboolean cache_requested)
 		mcl->cc = NULL;
 	}
 
-	g_source_remove(mcl->wid);
+	if (mcl->wid) {
+		g_source_remove(mcl->wid);
+		mcl->wid = 0;
+	}
+
 	if (mcl->lcmd) {
 		g_free(mcl->lcmd);
 		mcl->lcmd = NULL;
-- 
1.7.0.4

