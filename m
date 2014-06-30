Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/5] android/health: Implement mcl_disconnected cb
Date: Mon, 30 Jun 2014 19:58:24 +0300
Message-Id: <1404147508-22756-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1404147508-22756-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provide a utility to find device by mcl and update the
mcl status.
---
 android/health.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 3225617..1905862 100644
--- a/android/health.c
+++ b/android/health.c
@@ -243,6 +243,14 @@ static bool match_channel_by_id(const void *data, const void *user_data)
 	return channel->id == channel_id;
 }
 
+static bool match_dev_by_mcl(const void *data, const void *user_data)
+{
+	const struct health_device *dev = data;
+	const struct mcap_mcl *mcl = user_data;
+
+	return dev->mcl == mcl;
+}
+
 static bool match_dev_by_addr(const void *data, const void *user_data)
 {
 	const struct health_device *dev = data;
@@ -329,6 +337,36 @@ static struct health_channel *search_channel_by_id(uint16_t id)
 	return search.channel;
 }
 
+struct mcl_search {
+	struct mcap_mcl *mcl;
+	struct health_device *dev;
+};
+
+static void app_search_dev(void *data, void *user_data)
+{
+	struct health_app *app = data;
+	struct mcl_search *search = user_data;
+
+	if (search->dev)
+		return;
+
+	search->dev = queue_find(app->devices, match_dev_by_mcl, search->mcl);
+}
+
+static struct health_device *search_dev_by_mcl(struct mcap_mcl *mcl)
+{
+	struct mcl_search search;
+
+	DBG("");
+
+	search.mcl = mcl;
+	search.dev = NULL;
+
+	queue_foreach(apps, app_search_dev, &search);
+
+	return search.dev;
+}
+
 struct app_search {
 	uint8_t mdepid;
 	struct health_app *app;
@@ -1977,7 +2015,13 @@ static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 
 static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 {
-	DBG("Not implemented");
+	struct health_device *dev;
+
+	DBG("");
+
+	dev = search_dev_by_mcl(mcl);
+	if (dev)
+		dev->mcl_conn = false;
 }
 
 static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
-- 
1.9.1

