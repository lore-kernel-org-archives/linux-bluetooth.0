Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 02/25] Initial work to create MCAP instances
Date: Fri, 14 May 2010 12:19:29 +0200
Message-Id: <1273832392-18654-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-1-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 48ea5cf..ff8c9b5 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -34,6 +34,18 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
+
+static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	/* TODO */
+}
+
+static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	/* TODO */
+}
+
 struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 					BtIOSecLevel sec,
 					uint16_t ccpsm,
@@ -45,8 +57,65 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 					mcap_mcl_event_cb mcl_uncached,
 					gpointer user_data)
 {
-	/* TODO */
-	return NULL;
+	struct mcap_instance *ms;
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
+	ms = g_new0(struct mcap_instance, 1);
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
 
 void mcap_release_instance(struct mcap_instance *ms)
-- 
1.6.3.3

