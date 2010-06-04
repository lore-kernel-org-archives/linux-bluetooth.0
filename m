Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 13/32] Implement connection of health instances
Date: Fri,  4 Jun 2010 10:30:06 +0200
Message-Id: <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 health/hdp_util.c |   26 ++++++++++++++
 health/hdp_util.h |    2 +
 3 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 840af0f..b9f637e 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -52,6 +52,13 @@ struct health_instances_aux {
 	GSList		*end_points;
 };
 
+struct hdp_connection_cb {
+	struct hdp_device	*device;
+	struct hdp_instance	*hdpi;
+	uint32_t		rem_id;
+	DBusMessage		*msg;
+};
+
 static struct hdp_adapter *find_adapter(GSList *list,
 					struct btd_adapter *btd_adapter)
 {
@@ -240,7 +247,7 @@ static DBusMessage *get_health_instances(DBusConnection *conn,
 	bdaddr_t src, dst;
 	uuid_t uuid;
 
-	adapter = device_get_adapter(device->dev);
+	adapter = device->hdp_adapter->btd_adapter;
 	adapter_get_address(adapter, &src);
 	device_get_address(device->dev, &dst);
 
@@ -284,12 +291,82 @@ static void dev_path_unregister(void *data)
 	health_device_free(device);
 }
 
+static sdp_record_t *get_record(sdp_list_t *recs, uint32_t handle)
+{
+	sdp_record_t *rec;
+	sdp_list_t *l;
+
+	for (l = recs; l; l = l->next) {
+		rec = l->data;
+		if (rec->handle == handle)
+			return rec;
+	}
+
+	return NULL;
+}
+
+static void hdp_mcl_connect_cb(struct mcap_mcl *mcl, GError *err, void *data)
+{
+	struct hdp_connection_cb *cb_data = data;
+
+	/* TODO */
+	g_free(cb_data);
+}
+
+static void connect_health_instance(sdp_list_t *recs, int err, gpointer data)
+{
+	struct hdp_connection_cb *cb_data = data;
+	struct hdp_device *device = cb_data->device;
+	struct hdp_instance *hdpi = cb_data->hdpi;
+	GError *gerr = NULL;
+	uint32_t rid = cb_data->rem_id;
+	DBusMessage *msg = cb_data->msg;
+	DBusMessage *reply;
+	sdp_record_t *rec;
+	guint16 ccpsm, version;
+	bdaddr_t dst;
+
+	if (err != 0) {
+		reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+				"Error getting remote information");
+		goto fail;
+	}
+
+	rec = get_record(recs, rid);
+	if (!rec) {
+		reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+				"Error getting remote information");
+		goto fail;
+	}
+
+	if (!hdp_get_prot_desc_list(rec, &ccpsm, &version)) {
+		reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+			"Error getting remote protocol descriptor list");
+		goto fail;
+	}
+
+	device_get_address(device->dev, &dst);
+	mcap_create_mcl(hdpi->mi, &dst, ccpsm, &gerr, hdp_mcl_connect_cb,
+								cb_data);
+	if (!gerr)
+		return;
+
+	reply = g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+			"Error getting remote protocol descriptor list");
+fail:
+	g_dbus_send_message(device->conn, reply);
+	g_free(cb_data);
+}
+
 static DBusMessage *hdp_connect(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct hdp_device *device = user_data;
-	struct hdp_instance *hdpi;
+	struct hdp_connection_cb *cb_data;
+	struct btd_adapter *adapter;
+	bdaddr_t src, dst;
 	uint32_t lid, rid;
+	uuid_t uuid;
 	GSList *l;
 
 	if (!dbus_message_get_args(msg, NULL,
@@ -307,11 +384,24 @@ static DBusMessage *hdp_connect(DBusConnection *conn,
 		return g_dbus_create_error(msg,
 					   ERROR_INTERFACE ".InvalidArguments",
 					   "Invalid local instance id");
-	hdpi = l->data;
 
+	cb_data = g_new0(struct hdp_connection_cb, 1);
+	cb_data->device = device;
+	cb_data->hdpi = l->data;
+	cb_data->rem_id = rid;
+	cb_data->msg = dbus_message_ref(msg);
 
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".HdpError",
-					"Function is not yet implemented");
+	adapter = device->hdp_adapter->btd_adapter;
+	adapter_get_address(adapter, &src);
+	device_get_address(device->dev, &dst);
+
+	bt_string2uuid(&uuid, HDP_UUID);
+	if (bt_search_service(&src, &dst, &uuid, connect_health_instance,
+							cb_data, NULL) == 0)
+		return NULL;
+
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+				   "Error getting remote information");
 }
 
 static GDBusMethodTable device_methods[] = {
diff --git a/health/hdp_util.c b/health/hdp_util.c
index 921a1e1..066147a 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -883,6 +883,32 @@ gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val)
 	return TRUE;
 }
 
+gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
+							guint16 *version)
+{
+	if (!(psm || version))
+		return TRUE;
+
+	/* TODO:
+	sdp_data_t *pdl, *l;
+
+	exspec = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
+	if (exspec->dtd != SDP_SEQ8)
+		return FALSE;
+
+	for (l = pdl->val.dataseq; l; l = l->next) {
+		if (l->dtd != SDP_SEQ8)
+			continue;
+		epl = get_feature(epl, l->val.dataseq);
+	}
+	*/
+	if (psm)
+		*psm = 0x1001;
+	if (version)
+		*version = 0x0100;
+	return TRUE;
+}
+
 static gint cmp_feat_mdep(gconstpointer a, gconstpointer b)
 {
 	const struct hdp_supp_fts *fts = a;
diff --git a/health/hdp_util.h b/health/hdp_util.h
index 08e6471..03a7256 100644
--- a/health/hdp_util.h
+++ b/health/hdp_util.h
@@ -37,6 +37,8 @@ typedef void (*hdp_dbus_fill_up)(DBusMessageIter *iter, gpointer data);
 struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err);
 gboolean hdp_register_sdp_record(struct hdp_instance *hdps);
 gboolean hdp_get_data_exchange_spec(const sdp_record_t *rec, guint8 *val);
+gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
+							guint16 *version);
 GSList *hdp_get_end_points(const sdp_record_t *rec);
 void hdp_instance_free(struct hdp_instance *hdpi);
 
-- 
1.6.3.3

