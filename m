Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 05/26] attrib: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:35 -0300
Message-Id: <1368073016-28434-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate and prefer this one over
stdint.h.
---
 attrib/att.c         |   2 +-
 attrib/gatt.c        | 124 ++++++++++++++++++++++++++-------------------------
 attrib/gatt.h        |  33 +++++++-------
 attrib/gattrib.c     |  51 ++++++++++-----------
 attrib/gattrib.h     |  21 +++++----
 attrib/gatttool.c    |  19 ++++----
 attrib/interactive.c |  35 ++++++++-------
 7 files changed, 148 insertions(+), 137 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index d2b78bd..e196fa3 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -27,7 +27,7 @@
 #endif
 
 #include <errno.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdlib.h>
 
 #include <bluetooth/bluetooth.h>
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 0f116e8..3dacf9e 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -26,7 +26,7 @@
 #include <config.h>
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdlib.h>
 #include <glib.h>
 #include <bluetooth/sdp.h>
@@ -107,11 +107,11 @@ static void discover_char_free(struct discover_char *dc)
 	g_free(dc);
 }
 
-static guint16 encode_discover_primary(uint16_t start, uint16_t end,
+static uint16_t encode_discover_primary(uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, uint8_t *pdu, size_t len)
 {
 	bt_uuid_t prim;
-	guint16 plen;
+	uint16_t plen;
 
 	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
 
@@ -143,15 +143,15 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 	return plen;
 }
 
-static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
-					guint16 iplen, gpointer user_data)
+static void primary_by_uuid_cb(uint8_t status, const uint8_t *ipdu,
+					uint16_t iplen, gpointer user_data)
 
 {
 	struct discover_primary *dp = user_data;
 	GSList *ranges, *last;
 	struct att_range *range;
 	uint8_t *buf;
-	guint16 oplen;
+	uint16_t oplen;
 	int err = 0;
 	size_t buflen;
 
@@ -187,7 +187,7 @@ done:
 	discover_primary_free(dp);
 }
 
-static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
+static void primary_all_cb(uint8_t status, const uint8_t *ipdu, uint16_t iplen,
 							gpointer user_data)
 {
 	struct discover_primary *dp = user_data;
@@ -242,7 +242,7 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	if (end != 0xffff) {
 		size_t buflen;
 		uint8_t *buf = g_attrib_get_buffer(dp->attrib, &buflen);
-		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
+		uint16_t oplen = encode_discover_primary(end + 1, 0xffff, NULL,
 								buf, buflen);
 
 		g_attrib_send(dp->attrib, 0, buf, oplen, primary_all_cb,
@@ -256,14 +256,14 @@ done:
 	discover_primary_free(dp);
 }
 
-guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
-							gpointer user_data)
+unsigned int gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid,
+					gatt_cb_t func, gpointer user_data)
 {
 	struct discover_primary *dp;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	GAttribResultFunc cb;
-	guint16 plen;
+	uint16_t plen;
 
 	plen = encode_discover_primary(0x0001, 0xffff, uuid, buf, buflen);
 	if (plen == 0)
@@ -322,13 +322,13 @@ done:
 	g_free(query);
 }
 
