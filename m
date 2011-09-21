Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] Fix memory allocation of struct attribute
Date: Tue, 20 Sep 2011 22:49:10 -0400
Message-Id: <1316573351-30884-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On commit 6a6da5de107e192f62ce2ecdde96eae985181df0 the struct
attribute "data[0]" member was replaced with a dynamically allocated
"data" pointer. This commit fixes remaining places where the old
allocation scheme was still assumed.
---
 attrib/att.c        |    7 +++----
 src/attrib-server.c |   33 +++++++++++++++------------------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 1b95c45..c3cbf86 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -868,11 +868,10 @@ struct attribute *dec_indication(const uint8_t *pdu, int len)
 	if (len < min_len)
 		return NULL;
 
-	a = g_malloc0(sizeof(struct attribute) + len - min_len);
-	a->len = len - min_len;
-
+	a = g_new0(struct attribute, 1);
 	a->handle = att_get_u16(&pdu[1]);
-	memcpy(a->data, &pdu[3], a->len);
+	a->len = len - min_len;
+	a->data = g_memdup(&pdu[3], a->len);
 
 	return a;
 }
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5c86085..2e99a52 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -271,10 +271,9 @@ static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
 		/* Create a private copy of the Client Characteristic
 		 * Configuration attribute */
 		a = g_new0(struct attribute, 1);
-		a->data = g_malloc0(vlen);
-
-		memcpy(a, orig_attr, sizeof(*a));
-		memcpy(a->data, value, vlen);
+		*a = *orig_attr;
+		a->len = vlen;
+		a->data = g_memdup(value, vlen);
 		a->write_cb = client_set_notifications;
 		a->cb_user_data = channel;
 
@@ -776,6 +775,14 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	return enc_mtu_resp(old_mtu, pdu, len);
 }
 
+static void attrib_free(void *data)
+{
+	struct attribute *a = data;
+
+	g_free(a->data);
+	g_free(a);
+}
+
 static void channel_disconnect(void *user_data)
 {
 	struct gatt_channel *channel = user_data;
@@ -785,7 +792,7 @@ static void channel_disconnect(void *user_data)
 
 	g_slist_free(channel->notify);
 	g_slist_free(channel->indicate);
-	g_slist_free_full(channel->configs, g_free);
+	g_slist_free_full(channel->configs, attrib_free);
 
 	g_free(channel);
 }
@@ -1123,14 +1130,6 @@ failed:
 	return -1;
 }
 
-static void attrib_free(void *data)
-{
-	struct attribute *a = data;
-
-	g_free(a->data);
-	g_free(a);
-}
-
 void attrib_server_exit(void)
 {
 	GSList *l;
@@ -1152,7 +1151,7 @@ void attrib_server_exit(void)
 
 		g_slist_free(channel->notify);
 		g_slist_free(channel->indicate);
-		g_slist_free_full(channel->configs, g_free);
+		g_slist_free_full(channel->configs, attrib_free);
 
 		g_attrib_unref(channel->attrib);
 		g_free(channel);
@@ -1253,14 +1252,12 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 		return NULL;
 
 	a = g_new0(struct attribute, 1);
-	a->data = g_malloc0(len);
-
+	a->len = len;
+	a->data = g_memdup(value, len);
 	a->handle = handle;
 	memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->read_reqs = read_reqs;
 	a->write_reqs = write_reqs;
-	a->len = len;
-	memcpy(a->data, value, len);
 
 	database = g_slist_insert_sorted(database, a, attribute_cmp);
 
-- 
1.7.0.4

