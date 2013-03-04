Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 6/6] attrib: removing gboolean usage when possible
Date: Mon,  4 Mar 2013 16:58:50 -0400
Message-Id: <1362430730-19580-7-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt-service.c | 26 +++++++-------
 attrib/gatt-service.h |  2 +-
 attrib/gatt.c         | 20 +++++------
 attrib/gatt.h         |  7 ++--
 attrib/gattrib.c      | 96 +++++++++++++++++++++++++--------------------------
 attrib/gattrib.h      | 16 ++++-----
 attrib/gatttool.c     | 37 ++++++++++----------
 attrib/interactive.c  |  1 +
 attrib/utils.c        |  1 +
 9 files changed, 104 insertions(+), 102 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 6f5de22..905d697 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -176,8 +176,8 @@ static int find_callback(const void *a, const void *b)
 	return cb->event - event;
 }
 
-static gboolean add_characteristic(struct btd_adapter *adapter,
-				uint16_t *handle, struct gatt_info *info)
+static bool add_characteristic(struct btd_adapter *adapter, uint16_t *handle,
+							struct gatt_info *info)
 {
 	int read_req, write_req;
 	uint16_t h = *handle;
@@ -188,7 +188,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 
 	if (!info->uuid.value.u16 || !info->props) {
 		error("Characteristic UUID or properties are missing");
-		return FALSE;
+		return false;
 	}
 
 	read_req = att_read_req(info->authorization, info->authentication,
@@ -204,7 +204,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 		if (!g_slist_find_custom(info->callbacks, reqs,
 							find_callback)) {
 			error("Callback for read required");
-			return FALSE;
+			return false;
 		}
 	}
 
@@ -214,7 +214,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 		if (!g_slist_find_custom(info->callbacks, reqs,
 							find_callback)) {
 			error("Callback for write required");
-			return FALSE;
+			return false;
 		}
 	}
 
@@ -225,13 +225,13 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	att_put_u16(info->uuid.value.u16, &atval[3]);
 	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
 						atval, sizeof(atval)) == NULL)
-		return FALSE;
+		return false;
 
 	/* characteristic value */
 	a = attrib_db_add(adapter, h++, &info->uuid, read_req, write_req,
 								NULL, 0);
 	if (a == NULL)
-		return FALSE;
+		return false;
 
 	for (l = info->callbacks; l != NULL; l = l->next) {
 		struct attrib_cb *cb = l->data;
@@ -261,7 +261,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 		a = attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE,
 				ATT_AUTHENTICATION, cfg_val, sizeof(cfg_val));
 		if (a == NULL)
-			return FALSE;
+			return false;
 
 		if (info->ccc_handle != NULL)
 			*info->ccc_handle = a->handle;
@@ -269,7 +269,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 
 	*handle = h;
 
-	return TRUE;
+	return true;
 }
 
 static void free_gatt_info(void *data)
@@ -290,7 +290,7 @@ static void service_attr_del(struct btd_adapter *adapter, uint16_t start_handle,
 			error("Can't delete handle 0x%04x", handle);
 }
 
-gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
+bool gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 				bt_uuid_t *svc_uuid, gatt_option opt1, ...)
 {
 	char uuidstr[MAX_LEN_UUID_STR];
@@ -303,7 +303,7 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 
 	if (svc_uuid->type != BT_UUID16 && svc_uuid->type != BT_UUID128) {
 		error("Invalid service uuid: %s", uuidstr);
-		return FALSE;
+		return false;
 	}
 
 	va_start(args, opt1);
@@ -344,9 +344,9 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 	g_assert(h - start_handle == (uint16_t) size);
 	g_slist_free_full(chrs, free_gatt_info);
 
-	return TRUE;
+	return true;
 
 fail:
 	g_slist_free_full(chrs, free_gatt_info);
-	return FALSE;
+	return false;
 }
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index b810e2e..ad3469d 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -47,5 +47,5 @@ typedef enum {
 	ATTRIB_WRITE,
 } attrib_event_t;
 
-gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
+bool gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 					bt_uuid_t *svc_uuid, gatt_option opt1, ...);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 3f1a469..8b05c43 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -28,6 +28,7 @@
 
 #include <stdint.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <glib.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
