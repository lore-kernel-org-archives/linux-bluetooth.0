Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/4] android/health: Simplify search_cb failure case
Date: Mon, 18 Aug 2014 12:07:02 +0300
Message-Id: <1408352822-21572-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/android/health.c b/android/health.c
index e188683..09b55ff 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1877,10 +1877,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 	return;
 
 fail:
-	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_DESTROYED, -1);
-
-	queue_remove(channel->dev->channels, channel);
-	free_health_channel(channel);
+	destroy_channel(channel);
 }
 
 static int connect_mcl(struct health_channel *channel)
-- 
1.9.1

