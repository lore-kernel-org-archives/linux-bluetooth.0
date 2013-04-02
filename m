Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 16/18] attrib: Avoid passing raw PDU to gatt_discover_char_desc() callback
Date: Tue,  2 Apr 2013 12:51:03 -0400
Message-Id: <1364921465-31182-17-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By centralizing the PDU parsing and validation internally to GATT API,
the callbacks become simpler.
---
 attrib/gatt.c                        |   94 +++++++++++++++++++++++++++++++++-
 attrib/gatt.h                        |    7 ++-
 attrib/gatttool.c                    |   36 ++++---------
 attrib/interactive.c                 |   44 +++++-----------
 profiles/cyclingspeed/cyclingspeed.c |   43 ++++++----------
 profiles/gatt/gas.c                  |   35 +++++--------
 profiles/heartrate/heartrate.c       |   39 +++++---------
 profiles/input/hog.c                 |   79 ++++++++++------------------
 profiles/scanparam/scan.c            |   47 ++++++++---------
 profiles/thermometer/thermometer.c   |   58 +++++++++------------
 10 files changed, 239 insertions(+), 243 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index d68b26c..aeea2ca 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -948,9 +948,92 @@ guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
 									g_free);
 }
 
+struct discover_char_desc_data {
+	GAttrib *attrib;
+	uint16_t end;
+	gatt_cb_t func;
+	gpointer user_data;
+};
+
+static void gatt_discover_char_desc_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	struct discover_char_desc_data *data = user_data;
+	struct att_data_list *list;
+	GSList *char_descs = NULL;
+	uint16_t last_handle = 0xffff;
+	bool continue_discovery;
+	uint8_t format;
+	unsigned int i;
+
+	if (status != 0)
+		goto done;
+
+	list = dec_find_info_resp(pdu, plen, &format);
+	if (list == NULL) {
+		status = ATT_ECODE_IO;
+		goto done;
+	}
+
+	for (i = 0; i < list->num; i++) {
+		uint8_t *value = list->data[i];
+		struct gatt_char_desc *desc;
+
+		desc = g_new0(struct gatt_char_desc, 1);
+		desc->handle = att_get_u16(value);
+		last_handle = desc->handle;
+
+		if (format == ATT_FIND_INFO_RESP_FMT_16BIT)
+			desc->uuid = att_get_uuid16(&value[2]);
+		else
+			desc->uuid = att_get_uuid128(&value[2]);
+
+		char_descs = g_slist_append(char_descs, desc);
+	}
+
+	att_data_list_free(list);
+
+	/* From the Core spec: "It is permitted to end the sub-procedure early
+	 * if a desired Characteristic Descriptor is found prior to discovering
+	 * all the characteristic descriptors of the specified characteristic."
+	 *
+	 * In other words, this callback will receive the partial list of
+	 * discovered descriptors, and if it returns false, the procedure is
+	 * interrupted.
+	 */
+	continue_discovery = data->func(char_descs, status, data->user_data);
+	g_slist_free_full(char_descs, g_free);
+
+	if (!continue_discovery)
+		goto data_free;
+
+	if (last_handle != 0xffff && last_handle < data->end) {
+		uint8_t *buf;
+		size_t buflen;
+		uint16_t plen;
+
+		buf = g_attrib_get_buffer(data->attrib, &buflen);
+		plen = enc_find_info_req(last_handle + 1, data->end, buf,
+									buflen);
+		g_attrib_send(data->attrib, 0, buf, plen,
+					gatt_discover_char_desc_cb, data, NULL);
+
+		return;
+	} else
+		/* Procedure has finished */
+		status = ATT_ECODE_ATTR_NOT_FOUND;
+
+done:
+	data->func(NULL, status, data->user_data);
+data_free:
+	g_attrib_unref(data->attrib);
+	g_free(data);
+}
+
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data)
+					gatt_cb_t func, gpointer user_data)
 {
+	struct discover_char_desc_data *data;
 	uint8_t *buf;
 	size_t buflen;
 	guint16 plen;
@@ -960,7 +1043,14 @@ guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
+	data = g_new0(struct discover_char_desc_data, 1);
+	data->attrib = g_attrib_ref(attrib);
+	data->end = end;
+	data->func = func;
+	data->user_data = user_data;
+
+	return g_attrib_send(attrib, 0, buf, plen, gatt_discover_char_desc_cb,
+								data, NULL);
 }
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 097d30d..97b38c6 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -79,6 +79,11 @@ struct gatt_char {
 	uint16_t value_handle;
 };
 
