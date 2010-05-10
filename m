Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 02/25] Initial work to create and destroy MCAP sessions
Date: Mon, 10 May 2010 12:15:04 +0200
Message-Id: <1273486527-7855-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-1-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |  135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index df8dd50..1c94452 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -34,6 +34,49 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
+
+static void mcap_mcl_shutdown(struct mcap_mcl *mcl)
+{
+	/* TODO: Shutdown MCL */
+}
+
+static void mcap_mcl_release(struct mcap_mcl *mcl)
+{
+	/* TODO: Free MCL */
+}
+
+static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	/* TODO: Check if we can connect this data channel */
+}
+
+static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	/* TODO: Check if we can connect this MCL */
+}
+
+struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl)
+{
+	mcl->ref++;
+
+	debug("mcap_mcl_ref(%p): ref=%d", mcl, mcl->ref);
+
+	return mcl;
+}
+
+void mcap_mcl_unref(struct mcap_mcl *mcl)
+{
+	mcl->ref--;
+
+	debug("mcap_mcl_unref(%p): ref=%d", mcl, mcl->ref);
+
+	if (mcl->ref > 0)
+		return;
+
+	mcap_mcl_release(mcl);
+}
+
 struct mcap_session *mcap_create_session(struct btd_adapter *btd_adapter,
 					BtIOSecLevel sec,
 					uint16_t ccpsm,
@@ -45,11 +88,97 @@ struct mcap_session *mcap_create_session(struct btd_adapter *btd_adapter,
 					mcap_mcl_event_cb mcl_uncached,
 					gpointer user_data)
 {
-	/* TODO: Create MCAP Session */
-	return NULL;
+	struct mcap_session *ms;
+
+	if (sec < BT_IO_SEC_MEDIUM) {
+		g_set_error(gerr, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+				"Security level can't be minor of %d",
+				BT_IO_SEC_MEDIUM);
+		return NULL;
+	}
+
+	if (!(mcl_connected && mcl_reconnected &&
+			mcl_disconnected && mcl_uncached)) {
+		g_set_error(gerr, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+				"The callbacks can't be null");
+		return NULL;
+	}
+
+	ms = g_new0(struct mcap_session, 1);
+
+	adapter_get_address(btd_adapter, &ms->src);
+
+	ms->sec = sec;
+	ms->mcl_connected_cb = mcl_connected;
+	ms->mcl_reconnected_cb = mcl_reconnected;
+	ms->mcl_disconnected_cb = mcl_disconnected;
+	ms->mcl_uncached_cb = mcl_uncached;
+	ms->user_data = user_data;
+
+	/* Listen incoming connections in control channel */
+	ms->ccio = bt_io_listen(BT_IO_L2CAP, NULL, confirm_mcl_event_cb, ms,
+				NULL, gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
+				BT_IO_OPT_PSM, ccpsm,
+				BT_IO_OPT_MTU, MCAP_CC_MTU,
+				BT_IO_OPT_SEC_LEVEL, sec,
+				BT_IO_OPT_INVALID);
+	if (!ms->ccio) {
+		error("%s", (*gerr)->message);
+		g_free(ms);
+		return NULL;
+	}
+
+	/* Listen incoming connections in data channels */
+	ms->dcio = bt_io_listen(BT_IO_L2CAP, NULL, confirm_dc_event_cb, ms,
+				NULL, gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
+				BT_IO_OPT_PSM, dcpsm,
+				BT_IO_OPT_MTU, MCAP_DC_MTU,
+				BT_IO_OPT_SEC_LEVEL, sec,
+				BT_IO_OPT_INVALID);
+	if (!ms->dcio) {
+		g_io_channel_shutdown(ms->ccio, TRUE, NULL);
+		g_io_channel_unref(ms->ccio);
+		ms->ccio = NULL;
+		error("%s", (*gerr)->message);
+		g_free(ms);
+		return NULL;
+	}
+
+	return ms;
 }
 
 void mcap_close_session(struct mcap_session *ms)
 {
-	/* Free MCAP session */
+	GSList *l;
+
+	if (!ms)
+		return;
+
+	if (ms->ccio) {
+		g_io_channel_shutdown(ms->ccio, TRUE, NULL);
+		g_io_channel_unref(ms->ccio);
+		ms->ccio = NULL;
+	}
+
+	if (ms->dcio) {
+		g_io_channel_shutdown(ms->dcio, TRUE, NULL);
+		g_io_channel_unref(ms->dcio);
+		ms->dcio = NULL;
+	}
+
+	for (l = ms->mcls; l; l = l->next) {
+		mcap_mcl_shutdown(l->data);
+		mcap_mcl_unref(l->data);
+	}
+	g_slist_free(ms->mcls);
+	ms->mcls = NULL;
+
+	for (l = ms->cached; l; l = l->next)
+		mcap_mcl_unref(l->data);
+	g_slist_free(ms->cached);
+	ms->cached = NULL;
+
+	g_free(ms);
 }
-- 
1.6.3.3

