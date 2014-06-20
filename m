Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 6/7] android/health: Implement mcap_mdl_deleted_cb
Date: Fri, 20 Jun 2014 15:23:35 +0300
Message-Id: <1403267016-28422-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403267016-28422-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mcap_mdl_deleted_cb will be called if remote device sends MDL_DELETE_REQ.
Free channel data and notify channel is destroyed.
---
 android/health.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index ec5a413..b379ee1 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1007,9 +1007,30 @@ static void mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
 	DBG("Not Implemeneted");
 }
 
+static void notify_channel(void *data, void *user_data)
+{
+	struct health_channel *channel = data;
+
+	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_DESTROYED, -1);
+}
+
 static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 {
-	DBG("Not Implemeneted");
+	struct health_channel *channel = data;
+	struct health_device *dev;
+
+	DBG("");
+
+	dev = channel->dev;
+	/* mdl == NULL means, delete all mdls */
+	if (!mdl) {
+		queue_foreach(dev->channels, notify_channel, NULL);
+		queue_destroy(dev->channels, free_health_channel);
+		dev->channels = NULL;
+		return;
+	}
+
+	destroy_channel(channel);
 }
 
 static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
-- 
1.9.1