+struct gatt_char_desc {
+	uint16_t handle;
+	bt_uuid_t uuid;
+};
+
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
@@ -97,7 +102,7 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 					void *user_data);
 
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
-				GAttribResultFunc func, gpointer user_data);
+					gatt_cb_t func, gpointer user_data);
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 				GDestroyNotify notify, gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 433a494..9049886 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -408,12 +408,12 @@ error:
 	return FALSE;
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static bool char_desc_cb(GSList *descs, guint8 status, gpointer user_data)
 {
-	struct att_data_list *list;
-	guint8 format;
-	int i;
+	GSList *l;
+
+	if (status == ATT_ECODE_ATTR_NOT_FOUND)
+		goto done;
 
 	if (status != 0) {
 		g_printerr("Discover all characteristic descriptors failed: "
@@ -421,33 +421,19 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto done;
 	}
 
-	list = dec_find_info_resp(pdu, plen, &format);
-	if (list == NULL)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
 		char uuidstr[MAX_LEN_UUID_STR];
-		uint16_t handle;
-		uint8_t *value;
-		bt_uuid_t uuid;
-
-		value = list->data[i];
-		handle = att_get_u16(value);
-
-		if (format == 0x01)
-			uuid = att_get_uuid16(&value[2]);
-		else
-			uuid = att_get_uuid128(&value[2]);
 
-		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		g_print("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
+		bt_uuid_to_string(&desc->uuid, uuidstr, sizeof(uuidstr));
+		g_print("handle = 0x%04x, uuid = %s\n", desc->handle, uuidstr);
 	}
 
-	att_data_list_free(list);
-
 done:
 	if (!opt_listen)
 		g_main_loop_quit(event_loop);
+
+	return true;
 }
 
 static gboolean characteristics_desc(gpointer user_data)
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 02c8167..f194e33 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -275,49 +275,31 @@ static bool char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 	return true;
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static bool char_desc_cb(GSList *descs, guint8 status, gpointer user_data)
 {
-	struct att_data_list *list;
-	guint8 format;
-	uint16_t handle = 0xffff;
-	int i;
+	GSList *l;
+
+	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
+		rl_forced_update_display();
+		return true;
+	}
 
 	if (status != 0) {
 		printf("Discover descriptors finished: %s\n",
 						att_ecode2str(status));
-		return;
+		return true;
 	}
 
-	list = dec_find_info_resp(pdu, plen, &format);
-	if (list == NULL)
-		return;
-
 	printf("\n");
-	for (i = 0; i < list->num; i++) {
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
 		char uuidstr[MAX_LEN_UUID_STR];
-		uint8_t *value;
-		bt_uuid_t uuid;
-
-		value = list->data[i];
-		handle = att_get_u16(value);
-
-		if (format == 0x01)
-			uuid = att_get_uuid16(&value[2]);
-		else
-			uuid = att_get_uuid128(&value[2]);
 
-		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		printf("handle: 0x%04x, uuid: %s\n", handle, uuidstr);
+		bt_uuid_to_string(&desc->uuid, uuidstr, sizeof(uuidstr));
+		printf("handle: 0x%04x, uuid: %s\n", desc->handle, uuidstr);
 	}
 
-	att_data_list_free(list);
-
-	if (handle != 0xffff && handle < end)
-		gatt_discover_char_desc(attrib, handle + 1, end, char_desc_cb,
-									NULL);
-	else
-		rl_forced_update_display();
+	return true;
 }
 
 static void char_read_cb(uint8_t status, const uint8_t *value, size_t vlen,
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index a845a1b..b24e3ab 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -399,42 +399,32 @@ static void read_location_cb(uint8_t status, const uint8_t *value, size_t vlen,
 					CYCLINGSPEED_INTERFACE, "Location");
 }
 
