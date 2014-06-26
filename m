Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 3/5] android/health: Fix deleting channels queue
Date: Fri, 27 Jun 2014 00:30:44 +0300
Message-Id: <1403818246-20205-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Channels queue is created only on device creation. So do not destroy
queue on all mdls deleted in mdl_deleted_cb, just remove all entries.
---
 android/health.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index 3afdf9b..717e9a6 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1088,8 +1088,8 @@ static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 	/* mdl == NULL means, delete all mdls */
 	if (!mdl) {
 		queue_foreach(dev->channels, notify_channel, NULL);
-		queue_destroy(dev->channels, free_health_channel);
-		dev->channels = NULL;
+		queue_remove_all(dev->channels, NULL, NULL,
+						free_health_channel);
 		return;
 	}
 
-- 
1.9.1

