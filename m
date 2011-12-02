Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/5] hdp_util: Fix coding style issues
Date: Fri,  2 Dec 2011 11:56:32 +0100
Message-Id: <1322823396-5941-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1322823396-5941-1-git-send-email-sancane@gmail.com>
References: <1322823396-5941-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp_util.c |  171 +++++++++++++++++++++++++++--------------------------
 1 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/health/hdp_util.c b/health/hdp_util.c
index e62ed46..7a234c1 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -362,24 +362,24 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
 	/* set l2cap information */
 	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
 	l2cap_list = sdp_list_append(NULL, &l2cap_uuid);
-	if (!l2cap_list) {
+	if (l2cap_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
 	psm = sdp_data_alloc(SDP_UINT16, &adapter->ccpsm);
-	if (!psm) {
+	if (psm == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
-	if (!sdp_list_append(l2cap_list, psm)) {
+	if (sdp_list_append(l2cap_list, psm) == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
 	proto_list = sdp_list_append(NULL, l2cap_list);
-	if (!proto_list) {
+	if (proto_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
@@ -387,30 +387,30 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
 	/* set mcap information */
 	sdp_uuid16_create(&mcap_c_uuid, MCAP_CTRL_UUID);
 	mcap_list = sdp_list_append(NULL, &mcap_c_uuid);
-	if (!mcap_list) {
+	if (mcap_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
 	mcap_ver = sdp_data_alloc(SDP_UINT16, &version);
-	if (!mcap_ver) {
+	if (mcap_ver == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
-	if (!sdp_list_append(mcap_list, mcap_ver)) {
+	if (sdp_list_append(mcap_list, mcap_ver) == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
-	if (!sdp_list_append(proto_list, mcap_list)) {
+	if (sdp_list_append(proto_list, mcap_list) == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
 	/* attach protocol information to service record */
 	access_proto_list = sdp_list_append(NULL, proto_list);
-	if (!access_proto_list) {
+	if (access_proto_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
@@ -422,17 +422,17 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
 	ret = TRUE;
 
 end:
-	if (l2cap_list)
+	if (l2cap_list != NULL)
 		sdp_list_free(l2cap_list, NULL);
-	if (mcap_list)
+	if (mcap_list != NULL)
 		sdp_list_free(mcap_list, NULL);
-	if (proto_list)
+	if (proto_list != NULL)
 		sdp_list_free(proto_list, NULL);
-	if (access_proto_list)
+	if (access_proto_list != NULL)
 		sdp_list_free(access_proto_list, NULL);
-	if (psm)
+	if (psm != NULL)
 		sdp_data_free(psm);
-	if (mcap_ver)
+	if (mcap_ver != NULL)
 		sdp_data_free(mcap_ver);
 
 	return ret;
@@ -448,7 +448,7 @@ static gboolean register_service_profiles(sdp_record_t *sdp_record)
 	sdp_uuid16_create(&hdp_profile.uuid, HDP_SVCLASS_ID);
 	hdp_profile.version = HDP_VERSION;
 	profile_list = sdp_list_append(NULL, &hdp_profile);
-	if (!profile_list)
+	if (profile_list == NULL)
 		return FALSE;
 
 	/* set profile descriptor list */
@@ -475,24 +475,24 @@ static gboolean register_service_additional_protocols(
 	/* set l2cap information */
 	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
 	l2cap_list = sdp_list_append(NULL, &l2cap_uuid);
-	if (!l2cap_list) {
+	if (l2cap_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
 	psm = sdp_data_alloc(SDP_UINT16, &adapter->dcpsm);
-	if (!psm) {
+	if (psm == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
-	if (!sdp_list_append(l2cap_list, psm)) {
+	if (sdp_list_append(l2cap_list, psm) == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
 	proto_list = sdp_list_append(NULL, l2cap_list);
-	if (!proto_list) {
+	if (proto_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
@@ -500,19 +500,19 @@ static gboolean register_service_additional_protocols(
 	/* set mcap information */
 	sdp_uuid16_create(&mcap_d_uuid, MCAP_DATA_UUID);
 	mcap_list = sdp_list_append(NULL, &mcap_d_uuid);
-	if (!mcap_list) {
+	if (mcap_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
-	if (!sdp_list_append(proto_list, mcap_list)) {
+	if (sdp_list_append(proto_list, mcap_list) == NULL) {
 		ret = FALSE;
 		goto end;
 	}
 
 	/* attach protocol information to service record */
 	access_proto_list = sdp_list_append(NULL, proto_list);
-	if (!access_proto_list) {
+	if (access_proto_list == NULL) {
 		ret = FALSE;
 		goto end;
 	}
@@ -523,15 +523,15 @@ static gboolean register_service_additional_protocols(
 		ret = TRUE;
 
 end:
-	if (l2cap_list)
+	if (l2cap_list != NULL)
 		sdp_list_free(l2cap_list, NULL);
-	if (mcap_list)
+	if (mcap_list != NULL)
 		sdp_list_free(mcap_list, NULL);
-	if (proto_list)
+	if (proto_list  != NULL)
 		sdp_list_free(proto_list, NULL);
-	if (access_proto_list)
+	if (access_proto_list != NULL)
 		sdp_list_free(access_proto_list, NULL);
-	if (psm)
+	if (psm != NULL)
 		sdp_data_free(psm);
 
 	return ret;
@@ -546,49 +546,49 @@ static sdp_list_t *app_to_sdplist(struct hdp_application *app)
 	sdp_list_t *f_list = NULL;
 
 	mdepid = sdp_data_alloc(SDP_UINT8, &app->id);
-	if (!mdepid)
+	if (mdepid == NULL)
 		return NULL;
 
 	dtype = sdp_data_alloc(SDP_UINT16, &app->data_type);
-	if (!dtype)
+	if (dtype == NULL)
 		goto fail;
 
 	role = sdp_data_alloc(SDP_UINT8, &app->role);
-	if (!role)
+	if (role == NULL)
 		goto fail;
 
-	if (app->description) {
+	if (app->description != NULL) {
 		desc = sdp_data_alloc(SDP_TEXT_STR8, app->description);
-		if (!desc)
+		if (desc == NULL)
 			goto fail;
 	}
 
 	f_list = sdp_list_append(NULL, mdepid);
-	if (!f_list)
+	if (f_list == NULL)
 		goto fail;
 
-	if (!sdp_list_append(f_list, dtype))
+	if (sdp_list_append(f_list, dtype) == NULL)
 		goto fail;
 
-	if (!sdp_list_append(f_list, role))
+	if (sdp_list_append(f_list, role) == NULL)
 		goto fail;
 
-	if (desc)
-		if (!sdp_list_append(f_list, desc))
+	if (desc != NULL)
+		if (sdp_list_append(f_list, desc) == NULL)
 			goto fail;
 
 	return f_list;
 
 fail:
-	if (f_list)
+	if (f_list != NULL)
 		sdp_list_free(f_list, NULL);
-	if (mdepid)
+	if (mdepid != NULL)
 		sdp_data_free(mdepid);
-	if (dtype)
+	if (dtype != NULL)
 		sdp_data_free(dtype);
-	if (role)
+	if (role != NULL)
 		sdp_data_free(role);
-	if (desc)
+	if (desc != NULL)
 		sdp_data_free(desc);
 
 	return NULL;
@@ -600,21 +600,21 @@ static gboolean register_features(struct hdp_application *app,
 	sdp_list_t *hdp_feature;
 
 	hdp_feature = app_to_sdplist(app);
-	if (!hdp_feature)
+	if (hdp_feature == NULL)
 		goto fail;
 
-	if (!*sup_features) {
+	if (*sup_features == NULL) {
 		*sup_features = sdp_list_append(NULL, hdp_feature);
-		if (!*sup_features)
+		if (*sup_features == NULL)
 			goto fail;
-	} else if (!sdp_list_append(*sup_features, hdp_feature)) {
+	} else if (sdp_list_append(*sup_features, hdp_feature) == NULL) {
 		goto fail;
 	}
 
 	return TRUE;
 
 fail:
-	if (hdp_feature)
+	if (hdp_feature != NULL)
 		sdp_list_free(hdp_feature, (sdp_free_func_t)sdp_data_free);
 	return FALSE;
 }
@@ -652,7 +652,7 @@ static gboolean register_data_exchange_spec(sdp_record_t *record)
 	/* As by now 11073 is the only supported we set it by default */
 
 	spec = sdp_data_alloc(SDP_UINT8, &data_spec);
-	if (!spec)
+	if (spec == NULL)
 		return FALSE;
 
 	if (sdp_attr_add(record, SDP_ATTR_DATA_EXCHANGE_SPEC, spec) < 0) {
@@ -669,7 +669,7 @@ static gboolean register_mcap_features(sdp_record_t *sdp_record)
 	uint8_t mcap_sup_proc = MCAP_SUP_PROC;
 
 	mcap_proc = sdp_data_alloc(SDP_UINT8, &mcap_sup_proc);
-	if (!mcap_proc)
+	if (mcap_proc == NULL)
 		return FALSE;
 
 	if (sdp_attr_add(sdp_record, SDP_ATTR_MCAP_SUPPORTED_PROCEDURES,
@@ -686,19 +686,19 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 	sdp_record_t *sdp_record;
 	bdaddr_t addr;
 
-	if (adapter->sdp_handler)
+	if (adapter->sdp_handler > 0)
 		remove_record_from_server(adapter->sdp_handler);
 
-	if (!app_list) {
+	if (app_list == NULL) {
 		adapter->sdp_handler = 0;
 		return TRUE;
 	}
 
 	sdp_record = sdp_record_alloc();
-	if (!sdp_record)
+	if (sdp_record == NULL)
 		return FALSE;
 
-	if (adapter->sdp_handler)
+	if (adapter->sdp_handler > 0)
 		sdp_record->handle = adapter->sdp_handler;
 	else
 		sdp_record->handle = 0xffffffff; /* Set automatically */
@@ -724,7 +724,7 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 
 	register_mcap_features(sdp_record);
 
-	if (sdp_set_record_state(sdp_record, adapter->record_state++))
+	if (sdp_set_record_state(sdp_record, adapter->record_state++) < 0)
 		goto fail;
 
 	adapter_get_address(adapter->btd_adapter, &addr);
@@ -735,7 +735,7 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 	return TRUE;
 
 fail:
-	if (sdp_record)
+	if (sdp_record != NULL)
 		sdp_record_free(sdp_record);
 	return FALSE;
 }
@@ -754,7 +754,7 @@ static gboolean get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
 {
 	sdp_data_t *list, *feat;
 
-	if (!desc && !mdep)
+	if (desc == NULL && mdep == NULL)
 		return TRUE;
 
 	list = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
@@ -771,15 +771,15 @@ static gboolean get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
 			continue;
 
 		mdepid = feat->val.dataseq;
-		if (!mdepid)
+		if (mdepid == NULL)
 			continue;
 
 		data_type = mdepid->next;
-		if (!data_type)
+		if (data_type == NULL)
 			continue;
 
 		role_t = data_type->next;
-		if (!role_t)
+		if (role_t == NULL)
 			continue;
 
 		desc_t = role_t->next;
@@ -792,10 +792,11 @@ static gboolean get_mdep_from_rec(const sdp_record_t *rec, uint8_t role,
 					!check_role(role_t->val.uint8, role))
 			continue;
 
-		if (mdep)
+		if (mdep != NULL)
 			*mdep = mdepid->val.uint8;
 
-		if (desc  && desc_t && (desc_t->dtd == SDP_TEXT_STR8 ||
+		if (desc != NULL  && desc_t != NULL  &&
+					(desc_t->dtd == SDP_TEXT_STR8 ||
 					desc_t->dtd == SDP_TEXT_STR16  ||
 					desc_t->dtd == SDP_TEXT_STR32))
 			*desc = g_strdup(desc_t->val.str);
@@ -812,7 +813,7 @@ static void get_mdep_cb(sdp_list_t *recs, int err, gpointer user_data)
 	GError *gerr = NULL;
 	uint8_t mdep;
 
-	if (err || !recs) {
+	if (err < 0 || recs == NULL) {
 		g_set_error(&gerr, HDP_ERROR, HDP_CONNECTION_ERROR,
 					"Error getting remote SDP records");
 		mdep_data->func(0, mdep_data->data, gerr);
@@ -862,7 +863,7 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 
 	bt_string2uuid(&uuid, HDP_UUID);
 	if (bt_search_service(&src, &dst, &uuid, get_mdep_cb, mdep_data,
-							free_mdep_data)) {
+							free_mdep_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
 		g_free(mdep_data);
@@ -877,8 +878,8 @@ static gboolean get_prot_desc_entry(sdp_data_t *entry, int type, guint16 *val)
 	sdp_data_t *iter;
 	int proto;
 
-	if (!entry || (entry->dtd != SDP_SEQ8 && entry->dtd != SDP_SEQ16 &&
-						entry->dtd != SDP_SEQ32))
+	if (entry == NULL || (entry->dtd != SDP_SEQ8 &&
+			entry->dtd != SDP_SEQ16 && entry->dtd != SDP_SEQ32))
 		return FALSE;
 
 	iter = entry->val.dataseq;
@@ -889,7 +890,7 @@ static gboolean get_prot_desc_entry(sdp_data_t *entry, int type, guint16 *val)
 	if (proto != type)
 		return FALSE;
 
-	if (!val)
+	if (val == NULL)
 		return TRUE;
 
 	iter = iter->next;
@@ -906,7 +907,7 @@ static gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
 {
 	sdp_data_t *pdl, *p0, *p1;
 
-	if (!psm && !version)
+	if (psm == NULL && version == NULL)
 		return TRUE;
 
 	pdl = sdp_data_get(rec, SDP_ATTR_PROTO_DESC_LIST);
@@ -930,7 +931,7 @@ static gboolean hdp_get_add_prot_desc_list(const sdp_record_t *rec,
 {
 	sdp_data_t *pdl, *p0, *p1;
 
-	if (!psm)
+	if (psm == NULL)
 		return TRUE;
 
 	pdl = sdp_data_get(rec, SDP_ATTR_ADD_PROTO_DESC_LIST);
@@ -981,7 +982,7 @@ static gboolean get_dcpsm(sdp_list_t *recs, uint16_t *dcpsm)
 
 static void con_mcl_data_unref(struct conn_mcl_data *conn_data)
 {
-	if (!conn_data)
+	if (conn_data == NULL)
 		return;
 
 	if (--conn_data->refs > 0)
@@ -1001,7 +1002,7 @@ static void destroy_con_mcl_data(gpointer data)
 
 static struct conn_mcl_data *con_mcl_data_ref(struct conn_mcl_data *conn_data)
 {
-	if (!conn_data)
+	if (conn_data == NULL)
 		return NULL;
 
 	conn_data->refs++;
@@ -1014,19 +1015,19 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError *err, gpointer data)
 	struct hdp_device *device = conn_data->dev;
 	GError *gerr = NULL;
 
-	if (err) {
+	if (err != NULL) {
 		conn_data->func(conn_data->data, err);
 		return;
 	}
 
-	if (!device->mcl)
+	if (device->mcl == NULL)
 		device->mcl = mcap_mcl_ref(mcl);
 	device->mcl_conn = TRUE;
 
 	hdp_set_mcl_cb(device, &gerr);
 
 	conn_data->func(conn_data->data, gerr);
-	if (gerr)
+	if (gerr != NULL)
 		g_error_free(gerr);
 }
 
@@ -1037,13 +1038,13 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	bdaddr_t dst;
 	uint16_t ccpsm;
 
-	if (!conn_data->dev->hdp_adapter->mi) {
+	if (conn_data->dev->hdp_adapter->mi == NULL) {
 		g_set_error(&gerr, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Mcap instance released");
 		goto fail;
 	}
 
-	if (err || !recs) {
+	if (err < 0 || recs == NULL) {
 		g_set_error(&gerr, HDP_ERROR, HDP_CONNECTION_ERROR,
 					"Error getting remote SDP records");
 		goto fail;
@@ -1092,7 +1093,7 @@ gboolean hdp_establish_mcl(struct hdp_device *device,
 
 	bt_string2uuid(&uuid, HDP_UUID);
 	if (bt_search_service(&src, &dst, &uuid, search_cb, conn_data,
-						destroy_con_mcl_data)) {
+						destroy_con_mcl_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
 		g_free(conn_data);
@@ -1108,7 +1109,7 @@ static void get_dcpsm_cb(sdp_list_t *recs, int err, gpointer data)
 	GError *gerr = NULL;
 	uint16_t dcpsm;
 
-	if (err || !recs) {
+	if (err < 0 || recs == NULL) {
 		g_set_error(&gerr, HDP_ERROR, HDP_CONNECTION_ERROR,
 					"Error getting remote SDP records");
 		goto fail;
@@ -1132,7 +1133,7 @@ static void free_dcpsm_data(gpointer data)
 {
 	struct get_dcpsm_data *dcpsm_data = data;
 
-	if (!dcpsm_data)
+	if (dcpsm_data == NULL)
 		return;
 
 	if (dcpsm_data->destroy)
@@ -1160,7 +1161,7 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 
 	bt_string2uuid(&uuid, HDP_UUID);
 	if (bt_search_service(&src, &dst, &uuid, get_dcpsm_cb, dcpsm_data,
-							free_dcpsm_data)) {
+							free_dcpsm_data) < 0) {
 		g_set_error(err, HDP_ERROR, HDP_CONNECTION_ERROR,
 						"Can't get remote SDP record");
 		g_free(dcpsm_data);
@@ -1172,10 +1173,10 @@ gboolean hdp_get_dcpsm(struct hdp_device *device, hdp_continue_dcpsm_f func,
 
 static void hdp_free_application(struct hdp_application *app)
 {
-	if (app->dbus_watcher)
+	if (app->dbus_watcher > 0)
 		g_dbus_remove_watch(app->conn, app->dbus_watcher);
 
-	if (app->conn)
+	if (app->conn != NULL)
 		dbus_connection_unref(app->conn);
 	g_free(app->oname);
 	g_free(app->description);
@@ -1185,7 +1186,7 @@ static void hdp_free_application(struct hdp_application *app)
 
 struct hdp_application *hdp_application_ref(struct hdp_application *app)
 {
-	if (!app)
+	if (app == NULL)
 		return NULL;
 
 	app->ref++;
@@ -1196,10 +1197,10 @@ struct hdp_application *hdp_application_ref(struct hdp_application *app)
 
 void hdp_application_unref(struct hdp_application *app)
 {
-	if (!app)
+	if (app == NULL)
 		return;
 
-	app->ref --;
+	app->ref--;
 
 	DBG("health_application_unref(%p): ref=%d", app, app->ref);
 	if (app->ref > 0)
-- 
1.7.7.4

