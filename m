Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 08/18] attrib: Run callback with the partial result of service discovery
Date: Tue,  2 Apr 2013 12:50:55 -0400
Message-Id: <1364921465-31182-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1364921465-31182-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Callbacks should check for status equal to ATT_ECODE_ATTR_NOT_FOUND to
ensure that the service discovery has finished.
---
 attrib/gatt.c    |   40 +++++++++++++++++++++++++++++++++++++---
 unit/test-gatt.c |   39 +++++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 7a96c67..ef24adc 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -73,7 +73,7 @@ struct discover_char {
 
 static void discover_primary_free(struct discover_primary *dp)
 {
-	g_slist_free(dp->primaries);
+	g_slist_free_full(dp->primaries, g_free);
 	g_attrib_unref(dp->attrib);
 	g_free(dp);
 }
@@ -157,7 +157,7 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	size_t buflen;
 
 	if (status) {
-		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		err = status;
 		goto done;
 	}
 
@@ -173,6 +173,23 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	if (range->end == 0xffff)
 		goto done;
 
+	/* From the Core spec: "It is permitted to end the sub-procedure early
+	 * if a desired primary service is found prior to discovering all the
+	 * primary services of the specified service UUID supported on the
+	 * server."
+	 *
+	 * In other words, this callback will receive the partial list of
+	 * discovered services, and if it returns false, the procedure is
+	 * interrupted.
+	 */
+	if (dp->cb(dp->primaries, err, dp->user_data)) {
+		g_slist_free_full(dp->primaries, g_free);
+		dp->primaries = NULL;
+	} else {
+		discover_primary_free(dp);
+		return;
+	}
+
 	buf = g_attrib_get_buffer(dp->attrib, &buflen);
 	oplen = encode_discover_primary(range->end + 1, 0xffff, &dp->uuid,
 								buf, buflen);
@@ -197,7 +214,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	uint16_t start, end;
 
 	if (status) {
-		err = status == ATT_ECODE_ATTR_NOT_FOUND ? 0 : status;
+		err = status;
 		goto done;
 	}
 
@@ -246,6 +263,23 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
 								buf, buflen);
 
+		/* From the Core spec: "It is permitted to end the
+		 * sub-procedure early if a desired primary service is found
+		 * prior to discovering all the primary services on the
+		 * server."
+		 *
+		 * In other words, this callback will receive the partial list
+		 * of discovered services, and if it returns false, the
+		 * procedure is interrupted.
+		 */
+		if (dp->cb(dp->primaries, err, dp->user_data)) {
+			g_slist_free_full(dp->primaries, g_free);
+			dp->primaries = NULL;
+		} else {
+			discover_primary_free(dp);
+			return;
+		}
+
 		g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
 								dp, NULL);
 
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 02afc69..4edf920 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -42,6 +42,7 @@ struct context {
 	GMainLoop *main_loop;
 	guint server_source;
 	GAttrib *attrib;
+	struct gatt_primary prim;
 };
 
 void btd_debug(const char *format, ...)
@@ -135,7 +136,7 @@ static gboolean handle_not_supported(int fd)
 	return TRUE;
 }
 
-static gboolean handle_read_by_group(int fd)
+static gboolean handle_read_by_group(int fd, struct context *context)
 {
 	uint8_t pdu[sizeof(uint16_t) * 3 + 2], ipdu[ATT_DEFAULT_LE_MTU];
 	uint16_t pdu_len, start, end;
@@ -162,16 +163,29 @@ static gboolean handle_read_by_group(int fd)
 		att_put_u16(0x0001, &value[0]);
 		att_put_u16(0x000f, &value[2]);
 		att_put_u16(0xaaaa, &value[4]);
+
+		context->prim.range.start = 0x0001;
+		context->prim.range.end = 0x000f;
+		strcpy(context->prim.uuid,
+					"0000aaaa-0000-1000-8000-00805f9b34fb");
 	} else if (start == 0x0010 && end == 0xffff) {
 		att_put_u16(0x0010, &value[0]);
 		att_put_u16(0x001f, &value[2]);
 		att_put_u16(0xbbbb, &value[4]);
+
+		context->prim.range.start = 0x0010;
+		context->prim.range.end = 0x001f;
+		strcpy(context->prim.uuid,
+					"0000bbbb-0000-1000-8000-00805f9b34fb");
 	} else {
 		/* Signal end of attribute group (primary service) */
 		pdu_len = enc_error_resp(ipdu[0], start,
 						ATT_ECODE_ATTR_NOT_FOUND,
 						pdu, sizeof(pdu));
 		g_assert(pdu_len == 5);
+
+		memset(&context->prim, 0, sizeof(context->prim));
+
 		goto done;
 	}
 
@@ -190,6 +204,7 @@ done:
 static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
+	struct context *context = user_data;
 	uint8_t opcode;
 	ssize_t len;
 	int fd;
@@ -208,7 +223,7 @@ static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 	case ATT_OP_MTU_REQ:
 		return handle_mtu_exchange(fd);
 	case ATT_OP_READ_BY_GROUP_REQ:
-		return handle_read_by_group(fd);
+		return handle_read_by_group(fd, context);
 	}
 
 	return handle_not_supported(fd);
@@ -288,22 +303,18 @@ static bool discover_primary_cb(GSList *services, uint8_t status,
 	struct context *context = user_data;
 	struct gatt_primary *prim;
 
+	if (status == ATT_ECODE_ATTR_NOT_FOUND) {
+		g_main_loop_quit(context->main_loop);
+		return false;
+	}
+
 	g_assert_cmpuint(status, ==, 0);
-	g_assert_cmpuint(g_slist_length(services), ==, 2);
+	g_assert_cmpuint(g_slist_length(services), ==, 1);
 
 	prim = g_slist_nth_data(services, 0);
-	g_assert(prim->range.start == 0x0001 && prim->range.end == 0x000f);
-	g_assert(bt_uuid_strcmp(&prim->uuid,
-				"0000aaaa-0000-1000-8000-00805f9b34fb") == 0);
-
-	prim = g_slist_nth_data(services, 1);
-	g_assert(prim->range.start == 0x0010 && prim->range.end == 0x001f);
-	g_assert(bt_uuid_strcmp(&prim->uuid,
-				"0000bbbb-0000-1000-8000-00805f9b34fb") == 0);
-
-	g_main_loop_quit(context->main_loop);
+	g_assert(memcmp(prim, &context->prim, sizeof(context->prim)) == 0);
 
-	return false;
+	return true;
 }
 
 static void test_gatt_discover_primary(void)
-- 
1.7.9.5

