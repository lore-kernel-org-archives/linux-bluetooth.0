Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/2] Simplify the handling of attribute callbacks
Date: Wed, 20 Jul 2011 15:57:57 -0300
Message-Id: <1311188278-7747-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

If we add a way for a attribute to store its own callbacks we can
simplify the handling of custom callbacks.
---
 attrib/att.h           |    4 +-
 plugins/gatt-example.c |    3 +-
 src/adapter.c          |    3 +-
 src/attrib-server.c    |  205 ++++++++++++++++++++++++++++--------------------
 src/attrib-server.h    |   16 ++++
 5 files changed, 142 insertions(+), 89 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 3b8c098..bf47117 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -126,9 +126,7 @@ struct attribute {
 	bt_uuid_t uuid;
 	int read_reqs;
 	int write_reqs;
-	uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
-	uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
-	gpointer cb_user_data;
+	GSList *callbacks;
 	int len;
 	uint8_t data[0];
 };
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f86e76d..64e1362 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -32,8 +32,9 @@
 #include "plugin.h"
 #include "hcid.h"
 #include "log.h"
-#include "attrib-server.h"
 #include "att.h"
+#include "gattrib.h"
+#include "attrib-server.h"
 
 /* FIXME: Not defined by SIG? UUID128? */
 #define OPCODES_SUPPORTED_UUID          0xA001
diff --git a/src/adapter.c b/src/adapter.c
index df06d1d..b9996bc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -56,8 +56,9 @@
 #include "glib-helper.h"
 #include "agent.h"
 #include "storage.h"
-#include "attrib-server.h"
 #include "att.h"
+#include "gattrib.h"
+#include "attrib-server.h"
 #include "eir.h"
 
 /* Flags Descriptions */
diff --git a/src/attrib-server.c b/src/attrib-server.c
index c02d575..85cb4e8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -53,8 +53,6 @@ struct gatt_channel {
 	bdaddr_t src;
 	bdaddr_t dst;
 	GSList *configs;
-	GSList *notify;
-	GSList *indicate;
 	GAttrib *attrib;
 	guint mtu;
 	gboolean le;
@@ -159,6 +157,47 @@ static int attribute_cmp(gconstpointer a1, gconstpointer a2)
 	return attrib1->handle - attrib2->handle;
 }
 
+static uint8_t run_callbacks(GAttrib *attrib, struct attribute *a, attrib_event_t event)
+{
+	GSList *l;
+	uint8_t status = 0;
+
+	if (attrib == NULL)
+		return 0;
+
+	for (l = a->callbacks; l; l = l->next) {
+		const struct attrib_cb *cb = l->data;
+
+		if (cb->event != event)
+			continue;
+
+		switch (event) {
+		case ATTRIB_READ:
+			if (cb->read)
+				status = cb->read(attrib, a);
+			break;
+		case ATTRIB_WRITE:
+			if (cb->write)
+				status = cb->write(attrib, a);
+			break;
+		case ATTRIB_UPDATE:
+			if (cb->update)
+				status = cb->update(attrib, a);
+			break;
+		}
+
+		if (status)
+			return status;
+	}
+
+	return status;
+}
+
+void attrib_add_callback(struct attribute *a, struct attrib_cb *cb)
+{
+	a->callbacks = g_slist_append(a->callbacks, cb);
+}
+
 static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 								int reqs)
 {
@@ -193,33 +232,60 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 	return 0;
 }
 
