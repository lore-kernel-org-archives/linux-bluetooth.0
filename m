Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/3] android/health: Remove mcl instance on mcl_disconnected call back
Date: Fri, 22 Aug 2014 12:10:05 +0300
Message-Id: <1408698607-23815-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MCAP library is maintaining two sets of mcl list. On mcl_disconnected
call mcl instance is removed from regular mcl list and cached in mcl_cache
list. health.c doesn't maintain any cached mcls list. So mcl_conn variable
doesn't make any sense of not being connected on mcl_disconnected call back.
So unref mcl on mcl_disconnected and don't do anything in mcl_unached callback.
---
 android/health.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/android/health.c b/android/health.c
index 665482e..ee6c11b 100644
--- a/android/health.c
+++ b/android/health.c
@@ -85,7 +85,6 @@ struct health_device {
 	uint16_t app_id;
 
 	struct mcap_mcl *mcl;
-	bool mcl_conn;
 
 	struct queue *channels;     /* data channels */
 
@@ -193,7 +192,6 @@ static void unref_mcl(struct health_device *dev)
 	mcap_close_mcl(dev->mcl, FALSE);
 	mcap_mcl_unref(dev->mcl);
 	dev->mcl = NULL;
-	dev->mcl_conn = false;
 }
 
 static void free_health_device(void *data)
@@ -1826,7 +1824,6 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 	if (!channel->dev->mcl)
 		channel->dev->mcl = mcap_mcl_ref(mcl);
 
-	channel->dev->mcl_conn = true;
 	info("health: MCL connected");
 
 	ret = set_mcl_cb(channel->dev->mcl, channel, &gerr);
@@ -1948,7 +1945,7 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 		}
 	}
 
-	if (!dev->mcl || (dev->mcl && !dev->mcl_conn)) {
+	if (!dev->mcl) {
 		if (connect_mcl(channel) < 0) {
 			error("health: error retrieving HDP SDP record");
 			goto fail;
@@ -2072,8 +2069,6 @@ static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 		error("device data does not exists");
 		return;
 	}
-
-	dev->mcl_conn = true;
 }
 
 static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
@@ -2084,18 +2079,12 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 
 	info("health: MCL disconnected");
 	dev = search_dev_by_mcl(mcl);
-	if (dev)
-		dev->mcl_conn = false;
+	unref_mcl(dev);
 }
 
 static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 {
-	struct health_device *dev;
-
-	DBG("");
-
-	dev = search_dev_by_mcl(mcl);
-	free_health_device(dev);
+	/* mcap library maintains cache of mcls, not required here */
 }
 
 bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
-- 
1.9.1

