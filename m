Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 03/32] Add functions to resiger health instances in SDP
Date: Fri,  4 Jun 2010 10:29:56 +0200
Message-Id: <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |    5 +-
 health/hdp_util.c |  393 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 health/hdp_util.h |    1 +
 3 files changed, 398 insertions(+), 1 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 2dec069..454483d 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -101,7 +101,10 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 
 	/* TODO: Create mcap instance */
 
-	/* TODO: Create SDP record if needed. */
+	if (!hdp_register_sdp_record(hdpi)) {
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+					"Session can't be registered");
+	}
 
 	return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".HealthError",
diff --git a/health/hdp_util.c b/health/hdp_util.c
index a215d5a..cc5dc2e 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -24,8 +24,14 @@
  */
 
 #include <gdbus.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 #include "log.h"
+#include "sdpd.h"
+
 #include "hdp_types.h"
+#include "hdp_util.h"
+#include "mcap.h"
 
 typedef gboolean (*parse_item_f)(DBusMessageIter *iter, GError **err,
 							gpointer user_data);
@@ -445,3 +451,390 @@ error:
 		free_config(config);
 	return NULL;
 }
+
+static gboolean is_session_role(struct hdp_instance *hdps, HdpRole role)
+{
+	GSList *l;
+	struct hdp_supp_fts *fts;
+
+	if (!hdps->config)
+		return FALSE;
+	for (l = hdps->config->supp_fts; l; l = l->next) {
+		fts = l->data;
+		if (fts->role == role)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gboolean register_service_protocols(struct hdp_instance *hdps,
+						sdp_record_t *sdp_record)
+{
+	gboolean error = FALSE;
+	uuid_t l2cap_uuid, mcap_c_uuid;
+	sdp_list_t *l2cap_list = NULL,
+	           *proto_list = NULL,
+		   *mcap_list = NULL,
+		   *access_proto_list = NULL;
+	sdp_data_t *psm = NULL,
+		   *mcap_ver = NULL;
+	uint16_t version = MCAP_VERSION;
+
+	// set l2cap information
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	l2cap_list = sdp_list_append(NULL, &l2cap_uuid);
+	if (!l2cap_list) {
+		error = TRUE;
+		goto end;
+	}
+	psm = sdp_data_alloc(SDP_UINT16, &hdps->ccpsm);
+	if (!psm) {
+		error = TRUE;
+		goto end;
+	}
+	if (!sdp_list_append(l2cap_list, psm)) {
+		error = TRUE;
+		goto end;
+	}
+	proto_list = sdp_list_append(NULL, l2cap_list);
+	if (!proto_list) {
+		error = TRUE;
+		goto end;
+	}
+
+	// set mcap information
+	sdp_uuid16_create(&mcap_c_uuid, MCAP_CTRL_UUID);
+	mcap_list = sdp_list_append(NULL, &mcap_c_uuid);
+	if (!mcap_list) {
+		error = TRUE;
+		goto end;
+	}
+	mcap_ver = sdp_data_alloc(SDP_UINT16, &version);
+	if (!mcap_ver) {
+		error = TRUE;
+		goto end;
+	}
+	if (!sdp_list_append( mcap_list, mcap_ver)) {
+		error = TRUE;
+		goto end;
+	}
+	if (!sdp_list_append( proto_list, mcap_list)) {
+		error = TRUE;
+		goto end;
+	}
+
+	// attach protocol information to service record
+	access_proto_list = sdp_list_append(NULL, proto_list);
+	if (!access_proto_list) {
+		error = TRUE;
+		goto end;
+	}
+	if (sdp_set_access_protos(sdp_record, access_proto_list) < 0)
+		error = TRUE;
+end:
+	if (l2cap_list)
+		sdp_list_free(l2cap_list, NULL);
+	if (mcap_list)
+		sdp_list_free(mcap_list, NULL);
+	if (proto_list)
+		sdp_list_free(proto_list, NULL);
+	if (access_proto_list)
+		sdp_list_free(access_proto_list, NULL);
+	if (psm)
+		sdp_data_free(psm);
+	if (mcap_ver)
+		sdp_data_free(mcap_ver);
+	return !error;
+}
+
+static gboolean register_service_profiles(sdp_record_t *sdp_record)
+{
+	gboolean error = FALSE;
+	sdp_list_t *profile_list = NULL;
+	sdp_profile_desc_t hdp_profile;
+
+	// set hdp information
+	sdp_uuid16_create( &hdp_profile.uuid, MDP_SVCLASS_ID);
+	hdp_profile.version = HDP_VERSION;
+	profile_list = sdp_list_append(NULL, &hdp_profile);
+	if (!profile_list)
+		return FALSE;
+	// set profile descriptor list
+	if (sdp_set_profile_descs(sdp_record, profile_list) < 0)
+		error = TRUE;
+
+	sdp_list_free(profile_list, NULL);
+	return !error;
+}
+
+static gboolean register_service_aditional_protocols(struct hdp_instance *hdps,
+						sdp_record_t *sdp_record)
+{
+	gboolean error = FALSE;
+	uuid_t l2cap_uuid, mcap_d_uuid;
+	sdp_list_t *l2cap_list = NULL,
+		   *proto_list = NULL,
+		   *mcap_list = NULL,
+		   *access_proto_list = NULL;
+	sdp_data_t *psm = NULL;
+
+	// set l2cap information
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	l2cap_list = sdp_list_append(NULL, &l2cap_uuid);
+	if (!l2cap_list) {
+		error = TRUE;
+		goto end;
+	}
+	psm = sdp_data_alloc(SDP_UINT16, &hdps->dcpsm);
+	if (!psm) {
+		error = TRUE;
+		goto end;
+	}
+	if (!sdp_list_append(l2cap_list, psm)) {
+		error = TRUE;
+		goto end;
+	}
+	proto_list = sdp_list_append(NULL, l2cap_list);
+	if (!proto_list) {
+		error = TRUE;
+		goto end;
+	}
+
+	// set mcap information
+	sdp_uuid16_create(&mcap_d_uuid, MCAP_DATA_UUID);
+	mcap_list = sdp_list_append(NULL, &mcap_d_uuid);
+	if (!mcap_list) {
+		error = TRUE;
+		goto end;
+	}
+	if (!sdp_list_append( proto_list, mcap_list)) {
+		error = TRUE;
+		goto end;
+	}
+
+	// attach protocol information to service record
+	access_proto_list = sdp_list_append(NULL, proto_list);
+	if (!access_proto_list) {
+		error = TRUE;
+		goto end;
+	}
+	if (sdp_set_add_access_protos(sdp_record, access_proto_list) < 0)
+		error = TRUE;
+end:
+	if (l2cap_list)
+		sdp_list_free(l2cap_list, NULL);
+	if (mcap_list)
+		sdp_list_free(mcap_list, NULL);
+	if (proto_list)
+		sdp_list_free(proto_list, NULL);
+	if (access_proto_list)
+		sdp_list_free(access_proto_list, NULL);
+	if (psm)
+		sdp_data_free(psm);
+	return !error;
+}
+
+static sdp_list_t *feature_to_sdplist(struct hdp_supp_fts *fts,
+							struct hdp_feature *f)
+{
+	sdp_data_t *mdepid,
+		   *dtype = NULL,
+		   *role = NULL,
+		   *desc = NULL;
+	sdp_list_t *f_list = NULL;
+
+	mdepid = sdp_data_alloc(SDP_UINT8, &fts->mdepid);
+	if (!mdepid)
+		return NULL;
+	dtype = sdp_data_alloc(SDP_UINT16, &f->dtype);
+	if (!dtype)
+		goto error;
+	role = sdp_data_alloc(SDP_UINT8, &fts->role);
+	if (!role)
+		goto error;
+	if (f->dscr) {
+		desc = sdp_data_alloc(SDP_TEXT_STR8, f->dscr);
+		if (!desc)
+			goto error;
+	}
+	f_list = sdp_list_append(NULL, mdepid);
+	if (!f_list)
+		goto error;
+	if (!sdp_list_append(f_list, dtype))
+		goto error;
+	if (!sdp_list_append(f_list, role))
+		goto error;
+	if (desc)
+		if (!sdp_list_append(f_list, desc))
+			goto error;
+	return f_list;
+error:
+	if (f_list)
+		sdp_list_free(f_list, NULL);
+	if (mdepid)
+		sdp_data_free(mdepid);
+	if (dtype)
+		sdp_data_free(dtype);
+	if (role)
+		sdp_data_free(role);
+	if (desc)
+		sdp_data_free(desc);
+	return NULL;
+}
+
+static gboolean register_features(struct hdp_supp_fts *fts,
+						sdp_list_t **sup_features)
+{
+	GSList *l;
+	sdp_list_t *hdp_feature = NULL;
+
+	for (l = fts->features; l; l = l->next){
+		hdp_feature = feature_to_sdplist(fts, l->data);
+		if (!hdp_feature)
+			goto error;
+
+		if (!*sup_features) {
+			*sup_features = sdp_list_append(NULL, hdp_feature);
+			if (!*sup_features)
+				goto error;
+		} else if (!sdp_list_append(*sup_features, hdp_feature))
+				goto error;
+		hdp_feature = NULL;
+	}
+	return TRUE;
+error:
+	if (hdp_feature)
+		sdp_list_free(hdp_feature, (sdp_free_func_t)sdp_data_free);
+	return FALSE;
+}
+
+static void free_hdp_list(void *list)
+{
+	sdp_list_t *hdp_list = list;
+
+	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
+}
+
+static gboolean register_service_sup_features(struct hdp_config *config,
+						sdp_record_t *sdp_record)
+{
+	GSList *l;
+	sdp_list_t *sup_features = NULL;
+	for (l = config->supp_fts; l; l = l->next) {
+		if (!register_features(l->data, &sup_features))
+			return FALSE;
+	}
+	if (sdp_set_supp_feat(sdp_record, sup_features) < 0) {
+		sdp_list_free(sup_features, free_hdp_list);
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static gboolean register_data_exchange_spec(struct hdp_config *config,
+							sdp_record_t *record)
+{
+	sdp_data_t *spec;
+
+	spec = sdp_data_alloc(SDP_UINT8, &config->data_spec);
+	if (!spec)
+		return FALSE;
+	if (sdp_attr_add(record, SDP_ATTR_DATA_EXCHANGE_SPEC, spec) < 0) {
+		sdp_data_free(spec);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean register_mcap_features(sdp_record_t *sdp_record)
+{
+	sdp_data_t *mcap_proc;
+	uint8_t mcap_sup_proc = MCAP_SUP_PROC;
+
+	mcap_proc = sdp_data_alloc(SDP_UINT8, &mcap_sup_proc);
+	if (!mcap_proc)
+		return FALSE;
+	if (sdp_attr_add(sdp_record, SDP_ATTR_MCAP_SUPPORTED_PROCEDURES,
+							mcap_proc) < 0) {
+		sdp_data_free(mcap_proc);
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static gboolean set_sdp_services_uuid(sdp_record_t *record, HdpRole role)
+{
+	uuid_t svc_uuid_source, svc_uuid_sink;
+	sdp_list_t *svc_list = NULL;
+
+	sdp_uuid16_create(&svc_uuid_sink, MDP_SINK_SVCLASS_ID);
+	sdp_uuid16_create(&svc_uuid_source, MDP_SOURCE_SVCLASS_ID);
+
+	sdp_get_service_classes(record, &svc_list);
+
+	if (role == HDP_SOURCE) {
+		if (sdp_list_find(svc_list, &svc_uuid_source, sdp_uuid_cmp) == NULL)
+			svc_list = sdp_list_append(svc_list, &svc_uuid_source);
+	}
+	else if (role == HDP_SINK) {
+		if (sdp_list_find(svc_list, &svc_uuid_sink, sdp_uuid_cmp) == NULL)
+			svc_list = sdp_list_append(svc_list, &svc_uuid_sink);
+	}
+
+	if (sdp_set_service_classes(record, svc_list) < 0) {
+		sdp_list_free(svc_list, NULL);
+		return FALSE;
+	}
+
+	sdp_list_free(svc_list, NULL);
+	return TRUE;
+}
+
+gboolean hdp_register_sdp_record(struct hdp_instance *hdps)
+{
+	sdp_record_t *sdp_record;
+	struct hdp_config *config;
+	bdaddr_t addr;
+
+	if (!hdps->config) /* Record is not needed */
+		return TRUE;
+	config = hdps->config;
+
+	sdp_record = sdp_record_alloc();
+	if (!sdp_record)
+		return FALSE;
+	sdp_record->handle = 0xffffffff; /* Set automatically */
+
+	if (is_session_role(hdps, HDP_SINK))
+		set_sdp_services_uuid(sdp_record, HDP_SINK);
+	if (is_session_role(hdps, HDP_SOURCE))
+		set_sdp_services_uuid(sdp_record, HDP_SOURCE);
+
+	if (!register_service_protocols(hdps, sdp_record))
+		goto error;
+	if (!register_service_profiles(sdp_record))
+		goto error;
+	if (!register_service_aditional_protocols(hdps, sdp_record))
+		goto error;
+	sdp_set_info_attr(sdp_record, config->svc_name, config->svc_prov,
+							config->svc_dsc);
+	if (!register_service_sup_features(config, sdp_record))
+		goto error;
+	if (!register_data_exchange_spec(config, sdp_record))
+		goto error;
+
+	register_mcap_features(sdp_record);
+
+	adapter_get_address(hdps->adapter->btd_adapter, &addr);
+
+	if (add_record_to_server(&addr, sdp_record) < 0)
+		goto error;
+	hdps->sdp_handler = sdp_record->handle;
+	return TRUE;
+error:
+	if (sdp_record)
+		sdp_record_free(sdp_record);
+	return FALSE;
+}
diff --git a/health/hdp_util.h b/health/hdp_util.h
index f09e9a6..fb114c7 100644
--- a/health/hdp_util.h
+++ b/health/hdp_util.h
@@ -30,5 +30,6 @@
 #include "hdp_types.h"
 
 struct hdp_config *hdp_get_config(DBusMessageIter *iter, GError **err);
+gboolean hdp_register_sdp_record(struct hdp_instance *hdps);
 
 #endif /* __HDP_UTIL_H__ */
-- 
1.6.3.3

