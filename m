Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/8] Get valid range descriptor if it is supported
Date: Thu, 20 Oct 2011 11:46:45 +0200
Message-Id: <1319104011-27747-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1319104011-27747-2-git-send-email-sancane@gmail.com>
References: <1319104011-27747-1-git-send-email-sancane@gmail.com>
 <1319104011-27747-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 854a157..343d72a 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -162,6 +162,44 @@ static void change_property(struct thermometer *t, const gchar *name,
 		DBG("%s is not a thermometer property", name);
 }
 
+static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct descriptor *desc = user_data;
+	uint8_t value[ATT_MAX_MTU];
+	uint16_t *p, max, min;
+	int vlen;
+
+	if (status != 0) {
+		DBG("Valid Range descriptor read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, value, &vlen)) {
+		DBG("Protocol error\n");
+		return;
+	}
+
+	if (vlen < 4) {
+		DBG("Invalid range received");
+		return;
+	}
+
+	p = (uint16_t *) value;
+	min = btohs(bt_get_unaligned(p));
+	p = (uint16_t *) &value[2];
+	max = btohs(bt_get_unaligned(p));
+
+	if (min == 0 || min > max) {
+		DBG("Invalid range");
+		return;
+	}
+
+	change_property(desc->ch->t, "Maximum", &max);
+	change_property(desc->ch->t, "Minimum", &min);
+}
+
 static void process_thermometer_desc(struct descriptor *desc)
 {
 	char uuidstr[MAX_LEN_UUID_STR];
@@ -193,7 +231,8 @@ static void process_thermometer_desc(struct descriptor *desc)
 	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0)
 		if (g_strcmp0(desc->ch->attr.uuid,
 					MEASUREMENT_INTERVAL_UUID) == 0) {
-			/* TODO: Process Measurement Interval */
+			gatt_read_char(desc->ch->t->attrib, desc->handle, 0,
+						valid_range_desc_cb, desc);
 			return;
 		}
 
-- 
1.7.6.1

