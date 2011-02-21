Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/5] Initial Client Characteristic Configuration implementation
Date: Mon, 21 Feb 2011 18:30:40 -0300
Message-Id: <1298323843-31106-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This initial version creates a private copy of the Client Configuration
attribute for each client on the first write to that attribute. Further
reads/writes should use the client's private copy.

Two list of attributes are created: one for values to be indicated and
another for values to be notified. The actual notification/indication
sending is implemented in a separate commit.

This initial version also does not check for the characteristic
properties, which is implemented in a separate commit as well.
---
 src/attrib-server.c |  177 ++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 146 insertions(+), 31 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 28649f1..be71621 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -54,6 +54,7 @@ static GSList *database = NULL;
 struct gatt_channel {
 	bdaddr_t src;
 	bdaddr_t dst;
+	GSList *configs, *notify, *indicate;
 	GAttrib *attrib;
 	guint mtu;
 	guint id;
@@ -143,6 +144,22 @@ static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t en
 	return record;
 }
 
+static int handle_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct attribute *attrib = a;
+	uint16_t handle = GPOINTER_TO_UINT(b);
+
+	return attrib->handle - handle;
+}
+
+static int attribute_cmp(gconstpointer a1, gconstpointer a2)
+{
+	const struct attribute *attrib1 = a1;
+	const struct attribute *attrib2 = a2;
+
+	return attrib1->handle - attrib2->handle;
+}
+
 static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 								int reqs)
 {
@@ -174,6 +191,91 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 	return 0;
 }
 
+static uint8_t client_set_notifications(struct attribute *attr,
+							gpointer user_data)
+{
+	struct gatt_channel *channel = user_data;
+	struct attribute *a, *last_chr_val = NULL;
+	uint16_t handle, cfg_val;
+	uuid_t uuid;
+	GSList *l;
+
+	cfg_val = att_get_u16(attr->data);
+
+	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	for (l = database, handle = 0; l != NULL; l = l->next) {
+		a = l->data;
+
+		if (a->handle >= attr->handle)
+			break;
+
+		if (sdp_uuid_cmp(&a->uuid, &uuid) == 0) {
+			handle = att_get_u16(&a->data[1]);
+			continue;
+		}
+
+		if (handle && a->handle == handle)
+			last_chr_val = a;
+	}
+
+	if (last_chr_val == NULL)
+		return 0;
+
+	/* FIXME: Characteristic properties shall be checked for
+	 * Notification/Indication permissions. */
+
+	if (cfg_val & 0x0001)
+		channel->notify = g_slist_append(channel->notify, last_chr_val);
+	else
+		channel->notify = g_slist_remove(channel->notify, last_chr_val);
+
+	if (cfg_val & 0x0002)
+		channel->indicate = g_slist_append(channel->indicate,
+								last_chr_val);
+	else
+		channel->indicate = g_slist_remove(channel->indicate,
+								last_chr_val);
+
+	return 0;
+}
+
+static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
+		struct attribute *orig_attr, const uint8_t *value, int vlen)
+{
+	uuid_t uuid;
+	GSList *l;
+	guint handle = orig_attr->handle;
+
+	sdp_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	if (sdp_uuid_cmp(&orig_attr->uuid, &uuid) != 0)
+		return NULL;
+
+	/* Value is unchanged, not need to create a private copy yet */
+	if (vlen == orig_attr->len && memcmp(orig_attr->data, value, vlen) == 0)
+		return orig_attr;
+
+	l = g_slist_find_custom(channel->configs, GUINT_TO_POINTER(handle),
+								handle_cmp);
+	if (!l) {
+		struct attribute *a;
+
+		/* Create a private copy of the Client Characteristic
+		 * Configuration attribute */
+		a = g_malloc0(sizeof(struct attribute) + vlen);
+		memcpy(a, orig_attr, sizeof(struct attribute));
+		memcpy(a->data, value, vlen);
+		a->write_cb = client_set_notifications;
+		a->cb_user_data = channel;
+
+		channel->configs = g_slist_insert_sorted(channel->configs, a,
+								attribute_cmp);
+
+		return a;
+	}
+
+	return l->data;
+}
+
 static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 						uint16_t end, uuid_t *uuid,
 						uint8_t *pdu, int len)
@@ -202,6 +304,8 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 	last_handle = end;
 	for (l = database, groups = NULL; l; l = l->next) {
+		struct attribute *client_attr;
+
 		a = l->data;
 
 		if (a->handle < start)
@@ -230,6 +334,10 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 		status = att_check_reqs(channel, ATT_OP_READ_BY_GROUP_REQ,
 								a->read_reqs);
 
+		client_attr = client_cfg_attribute(channel, a, a->data, a->len);
+		if (client_attr)
+			a = client_attr;
+
 		if (status == 0x00 && a->read_cb)
 			status = a->read_cb(a, a->cb_user_data);
 
@@ -308,6 +416,8 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 					ATT_ECODE_INVALID_HANDLE, pdu, len);
 
 	for (l = database, length = 0, types = NULL; l; l = l->next) {
+		struct attribute *client_attr;
+
 		a = l->data;
 
 		if (a->handle < start)
@@ -322,6 +432,10 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 		status = att_check_reqs(channel, ATT_OP_READ_BY_TYPE_REQ,
 								a->read_reqs);
 
+		client_attr = client_cfg_attribute(channel, a, a->data, a->len);
+		if (client_attr)
+			a = client_attr;
+
 		if (status == 0x00 && a->read_cb)
 			status = a->read_cb(a, a->cb_user_data);
 
@@ -506,22 +620,6 @@ static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 	return len;
 }
 
