Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 05/25] Save and restore state of MCLs
Date: Fri, 14 May 2010 12:19:32 +0200
Message-Id: <1273832392-18654-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-4-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
 <1273832392-18654-2-git-send-email-sancane@gmail.com>
 <1273832392-18654-3-git-send-email-sancane@gmail.com>
 <1273832392-18654-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 90c5fa3..f8caa01 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -34,8 +34,16 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define MAX_CACHED	10	/* 10 devices */
+
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
+#define RELEASE_TIMER(__mcl) do {	\
+	g_source_remove(__mcl->tid);	\
+	__mcl->tid = 0;			\
+} while(0)
+
+
 /* MCAP finite state machine functions */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
 static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
@@ -147,24 +155,166 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 	return NULL;
 }
 
+static void shutdown_mdl(struct mcap_mdl *mdl)
+{
+	mdl->state = MDL_CLOSED;
+
+	g_source_remove(mdl->wid);
+
+	if (mdl->dc) {
+		g_io_channel_shutdown(mdl->dc, TRUE, NULL);
+		g_io_channel_unref(mdl->dc);
+		mdl->dc = NULL;
+	}
+}
+
+static void mcap_free_mdls(struct mcap_mcl *mcl, gboolean save)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	if (!mcl->mdls)
+		return;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		shutdown_mdl(mdl);
+		if (!save)
+			g_free(mdl);
+	}
+
+	if (!save) {
+		g_slist_free(mcl->mdls);
+		mcl->mdls = NULL;
+	}
+}
+
+static void close_mcl(struct mcap_mcl *mcl, gboolean save)
+{
+	gboolean store = ((!(mcl->ctrl & MCAP_CTRL_FREE)) && save);
+
+	if (mcl->tid) {
+		RELEASE_TIMER(mcl);
+	}
+
+	if (mcl->cc) {
+		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
+		g_io_channel_unref(mcl->cc);
+		mcl->cc = NULL;
+	}
+
+	g_source_remove(mcl->wid);
+	if (mcl->lcmd) {
+		g_free(mcl->lcmd);
+		mcl->lcmd = NULL;
+	}
+
+	if (mcl->priv_data) {
+		g_free(mcl->priv_data);
+		mcl->priv_data = NULL;
+	}
+
+	mcap_free_mdls(mcl, store);
+
+	if (mcl->cb && !store) {
+		g_free(mcl->cb);
+		mcl->cb = NULL;
+	}
+
+	mcl->state = MCL_IDLE;
+
+	if (store)
+		return;
+
+	g_free(mcl);
+}
+
+static void mcap_mcl_shutdown(struct mcap_mcl *mcl)
+{
+	close_mcl(mcl, TRUE);
+}
+
 static void mcap_mcl_release(struct mcap_mcl *mcl)
 {
-	/* TODO */
+	close_mcl(mcl, FALSE);
 }
 
 static void mcap_mcl_check_del(struct mcap_mcl *mcl)
 {
-	/* TODO */
+	if (mcl->ctrl & MCAP_CTRL_CACHED)
+		mcap_mcl_shutdown(mcl);
+	else
+		mcap_mcl_unref(mcl);
 }
 
 static void mcap_cache_mcl(struct mcap_mcl *mcl)
 {
-	/* TODO */
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
+			 * freed next time that close_mcl is invoked */
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
-	/* TODO */
+	if (!(mcl->ctrl & MCAP_CTRL_CACHED))
+		return;
+
+	debug("Got MCL from cache");
+
+	mcl->ms->cached = g_slist_remove(mcl->ms->cached, mcl);
+	mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
+	mcl->ctrl &= ~MCAP_CTRL_CACHED;
+	mcl->ctrl &= ~MCAP_CTRL_FREE;
+}
+
+void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache)
+{
+	if (!mcl)
+		return;
+
+	if (mcl->cc) {
+		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
+		g_io_channel_unref(mcl->cc);
+		mcl->cc = NULL;
+	}
+
+	mcl->state = MCL_IDLE;
+
+	if (!cache)
+		mcl->ctrl |= MCAP_CTRL_NOCACHE;
 }
 
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl)
-- 
1.6.3.3

