Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v2 07/17] heartrate: Process characteristics descriptors
Date: Wed, 5 Sep 2012 15:05:38 +0200
Message-ID: <1346850348-21176-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346850348-21176-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346850348-21176-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch adds stub to process discovered characteristics descriptors.

---
 lib/uuid.h                     |  1 +
 profiles/heartrate/heartrate.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 0a9db51..15a80a0 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -64,6 +64,7 @@ extern "C" {
 #define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
 
 #define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
+#define HEART_RATE_MEASUREMENT_UUID	"00002a37-0000-1000-8000-00805f9b34fb"
 #define HEART_RATE_CONTROL_POINT_UUID	"00002a39-0000-1000-8000-00805f9b34fb"
 #define BODY_SENSOR_LOCATION_UUID	"00002a38-0000-1000-8000-00805f9b34fb"
 
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 69d6d51..eec8ae0 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -144,6 +144,22 @@ static void process_heartrate_char(struct characteristic *ch)
 		DBG("Body Sensor Location supported by client");
 }
 
+static void process_heartrate_desc(struct descriptor *desc)
+{
+	struct characteristic *ch = desc->ch;
+	char uuidstr[MAX_LEN_UUID_STR];
+	bt_uuid_t btuuid;
+
+	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0)
+		return;
+
+	bt_uuid_to_string(&desc->uuid, uuidstr, MAX_LEN_UUID_STR);
+	DBG("Ignored descriptor %s in characteristic %s", uuidstr,
+							ch->attr.uuid);
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -177,6 +193,8 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 			desc->uuid = att_get_uuid128(value + 2);
 
 		ch->desc = g_slist_append(ch->desc, desc);
+
+		process_heartrate_desc(desc);
 	}
 
 	att_data_list_free(list);
-- 
1.7.11.3

