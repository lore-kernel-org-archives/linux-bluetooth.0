Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 08/11] thermometer: Discover descriptors using gatt_discover_desc
Date: Fri,  2 May 2014 12:57:39 +0200
Message-Id: <1399028262-17187-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399028262-17187-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/thermometer/thermometer.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 20575c0..e3ab923 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -574,13 +574,9 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 							write_ccc_cb, msg);
 }
 
-static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void discover_desc_cb(guint8 status, GSList *descs, gpointer user_data)
 {
 	struct characteristic *ch = user_data;
-	struct att_data_list *list = NULL;
-	uint8_t format;
-	int i;
 
 	if (status != 0) {
 		error("Discover all characteristic descriptors failed [%s]: %s",
@@ -588,27 +584,13 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		goto done;
 	}
 
-	list = dec_find_info_resp(pdu, len, &format);
-	if (list == NULL)
-		goto done;
-
-	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
-		goto done;
-
-	for (i = 0; i < list->num; i++) {
-		uint8_t *value;
-		uint16_t handle, uuid;
-
-		value = list->data[i];
-		handle = get_le16(value);
-		uuid = get_le16(value + 2);
+	for ( ; descs; descs = descs->next) {
+		struct gatt_desc *desc = descs->data;
 
-		process_thermometer_desc(ch, uuid, handle);
+		process_thermometer_desc(ch, desc->uuid16, desc->handle);
 	}
 
 done:
-	if (list != NULL)
-		att_data_list_free(list);
 	g_free(ch);
 }
 
@@ -634,7 +616,7 @@ static void discover_desc(struct thermometer *t, struct gatt_char *c,
 	ch->t = t;
 	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
 
-	gatt_discover_char_desc(t->attrib, start, end, discover_desc_cb, ch);
+	gatt_discover_desc(t->attrib, start, end, NULL, discover_desc_cb, ch);
 }
 
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.9.2

