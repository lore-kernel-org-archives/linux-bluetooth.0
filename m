Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Client Characteristic Configuration on attribute server
Date: Wed,  6 Oct 2010 17:39:54 -0300
Message-Id: <1286397594-12366-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1286397594-12366-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1286397594-12366-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial implementation of per client attribute configuration for the
attribute server. Notification and indication shall be sent to the peer
only if Client Characteristic Configuration bit field is set.
---
 TODO                |    7 --
 src/attrib-server.c |  194 +++++++++++++++++++++++++++++++++++---------------
 src/storage.c       |   44 ++++++++++++
 src/storage.h       |    4 +
 4 files changed, 184 insertions(+), 65 deletions(-)

diff --git a/TODO b/TODO
index 2cd141b..6722af7 100644
--- a/TODO
+++ b/TODO
@@ -18,13 +18,6 @@ Background
 ATT/GATT
 ========
 
-- Sample server shouldn't send any indications or notifications without
-  the client requesting them
-
-  Priority: Medium
-  Complexity: C2
-  Owner: Claudio Takahasi <claudio.takahasi@openbossa.org>
-
 - gatttool should have the ability to wait for req responses before
   quitting (some servers require a small sleep even with cmd's). Maybe a
   --delay-exit or --timeout command line switch.
diff --git a/src/attrib-server.c b/src/attrib-server.c
index b45f300..a95dbda 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -37,6 +37,7 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "log.h"
+#include "storage.h"
 #include "glib-helper.h"
 #include "btio.h"
 #include "sdpd.h"
@@ -48,14 +49,25 @@
 #define GATT_PSM 0x1f
 #define GATT_CID 4
 
+/* Client Characteristic Configuration bit field */
+#define CONFIG_NOTIFICATION	0x0001
+#define CONFIG_INDICATION	0x0002
+
 static GSList *database = NULL;
 
+struct client_char_config {
+	uint16_t chr_handle;
+	uint16_t cfg_handle;
+	uint16_t value;
+};
+
 struct gatt_channel {
 	bdaddr_t src;
 	bdaddr_t dst;
 	GAttrib *attrib;
 	guint mtu;
 	guint id;
+	GSList *config;
 };
 
 struct group_elem {
@@ -137,6 +149,81 @@ static sdp_record_t *server_record_new(void)
 	return record;
 }
 
+static gint config_chr_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct client_char_config *config = a;
+	uint16_t handle = GPOINTER_TO_UINT(b);
+
+	return config->chr_handle - handle;
+}
+
+static gint config_cfg_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct client_char_config *config = a;
+	uint16_t handle = GPOINTER_TO_UINT(b);
+
+	return config->cfg_handle - handle;
+}
+
+static void channel_free(struct gatt_channel *channel)
+{
+	g_attrib_unref(channel->attrib);
+	g_slist_foreach(channel->config, (GFunc) g_free, NULL);
+	g_slist_free(channel->config);
+	g_free(channel);
+}
+
+static GSList *read_client_config(const bdaddr_t *src, const bdaddr_t *dst)
+{
+	struct client_char_config *config;
+	struct attribute *a1, *a2;
+	GSList *l, *ltmp, *lconfig;
+	uuid_t chr_uuid, cfg_uuid;
+	uint16_t chr_handle;
+
+	sdp_uuid16_create(&chr_uuid, GATT_CHARAC_UUID);
+	sdp_uuid16_create(&cfg_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	for (l = database, ltmp = NULL; l; l = l->next) {
+		a1 = l->data;
+
+		if (sdp_uuid_cmp(&a1->uuid, &chr_uuid) != 0 &&
+				sdp_uuid_cmp(&a1->uuid, &cfg_uuid) != 0)
+			continue;
+
+		/* Temporary list of characteristic declaration and config  */
+		ltmp = g_slist_append(ltmp, l->data);
+	}
+
+	for (l = ltmp, lconfig = NULL; l;) {
+		a1 = l->data;
+
+		l = l->next;
+		if (l == NULL)
+			break;
+
+		a2 = l->data;
+		if (sdp_uuid_cmp(&a2->uuid, &cfg_uuid) != 0)
+			continue;
+
+		/* Skip the first byte: attribute permission */
+		chr_handle = att_get_u16(&a1->data[1]);
+
+		config = g_malloc0(sizeof(*config));
+		config->chr_handle = chr_handle;
+		config->cfg_handle = a2->handle;
+
+		read_device_config(src, dst, config->cfg_handle,
+							&config->value);
+
+		lconfig = g_slist_append(lconfig, config);
+		l = l->next;
+	}
+
+	g_slist_free(ltmp);
+
+	return lconfig;
+}
+
 static uint16_t read_by_group(uint16_t start, uint16_t end, uuid_t *uuid,
 							uint8_t *pdu, int len)
 {
@@ -414,12 +501,14 @@ static uint16_t read_value(uint16_t handle, uint8_t *pdu, int len)
 	return enc_read_resp(a->data, a->len, pdu, len);
 }
 
-static void write_value(uint16_t handle, const uint8_t *value, int vlen)
+static void write_value(struct gatt_channel *channel, uint16_t handle,
+						const uint8_t *value, int vlen)
 {
+	struct client_char_config *config;
 	struct attribute *a;
 	GSList *l;
 	guint h = handle;
-	uuid_t uuid;
+	uuid_t uuid, cfg_uuid;
 
 	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
@@ -427,7 +516,30 @@ static void write_value(uint16_t handle, const uint8_t *value, int vlen)
 
 	a = l->data;
 	memcpy(&uuid, &a->uuid, sizeof(uuid_t));
-	attrib_db_update(handle, &uuid, value, vlen);
+
+	sdp_uuid16_create(&cfg_uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	if (sdp_uuid_cmp(&cfg_uuid, &uuid) != 0) {
+		attrib_db_update(handle, &uuid, value, vlen);
+		return;
+	}
+
+	if (vlen != 2) {
+		/* FIXME: Needs to handle error */
+		error("Client Characteristic Configuration: wrong length");
+		return;
+	}
+
+	/* Per client attribute: Client Characteristic Config */
+	l = g_slist_find_custom(channel->config, GUINT_TO_POINTER(h),
+							config_cfg_cmp);
+	if (!l)
+		return;
+
+	config = l->data;
+	config->value = att_get_u16(value);
+
+	write_device_config(&channel->src, &channel->dst, handle,
+							config->value);
 }
 
 static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
@@ -442,10 +554,9 @@ static void channel_disconnect(void *user_data)
 {
 	struct gatt_channel *channel = user_data;
 
-	g_attrib_unref(channel->attrib);
 	clients = g_slist_remove(clients, channel);
 
-	g_free(channel);
+	channel_free(channel);
 }
 
 static void channel_handler(const uint8_t *ipdu, uint16_t len,
@@ -507,7 +618,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 	case ATT_OP_WRITE_CMD:
 		length = dec_write_cmd(ipdu, len, &start, value, &vlen);
 		if (length > 0)
-			write_value(start, value, vlen);
+			write_value(channel, start, value, vlen);
 		return;
 	case ATT_OP_FIND_BY_TYPE_REQ:
 	case ATT_OP_READ_BLOB_REQ:
@@ -557,6 +668,7 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
 
 	channel->attrib = g_attrib_new(io);
 	channel->mtu = ATT_DEFAULT_MTU;
+	channel->config = read_client_config(&channel->src, &channel->dst);
 
 	channel->id = g_attrib_register(channel->attrib, GATTRIB_ALL_EVENTS,
 				channel_handler, channel, NULL);
@@ -580,52 +692,34 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
-static gboolean send_notification(gpointer user_data)
+static void report_attrib_changes(gpointer data, gpointer user_data)
 {
-	uint8_t pdu[ATT_MAX_MTU];
-	guint handle = GPOINTER_TO_UINT(user_data);
-	struct attribute *a;
+	struct gatt_channel *channel = data;
+	struct attribute *a = user_data;
+	struct client_char_config *config;
 	GSList *l;
+	uint8_t pdu[ATT_MAX_MTU];
 	uint16_t length;
+	guint h = a->handle;
 
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(handle), handle_cmp);
+	l = g_slist_find_custom(channel->config, GUINT_TO_POINTER(h),
+							config_chr_cmp);
 	if (!l)
-		return FALSE;
-
-	a = l->data;
+		return;
 
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
+	config = l->data;
 
+	if (config->value & CONFIG_NOTIFICATION) {
 		length = enc_notification(a, pdu, channel->mtu);
-		g_attrib_send(channel->attrib, pdu[0], pdu, length, NULL, NULL, NULL);
+		g_attrib_send(channel->attrib, pdu[0], pdu, length, NULL,
+								NULL, NULL);
 	}
 
-	return FALSE;
-}
-
-static gboolean send_indication(gpointer user_data)
-{
-	uint8_t pdu[ATT_MAX_MTU];
-	guint handle = GPOINTER_TO_UINT(user_data);
-	struct attribute *a;
-	GSList *l;
-	uint16_t length;
-
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(handle), handle_cmp);
-	if (!l)
-		return FALSE;
-
-	a = l->data;
-
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
-
+	if (config->value & CONFIG_INDICATION) {
 		length = enc_indication(a, pdu, channel->mtu);
-		g_attrib_send(channel->attrib, pdu[0], pdu, length, NULL, NULL, NULL);
+		g_attrib_send(channel->attrib, pdu[0], pdu, length, NULL,
+								NULL, NULL);
 	}
-
-	return FALSE;
 }
 
 int attrib_server_init(void)
@@ -680,8 +774,6 @@ int attrib_server_init(void)
 
 void attrib_server_exit(void)
 {
-	GSList *l;
-
 	g_slist_foreach(database, (GFunc) g_free, NULL);
 	g_slist_free(database);
 
@@ -695,13 +787,7 @@ void attrib_server_exit(void)
 		g_io_channel_shutdown(le_io, FALSE, NULL);
 	}
 
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
-
-		g_attrib_unref(channel->attrib);
-		g_free(channel);
-	}
-
+	g_slist_foreach(clients, (GFunc) channel_free, NULL);
 	g_slist_free(clients);
 
 	if (sdp_handle)
