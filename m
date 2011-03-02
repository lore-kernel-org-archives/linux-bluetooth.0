Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Add offset option to characteristic read by handle
Date: Wed,  2 Mar 2011 14:09:08 -0300
Message-Id: <1299085748-5328-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some tests require an arbitrary offset.
---
 attrib/client.c      |   10 +++++-----
 attrib/gatt.c        |   15 +++++++++++----
 attrib/gatt.h        |    4 ++--
 attrib/gatttool.c    |    5 ++++-
 attrib/interactive.c |   16 ++++++++++++++--
 5 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 97b1156..17157cd 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -709,7 +709,7 @@ static void update_char_desc(guint8 status, const guint8 *pdu, guint16 len,
 		if (bt_io_set(io, BT_IO_L2CAP, NULL,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
 				BT_IO_OPT_INVALID)) {
-			gatt_read_char(gatt->attrib, current->handle,
+			gatt_read_char(gatt->attrib, current->handle, 0,
 					update_char_desc, current);
 			return;
 		}
@@ -760,7 +760,7 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 		if (bt_io_set(io, BT_IO_L2CAP, NULL,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
 				BT_IO_OPT_INVALID)) {
-			gatt_read_char(gatt->attrib, chr->handle,
+			gatt_read_char(gatt->attrib, chr->handle, 0,
 					update_char_value, current);
 			return;
 		}
@@ -821,11 +821,11 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		if (uuid_desc16_cmp(&uuid, GATT_CHARAC_USER_DESC_UUID) == 0) {
 			gatt->attrib = g_attrib_ref(gatt->attrib);
-			gatt_read_char(gatt->attrib, handle, update_char_desc,
+			gatt_read_char(gatt->attrib, handle, 0, update_char_desc,
 									qfmt);
 		} else if (uuid_desc16_cmp(&uuid, GATT_CHARAC_FMT_UUID) == 0) {
 			gatt->attrib = g_attrib_ref(gatt->attrib);
-			gatt_read_char(gatt->attrib, handle,
+			gatt_read_char(gatt->attrib, handle, 0,
 						update_char_format, qfmt);
 		} else
 			g_free(qfmt);
@@ -857,7 +857,7 @@ static void update_all_chars(gpointer data, gpointer user_data)
 	qvalue->chr = chr;
 
 	gatt->attrib = g_attrib_ref(gatt->attrib);
-	gatt_read_char(gatt->attrib, chr->handle, update_char_value, qvalue);
+	gatt_read_char(gatt->attrib, chr->handle, 0, update_char_value, qvalue);
 }
 
 static void char_discovered_cb(GSList *characteristics, guint8 status,
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 20bb96f..ae482f1 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -457,8 +457,8 @@ done:
 	long_read->func(status, rpdu, rlen, long_read->user_data);
 }
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data)
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
+				GAttribResultFunc func, gpointer user_data)
 {
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
@@ -475,9 +475,16 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 	long_read->user_data = user_data;
 	long_read->handle = handle;
 
-	plen = enc_read_req(handle, pdu, sizeof(pdu));
-	id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, pdu, plen,
+	if (offset > 0) {
+		plen = enc_read_blob_req(long_read->handle, offset, pdu,
+								sizeof(pdu));
+		id = g_attrib_send(attrib, 0, ATT_OP_READ_BLOB_REQ, pdu, plen,
+				read_blob_helper, long_read, read_long_destroy);
+	} else {
+		plen = enc_read_req(handle, pdu, sizeof(pdu));
+		id = g_attrib_send(attrib, 0, ATT_OP_READ_REQ, pdu, plen,
 				read_char_helper, long_read, read_long_destroy);
+	}
 
 	if (id == 0)
 		g_free(long_read);
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 9f69646..b1a46e1 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -32,8 +32,8 @@ guint gatt_discover_primary(GAttrib *attrib, uuid_t *uuid, gatt_cb_t func,
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 					gatt_cb_t func, gpointer user_data);
 
-guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
-							gpointer user_data);
+guint gatt_read_char(GAttrib *attrib, uint16_t handle, uint16_t offset,
+				GAttribResultFunc func, gpointer user_data);
 
 guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 			int vlen, GAttribResultFunc func, gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 420fc91..e51db7b 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -54,6 +54,7 @@ static int opt_end = 0xffff;
 static int opt_handle = -1;
 static int opt_mtu = 0;
 static int opt_psm = 0;
+static int opt_offset = 0;
 static gboolean opt_primary = FALSE;
 static gboolean opt_characteristics = FALSE;
 static gboolean opt_char_read = FALSE;
@@ -308,7 +309,7 @@ static gboolean characteristics_read(gpointer user_data)
 		return FALSE;
 	}
 
-	gatt_read_char(attrib, opt_handle, char_read_cb, attrib);
+	gatt_read_char(attrib, opt_handle, opt_offset, char_read_cb, attrib);
 
 	return FALSE;
 }
@@ -488,6 +489,8 @@ static GOptionEntry char_rw_options[] = {
 	{ "value", 'n' , 0, G_OPTION_ARG_STRING, &opt_value,
 		"Write characteristic value (required for write operation)",
 		"0x0001" },
+	{ "offset", 'o', 0, G_OPTION_ARG_INT, &opt_offset,
+		"Offset to long read characteristic by handle", "N"},
 	{NULL},
 };
 
diff --git a/attrib/interactive.c b/attrib/interactive.c
index ff676b4..52edeac 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -433,6 +433,7 @@ static void cmd_char_desc(int argcp, char **argvp)
 static void cmd_read_hnd(int argcp, char **argvp)
 {
 	int handle;
+	int offset = 0;
 
 	if (conn_state != STATE_CONNECTED) {
 		printf("Command failed: disconnected\n");
@@ -450,7 +451,18 @@ static void cmd_read_hnd(int argcp, char **argvp)
 		return;
 	}
 
-	gatt_read_char(attrib, handle, char_read_cb, attrib);
+	if (argcp > 2) {
+		char *e;
+
+		errno = 0;
+		offset = strtol(argvp[2], &e, 0);
+		if (errno != 0 || *e != '\0') {
+			printf("Invalid offset: %s\n", argvp[2]);
+			return;
+		}
+	}
+
+	gatt_read_char(attrib, handle, offset, char_read_cb, attrib);
 }
 
 static void cmd_read_uuid(int argcp, char **argvp)
@@ -613,7 +625,7 @@ static struct {
 		"Characteristics Discovery" },
 	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
 		"Characteristics Descriptor Discovery" },
-	{ "char-read-hnd",	cmd_read_hnd,	"<handle>",
+	{ "char-read-hnd",	cmd_read_hnd,	"<handle> [offset]",
 		"Characteristics Value/Descriptor Read by handle" },
 	{ "char-read-uuid",	cmd_read_uuid,	"<UUID> [start hnd] [end hnd]",
 		"Characteristics Value/Descriptor Read by UUID" },
-- 
1.7.1

