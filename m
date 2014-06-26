Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 5/5] android/health: Implement destroy_channel call
Date: Fri, 27 Jun 2014 00:30:46 +0300
Message-Id: <1403818246-20205-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Delete MDL channel with MDL_DELETE_REQ.
---
 android/health.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index db3ae9c..e464f78 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1637,19 +1637,40 @@ fail:
 			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_FAILED);
 }
 
+static void channel_delete_cb(GError *gerr, gpointer data)
+{
+	struct health_channel *channel = data;
+
+	DBG("");
+
+	if (!gerr) {
+		error("health: channel delete failed %s", gerr->message);
+		return;
+	}
+
+	destroy_channel(channel);
+}
+
 static void bt_health_destroy_channel(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_health_destroy_channel *cmd = buf;
 	struct health_channel *channel;
+	GError *gerr = NULL;
 
-	DBG("Not Implemented");
+	DBG("");
 
 	channel = search_channel_by_id(cmd->channel_id);
 	if (!channel)
 		goto fail;
 
+	if (!mcap_delete_mdl(channel->mdl, channel_delete_cb, channel,
+							NULL, &gerr)) {
+		error("health: channel delete failed %s", gerr->message);
+		goto fail;
+	}
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
-			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_UNSUPPORTED);
+			HAL_OP_HEALTH_DESTROY_CHANNEL, HAL_STATUS_SUCCESS);
 
 	return;
 
-- 
1.9.1

