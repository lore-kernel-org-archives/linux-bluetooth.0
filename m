Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/5] android/health: Fix error messages
Date: Mon, 23 Jun 2014 18:06:01 +0300
Message-Id: <1403535964-32644-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/android/health.c b/android/health.c
index 183608b..f45ae51 100644
--- a/android/health.c
+++ b/android/health.c
@@ -661,7 +661,7 @@ static int update_sdp_record(struct health_app *app)
 		goto fail;
 
 	if (bt_adapter_add_record(rec, SVC_HINT_HEALTH) < 0) {
-		error("Failed to register HEALTH record");
+		error("health: Failed to register HEALTH record");
 		goto fail;
 	}
 
@@ -841,7 +841,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 	 *    multile MDEP configurations ?
 	 */
 	if (update_sdp_record(app) < 0) {
-		error("Error creating HDP SDP record");
+		error("health: HDP SDP record preparation failed");
 		status = HAL_STATUS_FAILED;
 		goto fail;
 	}
@@ -1105,7 +1105,7 @@ static void create_mdl_cb(struct mcap_mdl *mdl, uint8_t type, GError *gerr,
 	 */
 	if (channel->type != type) {
 		/* TODO: abort mdl */
-		error("abort, channel-type requested %d, preferred %d not same",
+		error("health: channel type requested %d preferred %d not same",
 							channel->type, type);
 		goto fail;
 	}
@@ -1261,7 +1261,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 	DBG("");
 
 	if (err) {
-		error("error creating MCL : %s", err->message);
+		error("health: error creating MCL : %s", err->message);
 		goto fail;
 	}
 
@@ -1269,7 +1269,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 		channel->dev->mcl = mcap_mcl_ref(mcl);
 
 	channel->dev->mcl_conn = true;
-	DBG("MCL connected");
+	info("MCL connected");
 
 	ret = mcap_mcl_set_cb(channel->dev->mcl, channel, &gerr,
 			MCAP_MDL_CB_CONNECTED, mcap_mdl_connected_cb,
@@ -1280,7 +1280,7 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 			MCAP_MDL_CB_REMOTE_RECONN_REQ, mcap_mdl_reconn_req_cb,
 			MCAP_MDL_CB_INVALID);
 	if (!ret) {
-		error("error setting mdl callbacks on mcl");
+		error("health: error setting mdl callbacks on mcl");
 
 		if (gerr)
 			g_error_free(gerr);
@@ -1307,23 +1307,23 @@ static void search_cb(sdp_list_t *recs, int err, gpointer data)
 	DBG("");
 
 	if (err < 0 || !recs) {
-		error("Error getting remote SDP records");
+		error("health: Error getting remote SDP records");
 		goto fail;
 	}
 
 	if (get_ccpsm(recs, &channel->dev->ccpsm) < 0) {
-		error("Can't get remote PSM for control channel");
+		error("health: Can't get remote PSM for control channel");
 		goto fail;
 	}
 
 	if (get_dcpsm(recs, &channel->dev->dcpsm) < 0) {
-		error("Can't get remote PSM for data channel");
+		error("health: Can't get remote PSM for data channel");
 		goto fail;
 	}
 
 	if (!mcap_create_mcl(mcap, &channel->dev->dst, channel->dev->ccpsm,
 					create_mcl_cb, channel, NULL, &gerr)) {
-		error("error creating mcl %s", gerr->message);
+		error("health: error creating mcl %s", gerr->message);
 
 		if (gerr)
 			g_error_free(gerr);
@@ -1478,14 +1478,14 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 
 	if (!queue_length(dev->channels)) {
 		if (channel->type != CHANNEL_TYPE_RELIABLE) {
-			error("error, first data shannel should be reliable");
+			error("health: first data shannel should be reliable");
 			goto fail;
 		}
 	}
 
 	if (!dev->mcl) {
 		if (connect_mcl(channel) < 0) {
-			error("health:error retrieving HDP SDP record");
+			error("health: error retrieving HDP SDP record");
 			goto fail;
 		}
 	} else {
@@ -1571,7 +1571,7 @@ bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 					NULL, &err);
 
 	if (!mcap) {
-		error("Error creating MCAP instance : %s", err->message);
+		error("health: MCAP instance creation failed %s", err->message);
 		g_error_free(err);
 		return false;
 	}
-- 
1.9.1