-static void discover_desc_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static bool discover_desc_cb(GSList *descs, guint8 status, gpointer user_data)
 {
 	struct characteristic *ch = user_data;
-	struct att_data_list *list = NULL;
-	uint8_t format;
-	int i;
+	GSList *l;
 
 	if (status != 0) {
-		error("Discover %s descriptors failed: %s", ch->uuid,
+		if (status != ATT_ECODE_ATTR_NOT_FOUND)
+			error("Discover %s descriptors failed: %s", ch->uuid,
 							att_ecode2str(status));
-		goto done;
-	}
-
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		goto done;
 
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
+		g_free(ch);
+		return true;
+	}
 
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value;
-		uint16_t handle, uuid;
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
 		uint8_t attr_val[2];
+		bt_uuid_t uuid;
 		char *msg;
 
-		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid = att_get_u16(value + 2);
-
-		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
+		bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+		if (bt_uuid_cmp(&desc->uuid, &uuid) != 0)
 			continue;
 
 		if (g_strcmp0(ch->uuid, CSC_MEASUREMENT_UUID) == 0) {
-			ch->csc->measurement_ccc_handle = handle;
+			ch->csc->measurement_ccc_handle = desc->handle;
 
 			if (g_slist_length(ch->csc->cadapter->watchers) == 0) {
 				att_put_u16(0x0000, attr_val);
@@ -452,17 +442,14 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 			break;
 		}
 
-		gatt_write_char(ch->csc->attrib, handle, attr_val,
+		gatt_write_char(ch->csc->attrib, desc->handle, attr_val,
 					sizeof(attr_val), char_write_cb, msg);
 
 		/* We only want CCC, can break here */
 		break;
 	}
 
-done:
-	if (list)
-		att_data_list_free(list);
-	g_free(ch);
+	return true;
 }
 
 static void discover_desc(struct csc *csc, struct gatt_char *c,
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 7b23a87..6313ea3 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -225,40 +225,31 @@ static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
 								user_data);
 }
 
-static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
+static bool gatt_descriptors_cb(GSList *descs, guint8 status,
 							gpointer user_data)
 {
 	struct gas *gas = user_data;
-	struct att_data_list *list;
-	int i;
-	uint8_t format;
+	GSList *l;
+
+	if (status == ATT_ECODE_ATTR_NOT_FOUND)
+		return true;
 
 	if (status) {
 		error("Discover all GATT characteristic descriptors: %s",
 							att_ecode2str(status));
-		return;
+		return true;
 	}
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		return;
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
+		char uuidstr[MAX_LEN_UUID_STR];
 
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint16_t uuid16, ccc;
-		uint8_t *value;
-
-		value = list->data[i];
-		ccc = att_get_u16(value);
-		uuid16 = att_get_u16(&value[2]);
-		DBG("CCC: 0x%04x UUID: 0x%04x", ccc, uuid16);
-		write_ccc(gas->attrib, ccc, user_data);
+		bt_uuid_to_string(&desc->uuid, uuidstr, sizeof(uuidstr));
+		DBG("CCC: 0x%04x UUID: %s", desc->handle, uuidstr);
+		write_ccc(gas->attrib, desc->handle, user_data);
 	}
 
-done:
-	att_data_list_free(list);
+	return true;
 }
 
 static bool gatt_characteristic_cb(GSList *characteristics, guint8 status,
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index e4b06ed..ab27d9b 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -380,41 +380,31 @@ static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	process_measurement(hr, pdu + 3, len - 3);
 }
 
