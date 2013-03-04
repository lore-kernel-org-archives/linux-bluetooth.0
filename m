Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 1/6] gattrib: remove glib basic data types usage
Date: Mon,  4 Mar 2013 16:58:45 -0400
Message-Id: <1362430730-19580-2-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gattrib.c | 93 ++++++++++++++++++++++++++++----------------------------
 attrib/gattrib.h | 36 +++++++++++-----------
 2 files changed, 64 insertions(+), 65 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 01c19f9..7cc489a 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -44,43 +44,43 @@
 
 struct _GAttrib {
 	GIOChannel *io;
-	gint refs;
+	int refs;
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
-	gpointer destroy_user_data;
+	void *destroy_user_data;
 	gboolean stale;
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
 	gboolean sent;
 	GAttribResultFunc func;
-	gpointer user_data;
+	void *user_data;
 	GDestroyNotify notify;
 };
 
 struct event {
-	guint id;
-	guint8 expected;
-	guint16 handle;
+	unsigned int id;
+	uint8_t expected;
+	uint16_t handle;
 	GAttribNotifyFunc func;
-	gpointer user_data;
+	void *user_data;
 	GDestroyNotify notify;
 };
 
-static guint8 opcode2expected(guint8 opcode)
+static uint8_t opcode2expected(uint8_t opcode)
 {
 	switch (opcode) {
 	case ATT_OP_MTU_REQ:
@@ -123,7 +123,7 @@ static guint8 opcode2expected(guint8 opcode)
 	return 0;
 }
 
-static gboolean is_response(guint8 opcode)
+static gboolean is_response(uint8_t opcode)
 {
 	switch (opcode) {
 	case ATT_OP_ERROR:
@@ -243,7 +243,7 @@ GIOChannel *g_attrib_get_channel(GAttrib *attrib)
 }
 
 gboolean g_attrib_set_destroy_function(GAttrib *attrib,
-		GDestroyNotify destroy, gpointer user_data)
+					GDestroyNotify destroy, void *user_data)
 {
 	if (attrib == NULL)
 		return FALSE;
@@ -254,7 +254,7 @@ gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 	return TRUE;
 }
 
-static gboolean disconnect_timeout(gpointer data)
+static gboolean disconnect_timeout(void *data)
 {
 	struct _GAttrib *attrib = data;
 	struct command *c;
@@ -284,13 +284,12 @@ done:
 	return FALSE;
 }
 
-static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
-								gpointer data)
+static gboolean can_write_data(GIOChannel *io, GIOCondition cond, void *data)
 {
 	struct _GAttrib *attrib = data;
 	struct command *cmd;
 	GError *gerr = NULL;
-	gsize len;
+	size_t len;
 	GIOStatus iostat;
 	GQueue *queue;
 
@@ -316,8 +315,8 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 	if (cmd->sent)
 		return FALSE;
 
-	iostat = g_io_channel_write_chars(io, (gchar *) cmd->pdu, cmd->len,
-								&len, &gerr);
+	iostat = g_io_channel_write_chars(io, (char *) cmd->pdu, cmd->len, &len,
+									&gerr);
 	if (iostat != G_IO_STATUS_NORMAL) {
 		if (gerr) {
 			error("%s", gerr->message);
@@ -343,7 +342,7 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static void destroy_sender(gpointer data)
+static void destroy_sender(void *data)
 {
 	struct _GAttrib *attrib = data;
 
@@ -362,9 +361,9 @@ static void wake_up_sender(struct _GAttrib *attrib)
 				can_write_data, attrib, destroy_sender);
 }
 
-static gboolean match_event(struct event *evt, const uint8_t *pdu, gsize len)
+static gboolean match_event(struct event *evt, const uint8_t *pdu, size_t len)
 {
-	guint16 handle;
+	uint16_t handle;
 
 	if (evt->expected == GATTRIB_ALL_EVENTS)
 		return TRUE;
@@ -386,13 +385,13 @@ static gboolean match_event(struct event *evt, const uint8_t *pdu, gsize len)
 	return FALSE;
 }
 
-static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
+static gboolean received_data(GIOChannel *io, GIOCondition cond, void *data)
 {
 	struct _GAttrib *attrib = data;
 	struct command *cmd = NULL;
 	GSList *l;
 	uint8_t buf[512], status;
-	gsize len;
+	size_t len;
 	GIOStatus iostat;
 	gboolean norequests, noresponses;
 
@@ -406,8 +405,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 
 	memset(buf, 0, sizeof(buf));
 
-	iostat = g_io_channel_read_chars(io, (gchar *) buf, sizeof(buf),
-								&len, NULL);
+	iostat = g_io_channel_read_chars(io, (char *) buf, sizeof(buf), &len,
+									NULL);
 	if (iostat != G_IO_STATUS_NORMAL) {
 		status = ATT_ECODE_IO;
 		goto done;
@@ -504,9 +503,9 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	return g_attrib_ref(attrib);
 }
 
-guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
-			GAttribResultFunc func, gpointer user_data,
-			GDestroyNotify notify)
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const uint8_t *pdu,
+					uint16_t len, GAttribResultFunc func,
+					void *user_data, GDestroyNotify notify)
 {
 	struct command *c;
 	GQueue *queue;
@@ -558,15 +557,15 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 	return c->id;
 }
 
-static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
+static int command_cmp_by_id(const void *a, const void *b)
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
@@ -643,8 +642,8 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 	return ret;
 }
 
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data)
+gboolean g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
+								void *user_data)
 {
 	return TRUE;
 }