@@ -884,7 +885,7 @@ static sdp_data_t *proto_seq_find(sdp_list_t *proto_list)
 	return NULL;
 }
 
-static gboolean parse_proto_params(sdp_list_t *proto_list, uint16_t *psm,
+static bool parse_proto_params(sdp_list_t *proto_list, uint16_t *psm,
 						uint16_t *start, uint16_t *end)
 {
 	sdp_data_t *seq1, *seq2;
@@ -895,11 +896,11 @@ static gboolean parse_proto_params(sdp_list_t *proto_list, uint16_t *psm,
 	/* Getting start and end handle */
 	seq1 = proto_seq_find(proto_list);
 	if (!seq1 || seq1->dtd != SDP_UINT16)
-		return FALSE;
+		return false;
 
 	seq2 = seq1->next;
 	if (!seq2 || seq2->dtd != SDP_UINT16)
-		return FALSE;
+		return false;
 
 	if (start)
 		*start = seq1->val.uint16;
@@ -907,25 +908,24 @@ static gboolean parse_proto_params(sdp_list_t *proto_list, uint16_t *psm,
 	if (end)
 		*end = seq2->val.uint16;
 
-	return TRUE;
+	return true;
 }
 
-gboolean gatt_parse_record(const sdp_record_t *rec,
-					uuid_t *prim_uuid, uint16_t *psm,
-					uint16_t *start, uint16_t *end)
+bool gatt_parse_record(const sdp_record_t *rec, uuid_t *prim_uuid,
+				uint16_t *psm, uint16_t *start, uint16_t *end)
 {
 	sdp_list_t *list;
 	uuid_t uuid;
-	gboolean ret;
+	bool ret;
 
 	if (sdp_get_service_classes(rec, &list) < 0)
-		return FALSE;
+		return false;
 
 	memcpy(&uuid, list->data, sizeof(uuid));
 	sdp_list_free(list, free);
 
 	if (sdp_get_access_protos(rec, &list) < 0)
-		return FALSE;
+		return false;
 
 	ret = parse_proto_params(list, psm, start, end);
 
diff --git a/attrib/gatt.h b/attrib/gatt.h
index be38400..88a5cca 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -57,7 +57,7 @@ typedef void (*gatt_cb_t) (GSList *l, uint8_t status, void *user_data);
 
 struct gatt_primary {
 	char uuid[MAX_LEN_UUID_STR + 1];
-	gboolean changed;
+	bool changed;
 	struct att_range range;
 };
 
@@ -105,6 +105,5 @@ unsigned int gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start,
 unsigned int gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu,
 				GAttribResultFunc func, void *user_data);
 
-gboolean gatt_parse_record(const sdp_record_t *rec,
-					uuid_t *prim_uuid, uint16_t *psm,
-					uint16_t *start, uint16_t *end);
+bool gatt_parse_record(const sdp_record_t *rec, uuid_t *prim_uuid,
+				uint16_t *psm, uint16_t *start, uint16_t *end);
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 33df293..8307bb8 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -31,6 +31,7 @@
 #include <glib.h>
 
 #include <stdio.h>
+#include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
 #include <btio/btio.h>
@@ -56,7 +57,7 @@ struct _GAttrib {
 	unsigned int next_cmd_id;
 	GDestroyNotify destroy;
 	void *destroy_user_data;
-	gboolean stale;
+	bool stale;
 };
 
 struct command {
@@ -65,7 +66,7 @@ struct command {
 	uint8_t *pdu;
 	uint16_t len;
 	uint8_t expected;
-	gboolean sent;
+	bool sent;
 	GAttribResultFunc func;
 	void *user_data;
 	GDestroyNotify notify;
@@ -123,7 +124,7 @@ static uint8_t opcode2expected(uint8_t opcode)
 	return 0;
 }
 
-static gboolean is_response(uint8_t opcode)
+static bool is_response(uint8_t opcode)
 {
 	switch (opcode) {
 	case ATT_OP_ERROR:
@@ -139,10 +140,10 @@ static gboolean is_response(uint8_t opcode)
 	case ATT_OP_PREP_WRITE_RESP:
 	case ATT_OP_EXEC_WRITE_RESP:
 	case ATT_OP_HANDLE_CNF:
-		return TRUE;
+		return true;
 	}
 
-	return FALSE;
+	return false;
 }
 
 GAttrib *g_attrib_ref(GAttrib *attrib)
@@ -219,7 +220,7 @@ static void attrib_destroy(GAttrib *attrib)
 
 void g_attrib_unref(GAttrib *attrib)
 {
-	gboolean ret;
+	bool ret;
 
 	if (!attrib)
 		return;
@@ -242,16 +243,16 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib)
 	return attrib->io;
 }
 
-gboolean g_attrib_set_destroy_function(GAttrib *attrib,
-					GDestroyNotify destroy, void *user_data)
+bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
+								void *user_data)
 {
 	if (attrib == NULL)
-		return FALSE;
+		return false;
 
 	attrib->destroy = destroy;
 	attrib->destroy_user_data = user_data;
 
-	return TRUE;
+	return true;
 }
 
 static gboolean disconnect_timeout(void *data)
@@ -277,7 +278,7 @@ static gboolean disconnect_timeout(void *data)
 	}
 
 done:
-	attrib->stale = TRUE;
+	attrib->stale = true;
 
 	g_attrib_unref(attrib);
 
@@ -333,7 +334,7 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond, void *data)
 		return TRUE;
 	}
 