-static guint resolve_included_uuid(struct included_discovery *isd,
+static unsigned int resolve_included_uuid(struct included_discovery *isd,
 					struct gatt_included *incl)
 {
 	struct included_uuid_query *query;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(isd->attrib, &buflen);
-	guint16 oplen = enc_read_req(incl->range.start, buf, buflen);
+	uint16_t oplen = enc_read_req(incl->range.start, buf, buflen);
 
 	query = g_new0(struct included_uuid_query, 1);
 	query->isd = isd_ref(isd);
@@ -360,12 +360,13 @@ static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
 static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data);
 
-static guint find_included(struct included_discovery *isd, uint16_t start)
+static unsigned int find_included(struct included_discovery *isd,
+							uint16_t start)
 {
 	bt_uuid_t uuid;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(isd->attrib, &buflen);
-	guint16 oplen;
+	uint16_t oplen;
 
 	bt_uuid16_create(&uuid, GATT_INCLUDE_UUID);
 	oplen = enc_read_by_type_req(start, isd->end_handle, &uuid,
@@ -443,15 +444,15 @@ unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
 	return find_included(isd, start);
 }
 
-static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
-							gpointer user_data)
+static void char_discovered_cb(uint8_t status, const uint8_t *ipdu,
+					uint16_t iplen, gpointer user_data)
 {
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
 	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
 	size_t buflen;
 	uint8_t *buf;
-	guint16 oplen;
+	uint16_t oplen;
 	bt_uuid_t uuid;
 	uint16_t last = 0;
 
@@ -522,7 +523,7 @@ done:
 	discover_char_free(dc);
 }
 
-guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
+unsigned int gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 						bt_uuid_t *uuid, gatt_cb_t func,
 						gpointer user_data)
 {
@@ -530,7 +531,7 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
 	struct discover_char *dc;
 	bt_uuid_t type_uuid;
-	guint16 plen;
+	uint16_t plen;
 
 	bt_uuid16_create(&type_uuid, GATT_CHARAC_UUID);
 
@@ -552,13 +553,14 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 								dc, NULL);
 }
 
-guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-					bt_uuid_t *uuid, GAttribResultFunc func,
+unsigned int gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start,
+					uint16_t end, bt_uuid_t *uuid,
+					GAttribResultFunc func,
 					gpointer user_data)
 {
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(attrib, &buflen);
-	guint16 plen;
+	uint16_t plen;
 
 	plen = enc_read_by_type_req(start, end, uuid, buf, buflen);
 	if (plen == 0)
@@ -571,10 +573,10 @@ struct read_long_data {
 	GAttrib *attrib;
 	GAttribResultFunc func;
 	gpointer user_data;
-	guint8 *buffer;
-	guint16 size;
-	guint16 handle;
-	guint id;
+	uint8_t *buffer;
+	uint16_t size;
+	uint16_t handle;
+	unsigned int id;
 	int ref;
 };
 
@@ -591,15 +593,15 @@ static void read_long_destroy(gpointer user_data)
 	g_free(long_read);
 }
 
