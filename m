Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 18/18] gatt: Avoid passing raw PDU to read characteristic by UUID
Date: Tue,  2 Apr 2013 12:51:05 -0400
Message-Id: <1364921465-31182-19-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

By centralizing the PDU parsing and validation internally to GATT API,
the callbacks become simpler.
---
 attrib/gatt.c        |   57 +++++++++++++++++++++++++++++++++++++++++++++++---
 attrib/gatt.h        |   10 +++++++--
 attrib/gatttool.c    |   27 +++++++++---------------
 attrib/interactive.c |   29 ++++++++++---------------
 profiles/gatt/gas.c  |   22 +++++++------------
 5 files changed, 90 insertions(+), 55 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index aeea2ca..8ff54d8 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -587,10 +587,56 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 								dc, NULL);
 }
 
+struct read_char_by_uuid {
+	gatt_cb_t func;
+	void *user_data;
+};
+
+static void gatt_att_free(gpointer data)
+{
+	struct gatt_att *gatt_att = data;
+
+	g_free(gatt_att->value);
+	g_free(gatt_att);
+}
+
+static void read_char_by_uuid_cb(uint8_t status, const uint8_t *pdu,
+						uint16_t plen, void *user_data)
+{
+	struct read_char_by_uuid *rd = user_data;
+	struct att_data_list *att_list = NULL;
+	GSList *gatt_list = NULL;
+	int i;
+
+	if (status != 0)
+		goto done;
+
+	att_list = dec_read_by_type_resp(pdu, plen);
+	if (att_list == NULL) {
+		status = ATT_ECODE_IO;
+		goto done;
+	}
+
+	for (i = 0; i < att_list->num; i++) {
+		uint8_t *data = att_list->data[i];
+		struct gatt_att *gatt_att = g_new0(struct gatt_att, 1);
+		gatt_att->handle = att_get_u16(&data[0]);
+		gatt_att->size = att_list->len - 2;
+		gatt_att->value = g_memdup(&data[2], gatt_att->size);
+		gatt_list = g_slist_prepend(gatt_list, gatt_att);
+	}
+
+done:
+	att_data_list_free(att_list);
+	rd->func(gatt_list, status, rd->user_data);
+	g_slist_free_full(gatt_list, gatt_att_free);
+}
+
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-					bt_uuid_t *uuid, GAttribResultFunc func,
-					gpointer user_data)
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
 {
+	struct read_char_by_uuid *data;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	guint16 plen;
@@ -599,7 +645,12 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
+	data = g_new0(struct read_char_by_uuid, 1);
+	data->func = func;
+	data->user_data = user_data;
+
+	return g_attrib_send(attrib, 0, buf, plen, read_char_by_uuid_cb, data,
+									g_free);
 }
 
 struct read_long_data {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 97b38c6..d7f6880 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -84,6 +84,12 @@ struct gatt_char_desc {
 	bt_uuid_t uuid;
 };
 
+struct gatt_att {
+	uint16_t handle;
+	uint8_t *value;
+	size_t size;
+};
+
 guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 							gpointer user_data);
 
@@ -108,8 +114,8 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 				GDestroyNotify notify, gpointer user_data);
 
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-				bt_uuid_t *uuid, GAttribResultFunc func,
-				gpointer user_data);
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data);
 
 guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
 				gatt_exchange_mtu_cb_t func, void *user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 2013a15..860a98c 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -252,11 +252,10 @@ done:
 		g_main_loop_quit(event_loop);
 }
 
-static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static bool char_read_by_uuid_cb(GSList *values, uint8_t status,
+								void *user_data)
 {
-	struct att_data_list *list;
-	int i;
+	GSList *l;
 
 	if (status != 0) {
 		g_printerr("Read characteristics by UUID failed: %s\n",
@@ -264,25 +263,19 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		goto done;
 	}
 
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value = list->data[i];
-		int j;
+	for (l = values; l; l = g_slist_next(l)) {
+		size_t i;
+		struct gatt_att *att_data = l->data;
 
-		g_print("handle: 0x%04x \t value: ", att_get_u16(value));
-		value += 2;
-		for (j = 0; j < list->len - 2; j++, value++)
-			g_print("%02x ", *value);
+		printf("\nhandle: 0x%04x \t value: ", att_data->handle);
+		for (i = 0; i < att_data->size; i++)
+			g_print("%02x ", att_data->value[i]);
 		g_print("\n");
 	}
 
-	att_data_list_free(list);
-
 done:
 	g_main_loop_quit(event_loop);
+	return true;
 }
 
 static gboolean characteristics_read(gpointer user_data)
diff --git a/attrib/interactive.c b/attrib/interactive.c
index e297bd7..f030b5d 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -314,36 +314,29 @@ static void char_read_cb(uint8_t status, const uint8_t *value, size_t vlen,
 	rl_forced_update_display();
 }
 
-static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static bool char_read_by_uuid_cb(GSList *values, uint8_t status,
+								void *user_data)
 {
-	struct att_data_list *list;
-	int i;
+	GSList *l;
 
 	if (status != 0) {
 		printf("Read characteristics by UUID failed: %s\n",
 							att_ecode2str(status));
-		return;
+		return true;
 	}
 
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
-		return;
-
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value = list->data[i];
-		int j;
+	for (l = values; l; l = g_slist_next(l)) {
+		size_t i;
+		struct gatt_att *att_data = l->data;
 
-		printf("\nhandle: 0x%04x \t value: ", att_get_u16(value));
-		value += 2;
-		for (j = 0; j < list->len - 2; j++, value++)
-			printf("%02x ", *value);
+		printf("\nhandle: 0x%04x \t value: ", att_data->handle);
+		for (i = 0; i < att_data->size; i++)
+			printf("%02x ", att_data->value[i]);
 		printf("\n");
 	}
 
-	att_data_list_free(list);
-
 	rl_forced_update_display();
+	return true;
 }
 
 static void cmd_exit(int argcp, char **argvp)
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 6313ea3..e89c745 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -132,38 +132,30 @@ static int read_ctp_handle(struct btd_device *device, uint16_t uuid,
 	return err;
 }
 
-static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static bool gap_appearance_cb(GSList *values, uint8_t status, void *user_data)
 {
 	struct gas *gas = user_data;
-	struct att_data_list *list =  NULL;
+	struct gatt_att *gatt_att = values->data;
 	uint16_t app;
-	uint8_t *atval;
 
 	if (status != 0) {
 		error("Read characteristics by UUID failed: %s",
 				att_ecode2str(status));
-		return;
+		return false;
 	}
 
-	list = dec_read_by_type_resp(pdu, plen);
-	if (list == NULL)
-		return;
-
-	if (list->len != 4) {
+	if (gatt_att->size != 2) {
 		error("GAP Appearance value: invalid data");
-		goto done;
+		return false;
 	}
 
-	atval = list->data[0] + 2; /* skip handle value */
-	app = att_get_u16(atval);
+	app = att_get_u16(gatt_att->value);
 
 	DBG("GAP Appearance: 0x%04x", app);
 
 	device_set_appearance(gas->device, app);
 
-done:
-	att_data_list_free(list);
+	return false;
 }
 
 static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
-- 
1.7.9.5

