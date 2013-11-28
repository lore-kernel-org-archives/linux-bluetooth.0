Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 5/7] android/pan: Implement pan disconnect method in daemon
Date: Thu, 28 Nov 2013 16:45:53 +0200
Message-Id: <1385649955-29276-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disconnect ongoing PANU role connection betweek devices, free
the device and notify the connection state.
---
 android/pan.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 058ce70..7524dae 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -238,9 +238,35 @@ static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct network_peer *np;
+	GSList *l;
+	bdaddr_t dst;
 
-	return HAL_STATUS_FAILED;
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
+	if (np->watch) {
+		g_source_remove(np->watch);
+		np->watch = 0;
+	}
+
+	bnep_if_down(np->dev);
+	bnep_kill_connection(&dst);
+
+	bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+	network_peer_free(np);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
-- 
1.8.3.2