-static uint8_t client_set_notifications(struct attribute *attr,
-							gpointer user_data)
+
+static uint8_t attribute_notify(GAttrib *attrib, struct attribute *a)
+{
+	uint8_t *buf;
+	int blen;
+	uint16_t len;
+
+	buf = g_attrib_get_buffer(attrib, &blen);
+
+	len = enc_notification(a, buf, blen);
+	if (len == 0)
+		return 0;
+
+	return g_attrib_send(attrib, 0, buf[0], buf, len, NULL, NULL, NULL);
+}
+
+static uint8_t attribute_indicate(GAttrib *attrib, struct attribute *a)
+{
+	uint8_t *buf;
+	int blen;
+	uint16_t len;
+
+	buf = g_attrib_get_buffer(attrib, &blen);
+
+	len = enc_indication(a, buf, blen);
+	if (len == 0)
+		return 0;
+
+	return g_attrib_send(attrib, 0, buf[0], buf, len, NULL, NULL, NULL);
+}
+
+static uint8_t client_set_notifications(GAttrib *attrib, struct attribute *a)
 {
-	struct gatt_channel *channel = user_data;
 	struct attribute *last_chr_val = NULL;
 	uint16_t cfg_val;
 	uint8_t props;
 	bt_uuid_t uuid;
 	GSList *l;
 
-	cfg_val = att_get_u16(attr->data);
+	cfg_val = att_get_u16(a->data);
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	for (l = database, props = 0; l != NULL; l = l->next) {
-		struct attribute *a = l->data;
-		static uint16_t handle = 0;
+		struct attribute *cur = l->data;
 
-		if (a->handle >= attr->handle)
+		if (cur->handle >= a->handle)
 			break;
 
-		if (bt_uuid_cmp(&a->uuid, &uuid) == 0) {
-			props = att_get_u8(&a->data[0]);
-			handle = att_get_u16(&a->data[1]);
+		if (bt_uuid_cmp(&cur->uuid, &a->uuid) == 0) {
+			props = att_get_u8(&cur->data[0]);
 			continue;
 		}
 
-		if (handle && a->handle == handle)
+		if (a->handle && cur->handle == a->handle)
 			last_chr_val = a;
 	}
 
@@ -232,17 +298,23 @@ static uint8_t client_set_notifications(struct attribute *attr,
 	if ((cfg_val & 0x0002) && !(props & ATT_CHAR_PROPER_INDICATE))
 		return ATT_ECODE_WRITE_NOT_PERM;
 
-	if (cfg_val & 0x0001)
-		channel->notify = g_slist_append(channel->notify, last_chr_val);
-	else
-		channel->notify = g_slist_remove(channel->notify, last_chr_val);
+	if (cfg_val & 0x0001) {
+		struct attrib_cb *cb;
 
-	if (cfg_val & 0x0002)
-		channel->indicate = g_slist_append(channel->indicate,
-								last_chr_val);
-	else
-		channel->indicate = g_slist_remove(channel->indicate,
-								last_chr_val);
+		cb = g_new0(struct attrib_cb, 1);
+		cb->event = ATTRIB_UPDATE;
+		cb->update = attribute_notify;
+		attrib_add_callback(last_chr_val, cb);
+	}
+
+	if (cfg_val & 0x0002) {
+		struct attrib_cb *cb;
+
+		cb = g_new0(struct attrib_cb, 1);
+		cb->event = ATTRIB_UPDATE;
+		cb->update = attribute_indicate;
+		attrib_add_callback(last_chr_val, cb);
+	}
 
 	return 0;
 }
@@ -267,14 +339,18 @@ static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
 								handle_cmp);
 	if (!l) {
 		struct attribute *a;
+		struct attrib_cb *cb;
 
 		/* Create a private copy of the Client Characteristic
 		 * Configuration attribute */
 		a = g_malloc0(sizeof(*a) + vlen);
 		memcpy(a, orig_attr, sizeof(*a));
 		memcpy(a->data, value, vlen);
-		a->write_cb = client_set_notifications;
-		a->cb_user_data = channel;
+
+		cb = g_new0(struct attrib_cb, 1);
+		cb->event = ATTRIB_WRITE;
+		cb->write = client_set_notifications;
+		attrib_add_callback(a, cb);
 
 		channel->configs = g_slist_insert_sorted(channel->configs, a,
 								attribute_cmp);
@@ -347,9 +423,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 		if (client_attr)
 			a = client_attr;
 
-		if (status == 0x00 && a->read_cb)
-			status = a->read_cb(a, a->cb_user_data);
-
+		status = run_callbacks(channel->attrib, a, ATTRIB_READ);
 		if (status) {
 			g_slist_free_full(groups, g_free);
 			return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ,
@@ -439,9 +513,7 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 		if (client_attr)
 			a = client_attr;
 
-		if (status == 0x00 && a->read_cb)
-			status = a->read_cb(a, a->cb_user_data);
-
+		status = run_callbacks(channel->attrib, a, ATTRIB_READ);
 		if (status) {
 			g_slist_free(types);
 			return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ,
@@ -671,9 +743,7 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	if (client_attr)
 		a = client_attr;
 
-	if (status == 0x00 && a->read_cb)
-		status = a->read_cb(a, a->cb_user_data);
-
+	status = run_callbacks(channel->attrib, a, ATTRIB_READ);
 	if (status)
 		return enc_error_resp(ATT_OP_READ_REQ, handle, status, pdu,
 									len);
@@ -706,9 +776,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	if (client_attr)
 		a = client_attr;
 
-	if (status == 0x00 && a->read_cb)
-		status = a->read_cb(a, a->cb_user_data);
-
+	status = run_callbacks(channel->attrib, a, ATTRIB_READ);
 	if (status)
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle, status,
 								pdu, len);
@@ -743,16 +811,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	else
 		attrib_db_update(a->handle, NULL, value, vlen, &a);
 
-	if (a->write_cb) {
-		status = a->write_cb(a, a->cb_user_data);
-		if (status)
-			return enc_error_resp(ATT_OP_WRITE_REQ, handle, status,
-								pdu, len);
-	}
-
-	DBG("Notifications: %d, indications: %d",
-					g_slist_length(channel->notify),
-					g_slist_length(channel->indicate));
+	status = run_callbacks(channel->attrib, a, ATTRIB_WRITE);
 
 	return enc_write_resp(pdu, len);
 }
@@ -774,6 +833,15 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
+static void attribute_free(gpointer user_data)
+{
+	struct attribute *a = user_data;
+
+	g_slist_free_full(a->callbacks, g_free);
+	g_free(a->data);
+	g_free(a);
+}
+
 static void channel_disconnect(void *user_data)
 {
 	struct gatt_channel *channel = user_data;
@@ -781,9 +849,7 @@ static void channel_disconnect(void *user_data)
 	g_attrib_unref(channel->attrib);
 	clients = g_slist_remove(clients, channel);
 
-	g_slist_free(channel->notify);
-	g_slist_free(channel->indicate);
-	g_slist_free_full(channel->configs, g_free);
+	g_slist_free_full(channel->configs, attribute_free);
 
 	g_free(channel);
 }
@@ -974,39 +1040,12 @@ static void confirm_event(GIOChannel *io, void *user_data)
 
 static void attrib_notify_clients(struct attribute *attr)
 {
-	guint handle = attr->handle;
 	GSList *l;
 
 	for (l = clients; l; l = l->next) {
 		struct gatt_channel *channel = l->data;
 
-		/* Notification */
-		if (g_slist_find_custom(channel->notify,
-					GUINT_TO_POINTER(handle), handle_cmp)) {
-			uint8_t pdu[ATT_MAX_MTU];
-			uint16_t len;
-
-			len = enc_notification(attr, pdu, channel->mtu);
-			if (len == 0)
-				continue;
-
-			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
-							NULL, NULL, NULL);
-		}
-
-		/* Indication */
-		if (g_slist_find_custom(channel->indicate,
-					GUINT_TO_POINTER(handle), handle_cmp)) {
-			uint8_t pdu[ATT_MAX_MTU];
-			uint16_t len;
-
-			len = enc_indication(attr, pdu, channel->mtu);
-			if (len == 0)
-				return;
-
-			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
-							NULL, NULL, NULL);
-		}
+		run_callbacks(channel->attrib, attr, ATTRIB_UPDATE);
 	}
 }
 
