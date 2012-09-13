Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v5 11/17] heartrate: Read Heart Rate Control Point characteristics
Date: Thu, 13 Sep 2012 16:31:45 +0200
Message-ID: <1347546711-19961-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1347546711-19961-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reads and stores Heart Rate Control Point characteristics value.

---
 profiles/heartrate/heartrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 150a675..4591e56 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -58,6 +58,7 @@ struct heartrate {
 	GSList				*chars;
 	gboolean			has_location;
 	uint8_t				location;
+	gboolean			has_cp_reset;
 };
 
 struct characteristic {
@@ -420,6 +421,7 @@ static void process_heartrate_char(struct characteristic *ch)
 {
 	if (g_strcmp0(ch->attr.uuid, HEART_RATE_CONTROL_POINT_UUID) == 0) {
 		DBG("Heart Rate Control Point reset supported by client");
+		ch->hr->has_cp_reset = TRUE;
 	} else if (g_strcmp0(ch->attr.uuid, BODY_SENSOR_LOCATION_UUID) == 0) {
 		DBG("Body Sensor Location supported by client");
 		gatt_read_char(ch->hr->attrib, ch->attr.value_handle, 0,
-- 
1.7.11.3

