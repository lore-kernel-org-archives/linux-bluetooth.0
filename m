Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/4] android/health: Fix connect channel failure case
Date: Mon, 18 Aug 2014 12:06:59 +0300
Message-Id: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a possibilty of created channel is being added to queue,
but on failure case it does channel free but not removed from queue.
---
 android/health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/health.c b/android/health.c
index f4edc3e..f86fd26 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1978,6 +1978,7 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 	return;
 
 fail:
+	queue_remove(channel->dev->channels, channel);
 	free_health_channel(channel);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
 			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_FAILED);
-- 
1.9.1

