Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 2/5] android/health: Implement mdl_closed_cb callback
Date: Fri, 27 Jun 2014 00:30:43 +0300
Message-Id: <1403818246-20205-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Callback will be called when data channel is disconnected/closed.
It does not mean that it is deleted. So only change connected status.
---
 android/health.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 30a6166..3afdf9b 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1057,7 +1057,14 @@ static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 
 static void mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
 {
-	DBG("Not Implemeneted");
+	struct health_channel *channel = data;
+
+	info("MDL closed");
+
+	if (!channel)
+		return;
+
+	channel->mdl_conn = false;
 }
 
 static void notify_channel(void *data, void *user_data)
-- 
1.9.1

