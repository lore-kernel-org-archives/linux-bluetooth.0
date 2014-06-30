Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/health: Set L2CAP mode for MCAP channels
Date: Mon, 30 Jun 2014 14:48:22 +0300
Message-Id: <1404128905-27695-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check configuration and set L2CAP mode. Enables several PTS test cases.
---
 android/health.c | 72 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/android/health.c b/android/health.c
index 83ae107..2b8562f 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1301,24 +1301,18 @@ static struct health_channel *create_channel(struct health_app *app,
 	return channel;
 }
 
-static struct health_channel *connect_channel(struct mcap_mcl *mcl,
-								uint8_t mdepid)
+static struct health_channel *connect_channel(struct health_app *app,
+							struct mcap_mcl *mcl,
+							uint8_t mdepid)
 {
-	struct health_app *app;
 	struct health_device *device;
 	struct health_channel *channel = NULL;
 	bdaddr_t addr;
 
-	DBG("mcl %p mdepid %u", mcl, mdepid);
+	DBG("app %p mdepid %u", app, mdepid);
 
 	mcap_mcl_get_addr(mcl, &addr);
 
-	if (mdepid == MDEP_ECHO)
-		/* For echo service take last app */
-		app = queue_peek_tail(apps);
-	else
-		app = search_app_by_mdepid(mdepid);
-
 	if (!app) {
 		DBG("No app found for mdepid %u", mdepid);
 		return NULL;
@@ -1330,25 +1324,41 @@ static struct health_channel *connect_channel(struct mcap_mcl *mcl,
 
 	channel = create_channel(app, mdepid, device);
 
-	/* Channel is assigned here after creation */
-	mcl->cb->user_data = channel;
-
 	return channel;
 }
 
+static uint8_t conf_to_l2cap(uint8_t conf)
+{
+	return conf == CHANNEL_TYPE_STREAM ? L2CAP_MODE_STREAMING :
+								L2CAP_MODE_ERTM;
+}
+
 static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				uint16_t mdlid, uint8_t *conf, void *data)
 {
 	GError *gerr = NULL;
 	struct health_channel *channel;
+	struct health_app *app;
+	struct mdep_cfg *mdep;
 
 	DBG("Data channel request: mdepid %u mdlid %u", mdepid, mdlid);
 
-	/* TODO: find / create device */
-	channel = connect_channel(mcl, mdepid);
+	if (mdepid == MDEP_ECHO)
+		/* For echo service take last app */
+		app = queue_peek_tail(apps);
+	else
+		app = search_app_by_mdepid(mdepid);
+
+	if (!app)
+		return MCAP_MDL_BUSY;
+
+	channel = connect_channel(app, mcl, mdepid);
 	if (!channel)
 		return MCAP_MDL_BUSY;
 
+	/* Channel is assigned here after creation */
+	mcl->cb->user_data = channel;
+
 	if (mdepid == MDEP_ECHO) {
 		switch (*conf) {
 		case CHANNEL_TYPE_ANY:
@@ -1379,6 +1389,38 @@ static uint8_t mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 		return MCAP_SUCCESS;
 	}
 
+	mdep = queue_find(app->mdeps, match_mdep_by_id, INT_TO_PTR(mdepid));
+	if (!mdep)
+		return MCAP_MDL_BUSY;
+
+	switch (*conf) {
+	case CHANNEL_TYPE_ANY:
+		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SINK)
+			return MCAP_CONFIGURATION_REJECTED;
+		else
+			*conf = CHANNEL_TYPE_RELIABLE;
+		break;
+	case CHANNEL_TYPE_STREAM:
+		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SOURCE)
+			return MCAP_CONFIGURATION_REJECTED;
+	case CHANNEL_TYPE_RELIABLE:
+		if (mdep->role == HAL_HEALTH_MDEP_ROLE_SOURCE)
+			return MCAP_CONFIGURATION_REJECTED;
+		break;
+	default:
+		/* Special case defined in HDP spec 3.4. When an invalid
+		* configuration is received we shall close the MCL when
+		* we are still processing the callback. */
+		/* TODO: close device */
+		return MCAP_CONFIGURATION_REJECTED; /* not processed */
+	}
+
+	if (!mcap_set_data_chan_mode(mcap, conf_to_l2cap(*conf), &gerr)) {
+		error("health: error setting L2CAP mode: %s", gerr->message);
+		g_error_free(gerr);
+		return MCAP_MDL_BUSY;
+	}
+
 	return MCAP_SUCCESS;
 }
 
-- 
1.8.3.2