-	cmd->sent = TRUE;
+	cmd->sent = true;
 
 	if (attrib->timeout_watch == 0)
 		attrib->timeout_watch = g_timeout_add_seconds(GATT_TIMEOUT,
@@ -361,28 +362,28 @@ static void wake_up_sender(struct _GAttrib *attrib)
 				can_write_data, attrib, destroy_sender);
 }
 
-static gboolean match_event(struct event *evt, const uint8_t *pdu, size_t len)
+static bool match_event(struct event *evt, const uint8_t *pdu, size_t len)
 {
 	uint16_t handle;
 
 	if (evt->expected == GATTRIB_ALL_EVENTS)
-		return TRUE;
+		return true;
 
 	if (!is_response(pdu[0]) && evt->expected == GATTRIB_ALL_REQS)
-		return TRUE;
+		return true;
 
 	if (evt->expected == pdu[0] && evt->handle == GATTRIB_ALL_HANDLES)
-		return TRUE;
+		return true;
 
 	if (len < 3)
-		return FALSE;
+		return false;
 
 	handle = att_get_u16(&pdu[1]);
 
 	if (evt->expected == pdu[0] && evt->handle == handle)
-		return TRUE;
+		return true;
 
-	return FALSE;
+	return false;
 }
 
 static gboolean received_data(GIOChannel *io, GIOCondition cond, void *data)
@@ -393,7 +394,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, void *data)
 	uint8_t buf[512], status;
 	size_t len;
 	GIOStatus iostat;
-	gboolean norequests, noresponses;
+	bool norequests, noresponses;
 
 	if (attrib->stale)
 		return FALSE;
@@ -565,14 +566,14 @@ static int command_cmp_by_id(const void *a, const void *b)
 	return cmd->id - id;
 }
 
-gboolean g_attrib_cancel(GAttrib *attrib, unsigned int id)
+bool g_attrib_cancel(GAttrib *attrib, unsigned int id)
 {
 	GList *l = NULL;
 	struct command *cmd;
 	GQueue *queue;
 
 	if (attrib == NULL)
-		return FALSE;
+		return false;
 
 	queue = attrib->requests;
 	if (queue)
@@ -581,13 +582,13 @@ gboolean g_attrib_cancel(GAttrib *attrib, unsigned int id)
 	if (l == NULL) {
 		queue = attrib->responses;
 		if (!queue)
-			return FALSE;
+			return false;
 		l = g_queue_find_custom(queue, GUINT_TO_POINTER(id),
 					command_cmp_by_id);
 	}
 
 	if (l == NULL)
-		return FALSE;
+		return false;
 
 	cmd = l->data;
 
@@ -598,16 +599,16 @@ gboolean g_attrib_cancel(GAttrib *attrib, unsigned int id)
 		command_destroy(cmd);
 	}
 
