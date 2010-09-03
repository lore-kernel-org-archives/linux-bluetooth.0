Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Avoid possible memory leak in mcap_create_mcl function
Date: Fri,  3 Sep 2010 10:33:59 +0200
Message-Id: <1283502839-5932-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1283502664-5894-1-git-send-email-santoscadenas@gmail.com>
References: <1283502664-5894-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index ec9ea08..dd955e8 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1755,6 +1755,25 @@ static void connect_dc_event_cb(GIOChannel *chan, GError *err,
 	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
 }
 
+static void mcl_io_destroy(gpointer data)
+{
+	struct connect_mcl *con = data;
+	struct mcap_mcl *mcl = con->mcl;
+	mcap_mcl_connect_cb connect_cb = con->connect_cb;
+	gpointer user_data = con->user_data;
+	GError *err = NULL;
+
+	g_free(con);
+
+	mcl->ctrl &= ~MCAP_CTRL_CONN;
+
+	if (mcl->ctrl & MCAP_CTRL_FREE)
+		mcl->ms->mcl_uncached_cb(mcl, mcl->ms->user_data);
+	mcap_mcl_check_del(mcl);
+	g_set_error(&err, MCAP_ERROR, MCAP_ERROR_FAILED, "Connection error");
+	connect_cb(NULL, err, user_data);
+}
+
 gboolean mcap_create_mcl(struct mcap_instance *ms,
 				const bdaddr_t *addr,
 				uint16_t ccpsm,
@@ -1790,7 +1809,7 @@ gboolean mcap_create_mcl(struct mcap_instance *ms,
 	con->user_data = user_data;
 
 	mcl->cc = bt_io_connect(BT_IO_L2CAP, mcap_connect_mcl_cb, con,
-				NULL, err,
+				mcl_io_destroy, err,
 				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
 				BT_IO_OPT_DEST_BDADDR, addr,
 				BT_IO_OPT_PSM, ccpsm,
-- 
1.7.0.4

