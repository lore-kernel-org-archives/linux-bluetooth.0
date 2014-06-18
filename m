Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/3] android/health: Create and connect MDL
Date: Wed, 18 Jun 2014 18:58:07 +0300
Message-Id: <1403107087-10539-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403107087-10539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403107087-10539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Based on retrived remote mdep id, request for md_create_mdl and
on successful response connect mdl and pass fd.
---
 android/health.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index d1e8e79..b7e249e 100644
--- a/android/health.c
+++ b/android/health.c
@@ -115,6 +115,16 @@ struct health_app {
 	struct queue *devices;
 };
 
+static void unref_mdl(struct health_channel *channel)
+{
+	if (!channel || !channel->mdl)
+		return;
+
+	mcap_mdl_unref(channel->mdl);
+	channel->mdl = NULL;
+	channel->mdl_conn = false;
+}
+
 static void free_health_channel(void *data)
 {
 	struct health_channel *channel = data;
@@ -122,6 +132,7 @@ static void free_health_channel(void *data)
 	if (!channel)
 		return;
 
+	unref_mdl(channel);
 	free(channel);
 }
 
@@ -1016,6 +1027,69 @@ static void mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
 	DBG("Not Implemeneted");
 }
 
+static void connect_mdl_cb(struct mcap_mdl *mdl, GError *gerr, gpointer data)
+{
+	struct health_channel *channel = data;
+	int fd;
+
+	DBG("");
+
+	if (gerr) {
+		error("error connecting to MDL %s", gerr->message);
+		goto fail;
+	}
+
+	DBG("MDL connected");
+	fd = mcap_mdl_get_fd(channel->mdl);
+	channel->mdl_conn = true;
+	send_channel_state_notify(channel, HAL_HEALTH_CHANNEL_CONNECTED, fd);
+
+	return;
+
+fail:
+	/* TODO: mcap_mdl_abort */
+	destroy_channel(channel);
+}
+
+static void create_mdl_cb(struct mcap_mdl *mdl, uint8_t type, GError *gerr,
+								gpointer data)
+{
+	struct health_channel *channel = data;
+	uint8_t mode;
+	GError *err = NULL;
+
+	DBG("");
+
+	if (gerr) {
+		error("error creating MDL %s", gerr->message);
+		goto fail;
+	}
+
+	if (!channel->mdl)
+		channel->mdl = mcap_mdl_ref(mdl);
+
+	channel->type = type;
+	channel->mdl_id = mcap_mdl_get_mdlid(mdl);
+
+	if (channel->type == CHANNEL_TYPE_RELIABLE)
+		mode = L2CAP_MODE_ERTM;
+	else
+		mode = L2CAP_MODE_STREAMING;
+
+	if (!mcap_connect_mdl(channel->mdl, mode, channel->dev->dcpsm,
+						connect_mdl_cb, channel,
+						NULL, &err)) {
+		error("error connecting to mdl");
+		g_error_free(err);
+		goto fail;
+	}
+
+	return;
+
+fail:
+	destroy_channel(channel);
+}
+
 static bool check_role(uint8_t rec_role, uint8_t app_role)
 {
 	if ((rec_role == HAL_HEALTH_MDEP_ROLE_SINK &&
@@ -1079,6 +1153,7 @@ static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
 	struct health_app *app;
 	struct mdep_cfg *mdep;
 	uint8_t mdep_id;
+	GError *gerr = NULL;
 
 	if (err < 0 || !recs) {
 		error("error getting remote SDP records");
@@ -1102,7 +1177,14 @@ static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	channel->remote_mdep = mdep_id;
 
-	/* TODO : create mdl */
+	if (!mcap_create_mdl(channel->dev->mcl, channel->remote_mdep,
+				CHANNEL_TYPE_ANY, create_mdl_cb, channel,
+				NULL, &gerr)) {
+		error("error creating mdl %s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
+
 	return;
 
 fail:
-- 
1.9.1

