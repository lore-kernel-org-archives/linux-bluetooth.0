Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 01/15] thermometer: Store Temperature Measurement CCC handle in struct
Date: Fri, 9 Nov 2012 09:55:43 +0100
Message-ID: <1352451357-22097-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Temperature Measurement CCC handle value directly into
thermometer struct. This way there's no need to traverse nested lists
looking for value.
---
 profiles/thermometer/thermometer.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 4d1df1d..3ea6e96 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -80,6 +80,8 @@ struct thermometer {
 	uint16_t			min;
 	gboolean			has_type;
 	gboolean			has_interval;
+
+	uint16_t			measurement_ccc_handle;
 };
 
 struct characteristic {
@@ -403,6 +405,8 @@ static void process_thermometer_desc(struct descriptor *desc)
 
 		if (g_strcmp0(ch->attr.uuid,
 					TEMPERATURE_MEASUREMENT_UUID) == 0) {
+			desc->ch->t->measurement_ccc_handle = desc->handle;
+
 			if (g_slist_length(ch->t->tadapter->fwatchers) == 0)
 				return;
 
@@ -759,9 +763,18 @@ static void write_ccc(struct thermometer *t, const char *uuid, uint16_t value)
 static void enable_final_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
+	uint16_t handle = t->measurement_ccc_handle;
+	uint8_t value[2];
+	char *msg;
+
+	if (t->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(GATT_CLIENT_CHARAC_CFG_IND_BIT, value);
+	msg = g_strdup("Enable Temperature Measurement indications");
 
-	write_ccc(t, TEMPERATURE_MEASUREMENT_UUID,
-					GATT_CLIENT_CHARAC_CFG_IND_BIT);
+	gatt_write_char(t->attrib, handle, value, sizeof(value),
+							write_ccc_cb, msg);
 }
 
 static void enable_intermediate_measurement(gpointer data, gpointer user_data)
@@ -775,8 +788,18 @@ static void enable_intermediate_measurement(gpointer data, gpointer user_data)
 static void disable_final_measurement(gpointer data, gpointer user_data)
 {
 	struct thermometer *t = data;
+	uint16_t handle = t->measurement_ccc_handle;
+	uint8_t value[2];
+	char *msg;
+
+	if (t->attrib == NULL || !handle)
+		return;
+
+	att_put_u16(0x0000, value);
+	msg = g_strdup("Disable Temperature Measurement indications");
 
-	write_ccc(t, TEMPERATURE_MEASUREMENT_UUID, 0x0000);
+	gatt_write_char(t->attrib, handle, value, sizeof(value),
+							write_ccc_cb, msg);
 }
 
 static void disable_intermediate_measurement(gpointer data, gpointer user_data)
-- 
1.8.0

