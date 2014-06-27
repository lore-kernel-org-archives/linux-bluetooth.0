Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 04/12] android/dis: Only cache the handle not all the characteristics
Date: Fri, 27 Jun 2014 21:08:52 +0300
Message-Id: <1403892540-21222-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
References: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/dis.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/android/dis.c b/android/dis.c
index 3237c03..ce6e063 100644
--- a/android/dis.c
+++ b/android/dis.c
@@ -44,13 +44,13 @@
 
 struct bt_dis {
 	int			ref_count;
+	uint16_t		handle;
 	uint8_t			source;
 	uint16_t		vendor;
 	uint16_t		product;
 	uint16_t		version;
 	GAttrib			*attrib;	/* GATT connection */
 	struct gatt_primary	*primary;	/* Primary details */
-	GSList			*chars;		/* Characteristics */
 	bt_dis_notify		notify;
 	void			*notify_data;
 };
@@ -65,8 +65,6 @@ static void dis_free(struct bt_dis *dis)
 	if (dis->attrib)
 		g_attrib_unref(dis->attrib);
 
-	g_slist_free_full(dis->chars, g_free);
-
 	g_free(dis->primary);
 	g_free(dis);
 }
@@ -109,8 +107,7 @@ void bt_dis_unref(struct bt_dis *dis)
 static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct characteristic *ch = user_data;
-	struct bt_dis *dis = ch->d;
+	struct bt_dis *dis = user_data;
 	uint8_t value[PNP_ID_SIZE];
 	ssize_t vlen;
 
@@ -143,13 +140,6 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 						dis->version, dis->notify_data);
 }
 
-static void process_deviceinfo_char(struct characteristic *ch)
-{
-	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0)
-		gatt_read_char(ch->d->attrib, ch->attr.value_handle,
-							read_pnpid_cb, ch);
-}
-
 static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 								void *user_data)
 {
@@ -164,18 +154,12 @@ static void configure_deviceinfo_cb(uint8_t status, GSList *characteristics,
 
 	for (l = characteristics; l; l = l->next) {
 		struct gatt_char *c = l->data;
-		struct characteristic *ch;
-
-		ch = g_new0(struct characteristic, 1);
-		ch->attr.handle = c->handle;
-		ch->attr.properties = c->properties;
-		ch->attr.value_handle = c->value_handle;
-		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
-		ch->d = d;
-
-		d->chars = g_slist_append(d->chars, ch);
 
-		process_deviceinfo_char(ch);
+		if (strcmp(c->uuid, PNPID_UUID) == 0) {
+			d->handle = c->value_handle;
+			gatt_read_char(d->attrib, d->handle, read_pnpid_cb, d);
+			break;
+		}
 	}
 }
 
@@ -188,7 +172,8 @@ bool bt_dis_attach(struct bt_dis *dis, void *attrib)
 
 	dis->attrib = g_attrib_ref(attrib);
 
-	gatt_discover_char(dis->attrib, primary->range.start,
+	if (!dis->handle)
+		gatt_discover_char(dis->attrib, primary->range.start,
 						primary->range.end, NULL,
 						configure_deviceinfo_cb, dis);
 
-- 
1.9.3

