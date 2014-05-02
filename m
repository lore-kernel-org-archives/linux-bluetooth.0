Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 07/11] cyclingspeed: Discover CCC using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:38 +0200
Message-Id: <1399028262-17187-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 73 +++++++++++++-----------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 2f80bca..6b00da7 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -419,13 +419,12 @@ static void read_location_cb(guint8 status, const guint8 *pdu,
 					CYCLINGSPEED_INTERFACE, "Location");
 }
 
-static void discover_desc_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static void discover_desc_cb(guint8 status, GSList *descs, gpointer user_data)
 {
 	struct characteristic *ch = user_data;
-	struct att_data_list *list = NULL;
-	uint8_t format;
-	int i;
+	struct gatt_desc *desc;
+	uint8_t attr_val[2];
+	char *msg = NULL;
 
 	if (status != 0) {
 		error("Discover %s descriptors failed: %s", ch->uuid,
@@ -433,55 +432,31 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 		goto done;
 	}
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		goto done;
+	/* There will be only one descriptor on list and it will be CCC */
+	desc = descs->data;
 
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
+	if (g_strcmp0(ch->uuid, CSC_MEASUREMENT_UUID) == 0) {
+		ch->csc->measurement_ccc_handle = desc->handle;
 
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value;
-		uint16_t handle, uuid;
-		uint8_t attr_val[2];
-		char *msg;
-
-		value = list->data[i];
-		handle = get_le16(value);
-		uuid = get_le16(value + 2);
-
-		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
-			continue;
-
-		if (g_strcmp0(ch->uuid, CSC_MEASUREMENT_UUID) == 0) {
-			ch->csc->measurement_ccc_handle = handle;
-
-			if (g_slist_length(ch->csc->cadapter->watchers) == 0) {
-				put_le16(0x0000, attr_val);
-				msg = g_strdup("Disable measurement");
-			} else {
-				put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
-								attr_val);
-				msg = g_strdup("Enable measurement");
-			}
-
-		} else if (g_strcmp0(ch->uuid, SC_CONTROL_POINT_UUID) == 0) {
-			put_le16(GATT_CLIENT_CHARAC_CFG_IND_BIT, attr_val);
-			msg = g_strdup("Enable SC Control Point indications");
+		if (g_slist_length(ch->csc->cadapter->watchers) == 0) {
+			put_le16(0x0000, attr_val);
+			msg = g_strdup("Disable measurement");
 		} else {
-			break;
+			put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT,
+							attr_val);
+			msg = g_strdup("Enable measurement");
 		}
+	} else if (g_strcmp0(ch->uuid, SC_CONTROL_POINT_UUID) == 0) {
+		put_le16(GATT_CLIENT_CHARAC_CFG_IND_BIT, attr_val);
+		msg = g_strdup("Enable SC Control Point indications");
+	} else {
+		goto done;
+	}
 
-		gatt_write_char(ch->csc->attrib, handle, attr_val,
+	gatt_write_char(ch->csc->attrib, desc->handle, attr_val,
 					sizeof(attr_val), char_write_cb, msg);
 
-		/* We only want CCC, can break here */
-		break;
-	}
-
 done:
-	if (list)
-		att_data_list_free(list);
 	g_free(ch);
 }
 
@@ -490,6 +465,7 @@ static void discover_desc(struct csc *csc, struct gatt_char *c,
 {
 	struct characteristic *ch;
 	uint16_t start, end;
+	bt_uuid_t uuid;
 
 	start = c->value_handle + 1;
 
@@ -507,7 +483,10 @@ static void discover_desc(struct csc *csc, struct gatt_char *c,
 	ch->csc = csc;
 	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
 
-	gatt_discover_char_desc(csc->attrib, start, end, discover_desc_cb, ch);
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	gatt_discover_desc(csc->attrib, start, end, &uuid, discover_desc_cb,
+									ch);
 }
 
 static void update_watcher(gpointer data, gpointer user_data)
-- 
1.9.2

