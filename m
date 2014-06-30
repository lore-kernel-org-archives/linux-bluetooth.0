Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/health: Add handling incoming connection
Date: Mon, 30 Jun 2014 11:14:55 +0300
Message-Id: <1404116096-21971-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add support for normal data channel creation. Also add search helper for
searching apps for suitable mdepid.
---
 android/health.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/android/health.c b/android/health.c
index 709e621..83ae107 100644
--- a/android/health.c
+++ b/android/health.c
@@ -329,6 +329,38 @@ static struct health_channel *search_channel_by_id(uint16_t id)
 	return search.channel;
 }
 
+struct app_search {
+	uint8_t mdepid;
+	struct health_app *app;
+};
+
+static void app_search_mdep(void *data, void *user_data)
+{
+	struct health_app *app = data;
+	struct app_search *search = user_data;
+
+	if (search->app)
+		return;
+
+	if (queue_find(app->mdeps, match_mdep_by_id,
+						INT_TO_PTR(search->mdepid)))
+		search->app = app;
+}
+
+static struct health_app *search_app_by_mdepid(uint8_t mdepid)
+{
+	struct app_search search;
+
+	DBG("");
+
+	search.mdepid = mdepid;
+	search.app = NULL;
+
+	queue_foreach(apps, app_search_mdep, &search);
+
+	return search.app;
+}
+
 static int register_service_protocols(sdp_record_t *rec,
 					struct health_app *app)
 {
@@ -1281,22 +1313,24 @@ static struct health_channel *connect_channel(struct mcap_mcl *mcl,
 
 	mcap_mcl_get_addr(mcl, &addr);
 
-	/* TODO: Search app for mdepid */
-
-	if (mdepid == MDEP_ECHO) {
+	if (mdepid == MDEP_ECHO)
 		/* For echo service take last app */
 		app = queue_peek_tail(apps);
-		if (!app)
-			return NULL;
-
-		device = get_device(app, (uint8_t *) &addr);
-		if (!device)
-			return NULL;
+	else
+		app = search_app_by_mdepid(mdepid);
 
-		channel = create_channel(app, mdepid, device);
+	if (!app) {
+		DBG("No app found for mdepid %u", mdepid);
+		return NULL;
 	}
 
-	/* Device is created here */
+	device = get_device(app, (uint8_t *) &addr);
+	if (!device)
+		return NULL;
+
+	channel = create_channel(app, mdepid, device);
+
+	/* Channel is assigned here after creation */
 	mcl->cb->user_data = channel;
 
 	return channel;
-- 
1.8.3.2

