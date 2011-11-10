Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/6] Manage GATT attribute indications in handle callback.
Date: Thu, 10 Nov 2011 12:36:57 +0100
Message-Id: <1320925022-21891-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1320925022-21891-1-git-send-email-sancane@gmail.com>
References: <1320925022-21891-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 5b0e30a..69ae708 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -163,6 +163,14 @@ static gint cmp_char_uuid(gconstpointer a, gconstpointer b)
 	return g_strcmp0(ch->attr.uuid, uuid);
 }
 
+static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
+{
+	const struct characteristic *ch = a;
+	const uint16_t *handle = b;
+
+	return ch->attr.value_handle - *handle;
+}
+
 static gint cmp_descriptor(gconstpointer a, gconstpointer b)
 {
 	const struct descriptor *desc = a;
@@ -703,9 +711,50 @@ static GDBusSignalTable thermometer_signals[] = {
 	{ }
 };
 
+static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
+						uint16_t len, gboolean final)
+{
+	DBG("TODO: Process measurement indication");
+}
+
+static void proc_measurement_interval(struct thermometer *t, const uint8_t *pdu,
+								uint16_t len)
+{
+	DBG("TODO: Process measurements interval indication");
+}
+
 static void ind_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
-	/* TODO: Process indication */
+	struct thermometer *t = user_data;
+	const struct characteristic *ch;
+	uint8_t opdu[ATT_MAX_MTU];
+	uint16_t handle, olen;
+	GSList *l;
+
+	if (len < 3) {
+		DBG("Bad pdu received");
+		return;
+	}
+
+	handle = att_get_u16(&pdu[1]);
+	l = g_slist_find_custom(t->chars, &handle, cmp_char_val_handle);
+	if (l == NULL) {
+		DBG("Unexpected handle: 0x%04x", handle);
+		return;
+	}
+
+	ch = l->data;
+
+	if (g_strcmp0(ch->attr.uuid, TEMPERATURE_MEASUREMENT_UUID) == 0)
+		proc_measurement(t, pdu, len, TRUE);
+	else if (g_strcmp0(ch->attr.uuid, MEASUREMENT_INTERVAL_UUID) == 0)
+		proc_measurement_interval(t, pdu, len);
+
+	olen = enc_confirmation(opdu, sizeof(opdu));
+
+	if (olen > 0)
+		g_attrib_send(t->attrib, 0, opdu[0], opdu, olen, NULL, NULL,
+									NULL);
 }
 
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-- 
1.7.7.3