-static int handle_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct attribute *attrib = a;
-	uint16_t handle = GPOINTER_TO_UINT(b);
-
-	return attrib->handle - handle;
-}
-
-static int attribute_cmp(gconstpointer a1, gconstpointer a2)
-{
-	const struct attribute *attrib1 = a1;
-	const struct attribute *attrib2 = a2;
-
-	return attrib1->handle - attrib2->handle;
-}
-
 static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
 {
 	struct attribute *attrib;
@@ -559,7 +657,7 @@ static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
 static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 							uint8_t *pdu, int len)
 {
-	struct attribute *a;
+	struct attribute *a, *client_attr;
 	uint8_t status;
 	GSList *l;
 	guint h = handle;
@@ -573,6 +671,10 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 
 	status = att_check_reqs(channel, ATT_OP_READ_REQ, a->read_reqs);
 
+	client_attr = client_cfg_attribute(channel, a, a->data, a->len);
+	if (client_attr)
+		a = client_attr;
+
 	if (status == 0x00 && a->read_cb)
 		status = a->read_cb(a, a->cb_user_data);
 
@@ -586,7 +688,7 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 					uint16_t offset, uint8_t *pdu, int len)
 {
-	struct attribute *a;
+	struct attribute *a, *client_attr;
 	uint8_t status;
 	GSList *l;
 	guint h = handle;
@@ -604,6 +706,10 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 
 	status = att_check_reqs(channel, ATT_OP_READ_BLOB_REQ, a->read_reqs);
 
+	client_attr = client_cfg_attribute(channel, a, a->data, a->len);
+	if (client_attr)
+		a = client_attr;
+
 	if (status == 0x00 && a->read_cb)
 		status = a->read_cb(a, a->cb_user_data);
 
@@ -618,11 +724,10 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 						const uint8_t *value, int vlen,
 						uint8_t *pdu, int len)
 {
-	struct attribute *a;
+	struct attribute *a, *client_attr;
 	uint8_t status;
 	GSList *l;
 	guint h = handle;
-	uuid_t uuid;
 
 	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
@@ -636,8 +741,11 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		return enc_error_resp(ATT_OP_WRITE_REQ, handle, status, pdu,
 									len);
 
-	memcpy(&uuid, &a->uuid, sizeof(uuid_t));
-	attrib_db_update(handle, &uuid, value, vlen);
+	client_attr = client_cfg_attribute(channel, a, value, vlen);
+	if (client_attr)
+		a = client_attr;
+	else
+		attrib_db_update(a->handle, &a->uuid, value, vlen);
 
 	if (a->write_cb) {
 		status = a->write_cb(a, a->cb_user_data);
@@ -646,6 +754,10 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 								pdu, len);
 	}
 
+	DBG("Notifications: %d, indications: %d",
+					g_slist_length(channel->notify),
+					g_slist_length(channel->indicate));
+
 	return enc_write_resp(pdu, len);
 }
 
@@ -664,6 +776,11 @@ static void channel_disconnect(void *user_data)
 	g_attrib_unref(channel->attrib);
 	clients = g_slist_remove(clients, channel);
 
+	g_slist_free(channel->notify);
+	g_slist_free(channel->indicate);
+	g_slist_foreach(channel->configs, (GFunc) g_free, NULL);
+	g_slist_free(channel->configs);
+
 	g_free(channel);
 }
 
@@ -976,6 +1093,11 @@ void attrib_server_exit(void)
 	for (l = clients; l; l = l->next) {
 		struct gatt_channel *channel = l->data;
 
+		g_slist_free(channel->notify);
+		g_slist_free(channel->indicate);
+		g_slist_foreach(channel->configs, (GFunc) g_free, NULL);
+		g_slist_free(channel->configs);
+
 		g_attrib_unref(channel->attrib);
 		g_free(channel);
 	}
@@ -1073,18 +1195,11 @@ int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 
 	l->data = a;
 	a->handle = handle;
-	memcpy(&a->uuid, uuid, sizeof(uuid_t));
+	if (uuid != &a->uuid)
+		memcpy(&a->uuid, uuid, sizeof(uuid_t));
 	a->len = len;
 	memcpy(a->data, value, len);
 
-	/*
-	 * <<Client/Server Characteristic Configuration>> descriptors are
-	 * not supported yet. If a given attribute changes, the attribute
-	 * server shall report the new values using the mechanism selected
-	 * by the client. Notification/Indication shall not be automatically
-	 * sent if the client didn't request them.
-	 */
-
 	return 0;
 }
 
-- 
1.7.0.4