@@ -1128,7 +1167,7 @@ void attrib_server_exit(void)
 {
 	GSList *l;
 
-	g_slist_free_full(database, g_free);
+	g_slist_free_full(database, attribute_free);
 
 	if (l2cap_io) {
 		g_io_channel_unref(l2cap_io);
@@ -1143,9 +1182,7 @@ void attrib_server_exit(void)
 	for (l = clients; l; l = l->next) {
 		struct gatt_channel *channel = l->data;
 
-		g_slist_free(channel->notify);
-		g_slist_free(channel->indicate);
-		g_slist_free_full(channel->configs, g_free);
+		g_slist_free_full(channel->configs, attribute_free);
 
 		g_attrib_unref(channel->attrib);
 		g_free(channel);
@@ -1281,11 +1318,11 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 	a->len = len;
 	memcpy(a->data, value, len);
 
-	attrib_notify_clients(a);
-
 	if (attr)
 		*attr = a;
 
+	attrib_notify_clients(a);
+
 	return 0;
 }
 
diff --git a/src/attrib-server.h b/src/attrib-server.h
index cde6eff..79ce44f 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -22,12 +22,28 @@
  *
  */
 
+typedef enum {
+	ATTRIB_READ,
+	ATTRIB_WRITE,
+	ATTRIB_UPDATE,
+} attrib_event_t;
+
+struct attrib_cb {
+	attrib_event_t event;
+	union {
+		uint8_t (*read)(GAttrib *attrib, struct attribute *a);
+		uint8_t (*write)(GAttrib *attrib, struct attribute *a);
+		uint8_t (*update)(GAttrib *attrib, struct attribute *a);
+	};
+};
+
 uint16_t attrib_db_find_avail(uint16_t nitems);
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr);
 int attrib_db_del(uint16_t handle);
+void attrib_add_callback(struct attribute *a, struct attrib_cb *cb);
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
 uint32_t attrib_create_sdp(uint16_t handle, const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
-- 
1.7.0.4

