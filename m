Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 4/7] Add CCC persistence in attrib server
Date: Mon,  7 Nov 2011 10:59:52 -0300
Message-Id: <1320674392-22673-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517004-17003-5-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517004-17003-5-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds storage of the Client Characteristic Configuration
attribute value. CCC is readable with no authentication/authorization.
Writable with authentication and authorization defined by a higher layer
specification or implementation specific.
---
 src/attrib-server.c |  161 +++++++++++++--------------------------------------
 1 files changed, 41 insertions(+), 120 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index b2e218c..5bb0dab 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -44,6 +44,7 @@
 #include "hcid.h"
 #include "att.h"
 #include "gattrib.h"
+#include "storage.h"
 
 #include "attrib-server.h"
 
@@ -52,7 +53,6 @@ static GSList *database = NULL;
 struct gatt_channel {
 	bdaddr_t src;
 	bdaddr_t dst;
-	GSList *configs;
 	GSList *notify;
 	GSList *indicate;
 	GAttrib *attrib;
@@ -87,6 +87,10 @@ static bt_uuid_t snd_uuid = {
 			.type = BT_UUID16,
 			.value.u16 = GATT_SND_SVC_UUID
 };
+static bt_uuid_t ccc_uuid = {
+			.type = BT_UUID16,
+			.value.u16 = GATT_CLIENT_CHARAC_CFG_UUID
+};
 
 static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 {
@@ -193,99 +197,6 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 	return 0;
 }
 
-static uint8_t client_set_notifications(struct attribute *attr,
-							gpointer user_data)
-{
-	struct gatt_channel *channel = user_data;
-	struct attribute *last_chr_val = NULL;
-	uint16_t cfg_val;
-	uint8_t props;
-	bt_uuid_t uuid;
-	GSList *l;
-
-	cfg_val = att_get_u16(attr->data);
-
-	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	for (l = database, props = 0; l != NULL; l = l->next) {
-		struct attribute *a = l->data;
-		static uint16_t handle = 0;
-
-		if (a->handle >= attr->handle)
-			break;
-
-		if (bt_uuid_cmp(&a->uuid, &uuid) == 0) {
-			props = att_get_u8(&a->data[0]);
-			handle = att_get_u16(&a->data[1]);
-			continue;
-		}
-
-		if (handle && a->handle == handle)
-			last_chr_val = a;
-	}
-
-	if (last_chr_val == NULL)
-		return 0;
-
-	if ((cfg_val & 0x0001) && !(props & ATT_CHAR_PROPER_NOTIFY))
-		return ATT_ECODE_WRITE_NOT_PERM;
-
-	if ((cfg_val & 0x0002) && !(props & ATT_CHAR_PROPER_INDICATE))
-		return ATT_ECODE_WRITE_NOT_PERM;
-
-	if (cfg_val & 0x0001)
-		channel->notify = g_slist_append(channel->notify, last_chr_val);
-	else
-		channel->notify = g_slist_remove(channel->notify, last_chr_val);
-
-	if (cfg_val & 0x0002)
-		channel->indicate = g_slist_append(channel->indicate,
-								last_chr_val);
-	else
-		channel->indicate = g_slist_remove(channel->indicate,
-								last_chr_val);
-
-	return 0;
-}
-
-static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
-						struct attribute *orig_attr,
-						const uint8_t *value, int vlen)
-{
-	guint handle = orig_attr->handle;
-	bt_uuid_t uuid;
-	GSList *l;
-
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	if (bt_uuid_cmp(&orig_attr->uuid, &uuid) != 0)
-		return NULL;
-
-	/* Value is unchanged, not need to create a private copy yet */
-	if (vlen == orig_attr->len && memcmp(orig_attr->data, value, vlen) == 0)
-		return orig_attr;
-
-	l = g_slist_find_custom(channel->configs, GUINT_TO_POINTER(handle),
-								handle_cmp);
-	if (!l) {
-		struct attribute *a;
-
-		/* Create a private copy of the Client Characteristic
-		 * Configuration attribute */
-		a = g_new0(struct attribute, 1);
-		*a = *orig_attr;
-		a->len = vlen;
-		a->data = g_memdup(value, vlen);
-		a->write_cb = client_set_notifications;
-		a->cb_user_data = channel;
-
-		channel->configs = g_slist_insert_sorted(channel->configs, a,
-								attribute_cmp);
-
-		return a;
-	}
-
-	return l->data;
-}
-
 static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 						uint16_t end, bt_uuid_t *uuid,
 						uint8_t *pdu, int len)
