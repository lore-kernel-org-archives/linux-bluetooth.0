Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 5/9] battery: Get Battery ID
Date: Mon,  7 Jan 2013 16:41:00 -0300
Message-Id: <1357587664-16818-6-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
References: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Read the battery level format characteristic descriptor to get the
unique namespace and description values.
---
 lib/uuid.h                 |    1 +
 profiles/battery/battery.c |   53 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 8736749..3abdd44 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -57,6 +57,7 @@ extern "C" {
 #define DEVICE_INFORMATION_UUID	"0000180a-0000-1000-8000-00805f9b34fb"
 
 #define BATTERY_SERVICE_UUID	"0000180f-0000-1000-8000-00805f9b34fb"
+#define BATTERY_LEVEL_UUID	"00002a19-0000-1000-8000-00805f9b34fb"
 
 #define GATT_UUID		"00001801-0000-1000-8000-00805f9b34fb"
 #define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 8e7e4c5..8bbfaf7 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -50,6 +50,8 @@ struct characteristic {
 	struct gatt_char	attr;		/* Characteristic */
 	struct battery		*batt;		/* Parent Battery Service */
 	GSList			*desc;		/* Descriptors */
+	uint8_t			ns;		/* Battery Namespace */
+	uint16_t		description;	/* Battery description */
 };
 
 struct descriptor {
@@ -98,6 +100,53 @@ static void battery_free(gpointer user_data)
 	g_free(batt);
 }
 
+static void batterylevel_presentation_format_desc_cb(guint8 status,
+						const guint8 *pdu, guint16 len,
+						gpointer user_data)
+{
+	struct descriptor *desc = user_data;
+	uint8_t value[ATT_MAX_VALUE_LEN];
+	int vlen;
+
+	if (status != 0) {
+		error("Presentation Format desc read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (vlen < 0) {
+		error("Presentation Format desc read failed: Protocol error");
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
+static void process_batterylevel_desc(struct descriptor *desc)
+{
+	struct characteristic *ch = desc->ch;
+	char uuidstr[MAX_LEN_UUID_STR];
+	bt_uuid_t btuuid;
+
+	bt_uuid16_create(&btuuid, GATT_CHARAC_FMT_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
+		gatt_read_char(ch->batt->attrib, desc->handle,
+				batterylevel_presentation_format_desc_cb, desc);
+		return;
+	}
+
+	bt_uuid_to_string(&desc->uuid, uuidstr, MAX_LEN_UUID_STR);
+	DBG("Ignored descriptor %s characteristic %s", uuidstr,	ch->attr.uuid);
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -131,6 +180,7 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 			desc->uuid = att_get_uuid128(&value[2]);
 
 		ch->desc = g_slist_append(ch->desc, desc);
+		process_batterylevel_desc(desc);
 	}
 
 	att_data_list_free(list);
@@ -153,6 +203,9 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 		struct characteristic *ch;
 		uint16_t start, end;
 
+		if (g_strcmp0(c->uuid, BATTERY_LEVEL_UUID) != 0)
+			continue;
+
 		ch = g_new0(struct characteristic, 1);
 		ch->attr.handle = c->handle;
 		ch->attr.properties = c->properties;
-- 
1.7.9.5