-static void discover_ccc_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static bool discover_ccc_cb(GSList *descs, guint8 status, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
-	struct att_data_list *list;
-	uint8_t format;
-	int i;
+	GSList *l;
+
+	if (status == ATT_ECODE_ATTR_NOT_FOUND)
+		return true;
 
 	if (status != 0) {
 		error("Discover Heart Rate Measurement descriptors failed: %s",
 							att_ecode2str(status));
-		return;
+		return true;
 	}
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		return;
-
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value;
-		uint16_t handle, uuid;
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
 		char *msg;
 		uint8_t attr_val[2];
+		bt_uuid_t uuid;
 
-		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid = att_get_u16(value + 2);
-
-		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
+		bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+		if (bt_uuid_cmp(&desc->uuid, &uuid) != 0)
 			continue;
 
-		hr->measurement_ccc_handle = handle;
+		hr->measurement_ccc_handle = desc->handle;
 
 		if (g_slist_length(hr->hradapter->watchers) == 0) {
 			att_put_u16(0x0000, attr_val);
@@ -424,14 +414,13 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 			msg = g_strdup("Enable measurement");
 		}
 
-		gatt_write_char(hr->attrib, handle, attr_val,
+		gatt_write_char(hr->attrib, desc->handle, attr_val,
 					sizeof(attr_val), char_write_cb, msg);
 
 		break;
 	}
 
-done:
-	att_data_list_free(list);
+	return true;
 }
 
 static void discover_measurement_ccc(struct heartrate *hr,
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 33c3aed..e04d4be 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -194,75 +194,52 @@ static void report_reference_cb(uint8_t status, const uint8_t *value,
 static void external_report_reference_cb(uint8_t status, const uint8_t *value,
 						size_t vlen, void *user_data);
 
-
-static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static bool discover_descriptor_cb(GSList *descs, guint8 status,
+							gpointer user_data)
 {
 	struct disc_desc_cb_data *ddcb_data = user_data;
-	struct report *report;
-	struct hog_device *hogdev;
-	struct att_data_list *list = NULL;
-	GAttrib *attrib = NULL;
-	uint8_t format;
-	uint16_t handle = 0xffff;
-	uint16_t end = ddcb_data->end;
-	int i;
-
-	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
-		DBG("Discover all characteristic descriptors finished");
-		goto done;
-	}
+	GSList *l;
 
 	if (status != 0) {
-		error("Discover all characteristic descriptors failed: %s",
+		if (status != ATT_ECODE_ATTR_NOT_FOUND)
+			error("Characteristic descriptor discovery failed: %s",
 							att_ecode2str(status));
-		goto done;
-	}
-
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		return;
 
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint16_t uuid16;
-		uint8_t *value;
+		g_free(ddcb_data);
+		return true;
+	}
 
-		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid16 = att_get_u16(&value[2]);
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
+		struct report *report;
+		struct hog_device *hogdev;
+		GAttrib *attrib;
+		bt_uuid_t uuid;
 
-		switch (uuid16) {
-		case GATT_CLIENT_CHARAC_CFG_UUID:
+		bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+		if (bt_uuid_cmp(&desc->uuid, &uuid) == 0) {
 			report = ddcb_data->data;
-			attrib = report->hogdev->attrib;
-			write_ccc(handle, report);
-			break;
-		case GATT_REPORT_REFERENCE:
+			write_ccc(desc->handle, report);
+		}
+
+		bt_uuid16_create(&uuid, GATT_REPORT_REFERENCE);
+		if (bt_uuid_cmp(&desc->uuid, &uuid) == 0) {
 			report = ddcb_data->data;
 			attrib = report->hogdev->attrib;
-			gatt_read_char(attrib, handle,
+			gatt_read_char(attrib, desc->handle,
 						report_reference_cb, report);
-			break;
-		case GATT_EXTERNAL_REPORT_REFERENCE:
+		}
+
+		bt_uuid16_create(&uuid, GATT_EXTERNAL_REPORT_REFERENCE);
+		if (bt_uuid_cmp(&desc->uuid, &uuid) == 0) {
 			hogdev = ddcb_data->data;
 			attrib = hogdev->attrib;
-			gatt_read_char(attrib, handle,
+			gatt_read_char(attrib, desc->handle,
 					external_report_reference_cb, hogdev);
-			break;
 		}
 	}
 
-done:
-	att_data_list_free(list);
-
-	if (handle != 0xffff && handle < end)
-		gatt_discover_char_desc(attrib, handle + 1, end,
-					discover_descriptor_cb, ddcb_data);
-	else
-		g_free(ddcb_data);
+	return true;
 }
 
 static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 8412d67..b21e92b 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -111,35 +111,36 @@ static void ccc_written_cb(uint8_t status, void *user_data)
 				refresh_value_cb, scan, NULL);
 }
 
-static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static bool discover_descriptor_cb(GSList *descs, guint8 status,
+							gpointer user_data)
 {
 	struct scan *scan = user_data;
-	struct att_data_list *list;
-	uint8_t *ptr;
-	uint16_t uuid16, handle;
-	uint8_t value[2];
-	uint8_t format;
-
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		return;
+	GSList *l;
+
+	if (status == ATT_ECODE_ATTR_NOT_FOUND)
+		return true;
+
+	if (status != 0) {
+		error("Discover all GATT characteristic descriptors failed: %s",
+							att_ecode2str(status));
+		return true;
+	}
 
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
+		uint8_t value[2];
+		bt_uuid_t uuid;
 
-	ptr = list->data[0];
-	handle = att_get_u16(ptr);
-	uuid16 = att_get_u16(&ptr[2]);
+		bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+		if (bt_uuid_cmp(&desc->uuid, &uuid) != 0)
+			continue;
 
-	if (uuid16 != GATT_CLIENT_CHARAC_CFG_UUID)
-		goto done;
+		att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+		gatt_write_char(scan->attrib, desc->handle, value,
+				sizeof(value), ccc_written_cb, user_data);
+	}
 
-	att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-	gatt_write_char(scan->attrib, handle, value, sizeof(value),
-						ccc_written_cb, user_data);
-done:
-	att_data_list_free(list);
+	return true;
 }
 
 static bool refresh_discovered_cb(GSList *chars, guint8 status,
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index f506c69..ae89600 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -514,25 +514,28 @@ static void write_ccc_cb(uint8_t status, void *user_data)
 	g_free(msg);
 }
 