-	return TRUE;
+	return true;
 }
 
-static gboolean cancel_all_per_queue(GQueue *queue)
+static bool cancel_all_per_queue(GQueue *queue)
 {
 	struct command *c, *head = NULL;
-	gboolean first = TRUE;
+	bool first = true;
 
 	if (queue == NULL)
-		return FALSE;
+		return false;
 
 	while ((c = g_queue_pop_head(queue))) {
 		if (first && c->sent) {
@@ -617,7 +618,7 @@ static gboolean cancel_all_per_queue(GQueue *queue)
 			continue;
 		}
 
-		first = FALSE;
+		first = false;
 		command_destroy(c);
 	}
 
@@ -626,15 +627,15 @@ static gboolean cancel_all_per_queue(GQueue *queue)
 		g_queue_push_head(queue, head);
 	}
 
-	return TRUE;
+	return true;
 }
 
-gboolean g_attrib_cancel_all(GAttrib *attrib)
+bool g_attrib_cancel_all(GAttrib *attrib)
 {
-	gboolean ret;
+	bool ret;
 
 	if (attrib == NULL)
-		return FALSE;
+		return false;
 
 	ret = cancel_all_per_queue(attrib->requests);
 	ret = cancel_all_per_queue(attrib->responses) && ret;
@@ -642,10 +643,9 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 	return ret;
 }
 
-gboolean g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
-								void *user_data)
+bool g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func, void *user_data)
 {
-	return TRUE;
+	return true;
 }
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
@@ -658,16 +658,16 @@ uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 	return attrib->buf;
 }
 
-gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
+bool g_attrib_set_mtu(GAttrib *attrib, int mtu)
 {
 	if (mtu < ATT_DEFAULT_LE_MTU)
-		return FALSE;
+		return false;
 
 	attrib->buf = g_realloc(attrib->buf, mtu);
 
 	attrib->buflen = mtu;
 
-	return TRUE;
+	return true;
 }
 
 unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
@@ -701,32 +701,32 @@ static int event_cmp_by_id(const void *a, const void *b)
 	return evt->id - id;
 }
 
-gboolean g_attrib_is_encrypted(GAttrib *attrib)
+bool g_attrib_is_encrypted(GAttrib *attrib)
 {
 	BtIOSecLevel sec_level;
 
 	if (!bt_io_get(attrib->io, NULL,
 			BT_IO_OPT_SEC_LEVEL, &sec_level,
 			BT_IO_OPT_INVALID))
-		return FALSE;
+		return false;
 
 	return sec_level > BT_IO_SEC_LOW;
 }
 
-gboolean g_attrib_unregister(GAttrib *attrib, unsigned int id)
+bool g_attrib_unregister(GAttrib *attrib, unsigned int id)
 {
 	struct event *evt;
 	GSList *l;
 
 	if (id == 0) {
 		warn("%s: invalid id", __FUNCTION__);
-		return FALSE;
+		return false;
 	}
 
 	l = g_slist_find_custom(attrib->events, GUINT_TO_POINTER(id),
 							event_cmp_by_id);
 	if (l == NULL)
-		return FALSE;
+		return false;
 
 	evt = l->data;
 
@@ -737,15 +737,15 @@ gboolean g_attrib_unregister(GAttrib *attrib, unsigned int id)
 
 	g_free(evt);
 
-	return TRUE;
+	return true;
 }
 
-gboolean g_attrib_unregister_all(GAttrib *attrib)
+bool g_attrib_unregister_all(GAttrib *attrib)
 {
 	GSList *l;
 
 	if (attrib->events == NULL)
-		return FALSE;
+		return false;
 
 	for (l = attrib->events; l; l = l->next) {
 		struct event *evt = l->data;
@@ -759,5 +759,5 @@ gboolean g_attrib_unregister_all(GAttrib *attrib)
 	g_slist_free(attrib->events);
 	attrib->events = NULL;
 
-	return TRUE;
+	return true;
 }
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index f0dcdd4..72f4a50 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -48,30 +48,30 @@ void g_attrib_unref(GAttrib *attrib);
 
 GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 
-gboolean g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
+bool g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
 							void *user_data);
 
 unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const uint8_t *pdu,
 					uint16_t len, GAttribResultFunc func,
 					void *user_data, GDestroyNotify notify);
 