@@ -746,15 +832,7 @@ int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 	a->len = len;
 	memcpy(a->data, value, len);
 
-	/*
-	 * Characteristic configuration descriptor is not being used yet.
-	 * If the attribute changes, all connected clients will be notified.
-	 * For testing purposes, we send a Notification and a Indication for
-	 * each update.
-	 */
-	g_idle_add(send_notification, GUINT_TO_POINTER(h));
-
-	g_idle_add(send_indication, GUINT_TO_POINTER(h));
+	g_slist_foreach(clients, report_attrib_changes, a);
 
 	return 0;
 }
diff --git a/src/storage.c b/src/storage.c
index 06b36f1..b3fee08 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1391,3 +1391,47 @@ int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data)
 
 	return textfile_foreach(filename, func, data);
 }
+
+int write_device_config(const bdaddr_t *sba, const bdaddr_t *dba,
+					uint16_t handle, uint16_t value)
+{
+	char filename[PATH_MAX + 1], addr[18], key[23], str[5];
+
+	create_filename(filename, PATH_MAX, sba, "clientconfig");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(dba, addr);
+
+	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+	snprintf(str, sizeof(str), "%04X", value);
+
+	return textfile_put(filename, key, str);
+}
+
+int read_device_config(const bdaddr_t *sba, const bdaddr_t *dba,
+					uint16_t handle, uint16_t *value)
+{
+	char filename[PATH_MAX + 1], addr[18], key[23];
+	char *str;
+	long int val;
+
+	create_filename(filename, PATH_MAX, sba, "clientconfig");
+
+	ba2str(dba, addr);
+
+	snprintf(key, sizeof(key), "%17s#%04X", addr, handle);
+
+	str = textfile_caseget(filename, key);
+	if (str == NULL)
+		return -ENOENT;
+
+	val = strtol(str, NULL, 16);
+
+	if (value)
+		*value = val;
+
+	g_free(str);
+
+	return 0;
+}
diff --git a/src/storage.h b/src/storage.h
index c7e342c..22333b2 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -91,6 +91,10 @@ char *read_device_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 int write_device_attribute(const bdaddr_t *sba, const bdaddr_t *dba,
                                         uint16_t handle, const char *chars);
 int read_device_attributes(const bdaddr_t *sba, textfile_cb func, void *data);
+int write_device_config(const bdaddr_t *sba, const bdaddr_t *dba,
+                                        uint16_t handle, uint16_t value);
+int read_device_config(const bdaddr_t *sba, const bdaddr_t *dba,
+					uint16_t handle, uint16_t *value);
 
 #define PNP_UUID		"00001200-0000-1000-8000-00805f9b34fb"
 
-- 
1.7.3.1

