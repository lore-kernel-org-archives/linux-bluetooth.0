Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 8/9] Read measurement interval characteristic
Date: Wed, 28 Sep 2011 19:48:45 +0200
Message-Id: <1317232126-12640-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1317232126-12640-8-git-send-email-sancane@gmail.com>
References: <1317232126-12640-1-git-send-email-sancane@gmail.com>
 <1317232126-12640-2-git-send-email-sancane@gmail.com>
 <1317232126-12640-3-git-send-email-sancane@gmail.com>
 <1317232126-12640-4-git-send-email-sancane@gmail.com>
 <1317232126-12640-5-git-send-email-sancane@gmail.com>
 <1317232126-12640-6-git-send-email-sancane@gmail.com>
 <1317232126-12640-7-git-send-email-sancane@gmail.com>
 <1317232126-12640-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   72 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index de5f155..f9371c2 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -23,6 +23,7 @@
 #include <gdbus.h>
 #include <bluetooth/uuid.h>
 
+#include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
 #include "error.h"
@@ -129,6 +130,51 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static void change_property(struct thermometer *t, const gchar *name,
+							gpointer value) {
+	if (g_strcmp0(name, "Intermediate") == 0) {
+		gboolean *intermediate = value;
+		if (t->intermediate == *intermediate)
+			return;
+
+		t->intermediate = *intermediate;
+		emit_property_changed(t->conn, device_get_path(t->dev),
+					THERMOMETER_INTERFACE, name,
+					DBUS_TYPE_BOOLEAN, &t->intermediate);
+	} else if (g_strcmp0(name, "Interval") == 0) {
+		uint16_t *interval = value;
+		if (t->has_interval && t->interval == *interval)
+			return;
+
+		if (!t->has_interval)
+			t->has_interval = TRUE;
+
+		t->interval = *interval;
+		emit_property_changed(t->conn, device_get_path(t->dev),
+					THERMOMETER_INTERFACE, name,
+					DBUS_TYPE_UINT16, &t->interval);
+	} else if (g_strcmp0(name, "Maximum") == 0) {
+		uint16_t *max = value;
+		if (t->max == *max)
+			return;
+
+		t->max = *max;
+		emit_property_changed(t->conn, device_get_path(t->dev),
+					THERMOMETER_INTERFACE, name,
+					DBUS_TYPE_UINT16, &t->max);
+	} else if (g_strcmp0(name, "Minimum") == 0) {
+		uint16_t *min = value;
+		if (t->min == *min)
+			return;
+
+		t->min = *min;
+		emit_property_changed(t->conn, device_get_path(t->dev),
+					THERMOMETER_INTERFACE, name,
+					DBUS_TYPE_UINT16, &t->min);
+	} else
+		DBG("%s is not a thermometer property", name);
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -164,7 +210,31 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	/* TODO */
+	struct characteristic *ch = user_data;
+	uint8_t value[ATT_MAX_MTU];
+	uint16_t *p, interval;
+	int vlen;
+
+	if (status != 0) {
+		DBG("Measurement Interval value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, value, &vlen)) {
+		DBG("Protocol error\n");
+		return;
+	}
+
+	if (vlen < 2) {
+		DBG("Invalid Interval received");
+		return;
+	}
+
+	p = (uint16_t *) value;
+	interval = btohs(*p);
+
+	change_property(ch->t, "Interval", &interval);
 }
 
 static void process_thermometer_char(struct characteristic *ch)
-- 
1.7.6.1

