Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/4] android/health: Add some information messages
Date: Mon, 18 Aug 2014 12:07:01 +0300
Message-Id: <1408352822-21572-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index 361b043..e188683 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1233,6 +1233,7 @@ static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 		return;
 	}
 
+	info("health: MDL connected");
 	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
 
 	return;
@@ -1245,7 +1246,7 @@ static void mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
 {
 	struct health_channel *channel = data;
 
-	info("MDL closed");
+	info("health: MDL closed");
 
 	if (!channel)
 		return;
@@ -1271,6 +1272,7 @@ static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 	dev = channel->dev;
 
 	DBG("device %p channel %p mdl %p", dev, channel, mdl);
+	info("health: MDL deleted");
 
 	/* mdl == NULL means, delete all mdls */
 	if (!mdl) {
@@ -1822,7 +1824,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 	if (!channel->dev->mcl)
 		channel->dev->mcl = mcap_mcl_ref(mcl);
 
-	info("MCL connected");
+	info("health: MCL connected");
 
 	ret = set_mcl_cb(channel->dev->mcl, channel, &gerr);
 	if (!ret) {
@@ -2048,6 +2050,7 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 
 	DBG("");
 
+	info("health: MCL connected");
 	ret = set_mcl_cb(mcl, NULL, &gerr);
 	if (!ret) {
 		error("health: error setting mcl callbacks: %s", gerr->message);
@@ -2061,6 +2064,7 @@ static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 
 	DBG("");
 
+	info("health: MCL reconnected");
 	dev = search_dev_by_mcl(mcl);
 	if (!dev) {
 		error("device data does not exists");
@@ -2074,6 +2078,7 @@ static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 
 	DBG("");
 
+	info("health: MCL disconnected");
 	dev = search_dev_by_mcl(mcl);
 	mcap_mcl_unref(dev->mcl);
 	dev->mcl = NULL;
-- 
1.9.1

