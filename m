Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH v2 05/13] heartrate: Process Heart Rate Descriptors
Date: Mon, 13 Aug 2012 17:08:09 +0200
Message-ID: <1344870497-6929-6-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Process Heart Rate service descriptors and write
client specific characteristic configuration.

---
 lib/uuid.h                     |    1 +
 profiles/heartrate/heartrate.c |   34 +++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index 99b88cc..5d81856 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -64,6 +64,7 @@ extern "C" {
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
 #define HEART_RATE_UUID		"0000180d-0000-1000-8000-00805f9b34fb"
+#define HEART_RATE_MEASUREMENT_UUID	"00002a37-0000-1000-8000-00805f9b34fb"
 
 #define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
 #define TEMPERATURE_MEASUREMENT_UUID	"00002a1c-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index e917f27..4c313b2 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -70,12 +70,21 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static void char_destroy(gpointer user_data)
+{
+	struct characteristic *c = user_data;
+
+	g_slist_free_full(c->desc, g_free);
+
+	g_free(c);
+}
+
 static void heartrate_destroy(gpointer user_data)
 {
 	struct heartrate *hr = user_data;
 
 	if (hr->chars != NULL)
-		g_slist_free_full(hr->chars, g_free);
+		g_slist_free_full(hr->chars, char_destroy);
 
 	if (hr->attioid > 0)
 		btd_device_remove_attio_callback(hr->dev, hr->attioid);
@@ -89,6 +98,28 @@ static void heartrate_destroy(gpointer user_data)
 
 }
 
+static void process_heartrate_desc(struct descriptor *desc)
+{
+	struct characteristic *ch = desc->ch;
+	char uuidstr[MAX_LEN_UUID_STR];
+	bt_uuid_t btuuid;
+
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0 &&
+		g_strcmp0(ch->attr.uuid,
+				HEART_RATE_MEASUREMENT_UUID) == 0) {
+
+		DBG("Heart Rate Measurement notification" \
+						" supported");
+		return;
+	}
+
+	bt_uuid_to_string(&desc->uuid, uuidstr, MAX_LEN_UUID_STR);
+	DBG("Ignored descriptor %s in characteristic %s", uuidstr,
+							ch->attr.uuid);
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -122,6 +153,7 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 			desc->uuid = att_get_uuid128(&value[2]);
 
 		ch->desc = g_slist_append(ch->desc, desc);
+		process_heartrate_desc(desc);
 	}
 
 	att_data_list_free(list);
-- 
1.7.9.5

