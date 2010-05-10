Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 06/25] Add functions for caching and uncaching MCLs
Date: Mon, 10 May 2010 12:15:08 +0200
Message-Id: <1273486527-7855-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-5-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index b15728c..ebfaf9e 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -34,6 +34,8 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define MAX_CACHED	10	/* 10 devices */
+
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
 #define RELEASE_TIMER(__mcl) do {	\
@@ -246,12 +248,55 @@ static void mcap_mcl_check_del(struct mcap_mcl *mcl)
 
 static void mcap_cache_mcl(struct mcap_mcl *mcl)
 {
-	/* TODO: Store in cache this MCL for future reconnections */
+	GSList *l;
+	struct mcap_mcl *last;
+	int len;
+
+	if (mcl->ctrl & MCAP_CTRL_CACHED)
+		return;
+
+	mcl->ms->mcls = g_slist_remove(mcl->ms->mcls, mcl);
+
+	if ((mcl->ctrl & MCAP_CTRL_NOCACHE) || (mcl->ref < 2)) {
+		mcap_mcl_unref(mcl);
+		return;
+	}
+
+	debug("Caching MCL");
+
+	len = g_slist_length(mcl->ms->cached);
+	if (len == MAX_CACHED) {
+		/* Remove the latest cached mcl */
+		l = g_slist_last(mcl->ms->cached);
+		last = l->data;
+		mcl->ms->cached = g_slist_remove(mcl->ms->cached, last);
+		last->ctrl &= ~MCAP_CTRL_CACHED;
+		if (last->ctrl & MCAP_CTRL_CONN) {
+			/* If connection process is not success this MCL will be
+			 * freed next time that mcap_mcl_free is invoked */
+			last->ctrl |= MCAP_CTRL_FREE;
+		} else {
+			last->ms->mcl_uncached_cb(last, last->ms->user_data);
+			mcap_mcl_unref(last);
+		}
+	}
+
+	mcl->ms->cached = g_slist_prepend(mcl->ms->cached, mcl);
+	mcl->ctrl |= MCAP_CTRL_CACHED;
+	mcap_mcl_shutdown(mcl);
 }
 
 static void mcap_uncache_mcl(struct mcap_mcl *mcl)
 {
-	/* TODO: Remove this MCL from cache */
+	if (!(mcl->ctrl & MCAP_CTRL_CACHED))
+		return;
+
+	debug("Got MCL from cache");
+
+	mcl->ms->cached = g_slist_remove(mcl->ms->cached, mcl);
+	mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
+	mcl->ctrl &= ~MCAP_CTRL_CACHED;
+	mcl->ctrl &= ~MCAP_CTRL_FREE;
 }
 
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl)
-- 
1.6.3.3

