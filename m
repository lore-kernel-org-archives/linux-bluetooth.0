Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/5] android/health: Avoid multiple times of sdp search
Date: Wed, 27 Aug 2014 15:38:56 +0300
Message-Id: <1409143140-19651-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First it searches for control and data PSMs and then search again
for remote mdep id. It would be better to search remote mdep id
and cache in first time itself. Patch avoids load of sdp search
request for second time.
---
 android/health.c | 75 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/android/health.c b/android/health.c
index 2c05fb8..abf01b4 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1723,36 +1723,48 @@ static bool get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
 	return false;
 }
 
-static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
+static bool get_remote_mdep(sdp_list_t *recs, struct health_channel *channel)
 {
-	struct health_channel *channel = user_data;
 	struct health_app *app;
 	struct mdep_cfg *mdep;
-	uint8_t mdep_id, type;
-	GError *gerr = NULL;
-
-	if (err < 0 || !recs) {
-		error("health: error getting remote SDP records");
-		goto fail;
-	}
+	uint8_t mdep_id;
 
 	app = queue_find(apps, match_app_by_id,
 					INT_TO_PTR(channel->dev->app_id));
 	if (!app)
-		goto fail;
+		return false;
 
 	mdep = queue_find(app->mdeps, match_mdep_by_id,
 						INT_TO_PTR(channel->mdep_id));
 	if (!mdep)
-		goto fail;
+		return false;
 
 	if (!get_mdep_from_rec(recs->data, mdep->role, mdep->data_type,
 								&mdep_id)) {
 		error("health: no matching MDEP: %u", channel->mdep_id);
-		goto fail;
+		return false;
 	}
 
 	channel->remote_mdep = mdep_id;
+	return true;
+}
+
+static bool create_mdl(struct health_channel *channel)
+{
+	struct health_app *app;
+	struct mdep_cfg *mdep;
+	uint8_t type;
+	GError *gerr = NULL;
+
+	app = queue_find(apps, match_app_by_id,
+					INT_TO_PTR(channel->dev->app_id));
+	if (!app)
+		return false;
+
+	mdep = queue_find(app->mdeps, match_mdep_by_id,
+						INT_TO_PTR(channel->mdep_id));
+	if (!mdep)
+		return false;
 
 	if (mdep->role == HAL_HEALTH_MDEP_ROLE_SOURCE)
 		type = channel->type;
@@ -1763,25 +1775,10 @@ static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
 				type, create_mdl_cb, channel, NULL, &gerr)) {
 		error("health: error creating mdl %s", gerr->message);
 		g_error_free(gerr);
-		goto fail;
+		return false;
 	}
 
-	return;
-
-fail:
-	destroy_channel(channel);
-}
-
-static int get_mdep(struct health_channel *channel)
-{
-	uuid_t uuid;
-
-	DBG("");
-
-	bt_string2uuid(&uuid, HDP_UUID);
-
-	return bt_search_service(&adapter_addr, &channel->dev->dst, &uuid,
-						get_mdep_cb, channel, NULL, 0);
+	return true;
 }
 
 static bool set_mcl_cb(struct mcap_mcl *mcl, gpointer user_data, GError **err)
@@ -1821,10 +1818,8 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 		goto fail;
 	}
 
-	if (get_mdep(channel) < 0) {
-		error("health: error getting remote MDEP from SDP record");
+	if (!create_mdl(channel))
 		goto fail;
-	}
 
 	return;
 
@@ -1854,6 +1849,11 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
+	if (!get_remote_mdep(recs, channel)) {
+		error("health: Can't get remote MDEP data");
+		goto fail;
+	}
+
 	if (!mcap_create_mcl(mcap, &channel->dev->dst, channel->dev->ccpsm,
 					create_mcl_cb, channel, NULL, &gerr)) {
 		error("health: error creating mcl %s", gerr->message);
@@ -1861,7 +1861,6 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
-	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTING, -1);
 	return;
 
 fail:
@@ -1871,13 +1870,19 @@ fail:
 static int connect_mcl(struct health_channel *channel)
 {
 	uuid_t uuid;
+	int err;
 
 	DBG("");
 
 	bt_string2uuid(&uuid, HDP_UUID);
 
-	return bt_search_service(&adapter_addr, &channel->dev->dst, &uuid,
+	err = bt_search_service(&adapter_addr, &channel->dev->dst, &uuid,
 						search_cb, channel, NULL, 0);
+	if (!err)
+		send_channel_state_notify(channel,
+					HAL_HEALTH_CHANNEL_CONNECTING, -1);
+
+	return err;
 }
 
 static struct health_app *get_app(uint16_t app_id)
@@ -1944,7 +1949,7 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 			goto fail;
 
 		/* create mdl if it does not exists */
-		if (!channel->mdl && get_mdep(channel) < 0)
+		if (!channel->mdl && !create_mdl(channel) < 0)
 			goto fail;
 
 		/* reconnect mdl if it exists */
-- 
1.9.1

