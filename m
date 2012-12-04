Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 06/20] cyclingspeed: Read Sensor Location characteristic value
Date: Tue, 4 Dec 2012 13:43:32 +0100
Message-ID: <1354625026-29358-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 40 +++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 7f79116..ec52ab4 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <gdbus.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <glib.h>
@@ -33,12 +34,15 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "dbus-common.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 #include "attio.h"
 #include "log.h"
 
+#define CYCLINGSPEED_INTERFACE		"org.bluez.CyclingSpeed"
+
 struct csc_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;	/* list of registered devices */
@@ -57,6 +61,8 @@ struct csc {
 	uint16_t		controlpoint_val_handle;
 
 	uint16_t		feature;
+	gboolean		has_location;
+	uint8_t			location;
 };
 
 struct characteristic {
@@ -146,6 +152,37 @@ static void read_feature_cb(guint8 status, const guint8 *pdu,
 	csc->feature = att_get_u16(value);
 }
 
+static void read_location_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	struct csc *csc = user_data;
+	uint8_t value;
+	ssize_t vlen;
+
+	if (status) {
+		error("Sensor Location read failed: %s", att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, &value, sizeof(value));
+	if (vlen < 0) {
+		error("Protocol error");
+		return;
+	}
+
+	if (vlen != sizeof(value)) {
+		error("Invalid value length for Sensor Location");
+		return;
+	}
+
+	csc->has_location = TRUE;
+	csc->location = value;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					device_get_path(csc->dev),
+					CYCLINGSPEED_INTERFACE, "Location");
+}
+
 static void discover_desc_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -238,7 +275,8 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 			feature_val_handle = c->value_handle;
 		} else if (g_strcmp0(c->uuid, SENSOR_LOCATION_UUID) == 0) {
 			DBG("Sensor Location supported");
-			/* TODO: read characterictic value */
+			gatt_read_char(csc->attrib, c->value_handle,
+							read_location_cb, csc);
 		} else if (g_strcmp0(c->uuid, SC_CONTROL_POINT_UUID) == 0) {
 			DBG("SC Control Point supported");
 			csc->controlpoint_val_handle = c->value_handle;
-- 
1.8.0

