Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH 13/13] gatttool: Use error message prefixes consistently
Date: Thu, 21 Mar 2013 18:31:49 -0400
Message-Id: <1363905109-30839-14-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace rl_printf() calls with macros that add appropriate prefixes.
---
 attrib/interactive.c |  107 ++++++++++++++++++++++++++------------------------
 client/display.h     |    1 +
 2 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1d31889..6691f20 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -27,6 +27,7 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -74,6 +75,12 @@ static enum state {
 	STATE_CONNECTED
 } conn_state;
 
+#define error(fmt, arg...) \
+	rl_printf(COLOR_ERROR "Error: " COLOR_OFF fmt, ## arg)
+
+#define failed(fmt, arg...) \
+	rl_printf(COLOR_ERROR "Command Failed: " COLOR_OFF fmt, ## arg)
+
 static char *get_prompt(void)
 {
 	if (conn_state == STATE_CONNECTED)
@@ -127,7 +134,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 									handle);
 		break;
 	default:
-		rl_printf("Invalid opcode\n");
+		error("Invalid opcode\n");
 		return;
 	}
 
@@ -151,7 +158,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 {
 	if (err) {
 		set_state(STATE_DISCONNECTED);
-		rl_printf("%s\n", err->message);
+		error("%s\n", err->message);
 		return;
 	}
 
@@ -185,13 +192,13 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	GSList *l;
 
 	if (status) {
-		rl_printf("Discover all primary services failed: %s\n",
-							att_ecode2str(status));
+		error("Discover all primary services failed: %s\n",
+						att_ecode2str(status));
 		return;
 	}
 
 	if (services == NULL) {
-		rl_printf("No primary service found\n");
+		error("No primary service found\n");
 		return;
 	}
 
@@ -208,13 +215,13 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	GSList *l;
 
 	if (status) {
-		rl_printf("Discover primary services by UUID failed: %s\n",
+		error("Discover primary services by UUID failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
 	if (ranges == NULL) {
-		rl_printf("No service UUID found\n");
+		error("No service UUID found\n");
 		return;
 	}
 
@@ -230,7 +237,7 @@ static void included_cb(GSList *includes, guint8 status, gpointer user_data)
 	GSList *l;
 
 	if (status) {
-		rl_printf("Find included services failed: %s\n",
+		error("Find included services failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
@@ -254,7 +261,7 @@ static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 	GSList *l;
 
 	if (status) {
-		rl_printf("Discover all characteristics failed: %s\n",
+		error("Discover all characteristics failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
@@ -319,14 +326,14 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	GString *s;
 
 	if (status != 0) {
-		rl_printf("Characteristic value/descriptor read failed: %s\n",
+		error("Characteristic value/descriptor read failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
 	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
 	if (vlen < 0) {
-		rl_printf("Protocol error\n");
+		error("Protocol error\n");
 		return;
 	}
 
@@ -351,7 +358,7 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		goto done;
 
 	if (status != 0) {
-		rl_printf("Read characteristics by UUID failed: %s\n",
+		error("Read characteristics by UUID failed: %s\n",
 							att_ecode2str(status));
 		goto done;
 	}
@@ -415,7 +422,7 @@ static void cmd_connect(int argcp, char **argvp)
 	}
 
 	if (opt_dst == NULL) {
-		rl_printf("Remote Bluetooth address required\n");
+		error("Remote Bluetooth address required\n");
 		return;
 	}
 
@@ -425,7 +432,7 @@ static void cmd_connect(int argcp, char **argvp)
 					opt_psm, opt_mtu, connect_cb, &gerr);
 	if (iochannel == NULL) {
 		set_state(STATE_DISCONNECTED);
-		rl_printf("%s\n", gerr->message);
+		error("%s\n", gerr->message);
 		g_error_free(gerr);
 	} else
 		g_io_add_watch(iochannel, G_IO_HUP, channel_watcher, NULL);
@@ -441,7 +448,7 @@ static void cmd_primary(int argcp, char **argvp)
 	bt_uuid_t uuid;
 
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: disconnected\n");
+		failed("Disconnected\n");
 		return;
 	}
 
@@ -451,7 +458,7 @@ static void cmd_primary(int argcp, char **argvp)
 	}
 
 	if (bt_string_to_uuid(&uuid, argvp[1]) < 0) {
-		rl_printf("Invalid UUID\n");
+		error("Invalid UUID\n");
 		return;
 	}
 
@@ -477,14 +484,14 @@ static void cmd_included(int argcp, char **argvp)
 	int end = 0xffff;
 
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: disconnected\n");
+		failed("Disconnected\n");
 		return;
 	}
 
 	if (argcp > 1) {
 		start = strtohandle(argvp[1]);
 		if (start < 0) {
-			rl_printf("Invalid start handle: %s\n", argvp[1]);
+			error("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 		end = start;
@@ -493,7 +500,7 @@ static void cmd_included(int argcp, char **argvp)
 	if (argcp > 2) {
 		end = strtohandle(argvp[2]);
 		if (end < 0) {
-			rl_printf("Invalid end handle: %s\n", argvp[2]);
+			error("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	}
@@ -507,14 +514,14 @@ static void cmd_char(int argcp, char **argvp)
 	int end = 0xffff;
 
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: disconnected\n");
+		failed("Disconnected\n");
 		return;
 	}
 
 	if (argcp > 1) {
 		start = strtohandle(argvp[1]);
 		if (start < 0) {
-			rl_printf("Invalid start handle: %s\n", argvp[1]);
+			error("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 	}
@@ -522,7 +529,7 @@ static void cmd_char(int argcp, char **argvp)
 	if (argcp > 2) {
 		end = strtohandle(argvp[2]);
 		if (end < 0) {
-			rl_printf("Invalid end handle: %s\n", argvp[2]);
+			error("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	}
@@ -531,7 +538,7 @@ static void cmd_char(int argcp, char **argvp)
 		bt_uuid_t uuid;
 
 		if (bt_string_to_uuid(&uuid, argvp[3]) < 0) {
-			rl_printf("Invalid UUID\n");
+			error("Invalid UUID\n");
 			return;
 		}
 
@@ -545,14 +552,14 @@ static void cmd_char(int argcp, char **argvp)
 static void cmd_char_desc(int argcp, char **argvp)
 {
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: disconnected\n");
+		failed("Disconnected\n");
 		return;
 	}
 
 	if (argcp > 1) {
 		start = strtohandle(argvp[1]);
 		if (start < 0) {
-			rl_printf("Invalid start handle: %s\n", argvp[1]);
+			error("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 	} else
@@ -561,7 +568,7 @@ static void cmd_char_desc(int argcp, char **argvp)
 	if (argcp > 2) {
 		end = strtohandle(argvp[2]);
 		if (end < 0) {
-			rl_printf("Invalid end handle: %s\n", argvp[2]);
+			error("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	} else
@@ -575,18 +582,18 @@ static void cmd_read_hnd(int argcp, char **argvp)
 	int handle;
 
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: disconnected\n");
+		failed("Disconnected\n");
 		return;
 	}
 
 	if (argcp < 2) {
-		rl_printf("Missing argument: handle\n");
+		error("Missing argument: handle\n");
 		return;
 	}
 
 	handle = strtohandle(argvp[1]);
 	if (handle < 0) {
-		rl_printf("Invalid handle: %s\n", argvp[1]);
+		error("Invalid handle: %s\n", argvp[1]);
 		return;
 	}
 
@@ -601,24 +608,24 @@ static void cmd_read_uuid(int argcp, char **argvp)
 	bt_uuid_t uuid;
 
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: disconnected\n");
+		failed("Disconnected\n");
 		return;
 	}
 
 	if (argcp < 2) {
-		rl_printf("Missing argument: UUID\n");
+		error("Missing argument: UUID\n");
 		return;
 	}
 
 	if (bt_string_to_uuid(&uuid, argvp[1]) < 0) {
-		rl_printf("Invalid UUID\n");
+		error("Invalid UUID\n");
 		return;
 	}
 
 	if (argcp > 2) {
 		start = strtohandle(argvp[2]);
 		if (start < 0) {
-			rl_printf("Invalid start handle: %s\n", argvp[1]);
+			error("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 	}
@@ -626,7 +633,7 @@ static void cmd_read_uuid(int argcp, char **argvp)
 	if (argcp > 3) {
 		end = strtohandle(argvp[3]);
 		if (end < 0) {
-			rl_printf("Invalid end handle: %s\n", argvp[2]);
+			error("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	}
@@ -645,13 +652,13 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	if (status != 0) {
-		rl_printf("Characteristic Write Request failed: "
+		error("Characteristic Write Request failed: "
 						"%s\n", att_ecode2str(status));
 		return;
 	}
 
 	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
-		rl_printf("Protocol error\n");
+		error("Protocol error\n");
 		return;
 	}
 
@@ -665,7 +672,7 @@ static void cmd_char_write(int argcp, char **argvp)
 	int handle;
 
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: disconnected\n");
+		failed("Disconnected\n");
 		return;
 	}
 
@@ -676,13 +683,13 @@ static void cmd_char_write(int argcp, char **argvp)
 
 	handle = strtohandle(argvp[1]);
 	if (handle <= 0) {
-		rl_printf("A valid handle is required\n");
+		error("A valid handle is required\n");
 		return;
 	}
 
 	plen = gatt_attr_data_from_string(argvp[2], &value);
 	if (plen == 0) {
-		rl_printf("Invalid value\n");
+		error("Invalid value\n");
 		return;
 	}
 
@@ -731,7 +738,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 			BT_IO_OPT_SEC_LEVEL, sec_level,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
-		rl_printf("Error: %s\n", gerr->message);
+		error("%s\n", gerr->message);
 		g_error_free(gerr);
 	}
 }
@@ -742,13 +749,13 @@ static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	uint16_t mtu;
 
 	if (status != 0) {
-		rl_printf("Exchange MTU Request failed: %s\n",
-							att_ecode2str(status));
+		error("Exchange MTU Request failed: %s\n",
+						att_ecode2str(status));
 		return;
 	}
 
 	if (!dec_mtu_resp(pdu, plen, &mtu)) {
-		rl_printf("Protocol error\n");
+		error("Protocol error\n");
 		return;
 	}
 
@@ -757,19 +764,18 @@ static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (g_attrib_set_mtu(attrib, mtu))
 		rl_printf("MTU was exchanged successfully: %d\n", mtu);
 	else
-		rl_printf("Error exchanging MTU\n");
+		error("Error exchanging MTU\n");
 }
 
 static void cmd_mtu(int argcp, char **argvp)
 {
 	if (conn_state != STATE_CONNECTED) {
-		rl_printf("Command failed: not connected.\n");
+		failed("Disconnected\n");
 		return;
 	}
 
 	if (opt_psm) {
-		rl_printf("Command failed: operation is only available for LE"
-							" transport.\n");
+		failed("Operation is only available for LE transport.\n");
 		return;
 	}
 
@@ -779,15 +785,14 @@ static void cmd_mtu(int argcp, char **argvp)
 	}
 
 	if (opt_mtu) {
-		rl_printf("Command failed: MTU exchange can only occur once per"
-							" connection.\n");
+		failed("MTU exchange can only occur once per connection.\n");
 		return;
 	}
 
 	errno = 0;
 	opt_mtu = strtoll(argvp[1], NULL, 0);
 	if (errno != 0 || opt_mtu < ATT_DEFAULT_LE_MTU) {
-		rl_printf("Invalid value. Minimum MTU size is %d\n",
+		error("Invalid value. Minimum MTU size is %d\n",
 							ATT_DEFAULT_LE_MTU);
 		return;
 	}
@@ -871,7 +876,7 @@ static void parse_line(char *line_read)
 	if (commands[i].cmd)
 		commands[i].func(argcp, argvp);
 	else
-		rl_printf("%s: command not found\n", argvp[0]);
+		error("%s: command not found\n", argvp[0]);
 
 	g_strfreev(argvp);
 
diff --git a/client/display.h b/client/display.h
index 393a3c8..9ddf6d0 100644
--- a/client/display.h
+++ b/client/display.h
@@ -23,5 +23,6 @@
 
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_BLUE	"\x1B[0;34m"
+#define COLOR_ERROR	"\x1B[0;31m"
 
 void rl_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
-- 
1.7.9.5

