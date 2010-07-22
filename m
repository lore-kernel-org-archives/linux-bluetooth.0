Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 60/60] Change variable name for MCAP Instances
Date: Thu, 22 Jul 2010 10:58:17 +0200
Message-Id: <1279789097-2420-12-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-11-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
 <1279789097-2420-5-git-send-email-sancane@gmail.com>
 <1279789097-2420-6-git-send-email-sancane@gmail.com>
 <1279789097-2420-7-git-send-email-sancane@gmail.com>
 <1279789097-2420-8-git-send-email-sancane@gmail.com>
 <1279789097-2420-9-git-send-email-sancane@gmail.com>
 <1279789097-2420-10-git-send-email-sancane@gmail.com>
 <1279789097-2420-11-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c     |   46 +++++++++++++++++++++++-----------------------
 mcap/mcap_lib.h |    6 +++---
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 5369328..6155f0a 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1987,51 +1987,51 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 	return ms;
 }
 
-void mcap_release_instance(struct mcap_instance *ms)
+void mcap_release_instance(struct mcap_instance *mi)
 {
 	GSList *l;
 
-	if (!ms)
+	if (!mi)
 		return;
 
-	if (ms->ccio) {
-		g_io_channel_shutdown(ms->ccio, TRUE, NULL);
-		g_io_channel_unref(ms->ccio);
-		ms->ccio = NULL;
+	if (mi->ccio) {
+		g_io_channel_shutdown(mi->ccio, TRUE, NULL);
+		g_io_channel_unref(mi->ccio);
+		mi->ccio = NULL;
 	}
 
-	if (ms->dcio) {
-		g_io_channel_shutdown(ms->dcio, TRUE, NULL);
-		g_io_channel_unref(ms->dcio);
-		ms->dcio = NULL;
+	if (mi->dcio) {
+		g_io_channel_shutdown(mi->dcio, TRUE, NULL);
+		g_io_channel_unref(mi->dcio);
+		mi->dcio = NULL;
 	}
 
-	for (l = ms->mcls; l; l = l->next) {
+	for (l = mi->mcls; l; l = l->next) {
 		mcap_mcl_shutdown(l->data);
 		mcap_mcl_unref(l->data);
 	}
-	g_slist_free(ms->mcls);
-	ms->mcls = NULL;
+	g_slist_free(mi->mcls);
+	mi->mcls = NULL;
 
-	for (l = ms->cached; l; l = l->next)
+	for (l = mi->cached; l; l = l->next)
 		mcap_mcl_unref(l->data);
-	g_slist_free(ms->cached);
-	ms->cached = NULL;
+	g_slist_free(mi->cached);
+	mi->cached = NULL;
 
-	g_free(ms);
+	g_free(mi);
 }
 
-uint16_t mcap_get_ctrl_psm(struct mcap_instance *ms, GError **err)
+uint16_t mcap_get_ctrl_psm(struct mcap_instance *mi, GError **err)
 {
 	uint16_t lpsm;
 
-	if (!(ms && ms->ccio)) {
+	if (!(mi && mi->ccio)) {
 		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
 			"Invalid MCAP instance");
 		return 0;
 	}
 
-	bt_io_get(ms->ccio, BT_IO_L2CAP, err,
+	bt_io_get(mi->ccio, BT_IO_L2CAP, err,
 			BT_IO_OPT_PSM, &lpsm,
 			BT_IO_OPT_INVALID);
 	if (*err)
@@ -2039,17 +2039,17 @@ uint16_t mcap_get_ctrl_psm(struct mcap_instance *ms, GError **err)
 	return lpsm;
 }
 
-uint16_t mcap_get_data_psm(struct mcap_instance *ms, GError **err)
+uint16_t mcap_get_data_psm(struct mcap_instance *mi, GError **err)
 {
 	uint16_t lpsm;
 
-	if (!(ms && ms->dcio)) {
+	if (!(mi && mi->dcio)) {
 		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
 			"Invalid MCAP instance");
 		return 0;
 	}
 
-	bt_io_get(ms->dcio, BT_IO_L2CAP, err,
+	bt_io_get(mi->dcio, BT_IO_L2CAP, err,
 			BT_IO_OPT_PSM, &lpsm,
 			BT_IO_OPT_INVALID);
 	if (*err)
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
index fa62cbe..b6286a1 100644
--- a/mcap/mcap_lib.h
+++ b/mcap/mcap_lib.h
@@ -158,10 +158,10 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 					gpointer user_data,
 					GError **gerr);
 
-void mcap_release_instance(struct mcap_instance *ms);
+void mcap_release_instance(struct mcap_instance *mi);
 
-uint16_t mcap_get_ctrl_psm(struct mcap_instance *ms, GError **err);
-uint16_t mcap_get_data_psm(struct mcap_instance *ms, GError **err);
+uint16_t mcap_get_ctrl_psm(struct mcap_instance *mi, GError **err);
+uint16_t mcap_get_data_psm(struct mcap_instance *mi, GError **err);
 
 #ifdef __cplusplus
 }
-- 
1.6.3.3

