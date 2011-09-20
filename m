Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 07/19] Read temperature type characteristic
Date: Tue, 20 Sep 2011 19:47:19 +0200
Message-Id: <1316540841-14713-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1316540841-14713-7-git-send-email-sancane@gmail.com>
References: <1316540841-14713-1-git-send-email-sancane@gmail.com>
 <1316540841-14713-2-git-send-email-sancane@gmail.com>
 <1316540841-14713-3-git-send-email-sancane@gmail.com>
 <1316540841-14713-4-git-send-email-sancane@gmail.com>
 <1316540841-14713-5-git-send-email-sancane@gmail.com>
 <1316540841-14713-6-git-send-email-sancane@gmail.com>
 <1316540841-14713-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/thermometer.c |   54 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index f0b977e..2dcc4ba 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -39,6 +39,14 @@
 #define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
 
+struct properties {
+	gboolean	intermediate;
+	guint8		*type;
+	guint16		*interval;
+	guint16		*max;
+	guint16		*min;
+};
+
 struct thermometer {
 	DBusConnection          *conn;		/* The connection to the bus */
 	struct btd_device       *dev;		/* Device reference */
@@ -47,6 +55,7 @@ struct thermometer {
 	gint                    attioid;	/* Att watcher id */
 	gint			attindid;	/* Att incications id */
 	GSList			*chars;		/* Characteristics */
+	struct properties	properties;	/* Thermometer's properties */
 };
 
 struct characteristic {
@@ -63,6 +72,24 @@ struct descriptor {
 
 static GSList *thermometers = NULL;
 
+static gchar* temptype2str(uint8_t value)
+{
+	switch (value) {
+	case 1: return "Armpit";
+	case 2: return "Body";
+	case 3: return "Ear";
+	case 4: return "Finger";
+	case 5: return "Intestines";
+	case 6: return "Mouth";
+	case 7: return "Rectum";
+	case 8: return "Toe";
+	case 9: return "Tympanum";
+	default:
+		error("Temperature type %d reserved for future use", value);
+		return NULL;
+	};
+}
+
 static void destroy_char(gpointer user_data)
 {
 	struct characteristic *c = user_data;
@@ -87,6 +114,11 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->chars)
 		g_slist_free_full(t->chars, destroy_char);
 
+	g_free(t->properties.type);
+	g_free(t->properties.interval);
+	g_free(t->properties.max);
+	g_free(t->properties.min);
+
 	dbus_connection_unref(t->conn);
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
@@ -113,7 +145,27 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	/* TODO */
+	struct characteristic *ch = user_data;
+	struct thermometer *t = ch->t;
+	uint8_t value;
+	int vlen;
+
+	if (status != 0) {
+		DBG("Temperature Type value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, &value, &vlen)) {
+		DBG("Protocol error");
+		return;
+	}
+
+	DBG("TEMPERATURE TYPE: %s", temptype2str(value));
+	if (!t->properties.type)
+		t->properties.type = g_new0(guint8, 1);
+
+	*t->properties.type = value;
 }
 
 static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
-- 
1.7.6.1

