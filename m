Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 4/6] gatttool: remove glib basic data types usage
Date: Mon,  4 Mar 2013 16:58:48 -0400
Message-Id: <1362430730-19580-5-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatttool.c    | 61 ++++++++++++++++++++++++++--------------------------
 attrib/gatttool.h    |  8 +++----
 attrib/interactive.c | 54 ++++++++++++++++++++++------------------------
 3 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 29e3261..62a7c11 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -42,11 +42,11 @@
 #include "gatt.h"
 #include "gatttool.h"
 
-static gchar *opt_src = NULL;
-static gchar *opt_dst = NULL;
-static gchar *opt_dst_type = NULL;
-static gchar *opt_value = NULL;
-static gchar *opt_sec_level = NULL;
+static char *opt_src = NULL;
+static char *opt_dst = NULL;
+static char *opt_dst_type = NULL;
+static char *opt_value = NULL;
+static char *opt_sec_level = NULL;
 static bt_uuid_t *opt_uuid = NULL;
 static int opt_start = 0x0001;
 static int opt_end = 0xffff;
@@ -71,7 +71,7 @@ struct characteristic_data {
 	uint16_t end;
 };
 
-static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+static void events_handler(const uint8_t *pdu, uint16_t len, void *user_data)
 {
 	GAttrib *attrib = user_data;
 	uint8_t *opdu;
@@ -107,7 +107,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 		g_attrib_send(attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static gboolean listen_start(gpointer user_data)
+static gboolean listen_start(void *user_data)
 {
 	GAttrib *attrib = user_data;
 
@@ -119,7 +119,7 @@ static gboolean listen_start(gpointer user_data)
 	return FALSE;
 }
 
-static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+static void connect_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	GAttrib *attrib;
 
@@ -137,7 +137,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	operation(attrib);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_all_cb(GSList *services, uint8_t status, void *user_data)
 {
 	GSList *l;
 
@@ -157,8 +157,7 @@ done:
 	g_main_loop_quit(event_loop);
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
-							gpointer user_data)
+static void primary_by_uuid_cb(GSList *ranges, uint8_t status, void *user_data)
 {
 	GSList *l;
 
@@ -178,7 +177,7 @@ done:
 	g_main_loop_quit(event_loop);
 }
 
-static gboolean primary(gpointer user_data)
+static gboolean primary(void *user_data)
 {
 	GAttrib *attrib = user_data;
 
@@ -191,8 +190,8 @@ static gboolean primary(gpointer user_data)
 	return FALSE;
 }
 
-static void char_discovered_cb(GSList *characteristics, guint8 status,
-							gpointer user_data)
+static void char_discovered_cb(GSList *characteristics, uint8_t status,
+								void *user_data)
 {
 	GSList *l;
 
@@ -214,7 +213,7 @@ done:
 	g_main_loop_quit(event_loop);
 }
 
-static gboolean characteristics(gpointer user_data)
+static gboolean characteristics(void *user_data)
 {
 	GAttrib *attrib = user_data;
 
@@ -224,8 +223,8 @@ static gboolean characteristics(gpointer user_data)
 	return FALSE;
 }
 
-static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_read_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
+								void *user_data)
 {
 	uint8_t value[plen];
 	ssize_t vlen;
@@ -252,8 +251,8 @@ done:
 		g_main_loop_quit(event_loop);
 }
 
-static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void char_read_by_uuid_cb(uint8_t status, const uint8_t *pdu,
+						uint16_t plen, void *user_data)
 {
 	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
@@ -293,7 +292,7 @@ done:
 	g_main_loop_quit(event_loop);
 }
 
-static gboolean characteristics_read(gpointer user_data)
+static gboolean characteristics_read(void *user_data)
 {
 	GAttrib *attrib = user_data;
 
@@ -322,7 +321,7 @@ static gboolean characteristics_read(gpointer user_data)
 	return FALSE;
 }
 
-static void mainloop_quit(gpointer user_data)
+static void mainloop_quit(void *user_data)
 {
 	uint8_t *value = user_data;
 
@@ -330,7 +329,7 @@ static void mainloop_quit(gpointer user_data)
 	g_main_loop_quit(event_loop);
 }
 
-static gboolean characteristics_write(gpointer user_data)
+static gboolean characteristics_write(void *user_data)
 {
 	GAttrib *attrib = user_data;
 	uint8_t *value;
@@ -361,8 +360,8 @@ error:
 	return FALSE;
 }
 
-static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_write_req_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
+								void *user_data)
 {
 	if (status != 0) {
 		g_printerr("Characteristic Write Request failed: "
@@ -382,7 +381,7 @@ done:
 		g_main_loop_quit(event_loop);
 }
 
-static gboolean characteristics_write_req(gpointer user_data)
+static gboolean characteristics_write_req(void *user_data)
 {
 	GAttrib *attrib = user_data;
 	uint8_t *value;
@@ -414,11 +413,11 @@ error:
 	return FALSE;
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_desc_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
+								void *user_data)
 {
 	struct att_data_list *list;
-	guint8 format;
+	uint8_t format;
 	int i;
 
 	if (status != 0) {
@@ -456,7 +455,7 @@ done:
 		g_main_loop_quit(event_loop);
 }
 
-static gboolean characteristics_desc(gpointer user_data)
+static gboolean characteristics_desc(void *user_data)
 {
 	GAttrib *attrib = user_data;
 
@@ -466,7 +465,7 @@ static gboolean characteristics_desc(gpointer user_data)
 }
 
 static gboolean parse_uuid(const char *key, const char *value,
-				gpointer user_data, GError **error)
+						void *user_data, GError **error)
 {
 	if (!value)
 		return FALSE;
@@ -596,7 +595,7 @@ int main(int argc, char *argv[])
 	else if (opt_char_desc)
 		operation = characteristics_desc;
 	else {
-		gchar *help = g_option_context_get_help(context, TRUE, NULL);
+		char *help = g_option_context_get_help(context, TRUE, NULL);
 		g_print("%s\n", help);
 		g_free(help);
 		got_error = TRUE;
diff --git a/attrib/gatttool.h b/attrib/gatttool.h
index 260480d..6aa1611 100644
--- a/attrib/gatttool.h
+++ b/attrib/gatttool.h
@@ -21,9 +21,9 @@
  *
  */
 
-int interactive(const gchar *src, const gchar *dst, const gchar *dst_type,
+int interactive(const char *src, const char *dst, const char *dst_type,
 								int psm);
-GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-			const gchar *dst_type, const gchar *sec_level,
-			int psm, int mtu, BtIOConnect connect_cb);
+GIOChannel *gatt_connect(const char *src, const char *dst, const char *dst_type,
+					const char *sec_level, int psm,
+					int mtu, BtIOConnect connect_cb);
 size_t gatt_attr_data_from_string(const char *str, uint8_t **data);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index a99ad0a..1dccfe5 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -46,10 +46,10 @@ static GAttrib *attrib = NULL;
 static GMainLoop *event_loop;
 static GString *prompt;
 
-static gchar *opt_src = NULL;
-static gchar *opt_dst = NULL;
-static gchar *opt_dst_type = NULL;
-static gchar *opt_sec_level = NULL;
+static char *opt_src = NULL;
+static char *opt_dst = NULL;
+static char *opt_dst_type = NULL;
+static char *opt_sec_level = NULL;
 static int opt_psm = 0;
 static int opt_mtu = 0;
 static int start;
@@ -105,7 +105,7 @@ static void set_state(enum state st)
 	rl_redisplay();
 }
 
-static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
+static void events_handler(const uint8_t *pdu, uint16_t len, void *user_data)
 {
 	uint8_t *opdu;
 	uint16_t handle, i, olen;
@@ -142,7 +142,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 		g_attrib_send(attrib, 0, opdu, olen, NULL, NULL, NULL);
 }
 
-static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
+static void connect_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	if (err) {
 		printf("connect error: %s\n", err->message);
@@ -174,7 +174,7 @@ static void disconnect_io()
 	set_state(STATE_DISCONNECTED);
 }
 
-static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_all_cb(GSList *services, uint8_t status, void *user_data)
 {
 	GSList *l;
 
@@ -194,8 +194,7 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	rl_forced_update_display();
 }
 
-static void primary_by_uuid_cb(GSList *ranges, guint8 status,
-							gpointer user_data)
+static void primary_by_uuid_cb(GSList *ranges, uint8_t status, void *user_data)
 {
 	GSList *l;
 
@@ -215,7 +214,7 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	rl_forced_update_display();
 }
 
-static void included_cb(GSList *includes, guint8 status, gpointer user_data)
+static void included_cb(GSList *includes, uint8_t status, void *user_data)
 {
 	GSList *l;
 
@@ -243,7 +242,7 @@ done:
 	rl_forced_update_display();
 }
 
-static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
+static void char_cb(GSList *characteristics, uint8_t status, void *user_data)
 {
 	GSList *l;
 
@@ -266,11 +265,11 @@ static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 	rl_forced_update_display();
 }
 
-static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_desc_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
+								void *user_data)
 {
 	struct att_data_list *list;
-	guint8 format;
+	uint8_t format;
 	uint16_t handle = 0xffff;
 	int i;
 
@@ -310,8 +309,8 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		rl_forced_update_display();
 }
 
-static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_read_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
+							void *user_data)
 {
 	uint8_t value[plen];
 	ssize_t vlen;
@@ -337,8 +336,8 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	rl_forced_update_display();
 }
 
-static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void char_read_by_uuid_cb(uint8_t status, const uint8_t *pdu,
+						uint16_t plen, void *user_data)
 {
 	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
@@ -386,7 +385,7 @@ static void cmd_exit(int argcp, char **argvp)
 }
 
 static gboolean channel_watcher(GIOChannel *chan, GIOCondition cond,
-				gpointer user_data)
+								void *user_data)
 {
 	disconnect_io();
 
@@ -633,8 +632,8 @@ static void cmd_read_uuid(int argcp, char **argvp)
 					char_read_by_uuid_cb, char_data);
 }
 
