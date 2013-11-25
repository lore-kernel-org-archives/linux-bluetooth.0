Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/4] android/pan: Implement pan disconnect method in daemon
Date: Mon, 25 Nov 2013 15:49:28 +0200
Message-Id: <1385387369-3015-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disconnect ongoing PANU role connection betweek devices, free
the device and notify the connection state.
---
 android/pan.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index b1d0e15..74c27c0 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -270,20 +270,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 							bnep_setup_cb, np);
 }
 
-static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
-{
-	DBG("Not Implemented");
-
-	return HAL_STATUS_FAILED;
-}
-
-static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
-{
-	DBG("Not Implemented");
-
-	return HAL_STATUS_FAILED;
-}
-
 static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 {
 	struct network_peer *np;
@@ -335,6 +321,51 @@ static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
 								uint16_t len)
 {
+	struct network_peer *np;
+	GSList *l;
+	bdaddr_t dst;
+
+	DBG("");
+
+	if (len < sizeof(*cmd))
+		return HAL_STATUS_INVALID;
+
+	android2bdaddr(&cmd->bdaddr, &dst);
+
+	l = g_slist_find_custom(peers, &dst, peer_cmp);
+	if (!l)
+		return HAL_STATUS_FAILED;
+
+	np = l->data;
+
+	if (np->conn_state == HAL_PAN_STATE_CONNECTED) {
+		if (np->watch) {
+			g_source_remove(np->watch);
+			np->watch = 0;
+		}
+
+		bnep_if_down(np->dev);
+		bnep_kill_connection(&dst);
+		bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+		network_peer_free(np);
+
+	} else if (np->io) {
+		bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTING);
+		g_io_channel_shutdown(np->io, TRUE, NULL);
+	}
+
+	return HAL_STATUS_SUCCESS;
+}
+
+static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
+{
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
-- 
1.8.3.2