@@ -644,9 +555,10 @@ static struct attribute *find_primary_range(uint16_t start, uint16_t *end)
 static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 							uint8_t *pdu, int len)
 {
-	struct attribute *a, *client_attr;
+	struct attribute *a;
 	uint8_t status;
 	GSList *l;
+	uint16_t cccval;
 	guint h = handle;
 
 	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
@@ -656,11 +568,16 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 
 	a = l->data;
 
-	status = att_check_reqs(channel, ATT_OP_READ_REQ, a->read_reqs);
+	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) == 0 &&
+		read_device_ccc(&channel->src, &channel->dst,
+					handle, &cccval) == 0) {
+		uint8_t config[2];
 
-	client_attr = client_cfg_attribute(channel, a, a->data, a->len);
-	if (client_attr)
-		a = client_attr;
+		att_put_u16(cccval, config);
+		return enc_read_resp(config, sizeof(config), pdu, len);
+	}
+
+	status = att_check_reqs(channel, ATT_OP_READ_REQ, a->read_reqs);
 
 	if (status == 0x00 && a->read_cb)
 		status = a->read_cb(a, a->cb_user_data);
@@ -675,9 +592,10 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 					uint16_t offset, uint8_t *pdu, int len)
 {
-	struct attribute *a, *client_attr;
+	struct attribute *a;
 	uint8_t status;
 	GSList *l;
+	uint16_t cccval;
 	guint h = handle;
 
 	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
@@ -691,11 +609,17 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle,
 					ATT_ECODE_INVALID_OFFSET, pdu, len);
 
-	status = att_check_reqs(channel, ATT_OP_READ_BLOB_REQ, a->read_reqs);
+	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) == 0 &&
+		read_device_ccc(&channel->src, &channel->dst,
+					handle, &cccval) == 0) {
+		uint8_t config[2];
 
-	client_attr = client_cfg_attribute(channel, a, a->data, a->len);
-	if (client_attr)
-		a = client_attr;
+		att_put_u16(cccval, config);
+		return enc_read_blob_resp(config, sizeof(config), offset,
+								pdu, len);
+	}
+
+	status = att_check_reqs(channel, ATT_OP_READ_BLOB_REQ, a->read_reqs);
 
 	if (status == 0x00 && a->read_cb)
 		status = a->read_cb(a, a->cb_user_data);
@@ -711,7 +635,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 						const uint8_t *value, int vlen,
 						uint8_t *pdu, int len)
 {
-	struct attribute *a, *client_attr;
+	struct attribute *a;
 	uint8_t status;
 	GSList *l;
 	guint h = handle;
@@ -728,22 +652,20 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 		return enc_error_resp(ATT_OP_WRITE_REQ, handle, status, pdu,
 									len);
 
-	client_attr = client_cfg_attribute(channel, a, value, vlen);
-	if (client_attr)
-		a = client_attr;
-	else
-		attrib_db_update(a->handle, NULL, value, vlen, &a);
+	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) != 0) {
 
-	if (a->write_cb) {
-		status = a->write_cb(a, a->cb_user_data);
-		if (status)
-			return enc_error_resp(ATT_OP_WRITE_REQ, handle, status,
-								pdu, len);
-	}
+		attrib_db_update(handle, NULL, value, vlen, NULL);
 
-	DBG("Notifications: %d, indications: %d",
-					g_slist_length(channel->notify),
-					g_slist_length(channel->indicate));
+		if (a->write_cb) {
+			status = a->write_cb(a, a->cb_user_data);
+			if (status)
+				return enc_error_resp(ATT_OP_WRITE_REQ, handle,
+							status, pdu, len);
+		}
+	} else {
+		uint16_t cccval = att_get_u16(value);
+		write_device_ccc(&channel->src, &channel->dst, handle, cccval);
+	}
 
 	return enc_write_resp(pdu, len);
 }
@@ -777,7 +699,6 @@ static void channel_free(struct gatt_channel *channel)
 {
 	g_slist_free(channel->notify);
 	g_slist_free(channel->indicate);
-	g_slist_free_full(channel->configs, attrib_free);
 	g_attrib_unref(channel->attrib);
 
 	g_free(channel);
-- 
1.7.7.2

