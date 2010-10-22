Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/1] Fix small coding style issues
Date: Fri, 22 Oct 2010 17:18:42 -0200
Message-Id: <1287775122-12536-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Based on http://lxr.linux.no/linux+v2.6.36/Documentation/CodingStyle#L171
---
 health/hdp_util.c |   24 +++++++++++++-----------
 health/mcap_lib.h |    8 ++++----
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/health/hdp_util.c b/health/hdp_util.c
index b0399f8..fefb6d3 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -181,8 +181,9 @@ static gboolean parse_role(DBusMessageIter *iter, gpointer data, GError **err)
 		dbus_message_iter_recurse(iter, &value);
 		ctype = dbus_message_iter_get_arg_type(&value);
 		string = &value;
-	} else
+	} else {
 		string = iter;
+	}
 
 	if (ctype != DBUS_TYPE_STRING) {
 		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
@@ -191,11 +192,11 @@ static gboolean parse_role(DBusMessageIter *iter, gpointer data, GError **err)
 	}
 
 	dbus_message_iter_get_basic(string, &role);
-	if (g_ascii_strcasecmp(role, HDP_SINK_ROLE_AS_STRING) == 0)
+	if (g_ascii_strcasecmp(role, HDP_SINK_ROLE_AS_STRING) == 0) {
 		app->role = HDP_SINK;
-	else if (g_ascii_strcasecmp(role, HDP_SOURCE_ROLE_AS_STRING) == 0)
+	} else if (g_ascii_strcasecmp(role, HDP_SOURCE_ROLE_AS_STRING) == 0) {
 		app->role = HDP_SOURCE;
-	else {
+	} else {
 		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
 			"Role value should be \"source\" or \"sink\"");
 		return FALSE;
@@ -221,8 +222,9 @@ static gboolean parse_desc(DBusMessageIter *iter, gpointer data, GError **err)
 		dbus_message_iter_recurse(iter, &variant);
 		ctype = dbus_message_iter_get_arg_type(&variant);
 		string = &variant;
-	} else
+	} else {
 		string = iter;
+	}
 
 	if (ctype != DBUS_TYPE_STRING) {
 		g_set_error(err, HDP_ERROR, HDP_DIC_ENTRY_PARSE_ERROR,
@@ -395,12 +397,12 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
 		goto end;
 	}
 
-	if (!sdp_list_append( mcap_list, mcap_ver)) {
+	if (!sdp_list_append(mcap_list, mcap_ver)) {
 		ret = FALSE;
 		goto end;
 	}
 
-	if (!sdp_list_append( proto_list, mcap_list)) {
+	if (!sdp_list_append(proto_list, mcap_list)) {
 		ret = FALSE;
 		goto end;
 	}
@@ -442,7 +444,7 @@ static gboolean register_service_profiles(sdp_record_t *sdp_record)
 	sdp_profile_desc_t hdp_profile;
 
 	/* set hdp information */
-	sdp_uuid16_create( &hdp_profile.uuid, HDP_SVCLASS_ID);
+	sdp_uuid16_create(&hdp_profile.uuid, HDP_SVCLASS_ID);
 	hdp_profile.version = HDP_VERSION;
 	profile_list = sdp_list_append(NULL, &hdp_profile);
 	if (!profile_list)
@@ -459,7 +461,7 @@ static gboolean register_service_profiles(sdp_record_t *sdp_record)
 	return ret;
 }
 
-static gboolean register_service_aditional_protocols(
+static gboolean register_service_additional_protocols(
 						struct hdp_adapter *adapter,
 						sdp_record_t *sdp_record)
 {
@@ -502,7 +504,7 @@ static gboolean register_service_aditional_protocols(
 		goto end;
 	}
 
-	if (!sdp_list_append( proto_list, mcap_list)) {
+	if (!sdp_list_append(proto_list, mcap_list)) {
 		ret = FALSE;
 		goto end;
 	}
@@ -709,7 +711,7 @@ gboolean hdp_update_sdp_record(struct hdp_adapter *adapter, GSList *app_list)
 		goto fail;
 	if (!register_service_profiles(sdp_record))
 		goto fail;
-	if (!register_service_aditional_protocols(adapter, sdp_record))
+	if (!register_service_additional_protocols(adapter, sdp_record))
 		goto fail;
 
 	sdp_set_info_attr(sdp_record, HDP_SERVICE_NAME, HDP_SERVICE_PROVIDER,
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index daee1f8..7740623 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -69,7 +69,7 @@ struct sync_info_ind_data;
 
 /************ Callbacks ************/
 
-/* mdl callbacks */
+/* MDL callbacks */
 
 typedef void (* mcap_mdl_event_cb) (struct mcap_mdl *mdl, gpointer data);
 typedef void (* mcap_mdl_operation_conf_cb) (struct mcap_mdl *mdl, uint8_t conf,
@@ -85,7 +85,7 @@ typedef uint8_t (* mcap_remote_mdl_conn_req_cb) (struct mcap_mcl *mcl,
 typedef uint8_t (* mcap_remote_mdl_reconn_req_cb) (struct mcap_mdl *mdl,
 						gpointer data);
 
-/* mcl callbacks */
+/* MCL callbacks */
 
 typedef void (* mcap_mcl_event_cb) (struct mcap_mcl *mcl, gpointer data);
 typedef void (* mcap_mcl_connect_cb) (struct mcap_mcl *mcl, GError *err,
@@ -115,7 +115,7 @@ typedef void (* mcap_sync_set_cb) (struct mcap_mcl *mcl,
 
 /************ Operations ************/
 
-/* Mdl operations*/
+/* MDL operations */
 
 gboolean mcap_create_mdl(struct mcap_mcl *mcl,
 				uint8_t mdepid,
@@ -155,7 +155,7 @@ gboolean mcap_mdl_abort(struct mcap_mdl *mdl,
 int mcap_mdl_get_fd(struct mcap_mdl *mdl);
 uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl);
 
-/* Mcl operations*/
+/* MCL operations */
 
 gboolean mcap_create_mcl(struct mcap_instance *ms,
 				const bdaddr_t *addr,
-- 
1.7.0.4

