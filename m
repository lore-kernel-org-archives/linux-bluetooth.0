Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 3/5] android/health: improve search efficiency
Date: Mon, 15 Dec 2014 17:03:34 -0800
Message-Id: <1418691816-40271-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
References: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Iterate through the entries manually to return early for efficiency.
---
 android/health.c | 153 +++++++++++++++++++++++--------------------------------
 1 file changed, 64 insertions(+), 89 deletions(-)

diff --git a/android/health.c b/android/health.c
index 75811aa..f2895a2 100644
--- a/android/health.c
+++ b/android/health.c
@@ -302,133 +302,108 @@ static bool match_app_by_id(const void *data, const void *user_data)
 	return app->id == app_id;
 }
 
-/*
- * Helper struct and utility to search channel when only channel id
- * is the option. i.e. destroy_channel call from HAL is passing only
- * channel id.
- */
-struct channel_search {
-	uint16_t channel_id;
-	struct mcap_mdl *mdl;
-	struct health_channel *channel;
-};
-
-static void device_search_channel(void *data, void *user_data)
-{
-	struct health_device *dev = data;
-	struct channel_search *search = user_data;
-
-	if (search->channel)
-		return;
-
-	if (search->channel_id)
-		search->channel = queue_find(dev->channels, match_channel_by_id,
-						INT_TO_PTR(search->channel_id));
-	else if (search->mdl)
-		search->channel = queue_find(dev->channels,
-						match_channel_by_mdl,
-						search->mdl);
-}
-
-static void app_search_channel(void *data, void *user_data)
+static struct health_channel *search_channel_by_id(uint16_t id)
 {
-	struct health_app *app = data;
-	struct channel_search *search = user_data;
+	const struct queue_entry *apps_entry, *devices_entry;
+	struct health_app *app;
+	struct health_channel *channel;
+	struct health_device *dev;
 
-	if (search->channel)
-		return;
+	DBG("");
 
-	queue_foreach(app->devices, device_search_channel, search);
-}
+	apps_entry = queue_get_entries(apps);
+	while (apps_entry) {
+		app = apps_entry->data;
+		devices_entry = queue_get_entries(app->devices);
+		while (devices_entry) {
+			dev = devices_entry->data;
+			channel = queue_find(dev->channels, match_channel_by_id,
+								INT_TO_PTR(id));
 
-static struct health_channel *search_channel_by_id(uint16_t id)
-{
-	struct channel_search search;
+			if (channel)
+				return channel;
 
-	DBG("");
+			devices_entry = devices_entry->next;
+		}
 
-	search.channel_id = id;
-	search.mdl = NULL;
-	search.channel = NULL;
-	queue_foreach(apps, app_search_channel, &search);
+		apps_entry = apps_entry->next;
+	}
 
-	return search.channel;
+	return NULL;
 }
 
 static struct health_channel *search_channel_by_mdl(struct mcap_mdl *mdl)
 {
-	struct channel_search search;
+	const struct queue_entry *apps_entry, *devices_entry;
+	struct health_app *app;
+	struct health_channel *channel;
+	struct health_device *dev;
 
 	DBG("");
 
-	search.channel_id = 0;
-	search.mdl = mdl;
-	search.channel = NULL;
-	queue_foreach(apps, app_search_channel, &search);
+	apps_entry = queue_get_entries(apps);
+	while (apps_entry) {
+		app = apps_entry->data;
+		devices_entry = queue_get_entries(app->devices);
+		while (devices_entry) {
+			dev = devices_entry->data;
+			channel = queue_find(dev->channels,
+						match_channel_by_mdl, mdl);
 
-	return search.channel;
-}
+			if (channel)
+				return channel;
 
-struct mcl_search {
-	struct mcap_mcl *mcl;
-	struct health_device *dev;
-};
-
-static void app_search_dev(void *data, void *user_data)
-{
-	struct health_app *app = data;
-	struct mcl_search *search = user_data;
+			devices_entry = devices_entry->next;
+		}
 
-	if (search->dev)
-		return;
+		apps_entry = apps_entry->next;
+	}
 
-	search->dev = queue_find(app->devices, match_dev_by_mcl, search->mcl);
+	return NULL;
 }
 
 static struct health_device *search_dev_by_mcl(struct mcap_mcl *mcl)
 {
-	struct mcl_search search;
+	const struct queue_entry *apps_entry;
+	struct health_app *app;
+	struct health_device *dev;
 
 	DBG("");
 
-	search.mcl = mcl;
-	search.dev = NULL;
+	apps_entry = queue_get_entries(apps);
+	while (apps_entry) {
+		app = apps_entry->data;
 
-	queue_foreach(apps, app_search_dev, &search);
+		dev = queue_find(app->devices, match_dev_by_mcl, mcl);
 
-	return search.dev;
-}
-
-struct app_search {
-	uint8_t mdepid;
-	struct health_app *app;
-};
-
-static void app_search_mdep(void *data, void *user_data)
-{
-	struct health_app *app = data;
-	struct app_search *search = user_data;
+		if (dev)
+			return dev;
 
-	if (search->app)
-		return;
+		apps_entry = apps_entry->next;
+	}
 
-	if (queue_find(app->mdeps, match_mdep_by_id,
-						INT_TO_PTR(search->mdepid)))
-		search->app = app;
+	return NULL;
 }
 
 static struct health_app *search_app_by_mdepid(uint8_t mdepid)
 {
-	struct app_search search;
+	const struct queue_entry *apps_entry;
+	struct health_app *app;
 
 	DBG("");
 
-	search.mdepid = mdepid;
-	search.app = NULL;
+	apps_entry = queue_get_entries(apps);
+	while (apps_entry) {
+		app = apps_entry->data;
 
-	queue_foreach(apps, app_search_mdep, &search);
+		if (queue_find(app->mdeps, match_mdep_by_id,
+							INT_TO_PTR(mdepid)))
+			return app;
 
-	return search.app;
+		apps_entry = apps_entry->next;
+	}
+
+	return NULL;
 }
 
 static int register_service_protocols(sdp_record_t *rec,
-- 
2.2.0.rc0.207.ga3a616c

