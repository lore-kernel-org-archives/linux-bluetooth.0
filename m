Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/6] Confiure C.C.C descriptor during the thermometer configuration
Date: Tue, 22 Nov 2011 15:49:44 +0100
Message-Id: <1321973388-16300-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1321973388-16300-2-git-send-email-sancane@gmail.com>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
 <1321973388-16300-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 2a0fb0f..1746e60 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -340,21 +340,31 @@ static void process_thermometer_desc(struct descriptor *desc)
 	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
 	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
+		uint8_t atval[2];
+
 		if (g_strcmp0(ch->attr.uuid,
 					TEMPERATURE_MEASUREMENT_UUID) == 0) {
-			/* TODO: Check if we have to enable it */
-			DBG("C.C.C in Temperature Measurement");
+			if (g_slist_length(ch->t->fwatchers) == 0)
+				return;
+
+			atval[0] = 0x02;
+			atval[1] = 0x00;
 		} else if (g_strcmp0(ch->attr.uuid,
 					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
-			/* TODO: Check if we have to enable it */
-			DBG("C.C.C in Intermediate Temperature");
+			if (g_slist_length(ch->t->iwatchers) == 0)
+				return;
+
+			atval[0] = 0x01;
+			atval[1] = 0x00;
 		} else if (g_strcmp0(ch->attr.uuid,
 					MEASUREMENT_INTERVAL_UUID) == 0) {
-			/* TODO: Enable indications */
-			DBG("C.C.C in Measurement Interval");
+			atval[0] = 0x02;
+			atval[1] = 0x00;
 		} else
 			goto done;
 
+		gatt_write_char(ch->t->attrib, desc->handle, atval, 2,
+								NULL, NULL);
 		return;
 	}
 
-- 
1.7.7.4

