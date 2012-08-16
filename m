Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 05/10] Battery: Get Battery ID
Date: Thu, 16 Aug 2012 12:34:58 +0300
Message-ID: <1345109702-5698-6-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Read the battery level format characteristic descriptor to get the
unique namespace and description values.
---
 profiles/battery/battery.c |  112 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 27 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index f93fdbc..a33ac8c 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -37,6 +37,8 @@
 #include "battery.h"
 #include "log.h"
 
+#define BATTERY_LEVEL_UUID	"00002a19-0000-1000-8000-00805f9b34fb"
+
 struct battery {
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
@@ -48,15 +50,17 @@ struct battery {
 static GSList *servers;
 
 struct characteristic {
-	struct gatt_char	attr;	/* Characteristic */
-	struct battery		*batt;	/* Parent Battery Service */
+	struct gatt_char	attr;		/* Characteristic */
+	struct battery		*batt;		/* Parent Battery Service */
 	GSList				*desc;	/* Descriptors */
+	uint8_t			ns;		/* Battery Namespace */
+	uint16_t		description;	/* Battery description */
 };
 
 struct descriptor {
-	struct characteristic	*ch;	/* Parent Characteristic */
-	uint16_t		handle;	/* Descriptor Handle */
-	bt_uuid_t		uuid;	/* UUID */
+	struct characteristic	*ch;		/* Parent Characteristic */
+	uint16_t		handle;		/* Descriptor Handle */
+	bt_uuid_t		uuid;		/* UUID */
 };
 
 static gint cmp_device(gconstpointer a, gconstpointer b)
@@ -87,6 +91,55 @@ static void battery_free(gpointer user_data)
 	g_free(batt);
 }
 
+static void batterylevel_presentation_format_desc_cb(guint8 status,
+						const guint8 *pdu, guint16 len,
+						gpointer user_data)
+{
+	struct descriptor *desc = user_data;
+	uint8_t value[ATT_MAX_MTU];
+	int vlen;
+
+	if (status != 0) {
+		error("Presentation Format desc read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (!vlen) {
+		error("Presentation Format desc read failed: Protocol error\n");
+		return;
+	}
+
+	if (vlen < 7) {
+		error("Presentation Format desc read failed: Invalid range");
+		return;
+	}
+
+	desc->ch->ns = value[4];
+	desc->ch->description = att_get_u16(&value[5]);
+}
+
+
+static void process_batterylevel_desc(struct descriptor *desc)
+{
+	struct characteristic *ch = desc->ch;
+	char uuidstr[MAX_LEN_UUID_STR];
+	bt_uuid_t btuuid;
+
+	bt_uuid16_create(&btuuid, GATT_CHARAC_FMT_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
+		gatt_read_char(ch->batt->attrib, desc->handle, 0,
+				batterylevel_presentation_format_desc_cb, desc);
+		return;
+	}
+
+	bt_uuid_to_string(&desc->uuid, uuidstr, MAX_LEN_UUID_STR);
+	DBG("Ignored descriptor %s characteristic %s", uuidstr,	ch->attr.uuid);
+}
+
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -120,6 +173,7 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 			desc->uuid = att_get_uuid128(&value[2]);
 
 		ch->desc = g_slist_append(ch->desc, desc);
+		process_batterylevel_desc(desc);
 	}
 
 	att_data_list_free(list);
@@ -141,31 +195,35 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 	for (l = characteristics; l; l = l->next) {
 		struct gatt_char *c = l->data;
-		struct characteristic *ch;
-		uint16_t start, end;
-
-		ch = g_new0(struct characteristic, 1);
-		ch->attr.handle = c->handle;
-		ch->attr.properties = c->properties;
-		ch->attr.value_handle = c->value_handle;
-		memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
-		ch->batt = batt;
 
-		batt->chars = g_slist_append(batt->chars, ch);
-
-		start = c->value_handle + 1;
-
-		if (l->next != NULL) {
-			struct gatt_char *c = l->next->data;
-			if (start == c->handle)
+		if (g_strcmp0(c->uuid, BATTERY_LEVEL_UUID) == 0) {
+			struct characteristic *ch;
+			uint16_t start, end;
+
+			ch = g_new0(struct characteristic, 1);
+			ch->attr.handle = c->handle;
+			ch->attr.properties = c->properties;
+			ch->attr.value_handle = c->value_handle;
+			memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
+			ch->batt = batt;
+
+			batt->chars = g_slist_append(batt->chars, ch);
+
+			start = c->value_handle + 1;
+
+			if (l->next != NULL) {
+				struct gatt_char *c = l->next->data;
+				if (start == c->handle)
+					continue;
+				end = c->handle - 1;
+			} else if (c->value_handle != batt->svc_range->end)
+				end = batt->svc_range->end;
+			else
 				continue;
-			end = c->handle - 1;
-		} else if (c->value_handle != batt->svc_range->end)
-			end = batt->svc_range->end;
-		else
-			continue;
 
-		gatt_find_info(batt->attrib, start, end, discover_desc_cb, ch);
+			gatt_find_info(batt->attrib, start, end,
+							discover_desc_cb, ch);
+		}
 	}
 }
 
-- 
1.7.9.5

