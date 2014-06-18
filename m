Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/3] android/health: Cache remote mdep id on channel connect request
Date: Wed, 18 Jun 2014 18:58:06 +0300
Message-Id: <1403107087-10539-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403107087-10539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403107087-10539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remote mdep is required to initiate MD_CREATE_MDL_REQ request.
---
 android/health.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 3d852f8..d1e8e79 100644
--- a/android/health.c
+++ b/android/health.c
@@ -95,6 +95,11 @@ struct health_channel {
 
 	struct health_device *dev;
 
+	uint8_t remote_mdep;
+	struct mcap_mdl *mdl;
+	bool mdl_conn;
+	uint16_t mdl_id; /* MDL ID */
+
 	uint16_t id; /* channel id */
 };
 
@@ -1011,6 +1016,111 @@ static void mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
 	DBG("Not Implemeneted");
 }
 
+static bool check_role(uint8_t rec_role, uint8_t app_role)
+{
+	if ((rec_role == HAL_HEALTH_MDEP_ROLE_SINK &&
+			app_role == HAL_HEALTH_MDEP_ROLE_SOURCE) ||
+			(rec_role == HAL_HEALTH_MDEP_ROLE_SOURCE &&
+			app_role == HAL_HEALTH_MDEP_ROLE_SINK))
+		return true;
+
+	return false;
+}
+
+static bool get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
+						uint16_t d_type, uint8_t *mdep)
+{
+	sdp_data_t *list, *feat;
+
+	if (!mdep)
+		return false;
+
+	list = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
+	if (!list || !SDP_IS_SEQ(list->dtd))
+		return false;
+
+	for (feat = list->val.dataseq; feat; feat = feat->next) {
+		sdp_data_t *data_type, *mdepid, *role_t;
+
+		if (!SDP_IS_SEQ(feat->dtd))
+			continue;
+
+		mdepid = feat->val.dataseq;
+		if (!mdepid)
+			continue;
+
+		data_type = mdepid->next;
+		if (!data_type)
+			continue;
+
+		role_t = data_type->next;
+		if (!role_t)
+			continue;
+
+		if (data_type->dtd != SDP_UINT16 || mdepid->dtd != SDP_UINT8 ||
+						role_t->dtd != SDP_UINT8)
+			continue;
+
+		if (data_type->val.uint16 != d_type ||
+					!check_role(role_t->val.uint8, role))
+			continue;
+
+		*mdep = mdepid->val.uint8;
+
+		return true;
+	}
+
+	return false;
+}
+
+static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct health_channel *channel = user_data;
+	struct health_app *app;
+	struct mdep_cfg *mdep;
+	uint8_t mdep_id;
+
+	if (err < 0 || !recs) {
+		error("error getting remote SDP records");
+		goto fail;
+	}
+
+	app = queue_find(apps, app_by_app_id, INT_TO_PTR(channel->dev->app_id));
+	if (!app)
+		goto fail;
+
+	mdep = queue_find(app->mdeps, mdep_by_mdep_id,
+						INT_TO_PTR(channel->mdep_id));
+	if (!mdep)
+		goto fail;
+
+	if (!get_mdep_from_rec(recs->data, mdep->role, mdep->data_type,
+								&mdep_id)) {
+		error("no matching MDEP found");
+		goto fail;
+	}
+
+	channel->remote_mdep = mdep_id;
+
+	/* TODO : create mdl */
+	return;
+
+fail:
+	destroy_channel(channel);
+}
+
+static int get_mdep(struct health_channel *channel)
+{
+	uuid_t uuid;
+
+	DBG("");
+
+	bt_string2uuid(&uuid, HDP_UUID);
+
+	return bt_search_service(&adapter_addr, &channel->dev->dst, &uuid,
+						get_mdep_cb, channel, NULL, 0);
+}
+
 static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 {
 	struct health_channel *channel = data;
@@ -1047,7 +1157,11 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 		goto fail;
 	}
 
-	/* TODO : create mdl */
+	if (get_mdep(channel) < 0) {
+		error("error getting remote MDEP from SDP record");
+		goto fail;
+	}
+
 	return;
 
 fail:
@@ -1226,6 +1340,14 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 			error("error retrieving remote SDP record");
 			goto fail;
 		}
+	} else {
+		/* data channel is already connected */
+		if (channel->mdl && channel->mdl_conn)
+			goto fail;
+
+		/* create mdl if it does not exists */
+		if (!channel->mdl && get_mdep(channel) < 0)
+			goto fail;
 	}
 
 	rsp.channel_id = channel->id;
-- 
1.9.1

