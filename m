Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 10/15] thermometer: Always write CCC value when connecting
Date: Fri, 9 Nov 2012 09:55:52 +0100
Message-ID: <1352451357-22097-11-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch ensures that CCC values for Intermediate Temperature and
Termperature Measurement are always written when connecting to device.
This is to i.e. disable notifications and/or indications in case they
are already enabled (reconnection scenario) but we don't have watcher
registered so it's pointless for remote to send us data.
---
 profiles/thermometer/thermometer.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 30f79b0..ad1a41d 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -550,19 +550,23 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 	if (g_strcmp0(ch->uuid, TEMPERATURE_MEASUREMENT_UUID) == 0) {
 		ch->t->measurement_ccc_handle = handle;
 
-		if (g_slist_length(ch->t->tadapter->fwatchers) == 0)
-			return;
-
-		val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
-		msg = g_strdup("Enable Temperature Measurement indication");
+		if (g_slist_length(ch->t->tadapter->fwatchers) == 0) {
+			val = 0x0000;
+			msg = g_strdup("Disable Temperature Measurement ind");
+		} else {
+			val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
+			msg = g_strdup("Enable Temperature Measurement ind");
+		}
 	} else if (g_strcmp0(ch->uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
 		ch->t->intermediate_ccc_handle = handle;
 
-		if (g_slist_length(ch->t->tadapter->iwatchers) == 0)
-			return;
-
-		val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
-		msg = g_strdup("Enable Intermediate Temperature notification");
+		if (g_slist_length(ch->t->tadapter->iwatchers) == 0) {
+			val = 0x0000;
+			msg = g_strdup("Disable Intermediate Temperature noti");
+		} else {
+			val = GATT_CLIENT_CHARAC_CFG_NOTIF_BIT;
+			msg = g_strdup("Enable Intermediate Temperature noti");
+		}
 	} else if (g_strcmp0(ch->uuid, MEASUREMENT_INTERVAL_UUID) == 0) {
 		val = GATT_CLIENT_CHARAC_CFG_IND_BIT;
 		msg = g_strdup("Enable Measurement Interval indication");
-- 
1.8.0

