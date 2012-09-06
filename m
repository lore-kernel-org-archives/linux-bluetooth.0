Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v3 06/17] heartrate: Discover characteristics descriptors
Date: Thu, 6 Sep 2012 13:32:40 +0200
Message-ID: <1346931171-18968-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

---
 profiles/heartrate/heartrate.c | 72 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 02a4617..69d6d51 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -55,6 +55,13 @@ struct heartrate {
 struct characteristic {
 	struct gatt_char	attr;
 	struct heartrate	*hr;
+	GSList			*desc;
+};
+
+struct descriptor {
+	struct characteristic	*ch;
+	uint16_t		handle;
+	bt_uuid_t		uuid;
 };
 
 static GSList *heartrate_adapters = NULL;
@@ -92,6 +99,15 @@ find_heartrate_adapter(struct btd_adapter *adapter)
 	return l->data;
 }
 
+static void destroy_char(gpointer user_data)
+{
+	struct characteristic *c = user_data;
+
+	g_slist_free_full(c->desc, g_free);
+
+	g_free(c);
+}
+
 static void destroy_heartrate_device(gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -103,7 +119,7 @@ static void destroy_heartrate_device(gpointer user_data)
 		g_attrib_unref(hr->attrib);
 
 	if (hr->chars != NULL)
-		g_slist_free_full(hr->chars, g_free);
+		g_slist_free_full(hr->chars, destroy_char);
 
 	btd_device_unref(hr->dev);
 	g_free(hr->svc_range);
@@ -128,6 +144,44 @@ static void process_heartrate_char(struct characteristic *ch)
 		DBG("Body Sensor Location supported by client");
 }
 
+static void discover_desc_cb(guint8 status, const guint8 *pdu,
+					guint16 len, gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	struct att_data_list *list;
+	uint8_t format;
+	int i;
+
+	if (status != 0) {
+		error("Discover all characteristic descriptors failed [%s]: %s",
+					ch->attr.uuid, att_ecode2str(status));
+		return;
+	}
+
+	list = dec_find_info_resp(pdu, len, &format);
+	if (list == NULL)
+		return;
+
+	for (i = 0; i < list->num; i++) {
+		struct descriptor *desc;
+		uint8_t *value;
+
+		value = list->data[i];
+		desc = g_new0(struct descriptor, 1);
+		desc->handle = att_get_u16(value);
+		desc->ch = ch;
+
+		if (format == 0x01)
+			desc->uuid = att_get_uuid16(value + 2);
+		else
+			desc->uuid = att_get_uuid128(value + 2);
+
+		ch->desc = g_slist_append(ch->desc, desc);
+	}
+
+	att_data_list_free(list);
+}
+
 static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -143,6 +197,7 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 	for (l = characteristics; l; l = l->next) {
 		struct gatt_char *c = l->data;
 		struct characteristic *ch;
+		uint16_t start, end;
 
 		ch = g_new0(struct characteristic, 1);
 		ch->attr.handle = c->handle;
@@ -154,6 +209,21 @@ static void configure_heartrate_cb(GSList *characteristics, guint8 status,
 		hr->chars = g_slist_append(hr->chars, ch);
 
 		process_heartrate_char(ch);
+
+		start = c->value_handle + 1;
+
+		if (l->next != NULL) {
+			struct gatt_char *c = l->next->data;
+			if (start == c->handle)
+				continue;
+			end = c->handle - 1;
+		} else if (c->value_handle != hr->svc_range->end) {
+			end = hr->svc_range->end;
+		} else {
+			continue;
+		}
+
+		gatt_find_info(hr->attrib, start, end, discover_desc_cb, ch);
 	}
 }
 
-- 
1.7.11.3

