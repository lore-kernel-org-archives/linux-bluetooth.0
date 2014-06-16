Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/4] android/health: Initial connect channel implementation
Date: Tue, 17 Jun 2014 01:02:49 +0300
Message-Id: <1402956170-18356-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402956170-18356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402956170-18356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fetches remote sdp record and initiates MCL connection.
---
 android/health.c | 415 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 413 insertions(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index 5a87089..94154c3 100644
--- a/android/health.c
+++ b/android/health.c
@@ -36,9 +36,13 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
+#include "lib/uuid.h"
+#include "lib/l2cap.h"
 #include "src/log.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/uuid-helper.h"
+#include "src/sdp-client.h"
 
 #include "hal-msg.h"
 #include "ipc-common.h"
@@ -72,6 +76,28 @@ struct mdep_cfg {
 	uint8_t id; /* mdep id */
 };
 
+struct health_device {
+	bdaddr_t dst;
+	uint16_t app_id;
+
+	struct mcap_mcl *mcl;
+	bool mcl_conn;
+
+	struct queue *channels;     /* data channels */
+
+	uint16_t ccpsm;
+	uint16_t dcpsm;
+};
+
+struct health_channel {
+	uint8_t mdep_id;
+	uint8_t type;
+
+	struct health_device *dev;
+
+	uint16_t id; /* channel id */
+};
+
 struct health_app {
 	char *app_name;
 	char *provider_name;
@@ -81,8 +107,54 @@ struct health_app {
 	struct queue *mdeps;
 
 	uint16_t id; /* app id */
+	struct queue *devices;
 };
 
+static void free_health_channel(void *data)
+{
+	struct health_channel *channel = data;
+
+	if (!channel)
+		return;
+
+	free(channel);
+}
+
+static void destroy_channel(void *data)
+{
+	struct health_channel *channel = data;
+
+	if (!channel)
+		return;
+
+	/* TODO: Notify channel connection status DESTROYED */
+	queue_remove(channel->dev->channels, channel);
+	free_health_channel(channel);
+}
+
+static void unref_mcl(struct health_device *dev)
+{
+	if (!dev && !dev->mcl)
+		return;
+
+	mcap_close_mcl(dev->mcl, FALSE);
+	mcap_mcl_unref(dev->mcl);
+	dev->mcl = NULL;
+	dev->mcl_conn = FALSE;
+}
+
+static void free_health_device(void *data)
+{
+	struct health_device *dev = data;
+
+	if (!dev)
+		return;
+
+	unref_mcl(dev);
+	queue_destroy(dev->channels, free_health_channel);
+	free(dev);
+}
+
 static void free_mdep_cfg(void *data)
 {
 	struct mdep_cfg *cfg = data;
@@ -106,6 +178,7 @@ static void free_health_app(void *data)
 	free(app->service_name);
 	free(app->service_descr);
 	queue_destroy(app->mdeps, free_mdep_cfg);
+	queue_destroy(app->devices, free_health_device);
 	free(app);
 }
 
@@ -130,6 +203,14 @@ static bool mdep_by_mdep_role(const void *data, const void *user_data)
 	return mdep->role == role;
 }
 
+static bool mdep_by_mdep_id(const void *data, const void *user_data)
+{
+	const struct mdep_cfg *mdep = data;
+	uint16_t mdep_id = PTR_TO_INT(user_data);
+
+	return mdep->id == mdep_id;
+}
+
 static bool app_by_app_id(const void *data, const void *user_data)
 {
 	const struct health_app *app = data;
@@ -760,12 +841,342 @@ static void bt_health_unregister_app(const void *buf, uint16_t len)
 				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_SUCCESS);
 }
 
