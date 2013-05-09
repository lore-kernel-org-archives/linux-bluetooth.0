Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 11/26] cyclingspeed: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:41 -0300
Message-Id: <1368073016-28434-11-git-send-email-lucas.demarchi@profusion.mobi>
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
 profiles/cyclingspeed/cyclingspeed.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 76be234..6f0bd58 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <glib.h>
@@ -75,7 +76,7 @@ struct csc;
 struct controlpoint_req {
 	struct csc		*csc;
 	uint8_t			opcode;
-	guint			timeout;
+	unsigned int			timeout;
 	GDBusPendingReply	reply_id;
 	DBusMessage		*msg;
 
@@ -93,11 +94,11 @@ struct csc {
 	struct csc_adapter	*cadapter;
 
 	GAttrib			*attrib;
-	guint			attioid;
+	unsigned int			attioid;
 	/* attio id for measurement characteristics value notifications */
-	guint			attio_measurement_id;
+	unsigned int			attio_measurement_id;
 	/* attio id for SC Control Point characteristics value indications */
-	guint			attio_controlpoint_id;
+	unsigned int			attio_controlpoint_id;
 
 	struct att_range	*svc_range;
 
@@ -115,7 +116,7 @@ struct csc {
 
 struct watcher {
 	struct csc_adapter	*cadapter;
-	guint			id;
+	unsigned int			id;
 	char			*srv;
 	char			*path;
 };
@@ -274,7 +275,7 @@ static void destroy_csc(gpointer user_data)
 	g_free(csc);
 }
 
-static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void char_write_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	char *msg = user_data;
@@ -310,8 +311,8 @@ static gboolean controlpoint_timeout(gpointer user_data)
 	return FALSE;
 }
 
-static void controlpoint_write_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
+static void controlpoint_write_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct controlpoint_req *req = user_data;
 
@@ -357,7 +358,7 @@ static void read_supported_locations(struct csc *csc)
 					controlpoint_write_cb, req);
 }
 
-static void read_feature_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void read_feature_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	struct csc *csc = user_data;
@@ -387,8 +388,8 @@ static void read_feature_cb(guint8 status, const guint8 *pdu, guint16 len,
 		read_supported_locations(csc);
 }
 
-static void read_location_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void read_location_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct csc *csc = user_data;
 	uint8_t value;
@@ -418,8 +419,8 @@ static void read_location_cb(guint8 status, const guint8 *pdu,
 					CYCLINGSPEED_INTERFACE, "Location");
 }
 
-static void discover_desc_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static void discover_desc_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct characteristic *ch = user_data;
 	struct att_data_list *list = NULL;
@@ -759,7 +760,7 @@ done:
 		g_attrib_send(csc->attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+static void discover_char_cb(GSList *chars, uint8_t status, gpointer user_data)
 {
 	struct csc *csc = user_data;
 	uint16_t feature_val_handle = 0;
-- 
1.8.2.2

