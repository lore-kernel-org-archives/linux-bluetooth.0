Return-Path: <cyrus@holtmann.org>
Subject: obex-data-server BlueZ 4.x patch
From: Bastien Nocera <hadess@hadess.net>
To: Tadas Dailyda <tadas@dailyda.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-4k/ix4mr2e44ZmHT7UAR"
Date: Mon, 15 Sep 2008 15:56:52 +0100
Message-Id: <1221490612.24928.307.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-4k/ix4mr2e44ZmHT7UAR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Here's a patch to port obex-data-server to BlueZ 4.x. It drops support
for BIP devices though, as I have no example XML SDP record, or ways to
test.

The XML record parsing code is very naive, and could easily be made
stronger.

The latest version is also available at:
http://cvs.fedoraproject.org/viewvc/rpms/obex-data-server/devel/obex-data-server-0.4-bluez4.patch?view=markup

Comments?

Cheers

--=-4k/ix4mr2e44ZmHT7UAR
Content-Disposition: attachment; filename=obex-data-server-0.4-bluez4.patch
Content-Type: text/x-patch; name=obex-data-server-0.4-bluez4.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: src/ods-bluez.c
===================================================================
--- src/ods-bluez.c	(revision 1891)
+++ src/ods-bluez.c	(working copy)
@@ -116,11 +116,11 @@
 
 	bluez->priv->manager_proxy = dbus_g_proxy_new_for_name (klass->connection,
 															"org.bluez",
-															"/org/bluez",
+															"/",
 															"org.bluez.Manager");
 	if (!dbus_g_proxy_call (bluez->priv->manager_proxy, "DefaultAdapter", &error,
 								G_TYPE_INVALID,
-								G_TYPE_STRING, &adapter_object,
+								DBUS_TYPE_G_OBJECT_PATH, &adapter_object,
 								G_TYPE_INVALID)) {
 		g_warning("Unable to connect to dbus: %s", error->message);
 		g_clear_error (&error);
@@ -326,7 +326,7 @@
     g_clear_error (&error);
 }
 
-
+#if 0
 static void
 get_remote_service_record_cb (DBusGProxy *proxy, DBusGProxyCall *call,
 								OdsBluezCancellable *cb_data)
@@ -349,7 +349,7 @@
 		goto err;
 	}
 
-	sdp_record = sdp_extract_pdu ((uint8_t *)record_array->data, &scanned);
+	sdp_record = sdp_extract_pdu ((uint8_t *)record_array->data, record_array->len, &scanned);
 
 	/* get channel for this service */
 	if (sdp_get_access_protos (sdp_record, &protos) != 0) {
@@ -406,59 +406,135 @@
 	ods_bluez_cancellable_free (cb_data);
 	g_clear_error (&error);
 }
+#endif
 
+typedef struct {
+	int channel;
+	gboolean in_attr;
+	gboolean done;
+} ctxdata;
+
 static void
+record_parse_start_tag (GMarkupParseContext *context,
+			const gchar         *element_name,
+			const gchar        **attribute_names,
+			const gchar        **attribute_values,
+			gpointer             user_data,
+			GError             **error)
+{
+	ctxdata *data = (ctxdata *) user_data;
+
+	if (data->done
+	    || attribute_names == NULL
+	    || attribute_values == NULL)
+	    	return;
+	if (g_str_equal (element_name, "attribute")
+	    && g_str_equal (*attribute_names, "id")
+	    && g_str_equal (*attribute_values, "0x0004")) {
+	    	data->in_attr = TRUE;
+	    	return;
+	}
+	if (!data->in_attr)
+		return;
+	if (g_str_equal (element_name, "uint8")
+	    && g_str_equal (*attribute_names, "value")) {
+	    	double channel;
+	    	channel = g_ascii_strtod (*attribute_values, NULL);
+	    	data->channel = channel;
+	    	data->done = TRUE;
+	}
+}
+
+static gboolean
+parse_record (const char *record, int *ret_channel)
+{
+	GError *error = NULL;
+	GMarkupParseContext *ctx;
+	GMarkupParser parser = {
+		record_parse_start_tag, NULL, NULL, NULL, NULL
+	};
+	ctxdata *data;
+
+	data = g_new0 (ctxdata, 1);
+	data->channel = -1;
+
+	ctx = g_markup_parse_context_new (&parser, 0, data, NULL);
+
+	if (!g_markup_parse_context_parse (ctx, record, strlen (record), &error)) {
+		g_warning ("Couldn't parse service record: %s", error->message);
+		g_error_free (error);
+		g_markup_parse_context_free (ctx);
+		return FALSE;
+	}
+
+	if (data->channel != -1)
+		*ret_channel = data->channel;
+	return (data->channel != -1);
+}
+
+static void
 get_remote_service_handles_cb (DBusGProxy *proxy, DBusGProxyCall *call,
 								OdsBluezCancellable *cb_data)
 {
 	OdsBluezFunc	cb = cb_data->cb;
 	gboolean		ret;
 	GError			*error = NULL;
-	GArray			*handle_array = NULL;
-	guint32			service_handle = 0;
+	GHashTable		*handle_hash = NULL;
+	GList			*list, *l;
+	int			channel;
 
 	ret = dbus_g_proxy_end_call (proxy, call, &error,
-								DBUS_TYPE_G_UINT_ARRAY, &handle_array,
-								G_TYPE_INVALID);
+				     dbus_g_type_get_map ("GHashTable", G_TYPE_UINT, G_TYPE_STRING),
+				     &handle_hash, G_TYPE_INVALID);
 
 	/* check if we were looking for Nokia specific FTP service and failed */
