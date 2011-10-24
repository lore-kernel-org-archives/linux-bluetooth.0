Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/8] Process characteristic descriptors in the thermometer service.
Date: Mon, 24 Oct 2011 19:04:01 +0200
Message-Id: <1319475848-4171-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1319475848-4171-1-git-send-email-sancane@gmail.com>
References: <1319475848-4171-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   77 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index b4dad79..4008bb9 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -37,6 +37,7 @@
 
 #define THERMOMETER_INTERFACE "org.bluez.Thermometer"
 
+#define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
 #define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
@@ -156,10 +157,84 @@ static void change_property(struct thermometer *t, const gchar *name,
 		DBG("%s is not a thermometer property", name);
 }
 
+static void process_thermometer_desc(struct descriptor *desc)
+{
+	struct characteristic *ch = desc->ch;
+	char uuidstr[MAX_LEN_UUID_STR];
+	bt_uuid_t btuuid;
+
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
+		if (g_strcmp0(ch->attr.uuid,
+					TEMPERATURE_MEASUREMENT_UUID) == 0) {
+			/* TODO: Check if we have to enable it */
+			DBG("C.C.C in Temperature Measurement");
+		} else if (g_strcmp0(ch->attr.uuid,
+					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
+			/* TODO: Check if we have to enable it */
+			DBG("C.C.C in Intermediate Temperature");
+		} else if (g_strcmp0(ch->attr.uuid,
+					MEASUREMENT_INTERVAL_UUID) == 0) {
+			/* TODO: Enable indications */
+			DBG("C.C.C in Measurement Interval");
+		} else
+			goto done;
+
+		return;
+	}
+
+	bt_uuid16_create(&btuuid, GATT_CHARAC_VALID_RANGE_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0 && g_strcmp0(ch->attr.uuid,
+					MEASUREMENT_INTERVAL_UUID) == 0) {
+		/* TODO: Process Measurement Interval */
+		return;
+	}
+
+done:
+	bt_uuid_to_string(&desc->uuid, uuidstr, MAX_LEN_UUID_STR);
+	DBG("Ignored descriptor %s in characteristic %s", uuidstr,
+								ch->attr.uuid);
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	/* TODO */
+	struct characteristic *ch = user_data;
+	struct att_data_list *list;
+	guint8 format;
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
+		process_thermometer_desc(desc);
+	}
+
+	att_data_list_free(list);
 }
 
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.7.6.1

