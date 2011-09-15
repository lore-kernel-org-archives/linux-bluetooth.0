Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Fix allocation of attribute values
Date: Thu, 15 Sep 2011 14:58:51 -0400
Message-Id: <1316113131-10944-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Now that pointers to attribute are passed as reference to functions
we cannot have they change during run time, what g_try_realloc()
could do.
---
 attrib/att.h        |    2 +-
 src/attrib-server.c |   33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 3b8c098..9db8065 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -130,7 +130,7 @@ struct attribute {
 	uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
 	gpointer cb_user_data;
 	int len;
-	uint8_t data[0];
+	uint8_t *data;
 };
 
 struct att_data_list {
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 0bda1e3..5c86085 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -270,7 +270,9 @@ static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
 
 		/* Create a private copy of the Client Characteristic
 		 * Configuration attribute */
-		a = g_malloc0(sizeof(*a) + vlen);
+		a = g_new0(struct attribute, 1);
+		a->data = g_malloc0(vlen);
+
 		memcpy(a, orig_attr, sizeof(*a));
 		memcpy(a->data, value, vlen);
 		a->write_cb = client_set_notifications;
@@ -1121,11 +1123,19 @@ failed:
 	return -1;
 }
 
+static void attrib_free(void *data)
+{
+	struct attribute *a = data;
+
+	g_free(a->data);
+	g_free(a);
+}
+
 void attrib_server_exit(void)
 {
 	GSList *l;
 
-	g_slist_free_full(database, g_free);
+	g_slist_free_full(database, attrib_free);
 
 	if (l2cap_io) {
 		g_io_channel_unref(l2cap_io);
@@ -1242,7 +1252,9 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 	if (g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp))
 		return NULL;
 
-	a = g_malloc0(sizeof(struct attribute) + len);
+	a = g_new0(struct attribute, 1);
+	a->data = g_malloc0(len);
+
 	a->handle = handle;
 	memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->read_reqs = read_reqs;
@@ -1268,21 +1280,23 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 	if (!l)
 		return -ENOENT;
 
-	a = g_try_realloc(l->data, sizeof(struct attribute) + len);
-	if (a == NULL)
+	a = l->data;
+
+	a->data = g_try_realloc(a->data, len);
+	if (a->data == NULL)
 		return -ENOMEM;
 
-	l->data = a;
-	if (uuid != NULL)
-		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->len = len;
 	memcpy(a->data, value, len);
 
-	attrib_notify_clients(a);
+	if (uuid != NULL)
+		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 
 	if (attr)
 		*attr = a;
 
+	attrib_notify_clients(a);
+
 	return 0;
 }
 
@@ -1300,6 +1314,7 @@ int attrib_db_del(uint16_t handle)
 
 	a = l->data;
 	database = g_slist_remove(database, a);
+	g_free(a->data);
 	g_free(a);
 
 	return 0;
-- 
1.7.0.4