-	if (ret && handle_array->len == 0 && !strcmp (cb_data->uuid, OBEX_NOKIAFTP_UUID)) {
+	if (ret && g_hash_table_size (handle_hash) == 0 && !strcmp (cb_data->uuid, OBEX_NOKIAFTP_UUID)) {
 		g_free (cb_data->uuid);
 		cb_data->uuid = g_strdup (OBEX_FTP_UUID);
 		cb_data->dbus_call = dbus_g_proxy_begin_call (proxy,
-								"GetRemoteServiceHandles",
+								"DiscoverServices",
 								(DBusGProxyCallNotify) get_remote_service_handles_cb,
 								cb_data, NULL,
-								G_TYPE_STRING, cb_data->target_address,
 								G_TYPE_STRING, cb_data->uuid,
 								G_TYPE_INVALID);
 		return;
 	}
 	/* service search failed */
-	if (!ret || handle_array->len == 0) {
+	if (!ret || g_hash_table_size (handle_hash) == 0) {
 		g_clear_error (&error);
 		g_set_error (&error, ODS_ERROR, ODS_ERROR_CONNECTION_ATTEMPT_FAILED,
 						"Service search failed");
 		cb (-1, cb_data->imagingdata, error, cb_data->cb_data);
-		ods_bluez_cancellable_free (cb_data);
 		g_clear_error (&error);
 		goto out;
 	}
 
-	memcpy(&service_handle, handle_array->data, sizeof(service_handle));
+	channel = -1;
+	list = g_hash_table_get_values (handle_hash);
+	for (l = list; l != NULL; l = l->next) {
+		char *record = l->data;
+		if (parse_record (record, &channel) != FALSE) {
+			break;
+		}
+	}
+	g_list_free (list);
 
-	/* Now get service record */
-	cb_data->dbus_call = dbus_g_proxy_begin_call (proxy,
-							"GetRemoteServiceRecord",
-							(DBusGProxyCallNotify) get_remote_service_record_cb,
-							cb_data, NULL,
-							G_TYPE_STRING, cb_data->target_address,
-							G_TYPE_UINT, service_handle,
-							G_TYPE_INVALID);
+	if (channel != -1) {
+		rfcomm_connect (cb_data, channel);
+		g_object_unref (proxy);
+		g_hash_table_destroy (handle_hash);
+		return;
+	} else {
+		g_set_error (&error, ODS_ERROR, ODS_ERROR_FAILED,
+			     "Could not get service channel");
+		cb (-1, cb_data->imagingdata, error, cb_data->cb_data);
+		g_clear_error (&error);
+	}
 
 out:
-	if (handle_array != NULL)
-		g_array_free (handle_array, TRUE);
+	ods_bluez_cancellable_free (cb_data);
+	g_object_unref (proxy);
+	g_hash_table_destroy (handle_hash);
 }
 
 OdsBluezCancellable*
@@ -472,6 +548,7 @@
 								gpointer data)
 {
 	OdsBluezCancellable *cb_data;
+	OdsBluezClass *klass = ODS_BLUEZ_GET_CLASS (bluez);
 
 	cb_data = g_new0 (OdsBluezCancellable, 1);
 	cb_data->cb = func;
@@ -496,12 +573,27 @@
 
 	/* Discover channel for needed service only if we don't know it yet */
 	if (channel == 0) {
+		char *device_path;
+		DBusGProxy *device;
+
+		if (dbus_g_proxy_call (bluez->priv->adapter_proxy, "FindDevice", NULL,
+				   G_TYPE_STRING, cb_data->target_address, G_TYPE_INVALID,
+				   DBUS_TYPE_G_OBJECT_PATH, &device_path, G_TYPE_INVALID) == FALSE) {
+			GError *error = NULL;
+			g_set_error (&error, ODS_ERROR, ODS_ERROR_CONNECTION_ATTEMPT_FAILED,
+				     "Device not available");
+			func (-1, cb_data->imagingdata, error, cb_data->cb_data);
+			ods_bluez_cancellable_free (cb_data);
+			g_clear_error (&error);
+			return NULL;
+		}
+		device = dbus_g_proxy_new_for_name (klass->connection, "org.bluez", device_path, "org.bluez.Device");
+
 		/* find services that match our UUID */
-		cb_data->dbus_call = dbus_g_proxy_begin_call (bluez->priv->adapter_proxy,
-								"GetRemoteServiceHandles",
+		cb_data->dbus_call = dbus_g_proxy_begin_call (device,
+								"DiscoverServices",
 								(DBusGProxyCallNotify) get_remote_service_handles_cb,
 								cb_data, NULL,
-								G_TYPE_STRING, cb_data->target_address,
 								G_TYPE_STRING, cb_data->uuid,
 								G_TYPE_INVALID);
 	} else {

--=-4k/ix4mr2e44ZmHT7UAR--

