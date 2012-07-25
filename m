Return-Path: <cyrus@holtmann.org>
From: Chen Ganir <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v2 3/9] Battery: Discover Characteristic Descriptors
Date: Wed, 25 Jul 2012 08:42:21 +0300
Message-ID: <1343194947-13659-4-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discover all characteristic descriptors, and build a descriptor
list
---
 profiles/batterystate/batterystate.c |   61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
index 40663f6..a7d2f6e 100644
--- a/profiles/batterystate/batterystate.c
+++ b/profiles/batterystate/batterystate.c
@@ -50,6 +50,13 @@ static GSList *servers;
 struct characteristic {
 	struct gatt_char	attr;	/* Characteristic */
 	struct battery		*batt;	/* Parent Battery Service */
+	GSList				*desc;	/* Descriptors */
+};
+
+struct descriptor {
+	struct characteristic	*ch;	/* Parent Characteristic */
+	uint16_t		handle;	/* Descriptor Handle */
+	bt_uuid_t		uuid;	/* UUID */
 };
 
 static gint cmp_device(gconstpointer a, gconstpointer b)
@@ -80,6 +87,45 @@ static void batterystate_free(gpointer user_data)
 	g_free(batt);
 }
 
+static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
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
+			desc->uuid = att_get_uuid16(&value[2]);
+		else
+			desc->uuid = att_get_uuid128(&value[2]);
+
+		ch->desc = g_slist_append(ch->desc, desc);
+	}
+
+	att_data_list_free(list);
+}
+
+
 static void configure_batterystate_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -95,6 +141,7 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
 	for (l = characteristics; l; l = l->next) {
 		struct gatt_char *c = l->data;
 		struct characteristic *ch;
+		uint16_t start, end;
 
 		ch = g_new0(struct characteristic, 1);
 		ch->attr.handle = c->handle;
@@ -104,6 +151,20 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
 		ch->batt = batt;
 
 		batt->chars = g_slist_append(batt->chars, ch);
+
+		start = c->value_handle + 1;
+
+		if (l->next != NULL) {
+			struct gatt_char *c = l->next->data;
+			if (start == c->handle)
+				continue;
+			end = c->handle - 1;
+		} else if (c->value_handle != batt->svc_range->end)
+			end = batt->svc_range->end;
+		else
+			continue;
+
+		gatt_find_info(batt->attrib, start, end, discover_desc_cb, ch);
 	}
 }
 
-- 
1.7.9.5

