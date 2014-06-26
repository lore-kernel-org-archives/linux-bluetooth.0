Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] android/health: Improve debug
Date: Thu, 26 Jun 2014 15:04:25 +0300
Message-Id: <1403784265-1455-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index 2d52197..a12970d 100644
--- a/android/health.c
+++ b/android/health.c
@@ -160,6 +160,8 @@ static void free_health_channel(void *data)
 {
 	struct health_channel *channel = data;
 
+	DBG("channel %p", channel);
+
 	if (!channel)
 		return;
 
@@ -1137,12 +1139,13 @@ static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
 	struct health_channel *channel = data;
 	struct health_device *dev;
 
-	DBG("");
-
 	if (!channel)
 		return;
 
 	dev = channel->dev;
+
+	DBG("device %p channel %p mdl %p", dev, channel, mdl);
+
 	/* mdl == NULL means, delete all mdls */
 	if (!mdl) {
 		queue_foreach(dev->channels, notify_channel, NULL);
@@ -1258,6 +1261,8 @@ static struct health_channel *connect_channel(struct mcap_mcl *mcl,
 	struct health_channel *channel = NULL;
 	bdaddr_t addr;
 
+	DBG("mcl %p mdepid %u", mcl, mdepid);
+
 	mcap_mcl_get_addr(mcl, &addr);
 
 	/* TODO: Search app for mdepid */
-- 
1.8.3.2