-static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
-								uint16_t handle)
+static void process_thermometer_desc(struct characteristic *ch,
+						struct gatt_char_desc *desc)
 {
 	uint8_t atval[2];
+	bt_uuid_t uuid;
 	uint16_t val;
 	char *msg;
 
-	if (uuid == GATT_CHARAC_VALID_RANGE_UUID) {
+	bt_uuid16_create(&uuid, GATT_CHARAC_VALID_RANGE_UUID);
+	if (bt_uuid_cmp(&desc->uuid, &uuid) == 0) {
 		if (g_strcmp0(ch->uuid, MEASUREMENT_INTERVAL_UUID) == 0)
-			gatt_read_char(ch->t->attrib, handle,
+			gatt_read_char(ch->t->attrib, desc->handle,
 						valid_range_desc_cb, ch->t);
 		return;
 	}
 
-	if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	if (bt_uuid_cmp(&desc->uuid, &uuid) != 0)
 		return;
 
 	if (g_strcmp0(ch->uuid, TEMPERATURE_MEASUREMENT_UUID) == 0) {
-		ch->t->measurement_ccc_handle = handle;
+		ch->t->measurement_ccc_handle = desc->handle;
 
 		if (g_slist_length(ch->t->tadapter->fwatchers) == 0) {
 			val = 0x0000;
@@ -542,7 +545,7 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 			msg = g_strdup("Enable Temperature Measurement ind");
 		}
 	} else if (g_strcmp0(ch->uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
-		ch->t->intermediate_ccc_handle = handle;
+		ch->t->intermediate_ccc_handle = desc->handle;
 
 		if (g_slist_length(ch->t->tadapter->iwatchers) == 0) {
 			val = 0x0000;
@@ -559,46 +562,31 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 	}
 
 	att_put_u16(val, atval);
-	gatt_write_char(ch->t->attrib, handle, atval, sizeof(atval),
+	gatt_write_char(ch->t->attrib, desc->handle, atval, sizeof(atval),
 							write_ccc_cb, msg);
 }
 
-static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static bool discover_desc_cb(GSList *descs, guint8 status, gpointer user_data)
 {
 	struct characteristic *ch = user_data;
-	struct att_data_list *list = NULL;
-	uint8_t format;
-	int i;
+	GSList *l;
 
 	if (status != 0) {
-		error("Discover all characteristic descriptors failed [%s]: %s",
-					ch->uuid, att_ecode2str(status));
-		goto done;
-	}
-
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		goto done;
-
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
+		if (status != ATT_ECODE_ATTR_NOT_FOUND)
+			error("Discover %s descriptors failed: %s", ch->uuid,
+							att_ecode2str(status));
 
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value;
-		uint16_t handle, uuid;
+		g_free(ch);
+		return true;
+	}
 
-		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid = att_get_u16(value + 2);
+	for (l = descs; l != NULL; l = g_slist_next(l)) {
+		struct gatt_char_desc *desc = l->data;
 
-		process_thermometer_desc(ch, uuid, handle);
+		process_thermometer_desc(ch, desc);
 	}
 
-done:
-	if (list != NULL)
-		att_data_list_free(list);
-	g_free(ch);
+	return true;
 }
 
 static void discover_desc(struct thermometer *t, struct gatt_char *c,
-- 
1.7.9.5