+static int get_prot_desc_entry(sdp_data_t *entry, int type, guint16 *val)
+{
+	sdp_data_t *iter;
+	int proto;
+
+	if (!entry || !SDP_IS_SEQ(entry->dtd))
+		return -1;
+
+	iter = entry->val.dataseq;
+	if (!(iter->dtd & SDP_UUID_UNSPEC))
+		return -1;
+	proto = sdp_uuid_to_proto(&iter->val.uuid);
+	if (proto != type)
+		return -1;
+
+	if (!val)
+		return 0;
+
+	iter = iter->next;
+	if (iter->dtd != SDP_UINT16)
+		return -1;
+
+	*val = iter->val.uint16;
+
+	return 0;
+}
+
+static int get_prot_desc_list(const sdp_record_t *rec, uint16_t *psm,
+							uint16_t *version)
+{
+	sdp_data_t *pdl, *p0, *p1;
+
+	if (!psm && !version)
+		return -1;
+
+	pdl = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
+	if (!pdl || !SDP_IS_SEQ(pdl->dtd))
+		return -1;
+
+	p0 = pdl->val.dataseq;
+	if (get_prot_desc_entry(p0, L2CAP_UUID, psm) < 0)
+		return -1;
+
+	p1 = p0->next;
+	if (get_prot_desc_entry(p1, MCAP_CTRL_UUID, version) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int get_ccpsm(sdp_list_t *recs, uint16_t *ccpsm)
+{
+	sdp_list_t *l;
+
+	for (l = recs; l; l = l->next) {
+		sdp_record_t *rec = l->data;
+
+		if (!get_prot_desc_list(rec, ccpsm, NULL))
+			return 0;
+	}
+
+	return -1;
+}
+
+static int get_add_prot_desc_list(const sdp_record_t *rec, uint16_t *psm)
+{
+	sdp_data_t *pdl, *p0, *p1;
+
+	if (!psm)
+		return -1;
+
+	pdl = sdp_data_get(rec, SDP_ATTR_ADD_PROTO_DESC_LIST);
+	if (!pdl || pdl->dtd != SDP_SEQ8)
+		return -1;
+
+	pdl = pdl->val.dataseq;
+	if (pdl->dtd != SDP_SEQ8)
+		return -1;
+
+	p0 = pdl->val.dataseq;
+
+	if (get_prot_desc_entry(p0, L2CAP_UUID, psm) < 0)
+		return -1;
+
+	p1 = p0->next;
+	if (get_prot_desc_entry(p1, MCAP_DATA_UUID, NULL) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int get_dcpsm(sdp_list_t *recs, uint16_t *dcpsm)
+{
+	sdp_list_t *l;
+
+	for (l = recs; l; l = l->next) {
+		sdp_record_t *rec = l->data;
+
+		if (!get_add_prot_desc_list(rec, dcpsm))
+			return 0;
+	}
+
+	return -1;
+}
+
+static void mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
+{
+	DBG("Not Implemeneted");
+}
+
+static void mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
+{
+	DBG("Not Implemeneted");
+}
+
+static void mcap_mdl_deleted_cb(struct mcap_mdl *mdl, void *data)
+{
+	DBG("Not Implemeneted");
+}
+
+static void mcap_mdl_aborted_cb(struct mcap_mdl *mdl, void *data)
+{
+	DBG("Not Implemeneted");
+}
+
+static void mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
+				uint16_t mdlid, uint8_t *conf, void *data)
+{
+	DBG("Not Implemeneted");
+}
+
+static void mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
+{
+	DBG("Not Implemeneted");
+}
+
+static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
+{
+	struct health_channel *channel = data;
+	gboolean ret;
+	GError *gerr = NULL;
+
+	DBG("");
+
+	if (err) {
+		error("error creating MCL : %s", err->message);
+		goto fail;
+	}
+
+	if (!channel->dev->mcl)
+		channel->dev->mcl = mcap_mcl_ref(mcl);
+
+	channel->dev->mcl_conn = TRUE;
+	DBG("MCL connected");
+
+	ret = mcap_mcl_set_cb(channel->dev->mcl, channel, &gerr,
+			MCAP_MDL_CB_CONNECTED, mcap_mdl_connected_cb,
+			MCAP_MDL_CB_CLOSED, mcap_mdl_closed_cb,
+			MCAP_MDL_CB_DELETED, mcap_mdl_deleted_cb,
+			MCAP_MDL_CB_ABORTED, mcap_mdl_aborted_cb,
+			MCAP_MDL_CB_REMOTE_CONN_REQ, mcap_mdl_conn_req_cb,
+			MCAP_MDL_CB_REMOTE_RECONN_REQ, mcap_mdl_reconn_req_cb,
+			MCAP_MDL_CB_INVALID);
+	if (!ret) {
+		error("error setting mdl callbacks on mcl");
+		goto fail;
+	}
+
+	/* TODO : create mdl */
+	return;
+
+fail:
+	destroy_channel(channel);
+
+	if (err)
+		g_error_free(err);
+}
+
+static void search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	struct health_channel *channel = data;
+	GError *gerr = NULL;
+
+	DBG("");
+
+	if (err < 0 || !recs) {
+		error("Error getting remote SDP records");
+		goto fail;
+	}
+
+	if (get_ccpsm(recs, &channel->dev->ccpsm) < 0) {
+		error("Can't get remote PSM for control channel");
+		goto fail;
+	}
+
+	if (get_dcpsm(recs, &channel->dev->dcpsm) < 0) {
+		error("Can't get remote PSM for data channel");
+		goto fail;
+	}
+
+	if (!mcap_create_mcl(mcap, &channel->dev->dst, channel->dev->ccpsm,
+					create_mcl_cb, channel, NULL, &gerr)) {
+		error("error creating mcl %s", gerr->message);
+		goto fail;
+	}
+
+	/* TODO: send channel state CONNECTING */
+	return;
+
+fail:
+	/* TODO: send channel state DESTROYED*/
+
+	queue_remove(channel->dev->channels, channel);
+	free_health_channel(channel);
+
+	if (gerr)
+		g_error_free(gerr);
+}
+
+static int connect_mcl(struct health_channel *channel)
+{
+	uuid_t uuid;
+
+	DBG("");
+
+	bt_string2uuid(&uuid, HDP_UUID);
+
+	return bt_search_service(&adapter_addr, &channel->dev->dst, &uuid,
+						search_cb, channel, NULL, 0);
+}
+
+static struct health_device *create_device(uint16_t app_id,
+						const uint8_t addr[])
+{
+	struct health_device *dev;
+
+	dev = new0(struct health_device, 1);
+	if (!dev)
+		return NULL;
+
+	android2bdaddr(&addr, &dev->dst);
+	dev->app_id = app_id;
+
+	return dev;
+}
+
+static struct health_channel *create_channel(uint16_t app_id,
+						uint8_t mdep_index)
+{
+	struct health_app *app;
+	struct mdep_cfg *mdep;
+	struct health_channel *channel;
+	uint8_t index;
+	static unsigned int channel_id = 1;
+
+	app = queue_find(apps, app_by_app_id, INT_TO_PTR(app_id));
+	if (!app)
+		return NULL;
+
+	index = mdep_index + 1;
+	mdep = queue_find(app->mdeps, mdep_by_mdep_id, INT_TO_PTR(index));
+	if (!mdep)
+		return NULL;
+
+	channel = new0(struct health_channel, 1);
+	if (!channel)
+		return NULL;
+
+	channel->mdep_id = mdep_index;
+	channel->type = mdep->channel_type;
+	channel->id = channel_id++;
+
+	return channel;
+}
+
 static void bt_health_connect_channel(const void *buf, uint16_t len)
 {
-	DBG("Not implemented");
+	const struct hal_cmd_health_connect_channel *cmd = buf;
+	struct hal_rsp_health_connect_channel rsp;
+	struct health_app *app;
+	struct health_device *dev = NULL;
+	struct health_channel *channel = NULL;
+
+	DBG("");
 
+	app = queue_find(apps, app_by_app_id, INT_TO_PTR(cmd->app_id));
+	if (!app)
+		goto fail;
+
+	dev = create_device(cmd->app_id, cmd->bdaddr);
+	if (!dev)
+		goto fail;
+
+	channel = create_channel(cmd->app_id, cmd->mdep_index);
+	if (!channel)
+		goto fail;
+
+	channel->dev = dev;
+
+	if (!app->devices) {
+		app->devices = queue_new();
+		if (!app->devices)
+			goto fail;
+	}
+
+	if (!queue_push_tail(app->devices, dev))
+		goto fail;
+
+	if (!dev->channels) {
+		dev->channels = queue_new();
+		if (!dev->channels)
+			goto fail;
+	}
+
+	if (!queue_push_tail(dev->channels, channel)) {
+		queue_remove(app->devices, dev);
+		goto fail;
+	}
+
+	if (connect_mcl(channel) < 0) {
+		error("error retrieving HDP SDP record");
+		queue_remove(app->devices, dev);
+		goto fail;
+	}
+
+	rsp.channel_id = channel->id;
+	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_HEALTH,
+				HAL_OP_HEALTH_CONNECT_CHANNEL,
+				sizeof(rsp), &rsp, -1);
+	return;
+
+fail:
+	free_health_channel(channel);
+	free_health_device(dev);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
-			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_UNSUPPORTED);
+			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_FAILED);
 }
 
 static void bt_health_destroy_channel(const void *buf, uint16_t len)
-- 
1.9.1

