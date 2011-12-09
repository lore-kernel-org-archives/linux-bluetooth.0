Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/6] thermometer.c: Confiure C.C.C descriptor during the thermometer configuration
Date: Fri,  9 Dec 2011 19:19:00 +0100
Message-Id: <1323454744-14589-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1323454744-14589-2-git-send-email-sancane@gmail.com>
References: <1323454744-14589-1-git-send-email-sancane@gmail.com>
 <1323454744-14589-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables notification/indication in GATT server if there
are any watcher regitered for measurements when the thermometer is
configured.
---
 thermometer/thermometer.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 2a0fb0f..d175800 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -340,21 +340,30 @@ static void process_thermometer_desc(struct descriptor *desc)
 	bt_uuid16_create(&btuuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
 	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
+		uint8_t atval[2];
+		uint16_t val;
+
 		if (g_strcmp0(ch->attr.uuid,
 					TEMPERATURE_MEASUREMENT_UUID) == 0) {
-			/* TODO: Check if we have to enable it */
-			DBG("C.C.C in Temperature Measurement");
+			if (g_slist_length(ch->t->fwatchers) == 0)
+				return;
+
+			val = ATT_CLIENT_CHAR_CONF_INDICATION;
 		} else if (g_strcmp0(ch->attr.uuid,
 					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
-			/* TODO: Check if we have to enable it */
-			DBG("C.C.C in Intermediate Temperature");
+			if (g_slist_length(ch->t->iwatchers) == 0)
+				return;
+
+			val = ATT_CLIENT_CHAR_CONF_NOTIFICATION;
 		} else if (g_strcmp0(ch->attr.uuid,
-					MEASUREMENT_INTERVAL_UUID) == 0) {
-			/* TODO: Enable indications */
-			DBG("C.C.C in Measurement Interval");
-		} else
+					MEASUREMENT_INTERVAL_UUID) == 0)
+			val = ATT_CLIENT_CHAR_CONF_INDICATION;
+		else
 			goto done;
 
+		att_put_u16(val, atval);
+		gatt_write_char(ch->t->attrib, desc->handle, atval, 2,
+								NULL, NULL);
 		return;
 	}
 
-- 
1.7.8