-gboolean g_attrib_cancel(GAttrib *attrib, unsigned int id);
-gboolean g_attrib_cancel_all(GAttrib *attrib);
+bool g_attrib_cancel(GAttrib *attrib, unsigned int id);
+bool g_attrib_cancel_all(GAttrib *attrib);
 
-gboolean g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
+bool g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
 							void *user_data);
 
 unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
 					GAttribNotifyFunc func, void *user_data,
 					GDestroyNotify notify);
 
-gboolean g_attrib_is_encrypted(GAttrib *attrib);
+bool g_attrib_is_encrypted(GAttrib *attrib);
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
-gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
+bool g_attrib_set_mtu(GAttrib *attrib, int mtu);
 
-gboolean g_attrib_unregister(GAttrib *attrib, unsigned int id);
-gboolean g_attrib_unregister_all(GAttrib *attrib);
+bool g_attrib_unregister(GAttrib *attrib, unsigned int id);
+bool g_attrib_unregister_all(GAttrib *attrib);
 
 #ifdef __cplusplus
 }
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 5f4388d..fc72b38 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <glib.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
@@ -53,16 +54,16 @@ static int opt_end = 0xffff;
 static int opt_handle = -1;
 static int opt_mtu = 0;
 static int opt_psm = 0;
-static gboolean opt_primary = FALSE;
-static gboolean opt_characteristics = FALSE;
-static gboolean opt_char_read = FALSE;
-static gboolean opt_listen = FALSE;
-static gboolean opt_char_desc = FALSE;
-static gboolean opt_char_write = FALSE;
-static gboolean opt_char_write_req = FALSE;
-static gboolean opt_interactive = FALSE;
+static bool opt_primary = false;
+static bool opt_characteristics = false;
+static bool opt_char_read = false;
+static bool opt_listen = false;
+static bool opt_char_desc = false;
+static bool opt_char_write = false;
+static bool opt_char_write_req = false;
+static bool opt_interactive = false;
 static GMainLoop *event_loop;
-static gboolean got_error = FALSE;
+static bool got_error = false;
 static GSourceFunc operation;
 
 struct characteristic_data {
@@ -125,7 +126,7 @@ static void connect_cb(GIOChannel *io, GError *err, void *user_data)
 
 	if (err) {
 		g_printerr("%s\n", err->message);
-		got_error = TRUE;
+		got_error = true;
 		g_main_loop_quit(event_loop);
 	}
 
@@ -464,20 +465,20 @@ static gboolean characteristics_desc(void *user_data)
 	return FALSE;
 }
 
-static gboolean parse_uuid(const char *key, const char *value,
-						void *user_data, GError **error)
+static bool parse_uuid(const char *key, const char *value, void *user_data,
+								GError **error)
 {
 	if (!value)
-		return FALSE;
+		return false;
 
 	opt_uuid = g_try_malloc(sizeof(bt_uuid_t));
 	if (opt_uuid == NULL)
-		return FALSE;
+		return false;
 
 	if (bt_string_to_uuid(opt_uuid, value) < 0)
-		return FALSE;
+		return false;
 
-	return TRUE;
+	return true;
 }
 
 static GOptionEntry primary_char_options[] = {
@@ -598,14 +599,14 @@ int main(int argc, char *argv[])
 		char *help = g_option_context_get_help(context, TRUE, NULL);
 		g_print("%s\n", help);
 		g_free(help);
-		got_error = TRUE;
+		got_error = true;
 		goto done;
 	}
 
 	chan = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
 					opt_psm, opt_mtu, connect_cb);
 	if (chan == NULL) {
-		got_error = TRUE;
+		got_error = true;
 		goto done;
 	}
 
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1dccfe5..c394d5e 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -27,6 +27,7 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <stdio.h>
 #include <glib.h>
diff --git a/attrib/utils.c b/attrib/utils.c
index e410a35..a8af7f2 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdlib.h>
+#include <stdbool.h>
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
-- 
1.8.1.4

