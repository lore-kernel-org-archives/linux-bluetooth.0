Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/2] Fix allocation of attribute values
Date: Wed, 20 Jul 2011 15:57:58 -0300
Message-Id: <1311188278-7747-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1311188278-7747-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1311188278-7747-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Now that pointers to attribute are passed as reference to functions
we cannot have they change during run time, what g_try_realloc()
could do.
---
 attrib/att.h        |    2 +-
 src/attrib-server.c |   20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index bf47117..ecb635f 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -128,7 +128,7 @@ struct attribute {
 	int write_reqs;
 	GSList *callbacks;
 	int len;
-	uint8_t data[0];
+	uint8_t *data;
 };
 
 struct att_data_list {
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 85cb4e8..e850311 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -343,7 +343,9 @@ static struct attribute *client_cfg_attribute(struct gatt_channel *channel,
 
 		/* Create a private copy of the Client Characteristic
 		 * Configuration attribute */
-		a = g_malloc0(sizeof(*a) + vlen);
+		a = g_new0(struct attribute, 1);
+		a->data = g_malloc0(vlen);
+
 		memcpy(a, orig_attr, sizeof(*a));
 		memcpy(a->data, value, vlen);
 
@@ -1282,7 +1284,9 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 	if (g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp))
 		return NULL;
 
-	a = g_malloc0(sizeof(struct attribute) + len);
+	a = g_new0(struct attribute, 1);
+	a->data = g_malloc0(len);
+
 	a->handle = handle;
 	memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->read_reqs = read_reqs;
@@ -1308,16 +1312,18 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
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
 
+	if (uuid != NULL)
+		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
+
 	if (attr)
 		*attr = a;
 
-- 
1.7.0.4

