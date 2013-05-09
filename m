Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 22/26] thermometer: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:52 -0300
Message-Id: <1368073016-28434-22-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/thermometer/thermometer.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index c2ca251..ddc9d55 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
 
@@ -70,13 +71,13 @@ struct thermometer {
 	struct thermometer_adapter	*tadapter;
 	GAttrib				*attrib;	/* GATT connection */
 	struct att_range		*svc_range;	/* Thermometer range */
-	guint				attioid;	/* Att watcher id */
+	unsigned int			attioid;	/* Att watcher id */
 	/* attio id for Temperature Measurement value indications */
-	guint				attio_measurement_id;
+	unsigned int				attio_measurement_id;
 	/* attio id for Intermediate Temperature value notifications */
-	guint				attio_intermediate_id;
+	unsigned int				attio_intermediate_id;
 	/* attio id for Measurement Interval value indications */
-	guint				attio_interval_id;
+	unsigned int				attio_interval_id;
 	gboolean			intermediate;
 	uint8_t				type;
 	uint16_t			interval;
@@ -97,7 +98,7 @@ struct characteristic {
 
 struct watcher {
 	struct thermometer_adapter	*tadapter;
-	guint				id;
+	unsigned int				id;
 	char				*srv;
 	char				*path;
 };
@@ -476,8 +477,8 @@ static void interval_ind_handler(const uint8_t *pdu, uint16_t len,
 		g_attrib_send(t->attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void valid_range_desc_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct thermometer *t = user_data;
 	uint8_t value[VALID_RANGE_DESC_SIZE];
@@ -513,8 +514,8 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	change_property(t, "Minimum", &min);
 }
 
-static void write_ccc_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void write_ccc_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
+							gpointer user_data)
 {
 	char *msg = user_data;
 
@@ -525,7 +526,7 @@ static void write_ccc_cb(guint8 status, const guint8 *pdu,
 }
 
 static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
-								uint16_t handle)
+							uint16_t handle)
 {
 	uint8_t atval[2];
 	uint16_t val;
@@ -573,7 +574,7 @@ static void process_thermometer_desc(struct characteristic *ch, uint16_t uuid,
 							write_ccc_cb, msg);
 }
 
-static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void discover_desc_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	struct characteristic *ch = user_data;
@@ -636,7 +637,7 @@ static void discover_desc(struct thermometer *t, struct gatt_char *c,
 	gatt_find_info(t->attrib, start, end, discover_desc_cb, ch);
 }
 
-static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void read_temp_type_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -664,7 +665,7 @@ static void read_temp_type_cb(guint8 status, const guint8 *pdu, guint16 len,
 	t->type = value[0];
 }
 
-static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void read_interval_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -737,7 +738,7 @@ static void process_thermometer_char(struct thermometer *t,
 	}
 }
 
-static void configure_thermometer_cb(GSList *characteristics, guint8 status,
+static void configure_thermometer_cb(GSList *characteristics, uint8_t status,
 							gpointer user_data)
 {
 	struct thermometer *t = user_data;
@@ -757,7 +758,7 @@ static void configure_thermometer_cb(GSList *characteristics, guint8 status,
 	}
 }
 
-static void write_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void write_interval_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	struct tmp_interval_data *data = user_data;
-- 
1.8.2.2