-static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void char_write_req_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
+								void *user_data)
 {
 	if (status != 0) {
 		printf("Characteristic Write Request failed: "
@@ -728,8 +727,8 @@ static void cmd_sec_level(int argcp, char **argvp)
 	}
 }
 
-static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
+static void exchange_mtu_cb(uint8_t status, const uint8_t *pdu, uint16_t plen,
+								void *user_data)
 {
 	uint16_t mtu;
 
@@ -837,7 +836,7 @@ static void cmd_help(int argcp, char **argvp)
 
 static void parse_line(char *line_read)
 {
-	gchar **argvp;
+	char **argvp;
 	int argcp;
 	int i;
 
@@ -869,7 +868,7 @@ static void parse_line(char *line_read)
 }
 
 static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
-							gpointer user_data)
+								void *user_data)
 {
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
 		g_io_channel_unref(chan);
@@ -908,11 +907,10 @@ static char **commands_completion(const char *text, int start, int end)
 		return NULL;
 }
 
-int interactive(const gchar *src, const gchar *dst,
-		const gchar *dst_type, int psm)
+int interactive(const char *src, const char *dst, const char *dst_type, int psm)
 {
 	GIOChannel *pchan;
-	gint events;
+	int events;
 
 	opt_sec_level = g_strdup("low");
 
-- 
1.8.1.4