-static void read_blob_helper(guint8 status, const guint8 *rpdu, guint16 rlen,
+static void read_blob_helper(uint8_t status, const uint8_t *rpdu, uint16_t rlen,
 							gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
 	uint8_t *buf;
 	size_t buflen;
-	guint8 *tmp;
-	guint16 plen;
-	guint id;
+	uint8_t *tmp;
+	uint16_t plen;
+	unsigned int id;
 
 	if (status != 0 || rlen == 1) {
 		status = 0;
@@ -638,14 +640,14 @@ done:
 							long_read->user_data);
 }
 
-static void read_char_helper(guint8 status, const guint8 *rpdu,
-					guint16 rlen, gpointer user_data)
+static void read_char_helper(uint8_t status, const uint8_t *rpdu,
+					uint16_t rlen, gpointer user_data)
 {
 	struct read_long_data *long_read = user_data;
 	size_t buflen;
 	uint8_t *buf = g_attrib_get_buffer(long_read->attrib, &buflen);
-	guint16 plen;
-	guint id;
+	uint16_t plen;
+	unsigned int id;
 
 	if (status != 0 || rlen < buflen)
 		goto done;
@@ -674,13 +676,13 @@ done:
 	long_read->func(status, rpdu, rlen, long_read->user_data);
 }
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data)
+unsigned int gatt_read_char(GAttrib *attrib, uint16_t handle,
+				GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
-	guint id;
+	uint16_t plen;
+	unsigned int id;
 	struct read_long_data *long_read;
 
 	long_read = g_try_new0(struct read_long_data, 1);
@@ -711,18 +713,18 @@ struct write_long_data {
 	GAttrib *attrib;
 	GAttribResultFunc func;
 	gpointer user_data;
-	guint16 handle;
+	uint16_t handle;
 	uint16_t offset;
 	uint8_t *value;
 	size_t vlen;
 };
 
-static guint execute_write(GAttrib *attrib, uint8_t flags,
+static unsigned int execute_write(GAttrib *attrib, uint8_t flags,
 				GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_exec_write_req(flags, buf, buflen);
@@ -732,12 +734,12 @@ static guint execute_write(GAttrib *attrib, uint8_t flags,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
-			uint8_t *value, size_t vlen, GAttribResultFunc func,
-			gpointer user_data);
+static unsigned int prepare_write(GAttrib *attrib, uint16_t handle,
+				uint16_t offset, uint8_t *value, size_t vlen,
+				GAttribResultFunc func, gpointer user_data);
 
-static void prepare_write_cb(guint8 status, const guint8 *rpdu,
-					guint16 rlen, gpointer user_data)
+static void prepare_write_cb(uint8_t status, const uint8_t *rpdu,
+					uint16_t rlen, gpointer user_data)
 {
 	struct write_long_data *long_write = user_data;
 
@@ -763,11 +765,11 @@ static void prepare_write_cb(guint8 status, const guint8 *rpdu,
 		long_write->func, long_write);
 }
 
-static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
-			uint8_t *value, size_t vlen, GAttribResultFunc func,
-			gpointer user_data)
+static unsigned int prepare_write(GAttrib *attrib, uint16_t handle,
+				uint16_t offset, uint8_t *value, size_t vlen,
+				GAttribResultFunc func, gpointer user_data)
 {
-	guint16 plen;
+	uint16_t plen;
 	size_t buflen;
 	uint8_t *buf;
 
@@ -782,12 +784,12 @@ static guint prepare_write(GAttrib *attrib, uint16_t handle, uint16_t offset,
 							user_data, NULL);
 }
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+unsigned int gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 			size_t vlen, GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 	struct write_long_data *long_write;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
@@ -822,24 +824,24 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 							func, long_write);
 }
 
-guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
-							gpointer user_data)
+unsigned int gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
+				GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_mtu_req(mtu, buf, buflen);
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+unsigned int gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_find_info_req(start, end, buf, buflen);
@@ -849,12 +851,12 @@ guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
 }
 
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data)
+unsigned int gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value,
+			int vlen, GDestroyNotify notify, gpointer user_data)
 {
 	uint8_t *buf;
 	size_t buflen;
-	guint16 plen;
+	uint16_t plen;
 
 	buf = g_attrib_get_buffer(attrib, &buflen);
 	plen = enc_write_cmd(handle, value, vlen, buf, buflen);
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 305b4c6..d5758b7 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -22,6 +22,7 @@
  *
  */
 
+#include <inttypes.h>
 #include <bluetooth/sdp.h>
 
 /* GATT Profile Attribute types */
@@ -53,7 +54,7 @@
 #define GATT_CLIENT_CHARAC_CFG_NOTIF_BIT	0x0001
 #define GATT_CLIENT_CHARAC_CFG_IND_BIT		0x0002
 
-typedef void (*gatt_cb_t) (GSList *l, guint8 status, gpointer user_data);
+typedef void (*gatt_cb_t) (GSList *l, uint8_t status, gpointer user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
@@ -74,35 +75,37 @@ struct gatt_char {
 	uint16_t value_handle;
 };
 
-guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
-							gpointer user_data);
+unsigned int gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid,
+					gatt_cb_t func, gpointer user_data);
 
 unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
 					gatt_cb_t func, gpointer user_data);
 
-guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
+unsigned int gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					bt_uuid_t *uuid, gatt_cb_t func,
 					gpointer user_data);
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data);
+unsigned int gatt_read_char(GAttrib *attrib, uint16_t handle,
+				GAttribResultFunc func, gpointer user_data);
 
-guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
+unsigned int gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 					size_t vlen, GAttribResultFunc func,
 					gpointer user_data);
 
-guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
+unsigned int gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
 
-guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
-				GDestroyNotify notify, gpointer user_data);
+unsigned int gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value,
+					int vlen, GDestroyNotify notify,
+					gpointer user_data);
 
-guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
-				bt_uuid_t *uuid, GAttribResultFunc func,
-				gpointer user_data);
+unsigned int gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start,
+					uint16_t end, bt_uuid_t *uuid,
+					GAttribResultFunc func,
+					gpointer user_data);
 
-guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
-							gpointer user_data);
+unsigned int gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
+				GAttribResultFunc func, gpointer user_data);
 
 gboolean gatt_parse_record(const sdp_record_t *rec,
 					uuid_t *prim_uuid, uint16_t *psm,
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index c662ace..ad4efe1 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -26,7 +26,7 @@
 #include "config.h"
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdbool.h>
 #include <string.h>
 #include <glib.h>
@@ -48,24 +48,24 @@ struct _GAttrib {
 	int refs;
 	uint8_t *buf;
 	size_t buflen;
-	guint read_watch;
-	guint write_watch;
-	guint timeout_watch;
+	unsigned int read_watch;
+	unsigned int write_watch;
+	unsigned int timeout_watch;
 	GQueue *requests;
 	GQueue *responses;
 	GSList *events;
-	guint next_cmd_id;
+	unsigned int next_cmd_id;
 	GDestroyNotify destroy;
 	gpointer destroy_user_data;
 	bool stale;
 };
 
 struct command {
-	guint id;
-	guint8 opcode;
-	guint8 *pdu;
-	guint16 len;
-	guint8 expected;
+	unsigned int id;
+	uint8_t opcode;
+	uint8_t *pdu;
+	uint16_t len;
+	uint8_t expected;
 	bool sent;
 	GAttribResultFunc func;
 	gpointer user_data;
@@ -73,15 +73,15 @@ struct command {
 };
 
 struct event {
-	guint id;
-	guint8 expected;
-	guint16 handle;
+	unsigned int id;
+	uint8_t expected;
+	uint16_t handle;
 	GAttribNotifyFunc func;
 	gpointer user_data;
 	GDestroyNotify notify;
 };
 
-static guint8 opcode2expected(guint8 opcode)
+static uint8_t opcode2expected(uint8_t opcode)
 {
 	switch (opcode) {
 	case ATT_OP_MTU_REQ:
@@ -124,7 +124,7 @@ static guint8 opcode2expected(guint8 opcode)
 	return 0;
 }
 
-static bool is_response(guint8 opcode)
+static bool is_response(uint8_t opcode)
 {
 	switch (opcode) {
 	case ATT_OP_ERROR:
@@ -367,7 +367,7 @@ static void wake_up_sender(struct _GAttrib *attrib)
 
 static bool match_event(struct event *evt, const uint8_t *pdu, gsize len)
 {
-	guint16 handle;
+	uint16_t handle;
 
 	if (evt->expected == GATTRIB_ALL_EVENTS)
 		return true;
@@ -502,9 +502,10 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	return g_attrib_ref(attrib);
 }
 
-guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
-			GAttribResultFunc func, gpointer user_data,
-			GDestroyNotify notify)
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id,
+				const uint8_t *pdu, uint16_t len,
+				GAttribResultFunc func, gpointer user_data,
+				GDestroyNotify notify)
 {
 	struct command *c;
 	GQueue *queue;
@@ -559,12 +560,12 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 static int command_cmp_by_id(gconstpointer a, gconstpointer b)
 {
 	const struct command *cmd = a;
-	guint id = GPOINTER_TO_UINT(b);
+	unsigned int id = GPOINTER_TO_UINT(b);
 
 	return cmd->id - id;
 }
 
-gboolean g_attrib_cancel(GAttrib *attrib, guint id)
+gboolean g_attrib_cancel(GAttrib *attrib, unsigned int id)
 {
 	GList *l = NULL;
 	struct command *cmd;
@@ -669,11 +670,11 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 	return TRUE;
 }
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
+unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
 {
-	static guint next_evt_id = 0;
+	static unsigned int next_evt_id = 0;
 	struct event *event;
 
 	event = g_try_new0(struct event, 1);
@@ -695,7 +696,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 static int event_cmp_by_id(gconstpointer a, gconstpointer b)
 {
 	const struct event *evt = a;
-	guint id = GPOINTER_TO_UINT(b);
+	unsigned int id = GPOINTER_TO_UINT(b);
 
 	return evt->id - id;
 }
@@ -712,7 +713,7 @@ gboolean g_attrib_is_encrypted(GAttrib *attrib)
 	return sec_level > BT_IO_SEC_LOW;
 }
 
-gboolean g_attrib_unregister(GAttrib *attrib, guint id)
+gboolean g_attrib_unregister(GAttrib *attrib, unsigned int id)
 {
 	struct event *evt;
 	GSList *l;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 3fe92c7..a1f2dd8 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -28,6 +28,8 @@
 extern "C" {
 #endif
 
+#include <inttypes.h>
+
 #define GATTRIB_ALL_EVENTS 0xFF
 #define GATTRIB_ALL_REQS 0xFE
 #define GATTRIB_ALL_HANDLES 0x0000
@@ -35,11 +37,11 @@ extern "C" {
 struct _GAttrib;
 typedef struct _GAttrib GAttrib;
 
-typedef void (*GAttribResultFunc) (guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data);
+typedef void (*GAttribResultFunc) (uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data);
 typedef void (*GAttribDisconnectFunc)(gpointer user_data);
 typedef void (*GAttribDebugFunc)(const char *str, gpointer user_data);
-typedef void (*GAttribNotifyFunc)(const guint8 *pdu, guint16 len,
+typedef void (*GAttribNotifyFunc)(const uint8_t *pdu, uint16_t len,
 							gpointer user_data);
 
 GAttrib *g_attrib_new(GIOChannel *io);
@@ -51,17 +53,18 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 		GDestroyNotify destroy, gpointer user_data);
 
-guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
-			GAttribResultFunc func, gpointer user_data,
-			GDestroyNotify notify);
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id,
+				const uint8_t *pdu, uint16_t len,
+				GAttribResultFunc func, gpointer user_data,
+				GDestroyNotify notify);
 
-gboolean g_attrib_cancel(GAttrib *attrib, guint id);
+gboolean g_attrib_cancel(GAttrib *attrib, unsigned int id);
 gboolean g_attrib_cancel_all(GAttrib *attrib);
 
 gboolean g_attrib_set_debug(GAttrib *attrib,
 		GAttribDebugFunc func, gpointer user_data);
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
+unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify);
 
@@ -70,7 +73,7 @@ gboolean g_attrib_is_encrypted(GAttrib *attrib);
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
 
-gboolean g_attrib_unregister(GAttrib *attrib, guint id);
+gboolean g_attrib_unregister(GAttrib *attrib, unsigned int id);
 gboolean g_attrib_unregister_all(GAttrib *attrib);
 
 #ifdef __cplusplus
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 2c11562..9ecd628 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <glib.h>
 #include <stdlib.h>
@@ -137,7 +138,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	operation(attrib);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_all_cb(GSList *services, uint8_t status, gpointer user_data)
 {
 	GSList *l;
 
@@ -157,7 +158,7 @@ done:
 	g_main_loop_quit(event_loop);
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
+static void primary_by_uuid_cb(GSList *ranges, uint8_t status,
 							gpointer user_data)
 {
 	GSList *l;
@@ -191,7 +192,7 @@ static gboolean primary(gpointer user_data)
 	return FALSE;
 }
 
-static void char_discovered_cb(GSList *characteristics, guint8 status,
+static void char_discovered_cb(GSList *characteristics, uint8_t status,
 							gpointer user_data)
 {
 	GSList *l;
@@ -224,7 +225,7 @@ static gboolean characteristics(gpointer user_data)
 	return FALSE;
 }
 
-static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_read_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	uint8_t value[plen];
@@ -252,8 +253,8 @@ done:
 		g_main_loop_quit(event_loop);
 }
 
-static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void char_read_by_uuid_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
@@ -361,7 +362,7 @@ error:
 	return FALSE;
 }
 
-static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_write_req_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	if (status != 0) {
@@ -414,11 +415,11 @@ error:
 	return FALSE;
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_desc_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	struct att_data_list *list;
-	guint8 format;
+	uint8_t format;
 	int i;
 
 	if (status != 0) {
diff --git a/attrib/interactive.c b/attrib/interactive.c
index f28dc22..12f1506 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -25,6 +25,7 @@
 #include "config.h"
 #endif
 
+#include <inttypes.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -187,7 +188,7 @@ static void disconnect_io()
 	set_state(STATE_DISCONNECTED);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_all_cb(GSList *services, uint8_t status, gpointer user_data)
 {
 	GSList *l;
 
@@ -209,7 +210,7 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	}
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
+static void primary_by_uuid_cb(GSList *ranges, uint8_t status,
 							gpointer user_data)
 {
 	GSList *l;
@@ -232,7 +233,7 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	}
 }
 
-static void included_cb(GSList *includes, guint8 status, gpointer user_data)
+static void included_cb(GSList *includes, uint8_t status, gpointer user_data)
 {
 	GSList *l;
 
@@ -256,7 +257,7 @@ static void included_cb(GSList *includes, guint8 status, gpointer user_data)
 	}
 }
 
-static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
+static void char_cb(GSList *characteristics, uint8_t status, gpointer user_data)
 {
 	GSList *l;
 
@@ -276,11 +277,11 @@ static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 	}
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_desc_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	struct att_data_list *list;
-	guint8 format;
+	uint8_t format;
 	uint16_t handle = 0xffff;
 	int i;
 
@@ -317,7 +318,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		gatt_find_info(attrib, handle + 1, end, char_desc_cb, NULL);
 }
 
-static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_read_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	uint8_t value[plen];
@@ -345,8 +346,8 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	g_string_free(s, TRUE);
 }
 
-static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void char_read_by_uuid_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
@@ -648,7 +649,7 @@ static void cmd_read_uuid(int argcp, char **argvp)
 					char_read_by_uuid_cb, char_data);
 }
 
-static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void char_write_req_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	if (status != 0) {
@@ -743,7 +744,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 	}
 }
 
-static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+static void exchange_mtu_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
 							gpointer user_data)
 {
 	uint16_t mtu;
@@ -924,10 +925,10 @@ static char **commands_completion(const char *text, int start, int end)
 		return NULL;
 }
 
-static guint setup_standard_input(void)
+static unsigned int setup_standard_input(void)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 
 	channel = g_io_channel_unix_new(fileno(stdin));
 
@@ -980,10 +981,10 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
 	return TRUE;
 }
 
-static guint setup_signalfd(void)
+static unsigned int setup_signalfd(void)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 	sigset_t mask;
 	int fd;
 
@@ -1020,8 +1021,8 @@ static guint setup_signalfd(void)
 int interactive(const char *src, const char *dst,
 		const char *dst_type, int psm)
 {
-	guint input;
-	guint signal;
+	unsigned int input;
+	unsigned int signal;
 
 	opt_sec_level = g_strdup("low");
 
-- 
1.8.2.2