@@ -671,11 +670,11 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 	return TRUE;
 }
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
-				GAttribNotifyFunc func, gpointer user_data,
-				GDestroyNotify notify)
+unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
+					GAttribNotifyFunc func, void *user_data,
+					GDestroyNotify notify)
 {
-	static guint next_evt_id = 0;
+	static unsigned int next_evt_id = 0;
 	struct event *event;
 
 	event = g_try_new0(struct event, 1);
@@ -694,10 +693,10 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 	return event->id;
 }
 
-static gint event_cmp_by_id(gconstpointer a, gconstpointer b)
+static int event_cmp_by_id(const void *a, const void *b)
 {
 	const struct event *evt = a;
-	guint id = GPOINTER_TO_UINT(b);
+	unsigned int id = GPOINTER_TO_UINT(b);
 
 	return evt->id - id;
 }
@@ -714,7 +713,7 @@ gboolean g_attrib_is_encrypted(GAttrib *attrib)
 	return sec_level > BT_IO_SEC_LOW;
 }
 
-gboolean g_attrib_unregister(GAttrib *attrib, guint id)
+gboolean g_attrib_unregister(GAttrib *attrib, unsigned int id)
 {
 	struct event *evt;
 	GSList *l;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 3fe92c7..f0dcdd4 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -35,12 +35,12 @@ extern "C" {
 struct _GAttrib;
 typedef struct _GAttrib GAttrib;
 
-typedef void (*GAttribResultFunc) (guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data);
-typedef void (*GAttribDisconnectFunc)(gpointer user_data);
-typedef void (*GAttribDebugFunc)(const char *str, gpointer user_data);
-typedef void (*GAttribNotifyFunc)(const guint8 *pdu, guint16 len,
-							gpointer user_data);
+typedef void (*GAttribResultFunc) (uint8_t status, const uint8_t *pdu,
+						uint16_t len, void *user_data);
+typedef void (*GAttribDisconnectFunc)(void *user_data);
+typedef void (*GAttribDebugFunc)(const char *str, void *user_data);
+typedef void (*GAttribNotifyFunc)(const uint8_t *pdu, uint16_t len,
+							void *user_data);
 
 GAttrib *g_attrib_new(GIOChannel *io);
 GAttrib *g_attrib_ref(GAttrib *attrib);
@@ -48,29 +48,29 @@ void g_attrib_unref(GAttrib *attrib);
 
 GIOChannel *g_attrib_get_channel(GAttrib *attrib);
 
-gboolean g_attrib_set_destroy_function(GAttrib *attrib,
-		GDestroyNotify destroy, gpointer user_data);
+gboolean g_attrib_set_destroy_function(GAttrib *attrib, GDestroyNotify destroy,
+							void *user_data);
 
-guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
-			GAttribResultFunc func, gpointer user_data,
-			GDestroyNotify notify);
+unsigned int g_attrib_send(GAttrib *attrib, unsigned int id, const uint8_t *pdu,
+					uint16_t len, GAttribResultFunc func,
+					void *user_data, GDestroyNotify notify);
 
-gboolean g_attrib_cancel(GAttrib *attrib, guint id);
+gboolean g_attrib_cancel(GAttrib *attrib, unsigned int id);
 gboolean g_attrib_cancel_all(GAttrib *attrib);
 
-gboolean g_attrib_set_debug(GAttrib *attrib,
-		GAttribDebugFunc func, gpointer user_data);
+gboolean g_attrib_set_debug(GAttrib *attrib, GAttribDebugFunc func,
+							void *user_data);
 
-guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
-				GAttribNotifyFunc func, gpointer user_data,
-				GDestroyNotify notify);
+unsigned int g_attrib_register(GAttrib *attrib, uint8_t opcode, uint16_t handle,
+					GAttribNotifyFunc func, void *user_data,
+					GDestroyNotify notify);
 
 gboolean g_attrib_is_encrypted(GAttrib *attrib);
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
 
-gboolean g_attrib_unregister(GAttrib *attrib, guint id);
+gboolean g_attrib_unregister(GAttrib *attrib, unsigned int id);
 gboolean g_attrib_unregister_all(GAttrib *attrib);
 
 #ifdef __cplusplus
-- 
1.8.1.4

