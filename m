Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/5] client/display: Prefix remaining functions with interactive_
Date: Thu, 12 Feb 2015 18:52:10 +0100
Message-Id: <1423763533-15071-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
References: <1423763533-15071-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to not confuse those with readline API.
---
 attrib/interactive.c     |  44 +++----
 client/agent.c           |  48 ++++----
 client/display.c         |  16 +--
 client/display.h         |   4 +-
 client/gatt.c            |  40 +++----
 client/main.c            | 130 ++++++++++----------
 tools/bluetooth-player.c | 192 +++++++++++++++---------------
 tools/btmgmt.c           |   4 +-
 tools/obexctl.c          | 302 +++++++++++++++++++++++------------------------
 9 files changed, 390 insertions(+), 390 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 7911ba5..da8bcb9 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -70,10 +70,10 @@ static enum state {
 } conn_state;
 
 #define error(fmt, arg...) \
-	rl_printf(COLOR_RED "Error: " COLOR_OFF fmt, ## arg)
+	interactive_printf(COLOR_RED "Error: " COLOR_OFF fmt, ## arg)
 
 #define failed(fmt, arg...) \
-	rl_printf(COLOR_RED "Command Failed: " COLOR_OFF fmt, ## arg)
+	interactive_printf(COLOR_RED "Command Failed: " COLOR_OFF fmt, ## arg)
 
 static char *get_prompt(void)
 {
@@ -135,7 +135,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	for (i = 3; i < len; i++)
 		g_string_append_printf(s, "%02x ", pdu[i]);
 
-	rl_printf("%s\n", s->str);
+	interactive_printf("%s\n", s->str);
 	g_string_free(s, TRUE);
 
 	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
@@ -177,7 +177,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	g_attrib_register(attrib, ATT_OP_HANDLE_IND, GATTRIB_ALL_HANDLES,
 						events_handler, attrib, NULL);
 	set_state(STATE_CONNECTED);
-	rl_printf("Connection successful\n");
+	interactive_printf("Connection successful\n");
 }
 
 static void disconnect_io()
@@ -213,7 +213,7 @@ static void primary_all_cb(uint8_t status, GSList *services, void *user_data)
 
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
-		rl_printf("attr handle: 0x%04x, end grp handle: 0x%04x uuid: %s\n",
+		interactive_printf("attr handle: 0x%04x, end grp handle: 0x%04x uuid: %s\n",
 				prim->range.start, prim->range.end, prim->uuid);
 	}
 }
@@ -235,7 +235,7 @@ static void primary_by_uuid_cb(uint8_t status, GSList *ranges, void *user_data)
 
 	for (l = ranges; l; l = l->next) {
 		struct att_range *range = l->data;
-		rl_printf("Starting handle: 0x%04x Ending handle: 0x%04x\n",
+		interactive_printf("Starting handle: 0x%04x Ending handle: 0x%04x\n",
 						range->start, range->end);
 	}
 }
@@ -251,13 +251,13 @@ static void included_cb(uint8_t status, GSList *includes, void *user_data)
 	}
 
 	if (includes == NULL) {
-		rl_printf("No included services found for this range\n");
+		interactive_printf("No included services found for this range\n");
 		return;
 	}
 
 	for (l = includes; l; l = l->next) {
 		struct gatt_included *incl = l->data;
-		rl_printf("handle: 0x%04x, start handle: 0x%04x, "
+		interactive_printf("handle: 0x%04x, start handle: 0x%04x, "
 					"end handle: 0x%04x uuid: %s\n",
 					incl->handle, incl->range.start,
 					incl->range.end, incl->uuid);
@@ -277,7 +277,7 @@ static void char_cb(uint8_t status, GSList *characteristics, void *user_data)
 	for (l = characteristics; l; l = l->next) {
 		struct gatt_char *chars = l->data;
 
-		rl_printf("handle: 0x%04x, char properties: 0x%02x, char value "
+		interactive_printf("handle: 0x%04x, char properties: 0x%02x, char value "
 				"handle: 0x%04x, uuid: %s\n", chars->handle,
 				chars->properties, chars->value_handle,
 				chars->uuid);
@@ -297,7 +297,7 @@ static void char_desc_cb(uint8_t status, GSList *descriptors, void *user_data)
 	for (l = descriptors; l; l = l->next) {
 		struct gatt_desc *desc = l->data;
 
-		rl_printf("handle: 0x%04x, uuid: %s\n", desc->handle,
+		interactive_printf("handle: 0x%04x, uuid: %s\n", desc->handle,
 								desc->uuid);
 	}
 }
@@ -326,7 +326,7 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	for (i = 0; i < vlen; i++)
 		g_string_append_printf(s, "%02x ", value[i]);
 
-	rl_printf("%s\n", s->str);
+	interactive_printf("%s\n", s->str);
 	g_string_free(s, TRUE);
 }
 
@@ -358,7 +358,7 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		for (j = 0; j < list->len - 2; j++, value++)
 			g_string_append_printf(s, "%02x ", *value);
 
-		rl_printf("%s\n", s->str);
+		interactive_printf("%s\n", s->str);
 	}
 
 	att_data_list_free(list);
@@ -402,7 +402,7 @@ static void cmd_connect(int argcp, char **argvp)
 		return;
 	}
 
-	rl_printf("Attempting to connect to %s\n", opt_dst);
+	interactive_printf("Attempting to connect to %s\n", opt_dst);
 	set_state(STATE_CONNECTING);
 	iochannel = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
 					opt_psm, opt_mtu, connect_cb, &gerr);
@@ -631,7 +631,7 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	rl_printf("Characteristic value was written successfully\n");
+	interactive_printf("Characteristic value was written successfully\n");
 }
 
 static void cmd_char_write(int argcp, char **argvp)
@@ -646,7 +646,7 @@ static void cmd_char_write(int argcp, char **argvp)
 	}
 
 	if (argcp < 3) {
-		rl_printf("Usage: %s <handle> <new value>\n", argvp[0]);
+		interactive_printf("Usage: %s <handle> <new value>\n", argvp[0]);
 		return;
 	}
 
@@ -677,7 +677,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 	BtIOSecLevel sec_level;
 
 	if (argcp < 2) {
-		rl_printf("sec-level: %s\n", opt_sec_level);
+		interactive_printf("sec-level: %s\n", opt_sec_level);
 		return;
 	}
 
@@ -688,7 +688,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 	else if (strcasecmp(argvp[1], "low") == 0)
 		sec_level = BT_IO_SEC_LOW;
 	else {
-		rl_printf("Allowed values: low | medium | high\n");
+		interactive_printf("Allowed values: low | medium | high\n");
 		return;
 	}
 
@@ -699,7 +699,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 		return;
 
 	if (opt_psm) {
-		rl_printf("Change will take effect on reconnection\n");
+		interactive_printf("Change will take effect on reconnection\n");
 		return;
 	}
 
@@ -731,7 +731,7 @@ static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	mtu = MIN(mtu, opt_mtu);
 	/* Set new value for MTU in client */
 	if (g_attrib_set_mtu(attrib, mtu))
-		rl_printf("MTU was exchanged successfully: %d\n", mtu);
+		interactive_printf("MTU was exchanged successfully: %d\n", mtu);
 	else
 		error("Error exchanging MTU\n");
 }
@@ -749,7 +749,7 @@ static void cmd_mtu(int argcp, char **argvp)
 	}
 
 	if (argcp < 2) {
-		rl_printf("Usage: mtu <value>\n");
+		interactive_printf("Usage: mtu <value>\n");
 		return;
 	}
 
@@ -813,7 +813,7 @@ static void cmd_help(int argcp, char **argvp)
 	int i;
 
 	for (i = 0; commands[i].cmd; i++)
-		rl_printf("%-15s %-30s %s\n", commands[i].cmd,
+		interactive_printf("%-15s %-30s %s\n", commands[i].cmd,
 				commands[i].params, commands[i].desc);
 }
 
@@ -824,7 +824,7 @@ static void parse_line(char *line_read)
 	int i;
 
 	if (line_read == NULL) {
-		rl_printf("\n");
+		interactive_printf("\n");
 		cmd_exit(0, NULL);
 		return;
 	}
diff --git a/client/agent.c b/client/agent.c
index 1034cad..4691afe 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -173,7 +173,7 @@ static void agent_release(DBusConnection *conn)
 static DBusMessage *release_agent(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	rl_printf("Agent released\n");
+	interactive_printf("Agent released\n");
 
 	agent_release(conn);
 
@@ -185,7 +185,7 @@ static DBusMessage *request_pincode(DBusConnection *conn,
 {
 	const char *device;
 
-	rl_printf("Request PIN code\n");
+	interactive_printf("Request PIN code\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 							DBUS_TYPE_INVALID);
@@ -206,7 +206,7 @@ static DBusMessage *display_pincode(DBusConnection *conn,
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_STRING, &pincode, DBUS_TYPE_INVALID);
 
-	rl_printf(AGENT_PROMPT "PIN code: %s\n", pincode);
+	interactive_printf(AGENT_PROMPT "PIN code: %s\n", pincode);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -216,7 +216,7 @@ static DBusMessage *request_passkey(DBusConnection *conn,
 {
 	const char *device;
 
-	rl_printf("Request passkey\n");
+	interactive_printf("Request passkey\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 							DBUS_TYPE_INVALID);
@@ -246,7 +246,7 @@ static DBusMessage *display_passkey(DBusConnection *conn,
 	if (entered > strlen(passkey_full))
 		entered = strlen(passkey_full);
 
-	rl_printf(AGENT_PROMPT "Passkey: "
+	interactive_printf(AGENT_PROMPT "Passkey: "
 			COLOR_BOLDGRAY "%.*s" COLOR_BOLDWHITE "%s\n" COLOR_OFF,
 				entered, passkey_full, passkey_full + entered);
 
@@ -260,7 +260,7 @@ static DBusMessage *request_confirmation(DBusConnection *conn,
 	dbus_uint32_t passkey;
 	char *str;
 
-	rl_printf("Request confirmation\n");
+	interactive_printf("Request confirmation\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_UINT32, &passkey, DBUS_TYPE_INVALID);
@@ -279,7 +279,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 {
 	const char *device;
 
-	rl_printf("Request authorization\n");
+	interactive_printf("Request authorization\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 							DBUS_TYPE_INVALID);
@@ -297,7 +297,7 @@ static DBusMessage *authorize_service(DBusConnection *conn,
 	const char *device, *uuid;
 	char *str;
 
-	rl_printf("Authorize service\n");
+	interactive_printf("Authorize service\n");
 
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_STRING, &uuid, DBUS_TYPE_INVALID);
@@ -314,7 +314,7 @@ static DBusMessage *authorize_service(DBusConnection *conn,
 static DBusMessage *cancel_request(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	rl_printf("Request canceled\n");
+	interactive_printf("Request canceled\n");
 
 	agent_release_prompt();
 	dbus_message_unref(pending_message);
@@ -369,14 +369,14 @@ static void register_agent_reply(DBusMessage *message, void *user_data)
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
 		agent_registered = TRUE;
-		rl_printf("Agent registered\n");
+		interactive_printf("Agent registered\n");
 	} else {
-		rl_printf("Failed to register agent: %s\n", error.name);
+		interactive_printf("Failed to register agent: %s\n", error.name);
 		dbus_error_free(&error);
 
 		if (g_dbus_unregister_interface(conn, AGENT_PATH,
 						AGENT_INTERFACE) == FALSE)
-			rl_printf("Failed to unregister agent object\n");
+			interactive_printf("Failed to unregister agent object\n");
 	}
 }
 
@@ -385,7 +385,7 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 
 {
 	if (agent_registered == TRUE) {
-		rl_printf("Agent is already registered\n");
+		interactive_printf("Agent is already registered\n");
 		return;
 	}
 
@@ -394,7 +394,7 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 	if (g_dbus_register_interface(conn, AGENT_PATH,
 					AGENT_INTERFACE, methods,
 					NULL, NULL, NULL, NULL) == FALSE) {
-		rl_printf("Failed to register agent object\n");
+		interactive_printf("Failed to register agent object\n");
 		return;
 	}
 
@@ -402,7 +402,7 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 						register_agent_setup,
 						register_agent_reply,
 						conn, NULL) == FALSE) {
-		rl_printf("Failed to call register agent method\n");
+		interactive_printf("Failed to call register agent method\n");
 		return;
 	}
 
@@ -424,10 +424,10 @@ static void unregister_agent_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
-		rl_printf("Agent unregistered\n");
+		interactive_printf("Agent unregistered\n");
 		agent_release(conn);
 	} else {
-		rl_printf("Failed to unregister agent: %s\n", error.name);
+		interactive_printf("Failed to unregister agent: %s\n", error.name);
 		dbus_error_free(&error);
 	}
 }
@@ -435,12 +435,12 @@ static void unregister_agent_reply(DBusMessage *message, void *user_data)
 void agent_unregister(DBusConnection *conn, GDBusProxy *manager)
 {
 	if (agent_registered == FALSE) {
-		rl_printf("No agent is registered\n");
+		interactive_printf("No agent is registered\n");
 		return;
 	}
 
 	if (!manager) {
-		rl_printf("Agent unregistered\n");
+		interactive_printf("Agent unregistered\n");
 		agent_release(conn);
 		return;
 	}
@@ -449,7 +449,7 @@ void agent_unregister(DBusConnection *conn, GDBusProxy *manager)
 						unregister_agent_setup,
 						unregister_agent_reply,
 						conn, NULL) == FALSE) {
-		rl_printf("Failed to call unregister agent method\n");
+		interactive_printf("Failed to call unregister agent method\n");
 		return;
 	}
 }
@@ -468,18 +468,18 @@ static void request_default_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to request default agent: %s\n", error.name);
+		interactive_printf("Failed to request default agent: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Default agent request successful\n");
+	interactive_printf("Default agent request successful\n");
 }
 
 void agent_default(DBusConnection *conn, GDBusProxy *manager)
 {
 	if (agent_registered == FALSE) {
-		rl_printf("No agent is registered\n");
+		interactive_printf("No agent is registered\n");
 		return;
 	}
 
@@ -487,7 +487,7 @@ void agent_default(DBusConnection *conn, GDBusProxy *manager)
 						request_default_setup,
 						request_default_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to call request default agent method\n");
+		interactive_printf("Failed to call request default agent method\n");
 		return;
 	}
 }
diff --git a/client/display.c b/client/display.c
index f016853..25eafe3 100644
--- a/client/display.c
+++ b/client/display.c
@@ -45,7 +45,7 @@ static struct io *input = NULL;
 static const struct interactive_command *commands = NULL;
 static interactive_prompt_func_t prompt_cb = NULL;
 
-void rl_printf(const char *fmt, ...)
+void interactive_printf(const char *fmt, ...)
 {
 	va_list args;
 	bool save_input;
@@ -75,7 +75,7 @@ void rl_printf(const char *fmt, ...)
 	}
 }
 
-void rl_hexdump(const unsigned char *buf, size_t len)
+void interactive_hexdump(const unsigned char *buf, size_t len)
 {
 	static const char hexdigits[] = "0123456789abcdef";
 	char str[68];
@@ -96,7 +96,7 @@ void rl_hexdump(const unsigned char *buf, size_t len)
 			str[49] = ' ';
 			str[50] = ' ';
 			str[67] = '\0';
-			rl_printf("%s\n", str);
+			interactive_printf("%s\n", str);
 			str[0] = ' ';
 		}
 	}
@@ -112,7 +112,7 @@ void rl_hexdump(const unsigned char *buf, size_t len)
 		str[49] = ' ';
 		str[50] = ' ';
 		str[67] = '\0';
-		rl_printf("%s\n", str);
+		interactive_printf("%s\n", str);
 	}
 }
 
@@ -293,15 +293,15 @@ static void rl_handler(char *input)
 	}
 
 	if (strcmp(cmd, "help")) {
-		rl_printf("Invalid command\n");
+		interactive_printf("Invalid command\n");
 		goto free_we;
 	}
 
-	rl_printf("Available commands:\n");
+	interactive_printf("Available commands:\n");
 
 	for (i = 0; commands[i].cmd; i++) {
 		if (commands[i].doc)
-			rl_printf("  %s %-*s %s\n", commands[i].cmd,
+			interactive_printf("  %s %-*s %s\n", commands[i].cmd,
 					(int)(25 - strlen(commands[i].cmd)),
 					"", commands[i].doc ? : "");
 	}
@@ -310,7 +310,7 @@ static void rl_handler(char *input)
 		if (!interactive_cmd[i].doc)
 			continue;
 
-		rl_printf("  %s %-*s %s\n", interactive_cmd[i].cmd,
+		interactive_printf("  %s %-*s %s\n", interactive_cmd[i].cmd,
 				(int)(25 - strlen(interactive_cmd[i].cmd)),
 				"", interactive_cmd[i].doc ? : "");
 	}
diff --git a/client/display.h b/client/display.h
index c858639..e223670 100644
--- a/client/display.h
+++ b/client/display.h
@@ -47,5 +47,5 @@ void interactive_update_prompt(const char *prompt);
 void interactive_prompt(const char *msg);
 void interactive_release_prompt(void);
 
-void rl_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
-void rl_hexdump(const unsigned char *buf, size_t len);
+void interactive_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void interactive_hexdump(const unsigned char *buf, size_t len);
diff --git a/client/gatt.c b/client/gatt.c
index 3785452..4bdbaba 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -70,7 +70,7 @@ static void print_service(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%sService %s %s %s\n",
+	interactive_printf("%s%s%sService %s %s %s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
@@ -106,7 +106,7 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%sCharacteristic %s %s\n",
+	interactive_printf("%s%s%sCharacteristic %s %s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
@@ -171,7 +171,7 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%sDescriptor %s %s\n",
+	interactive_printf("%s%s%sDescriptor %s %s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
@@ -338,7 +338,7 @@ static void read_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to read: %s\n", error.name);
+		interactive_printf("Failed to read: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -346,7 +346,7 @@ static void read_reply(DBusMessage *message, void *user_data)
 	dbus_message_iter_init(message, &iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		rl_printf("Invalid response to read\n");
+		interactive_printf("Invalid response to read\n");
 		return;
 	}
 
@@ -354,22 +354,22 @@ static void read_reply(DBusMessage *message, void *user_data)
 	dbus_message_iter_get_fixed_array(&array, &value, &len);
 
 	if (len < 0) {
-		rl_printf("Unable to parse value\n");
+		interactive_printf("Unable to parse value\n");
 		return;
 	}
 
-	rl_hexdump(value, len);
+	interactive_hexdump(value, len);
 }
 
 static void read_attribute(GDBusProxy *proxy)
 {
 	if (g_dbus_proxy_method_call(proxy, "ReadValue", NULL, read_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to read\n");
+		interactive_printf("Failed to read\n");
 		return;
 	}
 
-	rl_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
 }
 
 void gatt_read_attribute(GDBusProxy *proxy)
@@ -383,7 +383,7 @@ void gatt_read_attribute(GDBusProxy *proxy)
 		return;
 	}
 
-	rl_printf("Unable to read attribute %s\n",
+	interactive_printf("Unable to read attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -394,7 +394,7 @@ static void write_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to write: %s\n", error.name);
+		interactive_printf("Failed to write: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -426,13 +426,13 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 			continue;
 
 		if (i > 512) {
-			rl_printf("Too much data\n");
+			interactive_printf("Too much data\n");
 			return;
 		}
 
 		val = strtol(entry, &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
-			rl_printf("Invalid value at index %d\n", i);
+			interactive_printf("Invalid value at index %d\n", i);
 			return;
 		}
 
@@ -444,11 +444,11 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup,
 					write_reply, &iov, NULL) == FALSE) {
-		rl_printf("Failed to write\n");
+		interactive_printf("Failed to write\n");
 		return;
 	}
 
-	rl_printf("Attempting to write %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Attempting to write %s\n", g_dbus_proxy_get_path(proxy));
 }
 
 void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
@@ -462,7 +462,7 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
 		return;
 	}
 
-	rl_printf("Unable to write attribute %s\n",
+	interactive_printf("Unable to write attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -474,13 +474,13 @@ static void notify_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to %s notify: %s\n",
+		interactive_printf("Failed to %s notify: %s\n",
 				enable ? "start" : "stop", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Notify %s\n", enable == TRUE ? "started" : "stopped");
+	interactive_printf("Notify %s\n", enable == TRUE ? "started" : "stopped");
 }
 
 static void notify_attribute(GDBusProxy *proxy, bool enable)
@@ -494,7 +494,7 @@ static void notify_attribute(GDBusProxy *proxy, bool enable)
 
 	if (g_dbus_proxy_method_call(proxy, method, NULL, notify_reply,
 				GUINT_TO_POINTER(enable), NULL) == FALSE) {
-		rl_printf("Failed to %s notify\n", enable ? "start" : "stop");
+		interactive_printf("Failed to %s notify\n", enable ? "start" : "stop");
 		return;
 	}
 }
@@ -509,6 +509,6 @@ void gatt_notify_attribute(GDBusProxy *proxy, bool enable)
 		return;
 	}
 
-	rl_printf("Unable to notify attribute %s\n",
+	interactive_printf("Unable to notify attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
diff --git a/client/main.c b/client/main.c
index 809c372..96781b2 100644
--- a/client/main.c
+++ b/client/main.c
@@ -120,7 +120,7 @@ static void print_adapter(GDBusProxy *proxy, const char *description)
 	else
 		name = "<unknown>";
 
-	rl_printf("%s%s%sController %s %s %s\n",
+	interactive_printf("%s%s%sController %s %s %s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
@@ -144,7 +144,7 @@ static void print_device(GDBusProxy *proxy, const char *description)
 	else
 		name = "<unknown>";
 
-	rl_printf("%s%s%sDevice %s %s\n",
+	interactive_printf("%s%s%sDevice %s %s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
@@ -163,39 +163,39 @@ static void print_iter(const char *label, const char *name,
 	DBusMessageIter subiter;
 
 	if (iter == NULL) {
-		rl_printf("%s%s is nil\n", label, name);
+		interactive_printf("%s%s is nil\n", label, name);
 		return;
 	}
 
 	switch (dbus_message_iter_get_arg_type(iter)) {
 	case DBUS_TYPE_INVALID:
-		rl_printf("%s%s is invalid\n", label, name);
+		interactive_printf("%s%s is invalid\n", label, name);
 		break;
 	case DBUS_TYPE_STRING:
 	case DBUS_TYPE_OBJECT_PATH:
 		dbus_message_iter_get_basic(iter, &valstr);
-		rl_printf("%s%s: %s\n", label, name, valstr);
+		interactive_printf("%s%s: %s\n", label, name, valstr);
 		break;
 	case DBUS_TYPE_BOOLEAN:
 		dbus_message_iter_get_basic(iter, &valbool);
-		rl_printf("%s%s: %s\n", label, name,
+		interactive_printf("%s%s: %s\n", label, name,
 					valbool == TRUE ? "yes" : "no");
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
+		interactive_printf("%s%s: 0x%06x\n", label, name, valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
+		interactive_printf("%s%s: 0x%04x\n", label, name, valu16);
 		break;
 	case DBUS_TYPE_INT16:
 		dbus_message_iter_get_basic(iter, &vals16);
-		rl_printf("%s%s: %d\n", label, name, vals16);
+		interactive_printf("%s%s: %d\n", label, name, vals16);
 		break;
 	case DBUS_TYPE_BYTE:
 		dbus_message_iter_get_basic(iter, &byte);
-		rl_printf("%s%s: 0x%02x\n", label, name, byte);
+		interactive_printf("%s%s: 0x%02x\n", label, name, byte);
 		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
@@ -216,7 +216,7 @@ static void print_iter(const char *label, const char *name,
 		print_iter(label, valstr, &subiter);
 		break;
 	default:
-		rl_printf("%s%s has unsupported type\n", label, name);
+		interactive_printf("%s%s has unsupported type\n", label, name);
 		break;
 	}
 }
@@ -262,10 +262,10 @@ static void print_uuids(GDBusProxy *proxy)
 				n = sizeof(str) - 1;
 			}
 
-			rl_printf("\tUUID: %s%*c(%s)\n",
+			interactive_printf("\tUUID: %s%*c(%s)\n",
 						str, 26 - n, ' ', uuid);
 		} else
-			rl_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
+			interactive_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -513,7 +513,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 static void message_handler(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	rl_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
+	interactive_printf("[SIGNAL] %s.%s\n", dbus_message_get_interface(message),
 					dbus_message_get_member(message));
 }
 
@@ -541,7 +541,7 @@ static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
 static gboolean check_default_ctrl(void)
 {
 	if (!default_ctrl) {
-		rl_printf("No default controller available\n");
+		interactive_printf("No default controller available\n");
 		return FALSE;
 	}
 
@@ -551,7 +551,7 @@ static gboolean check_default_ctrl(void)
 static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
 {
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing on/off argument\n");
+		interactive_printf("Missing on/off argument\n");
 		return FALSE;
 	}
 
@@ -565,7 +565,7 @@ static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
 		return TRUE;
 	}
 
-	rl_printf("Invalid argument %s\n", arg);
+	interactive_printf("Invalid argument %s\n", arg);
 	return FALSE;
 }
 
@@ -575,7 +575,7 @@ static gboolean parse_argument_agent(const char *arg, dbus_bool_t *value,
 	const char * const *opt;
 
 	if (arg == NULL || strlen(arg) == 0) {
-		rl_printf("Missing on/off/capability argument\n");
+		interactive_printf("Missing on/off/capability argument\n");
 		return FALSE;
 	}
 
@@ -598,7 +598,7 @@ static gboolean parse_argument_agent(const char *arg, dbus_bool_t *value,
 		}
 	}
 
-	rl_printf("Invalid argument %s\n", arg);
+	interactive_printf("Invalid argument %s\n", arg);
 	return FALSE;
 }
 
@@ -626,7 +626,7 @@ static void cmd_show(const char *arg)
 	} else {
 		proxy = find_proxy_by_address(ctrl_list, arg);
 		if (!proxy) {
-			rl_printf("Controller %s not available\n", arg);
+			interactive_printf("Controller %s not available\n", arg);
 			return;
 		}
 	}
@@ -635,7 +635,7 @@ static void cmd_show(const char *arg)
 		return;
 
 	dbus_message_iter_get_basic(&iter, &address);
-	rl_printf("Controller %s\n", address);
+	interactive_printf("Controller %s\n", address);
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Alias");
@@ -653,13 +653,13 @@ static void cmd_select(const char *arg)
 	GDBusProxy *proxy;
 
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing controller address argument\n");
+		interactive_printf("Missing controller address argument\n");
 		return;
 	}
 
 	proxy = find_proxy_by_address(ctrl_list, arg);
 	if (!proxy) {
-		rl_printf("Controller %s not available\n", arg);
+		interactive_printf("Controller %s not available\n", arg);
 		return;
 	}
 
@@ -708,9 +708,9 @@ static void generic_callback(const DBusError *error, void *user_data)
 	char *str = user_data;
 
 	if (dbus_error_is_set(error))
-		rl_printf("Failed to set %s: %s\n", str, error->name);
+		interactive_printf("Failed to set %s: %s\n", str, error->name);
 	else
-		rl_printf("Changing %s succeeded\n", str);
+		interactive_printf("Changing %s succeeded\n", str);
 }
 
 static void cmd_system_alias(const char *arg)
@@ -718,7 +718,7 @@ static void cmd_system_alias(const char *arg)
 	char *name;
 
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing name argument\n");
+		interactive_printf("Missing name argument\n");
 		return;
 	}
 
@@ -832,7 +832,7 @@ static void cmd_agent(const char *arg)
 			agent_register(dbus_conn, agent_manager,
 						auto_register_agent);
 		else
-			rl_printf("Agent registration enabled\n");
+			interactive_printf("Agent registration enabled\n");
 	} else {
 		g_free(auto_register_agent);
 		auto_register_agent = NULL;
@@ -840,7 +840,7 @@ static void cmd_agent(const char *arg)
 		if (agent_manager)
 			agent_unregister(dbus_conn, agent_manager);
 		else
-			rl_printf("Agent registration disabled\n");
+			interactive_printf("Agent registration disabled\n");
 	}
 }
 
@@ -857,13 +857,13 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to %s discovery: %s\n",
+		interactive_printf("Failed to %s discovery: %s\n",
 				enable == TRUE ? "start" : "stop", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Discovery %s\n", enable == TRUE ? "started" : "stopped");
+	interactive_printf("Discovery %s\n", enable == TRUE ? "started" : "stopped");
 }
 
 static void cmd_scan(const char *arg)
@@ -885,7 +885,7 @@ static void cmd_scan(const char *arg)
 	if (g_dbus_proxy_method_call(default_ctrl, method,
 				NULL, start_discovery_reply,
 				GUINT_TO_POINTER(enable), NULL) == FALSE) {
-		rl_printf("Failed to %s discovery\n",
+		interactive_printf("Failed to %s discovery\n",
 					enable == TRUE ? "start" : "stop");
 		return;
 	}
@@ -898,13 +898,13 @@ static struct GDBusProxy *find_device(const char *arg)
 	if (!arg || !strlen(arg)) {
 		if (default_dev)
 			return default_dev;
-		rl_printf("Missing device address argument\n");
+		interactive_printf("Missing device address argument\n");
 		return NULL;
 	}
 
 	proxy = find_proxy_by_address(dev_list, arg);
 	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
+		interactive_printf("Device %s not available\n", arg);
 		return NULL;
 	}
 
@@ -925,7 +925,7 @@ static void cmd_info(const char *arg)
 		return;
 
 	dbus_message_iter_get_basic(&iter, &address);
-	rl_printf("Device %s\n", address);
+	interactive_printf("Device %s\n", address);
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Alias");
@@ -948,12 +948,12 @@ static void pair_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to pair: %s\n", error.name);
+		interactive_printf("Failed to pair: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Pairing successful\n");
+	interactive_printf("Pairing successful\n");
 }
 
 static void cmd_pair(const char *arg)
@@ -966,11 +966,11 @@ static void cmd_pair(const char *arg)
 
 	if (g_dbus_proxy_method_call(proxy, "Pair", NULL, pair_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to pair\n");
+		interactive_printf("Failed to pair\n");
 		return;
 	}
 
-	rl_printf("Attempting to pair with %s\n", arg);
+	interactive_printf("Attempting to pair with %s\n", arg);
 }
 
 static void cmd_trust(const char *arg)
@@ -1068,12 +1068,12 @@ static void remove_device_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to remove device: %s\n", error.name);
+		interactive_printf("Failed to remove device: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Device has been removed\n");
+	interactive_printf("Device has been removed\n");
 }
 
 static void remove_device_setup(DBusMessageIter *iter, void *user_data)
@@ -1089,7 +1089,7 @@ static void cmd_remove(const char *arg)
 	char *path;
 
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
+		interactive_printf("Missing device address argument\n");
 		return;
 	}
 
@@ -1098,7 +1098,7 @@ static void cmd_remove(const char *arg)
 
 	proxy = find_proxy_by_address(dev_list, arg);
 	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
+		interactive_printf("Device %s not available\n", arg);
 		return;
 	}
 
@@ -1108,7 +1108,7 @@ static void cmd_remove(const char *arg)
 						remove_device_setup,
 						remove_device_reply,
 						path, g_free) == FALSE) {
-		rl_printf("Failed to remove device\n");
+		interactive_printf("Failed to remove device\n");
 		g_free(path);
 		return;
 	}
@@ -1122,12 +1122,12 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to connect: %s\n", error.name);
+		interactive_printf("Failed to connect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Connection successful\n");
+	interactive_printf("Connection successful\n");
 
 	set_default_device(proxy, NULL);
 }
@@ -1137,23 +1137,23 @@ static void cmd_connect(const char *arg)
 	GDBusProxy *proxy;
 
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing device address argument\n");
+		interactive_printf("Missing device address argument\n");
 		return;
 	}
 
 	proxy = find_proxy_by_address(dev_list, arg);
 	if (!proxy) {
-		rl_printf("Device %s not available\n", arg);
+		interactive_printf("Device %s not available\n", arg);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_reply,
 							proxy, NULL) == FALSE) {
-		rl_printf("Failed to connect\n");
+		interactive_printf("Failed to connect\n");
 		return;
 	}
 
-	rl_printf("Attempting to connect to %s\n", arg);
+	interactive_printf("Attempting to connect to %s\n", arg);
 }
 
 static void disconn_reply(DBusMessage *message, void *user_data)
@@ -1164,12 +1164,12 @@ static void disconn_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to disconnect: %s\n", error.name);
+		interactive_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Successful disconnected\n");
+	interactive_printf("Successful disconnected\n");
 
 	if (proxy != default_dev)
 		return;
@@ -1187,11 +1187,11 @@ static void cmd_disconn(const char *arg)
 
 	if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, disconn_reply,
 							proxy, NULL) == FALSE) {
-		rl_printf("Failed to disconnect\n");
+		interactive_printf("Failed to disconnect\n");
 		return;
 	}
 
-	rl_printf("Attempting to disconnect from %s\n", arg);
+	interactive_printf("Attempting to disconnect from %s\n", arg);
 }
 
 static void cmd_list_attributes(const char *arg)
@@ -1210,12 +1210,12 @@ static void cmd_select_attribute(const char *arg)
 	GDBusProxy *proxy;
 
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing attribute argument\n");
+		interactive_printf("Missing attribute argument\n");
 		return;
 	}
 
 	if (!default_dev) {
-		rl_printf("No device connected\n");
+		interactive_printf("No device connected\n");
 		return;
 	}
 
@@ -1231,13 +1231,13 @@ static struct GDBusProxy *find_attribute(const char *arg)
 	if (!arg || !strlen(arg)) {
 		if (default_attr)
 			return default_attr;
-		rl_printf("Missing attribute argument\n");
+		interactive_printf("Missing attribute argument\n");
 		return NULL;
 	}
 
 	proxy = gatt_select_attribute(arg);
 	if (!proxy) {
-		rl_printf("Attribute %s not available\n", arg);
+		interactive_printf("Attribute %s not available\n", arg);
 		return NULL;
 	}
 
@@ -1265,14 +1265,14 @@ static void cmd_attribute_info(const char *arg)
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	if (!strcmp(iface, "org.bluez.GattService1")) {
-		rl_printf("Service - %s\n", text);
+		interactive_printf("Service - %s\n", text);
 
 		print_property(proxy, "UUID");
 		print_property(proxy, "Primary");
 		print_property(proxy, "Characteristics");
 		print_property(proxy, "Includes");
 	} else if (!strcmp(iface, "org.bluez.GattCharacteristic1")) {
-		rl_printf("Characteristic - %s\n", text);
+		interactive_printf("Characteristic - %s\n", text);
 
 		print_property(proxy, "UUID");
 		print_property(proxy, "Service");
@@ -1281,7 +1281,7 @@ static void cmd_attribute_info(const char *arg)
 		print_property(proxy, "Flags");
 		print_property(proxy, "Descriptors");
 	} else if (!strcmp(iface, "org.bluez.GattDescriptor1")) {
-		rl_printf("Descriptor - %s\n", text);
+		interactive_printf("Descriptor - %s\n", text);
 
 		print_property(proxy, "UUID");
 		print_property(proxy, "Characteristic");
@@ -1292,7 +1292,7 @@ static void cmd_attribute_info(const char *arg)
 static void cmd_read(const char *arg)
 {
 	if (!default_attr) {
-		rl_printf("No attribute selected\n");
+		interactive_printf("No attribute selected\n");
 		return;
 	}
 
@@ -1302,12 +1302,12 @@ static void cmd_read(const char *arg)
 static void cmd_write(const char *arg)
 {
 	if (!arg || !strlen(arg)) {
-		rl_printf("Missing data argument\n");
+		interactive_printf("Missing data argument\n");
 		return;
 	}
 
 	if (!default_attr) {
-		rl_printf("No attribute selected\n");
+		interactive_printf("No attribute selected\n");
 		return;
 	}
 
@@ -1322,7 +1322,7 @@ static void cmd_notify(const char *arg)
 		return;
 
 	if (!default_attr) {
-		rl_printf("No attribute selected\n");
+		interactive_printf("No attribute selected\n");
 		return;
 	}
 
@@ -1331,7 +1331,7 @@ static void cmd_notify(const char *arg)
 
 static void cmd_version(const char *arg)
 {
-	rl_printf("Version %s\n", VERSION);
+	interactive_printf("Version %s\n", VERSION);
 }
 
 static void cmd_quit(const char *arg)
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index f10d9be..22e0557 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -83,7 +83,7 @@ static void cmd_quit(int argc, char *argv[])
 static bool check_default_player(void)
 {
 	if (!default_player) {
-		rl_printf("No default player available\n");
+		interactive_printf("No default player available\n");
 		return FALSE;
 	}
 
@@ -97,12 +97,12 @@ static void play_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to play: %s\n", error.name);
+		interactive_printf("Failed to play: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Play successful\n");
+	interactive_printf("Play successful\n");
 }
 
 static GDBusProxy *find_item(const char *path)
@@ -125,17 +125,17 @@ static void cmd_play_item(int argc, char *argv[])
 
 	proxy = find_item(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Item %s not available\n", argv[1]);
+		interactive_printf("Item %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Play", NULL, play_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		interactive_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to play %s\n", argv[1]);
+	interactive_printf("Attempting to play %s\n", argv[1]);
 }
 
 static void cmd_play(int argc, char *argv[])
@@ -148,11 +148,11 @@ static void cmd_play(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Play", NULL, play_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		interactive_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to play\n");
+	interactive_printf("Attempting to play\n");
 }
 
 static void pause_reply(DBusMessage *message, void *user_data)
@@ -162,12 +162,12 @@ static void pause_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to pause: %s\n", error.name);
+		interactive_printf("Failed to pause: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Pause successful\n");
+	interactive_printf("Pause successful\n");
 }
 
 static void cmd_pause(int argc, char *argv[])
@@ -177,11 +177,11 @@ static void cmd_pause(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Pause", NULL,
 					pause_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		interactive_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to pause\n");
+	interactive_printf("Attempting to pause\n");
 }
 
 static void stop_reply(DBusMessage *message, void *user_data)
@@ -191,12 +191,12 @@ static void stop_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to stop: %s\n", error.name);
+		interactive_printf("Failed to stop: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Stop successful\n");
+	interactive_printf("Stop successful\n");
 }
 
 static void cmd_stop(int argc, char *argv[])
@@ -206,11 +206,11 @@ static void cmd_stop(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Stop", NULL, stop_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to stop\n");
+		interactive_printf("Failed to stop\n");
 		return;
 	}
 
-	rl_printf("Attempting to stop\n");
+	interactive_printf("Attempting to stop\n");
 }
 
 static void next_reply(DBusMessage *message, void *user_data)
@@ -220,12 +220,12 @@ static void next_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to jump to next: %s\n", error.name);
+		interactive_printf("Failed to jump to next: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Next successful\n");
+	interactive_printf("Next successful\n");
 }
 
 static void cmd_next(int argc, char *argv[])
@@ -235,11 +235,11 @@ static void cmd_next(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Next", NULL, next_reply,
 							NULL, NULL) == FALSE) {
-		rl_printf("Failed to jump to next\n");
+		interactive_printf("Failed to jump to next\n");
 		return;
 	}
 
-	rl_printf("Attempting to jump to next\n");
+	interactive_printf("Attempting to jump to next\n");
 }
 
 static void previous_reply(DBusMessage *message, void *user_data)
@@ -249,12 +249,12 @@ static void previous_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to jump to previous: %s\n", error.name);
+		interactive_printf("Failed to jump to previous: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Previous successful\n");
+	interactive_printf("Previous successful\n");
 }
 
 static void cmd_previous(int argc, char *argv[])
@@ -264,11 +264,11 @@ static void cmd_previous(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Previous", NULL,
 					previous_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to jump to previous\n");
+		interactive_printf("Failed to jump to previous\n");
 		return;
 	}
 
-	rl_printf("Attempting to jump to previous\n");
+	interactive_printf("Attempting to jump to previous\n");
 }
 
 static void fast_forward_reply(DBusMessage *message, void *user_data)
@@ -278,12 +278,12 @@ static void fast_forward_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to fast forward: %s\n", error.name);
+		interactive_printf("Failed to fast forward: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("FastForward successful\n");
+	interactive_printf("FastForward successful\n");
 }
 
 static void cmd_fast_forward(int argc, char *argv[])
@@ -293,11 +293,11 @@ static void cmd_fast_forward(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "FastForward", NULL,
 				fast_forward_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to jump to previous\n");
+		interactive_printf("Failed to jump to previous\n");
 		return;
 	}
 
-	rl_printf("Fast forward playback\n");
+	interactive_printf("Fast forward playback\n");
 }
 
 static void rewind_reply(DBusMessage *message, void *user_data)
@@ -307,12 +307,12 @@ static void rewind_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to rewind: %s\n", error.name);
+		interactive_printf("Failed to rewind: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Rewind successful\n");
+	interactive_printf("Rewind successful\n");
 }
 
 static void cmd_rewind(int argc, char *argv[])
@@ -322,11 +322,11 @@ static void cmd_rewind(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(default_player, "Rewind", NULL,
 					rewind_reply, NULL, NULL) == FALSE) {
-		rl_printf("Failed to rewind\n");
+		interactive_printf("Failed to rewind\n");
 		return;
 	}
 
-	rl_printf("Rewind playback\n");
+	interactive_printf("Rewind playback\n");
 }
 
 static void generic_callback(const DBusError *error, void *user_data)
@@ -334,9 +334,9 @@ static void generic_callback(const DBusError *error, void *user_data)
 	char *str = user_data;
 
 	if (dbus_error_is_set(error))
-		rl_printf("Failed to set %s: %s\n", str, error->name);
+		interactive_printf("Failed to set %s: %s\n", str, error->name);
 	else
-		rl_printf("Changing %s succeeded\n", str);
+		interactive_printf("Changing %s succeeded\n", str);
 }
 
 static void cmd_equalizer(int argc, char *argv[])
@@ -348,12 +348,12 @@ static void cmd_equalizer(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing on/off argument\n");
+		interactive_printf("Missing on/off argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Equalizer", &iter)) {
-		rl_printf("Operation not supported\n");
+		interactive_printf("Operation not supported\n");
 		return;
 	}
 
@@ -363,12 +363,12 @@ static void cmd_equalizer(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to setting equalizer\n");
+		interactive_printf("Failed to setting equalizer\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set equalizer\n");
+	interactive_printf("Attempting to set equalizer\n");
 }
 
 static void cmd_repeat(int argc, char *argv[])
@@ -380,12 +380,12 @@ static void cmd_repeat(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing mode argument\n");
+		interactive_printf("Missing mode argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Repeat", &iter)) {
-		rl_printf("Operation not supported\n");
+		interactive_printf("Operation not supported\n");
 		return;
 	}
 
@@ -395,12 +395,12 @@ static void cmd_repeat(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to set repeat\n");
+		interactive_printf("Failed to set repeat\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set repeat\n");
+	interactive_printf("Attempting to set repeat\n");
 }
 
 static void cmd_shuffle(int argc, char *argv[])
@@ -412,12 +412,12 @@ static void cmd_shuffle(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing mode argument\n");
+		interactive_printf("Missing mode argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Shuffle", &iter)) {
-		rl_printf("Operation not supported\n");
+		interactive_printf("Operation not supported\n");
 		return;
 	}
 
@@ -427,12 +427,12 @@ static void cmd_shuffle(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to set shuffle\n");
+		interactive_printf("Failed to set shuffle\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set shuffle\n");
+	interactive_printf("Attempting to set shuffle\n");
 }
 
 static void cmd_scan(int argc, char *argv[])
@@ -444,12 +444,12 @@ static void cmd_scan(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing mode argument\n");
+		interactive_printf("Missing mode argument\n");
 		return;
 	}
 
 	if (!g_dbus_proxy_get_property(default_player, "Shuffle", &iter)) {
-		rl_printf("Operation not supported\n");
+		interactive_printf("Operation not supported\n");
 		return;
 	}
 
@@ -459,12 +459,12 @@ static void cmd_scan(int argc, char *argv[])
 						DBUS_TYPE_STRING, &value,
 						generic_callback, value,
 						g_free) == FALSE) {
-		rl_printf("Failed to set scan\n");
+		interactive_printf("Failed to set scan\n");
 		g_free(value);
 		return;
 	}
 
-	rl_printf("Attempting to set scan\n");
+	interactive_printf("Attempting to set scan\n");
 }
 
 static char *proxy_description(GDBusProxy *proxy, const char *title,
@@ -487,7 +487,7 @@ static void print_player(GDBusProxy *proxy, const char *description)
 
 	str = proxy_description(proxy, "Player", description);
 
-	rl_printf("%s%s\n", str, default_player == proxy ? "[default]" : "");
+	interactive_printf("%s%s\n", str, default_player == proxy ? "[default]" : "");
 
 	g_free(str);
 }
@@ -527,35 +527,35 @@ static void print_iter(const char *label, const char *name,
 	DBusMessageIter subiter;
 
 	if (iter == NULL) {
-		rl_printf("%s%s is nil\n", label, name);
+		interactive_printf("%s%s is nil\n", label, name);
 		return;
 	}
 
 	switch (dbus_message_iter_get_arg_type(iter)) {
 	case DBUS_TYPE_INVALID:
-		rl_printf("%s%s is invalid\n", label, name);
+		interactive_printf("%s%s is invalid\n", label, name);
 		break;
 	case DBUS_TYPE_STRING:
 	case DBUS_TYPE_OBJECT_PATH:
 		dbus_message_iter_get_basic(iter, &valstr);
-		rl_printf("%s%s: %s\n", label, name, valstr);
+		interactive_printf("%s%s: %s\n", label, name, valstr);
 		break;
 	case DBUS_TYPE_BOOLEAN:
 		dbus_message_iter_get_basic(iter, &valbool);
-		rl_printf("%s%s: %s\n", label, name,
+		interactive_printf("%s%s: %s\n", label, name,
 					valbool == TRUE ? "yes" : "no");
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
+		interactive_printf("%s%s: 0x%06x\n", label, name, valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
+		interactive_printf("%s%s: 0x%04x\n", label, name, valu16);
 		break;
 	case DBUS_TYPE_INT16:
 		dbus_message_iter_get_basic(iter, &vals16);
-		rl_printf("%s%s: %d\n", label, name, vals16);
+		interactive_printf("%s%s: %d\n", label, name, vals16);
 		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
@@ -576,7 +576,7 @@ static void print_iter(const char *label, const char *name,
 		print_iter(label, valstr, &subiter);
 		break;
 	default:
-		rl_printf("%s%s has unsupported type\n", label, name);
+		interactive_printf("%s%s has unsupported type\n", label, name);
 		break;
 	}
 }
@@ -610,17 +610,17 @@ static void cmd_show_item(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing item address argument\n");
+		interactive_printf("Missing item address argument\n");
 		return;
 	}
 
 	proxy = find_item(argv[1]);
 	if (!proxy) {
-		rl_printf("Item %s not available\n", argv[1]);
+		interactive_printf("Item %s not available\n", argv[1]);
 		return;
 	}
 
-	rl_printf("Item %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Item %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Player");
 	print_property(proxy, "Name");
@@ -646,12 +646,12 @@ static void cmd_show(int argc, char *argv[])
 	} else {
 		proxy = find_player(argv[1]);
 		if (!proxy) {
-			rl_printf("Player %s not available\n", argv[1]);
+			interactive_printf("Player %s not available\n", argv[1]);
 			return;
 		}
 	}
 
-	rl_printf("Player %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Player %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Name");
 	print_property(proxy, "Repeat");
@@ -666,7 +666,7 @@ static void cmd_show(int argc, char *argv[])
 	if (folder == NULL)
 		return;
 
-	rl_printf("Folder %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Folder %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(folder, "Name");
 	print_property(folder, "NumberOfItems");
@@ -680,7 +680,7 @@ static void cmd_show(int argc, char *argv[])
 	if (item == NULL)
 		return;
 
-	rl_printf("Playlist %s\n", path);
+	interactive_printf("Playlist %s\n", path);
 
 	print_property(item, "Name");
 }
@@ -690,13 +690,13 @@ static void cmd_select(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing player address argument\n");
+		interactive_printf("Missing player address argument\n");
 		return;
 	}
 
 	proxy = find_player(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Player %s not available\n", argv[1]);
+		interactive_printf("Player %s not available\n", argv[1]);
 		return;
 	}
 
@@ -714,12 +714,12 @@ static void change_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to change folder: %s\n", error.name);
+		interactive_printf("Failed to change folder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("ChangeFolder successful\n");
+	interactive_printf("ChangeFolder successful\n");
 }
 
 static void change_folder_setup(DBusMessageIter *iter, void *user_data)
@@ -734,12 +734,12 @@ static void cmd_change_folder(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing item argument\n");
+		interactive_printf("Missing item argument\n");
 		return;
 	}
 
 	if (dbus_validate_path(argv[1], NULL) == FALSE) {
-		rl_printf("Not a valid path\n");
+		interactive_printf("Not a valid path\n");
 		return;
 	}
 
@@ -748,17 +748,17 @@ static void cmd_change_folder(int argc, char *argv[])
 
 	proxy = find_folder(g_dbus_proxy_get_path(default_player));
 	if (proxy == NULL) {
-		rl_printf("Operation not supported\n");
+		interactive_printf("Operation not supported\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
 				change_folder_reply, argv[1], NULL) == FALSE) {
-		rl_printf("Failed to change current folder\n");
+		interactive_printf("Failed to change current folder\n");
 		return;
 	}
 
-	rl_printf("Attempting to change folder\n");
+	interactive_printf("Attempting to change folder\n");
 }
 
 static void append_variant(DBusMessageIter *iter, int type, void *val)
@@ -832,12 +832,12 @@ static void list_items_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to list items: %s\n", error.name);
+		interactive_printf("Failed to list items: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("ListItems successful\n");
+	interactive_printf("ListItems successful\n");
 }
 
 static void cmd_list_items(int argc, char *argv[])
@@ -850,7 +850,7 @@ static void cmd_list_items(int argc, char *argv[])
 
 	proxy = find_folder(g_dbus_proxy_get_path(default_player));
 	if (proxy == NULL) {
-		rl_printf("Operation not supported\n");
+		interactive_printf("Operation not supported\n");
 		return;
 	}
 
@@ -864,7 +864,7 @@ static void cmd_list_items(int argc, char *argv[])
 	errno = 0;
 	args->start = strtol(argv[1], NULL, 10);
 	if (errno != 0) {
-		rl_printf("%s(%d)\n", strerror(errno), errno);
+		interactive_printf("%s(%d)\n", strerror(errno), errno);
 		g_free(args);
 		return;
 	}
@@ -875,7 +875,7 @@ static void cmd_list_items(int argc, char *argv[])
 	errno = 0;
 	args->end = strtol(argv[2], NULL, 10);
 	if (errno != 0) {
-		rl_printf("%s(%d)\n", strerror(errno), errno);
+		interactive_printf("%s(%d)\n", strerror(errno), errno);
 		g_free(args);
 		return;
 	}
@@ -883,12 +883,12 @@ static void cmd_list_items(int argc, char *argv[])
 done:
 	if (g_dbus_proxy_method_call(proxy, "ListItems", list_items_setup,
 				list_items_reply, args, g_free) == FALSE) {
-		rl_printf("Failed to change current folder\n");
+		interactive_printf("Failed to change current folder\n");
 		g_free(args);
 		return;
 	}
 
-	rl_printf("Attempting to list items\n");
+	interactive_printf("Attempting to list items\n");
 }
 
 static void search_setup(DBusMessageIter *iter, void *user_data)
@@ -915,12 +915,12 @@ static void search_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to search: %s\n", error.name);
+		interactive_printf("Failed to search: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Search successful\n");
+	interactive_printf("Search successful\n");
 }
 
 static void cmd_search(int argc, char *argv[])
@@ -929,7 +929,7 @@ static void cmd_search(int argc, char *argv[])
 	char *string;
 
 	if (argc < 2) {
-		rl_printf("Missing string argument\n");
+		interactive_printf("Missing string argument\n");
 		return;
 	}
 
@@ -938,7 +938,7 @@ static void cmd_search(int argc, char *argv[])
 
 	proxy = find_folder(g_dbus_proxy_get_path(default_player));
 	if (proxy == NULL) {
-		rl_printf("Operation not supported\n");
+		interactive_printf("Operation not supported\n");
 		return;
 	}
 
@@ -946,12 +946,12 @@ static void cmd_search(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "Search", search_setup,
 				search_reply, string, g_free) == FALSE) {
-		rl_printf("Failed to search\n");
+		interactive_printf("Failed to search\n");
 		g_free(string);
 		return;
 	}
 
-	rl_printf("Attempting to search\n");
+	interactive_printf("Attempting to search\n");
 }
 
 static void add_to_nowplaying_reply(DBusMessage *message, void *user_data)
@@ -961,12 +961,12 @@ static void add_to_nowplaying_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to queue: %s\n", error.name);
+		interactive_printf("Failed to queue: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("AddToNowPlaying successful\n");
+	interactive_printf("AddToNowPlaying successful\n");
 }
 
 static void cmd_queue(int argc, char *argv[])
@@ -974,24 +974,24 @@ static void cmd_queue(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing item address argument\n");
+		interactive_printf("Missing item address argument\n");
 		return;
 	}
 
 	proxy = find_item(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Item %s not available\n", argv[1]);
+		interactive_printf("Item %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "AddtoNowPlaying", NULL,
 					add_to_nowplaying_reply, NULL,
 					NULL) == FALSE) {
-		rl_printf("Failed to play\n");
+		interactive_printf("Failed to play\n");
 		return;
 	}
 
-	rl_printf("Attempting to queue %s\n", argv[1]);
+	interactive_printf("Attempting to queue %s\n", argv[1]);
 }
 
 static const struct {
@@ -1256,7 +1256,7 @@ static void print_folder(GDBusProxy *proxy, const char *description)
 
 	path = g_dbus_proxy_get_path(proxy);
 
-	rl_printf("%s%s%sFolder %s\n", description ? "[" : "",
+	interactive_printf("%s%s%sFolder %s\n", description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					path);
@@ -1281,7 +1281,7 @@ static void print_item(GDBusProxy *proxy, const char *description)
 	else
 		name = "<unknown>";
 
-	rl_printf("%s%s%sItem %s %s\n", description ? "[" : "",
+	interactive_printf("%s%s%sItem %s %s\n", description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					path, name);
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index e3bd5ce..abc2fd0 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -116,14 +116,14 @@ static void noninteractive_quit(int status)
 
 #define print(fmt, arg...) do { \
 	if (interactive) \
-		rl_printf(fmt "\n", ## arg); \
+		interactive_printf(fmt "\n", ## arg); \
 	else \
 		printf(fmt "\n", ## arg); \
 } while (0)
 
 #define error(fmt, arg...) do { \
 	if (interactive) \
-		rl_printf(COLOR_RED fmt "\n" COLOR_OFF, ## arg); \
+		interactive_printf(COLOR_RED fmt "\n" COLOR_OFF, ## arg); \
 	else \
 		fprintf(stderr, fmt "\n", ## arg); \
 } while (0)
diff --git a/tools/obexctl.c b/tools/obexctl.c
index b4fdc1c..c105b2f 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -104,12 +104,12 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to connect: %s\n", error.name);
+		interactive_printf("Failed to connect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Connection successful\n");
+	interactive_printf("Connection successful\n");
 }
 
 static void append_variant(DBusMessageIter *iter, int type, void *val)
@@ -188,12 +188,12 @@ static void cmd_connect(int argc, char *argv[])
 	const char *target = "opp";
 
 	if (argc < 2) {
-		rl_printf("Missing device address argument\n");
+		interactive_printf("Missing device address argument\n");
 		return;
 	}
 
 	if (!client) {
-		rl_printf("Client proxy not available\n");
+		interactive_printf("Client proxy not available\n");
 		return;
 	}
 
@@ -206,11 +206,11 @@ static void cmd_connect(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(client, "CreateSession", connect_setup,
 			connect_reply, args, connect_args_free) == FALSE) {
-		rl_printf("Failed to connect\n");
+		interactive_printf("Failed to connect\n");
 		return;
 	}
 
-	rl_printf("Attempting to connect to %s\n", argv[1]);
+	interactive_printf("Attempting to connect to %s\n", argv[1]);
 }
 
 static void disconnect_reply(DBusMessage *message, void *user_data)
@@ -220,12 +220,12 @@ static void disconnect_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to disconnect: %s\n", error.name);
+		interactive_printf("Failed to disconnect: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Disconnection successful\n");
+	interactive_printf("Disconnection successful\n");
 }
 
 static void disconnect_setup(DBusMessageIter *iter, void *user_data)
@@ -262,17 +262,17 @@ static void cmd_disconnect(int argc, char *argv[])
 		proxy = default_session;
 
 	if (proxy == NULL) {
-		rl_printf("Session not available\n");
+		interactive_printf("Session not available\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(client, "RemoveSession", disconnect_setup,
 				disconnect_reply, proxy, NULL) == FALSE) {
-		rl_printf("Failed to disconnect\n");
+		interactive_printf("Failed to disconnect\n");
 		return;
 	}
 
-	rl_printf("Attempting to disconnect to %s\n",
+	interactive_printf("Attempting to disconnect to %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -297,7 +297,7 @@ static void print_proxy(GDBusProxy *proxy, const char *title,
 
 	str = proxy_description(proxy, title, description);
 
-	rl_printf("%s%s\n", str, default_session == proxy ? "[default]" : "");
+	interactive_printf("%s%s\n", str, default_session == proxy ? "[default]" : "");
 
 	g_free(str);
 }
@@ -315,7 +315,7 @@ static void cmd_list(int argc, char *arg[])
 static bool check_default_session(void)
 {
 	if (!default_session) {
-		rl_printf("No default session available\n");
+		interactive_printf("No default session available\n");
 		return FALSE;
 	}
 
@@ -334,39 +334,39 @@ static void print_iter(const char *label, const char *name,
 	DBusMessageIter subiter;
 
 	if (iter == NULL) {
-		rl_printf("%s%s is nil\n", label, name);
+		interactive_printf("%s%s is nil\n", label, name);
 		return;
 	}
 
 	switch (dbus_message_iter_get_arg_type(iter)) {
 	case DBUS_TYPE_INVALID:
-		rl_printf("%s%s is invalid\n", label, name);
+		interactive_printf("%s%s is invalid\n", label, name);
 		break;
 	case DBUS_TYPE_STRING:
 	case DBUS_TYPE_OBJECT_PATH:
 		dbus_message_iter_get_basic(iter, &valstr);
-		rl_printf("%s%s: %s\n", label, name, valstr);
+		interactive_printf("%s%s: %s\n", label, name, valstr);
 		break;
 	case DBUS_TYPE_BOOLEAN:
 		dbus_message_iter_get_basic(iter, &valbool);
-		rl_printf("%s%s: %s\n", label, name,
+		interactive_printf("%s%s: %s\n", label, name,
 					valbool == TRUE ? "yes" : "no");
 		break;
 	case DBUS_TYPE_UINT64:
 		dbus_message_iter_get_basic(iter, &valu64);
-		rl_printf("%s%s: %" PRIu64 "\n", label, name, valu64);
+		interactive_printf("%s%s: %" PRIu64 "\n", label, name, valu64);
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%08x\n", label, name, valu32);
+		interactive_printf("%s%s: 0x%08x\n", label, name, valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-		rl_printf("%s%s: 0x%04x\n", label, name, valu16);
+		interactive_printf("%s%s: 0x%04x\n", label, name, valu16);
 		break;
 	case DBUS_TYPE_INT16:
 		dbus_message_iter_get_basic(iter, &vals16);
-		rl_printf("%s%s: %d\n", label, name, vals16);
+		interactive_printf("%s%s: %d\n", label, name, vals16);
 		break;
 	case DBUS_TYPE_VARIANT:
 		dbus_message_iter_recurse(iter, &subiter);
@@ -387,7 +387,7 @@ static void print_iter(const char *label, const char *name,
 		print_iter(label, valstr, &subiter);
 		break;
 	default:
-		rl_printf("%s%s has unsupported type\n", label, name);
+		interactive_printf("%s%s has unsupported type\n", label, name);
 		break;
 	}
 }
@@ -414,12 +414,12 @@ static void cmd_show(int argc, char *argv[])
 	} else {
 		proxy = find_session(argv[1]);
 		if (!proxy) {
-			rl_printf("Session %s not available\n", argv[1]);
+			interactive_printf("Session %s not available\n", argv[1]);
 			return;
 		}
 	}
 
-	rl_printf("Session %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Session %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Destination");
 	print_property(proxy, "Target");
@@ -451,13 +451,13 @@ static void cmd_select(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing session address argument\n");
+		interactive_printf("Missing session address argument\n");
 		return;
 	}
 
 	proxy = find_session(argv[1]);
 	if (proxy == NULL) {
-		rl_printf("Session %s not available\n", argv[1]);
+		interactive_printf("Session %s not available\n", argv[1]);
 		return;
 	}
 
@@ -499,7 +499,7 @@ static GDBusProxy *find_message(const char *path)
 
 static void transfer_info(GDBusProxy *proxy, int argc, char *argv[])
 {
-	rl_printf("Transfer %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Transfer %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Session");
 	print_property(proxy, "Name");
@@ -513,7 +513,7 @@ static void transfer_info(GDBusProxy *proxy, int argc, char *argv[])
 
 static void message_info(GDBusProxy *proxy, int argc, char *argv[])
 {
-	rl_printf("Message %s\n", g_dbus_proxy_get_path(proxy));
+	interactive_printf("Message %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Folder");
 	print_property(proxy, "Subject");
@@ -538,7 +538,7 @@ static void cmd_info(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing object path argument\n");
+		interactive_printf("Missing object path argument\n");
 		return;
 	}
 
@@ -554,7 +554,7 @@ static void cmd_info(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Object %s not available\n", argv[1]);
+	interactive_printf("Object %s not available\n", argv[1]);
 }
 
 static void cancel_reply(DBusMessage *message, void *user_data)
@@ -564,12 +564,12 @@ static void cancel_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to cancel: %s\n", error.name);
+		interactive_printf("Failed to cancel: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Cancel successful\n");
+	interactive_printf("Cancel successful\n");
 }
 
 static void cmd_cancel(int argc, char *argv[])
@@ -577,23 +577,23 @@ static void cmd_cancel(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing transfer address argument\n");
+		interactive_printf("Missing transfer address argument\n");
 		return;
 	}
 
 	proxy = find_transfer(argv[1]);
 	if (!proxy) {
-		rl_printf("Transfer %s not available\n", argv[1]);
+		interactive_printf("Transfer %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Cancel", NULL, cancel_reply, NULL,
 							NULL) == FALSE) {
-		rl_printf("Failed to cancel transfer\n");
+		interactive_printf("Failed to cancel transfer\n");
 		return;
 	}
 
-	rl_printf("Attempting to cancel transfer %s\n",
+	interactive_printf("Attempting to cancel transfer %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -604,12 +604,12 @@ static void suspend_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to suspend: %s\n", error.name);
+		interactive_printf("Failed to suspend: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Suspend successful\n");
+	interactive_printf("Suspend successful\n");
 }
 
 static void cmd_suspend(int argc, char *argv[])
@@ -617,23 +617,23 @@ static void cmd_suspend(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing transfer address argument\n");
+		interactive_printf("Missing transfer address argument\n");
 		return;
 	}
 
 	proxy = find_transfer(argv[1]);
 	if (!proxy) {
-		rl_printf("Transfer %s not available\n", argv[1]);
+		interactive_printf("Transfer %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Suspend", NULL, suspend_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to suspend transfer\n");
+		interactive_printf("Failed to suspend transfer\n");
 		return;
 	}
 
-	rl_printf("Attempting to suspend transfer %s\n",
+	interactive_printf("Attempting to suspend transfer %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -644,12 +644,12 @@ static void resume_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to resume: %s\n", error.name);
+		interactive_printf("Failed to resume: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Resume successful\n");
+	interactive_printf("Resume successful\n");
 }
 
 static void cmd_resume(int argc, char *argv[])
@@ -657,23 +657,23 @@ static void cmd_resume(int argc, char *argv[])
 	GDBusProxy *proxy;
 
 	if (argc < 2) {
-		rl_printf("Missing transfer address argument\n");
+		interactive_printf("Missing transfer address argument\n");
 		return;
 	}
 
 	proxy = find_transfer(argv[1]);
 	if (!proxy) {
-		rl_printf("Transfer %s not available\n", argv[1]);
+		interactive_printf("Transfer %s not available\n", argv[1]);
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Resume", NULL, resume_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to resume transfer\n");
+		interactive_printf("Failed to resume transfer\n");
 		return;
 	}
 
-	rl_printf("Attempting to resume transfer %s\n",
+	interactive_printf("Attempting to resume transfer %s\n",
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -743,7 +743,7 @@ static void print_transfer_iter(DBusMessageIter *iter)
 
 	dbus_message_iter_get_basic(iter, &path);
 
-	rl_printf("Transfer %s\n", path);
+	interactive_printf("Transfer %s\n", path);
 
 	dbus_message_iter_next(iter);
 
@@ -758,7 +758,7 @@ static void send_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to send: %s\n", error.name);
+		interactive_printf("Failed to send: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -778,17 +778,17 @@ static void send_setup(DBusMessageIter *iter, void *user_data)
 static void opp_send(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing file argument\n");
+		interactive_printf("Missing file argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "SendFile", send_setup, send_reply,
 					g_strdup(argv[1]), g_free) == FALSE) {
-		rl_printf("Failed to send\n");
+		interactive_printf("Failed to send\n");
 		return;
 	}
 
-	rl_printf("Attempting to send %s to %s\n", argv[1],
+	interactive_printf("Attempting to send %s to %s\n", argv[1],
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -800,7 +800,7 @@ static void push_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to PushMessage: %s\n", error.name);
+		interactive_printf("Failed to PushMessage: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -832,18 +832,18 @@ static void push_setup(DBusMessageIter *iter, void *user_data)
 static void map_send(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing file argument\n");
+		interactive_printf("Missing file argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "PushMessage", push_setup,
 					push_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to send\n");
+		interactive_printf("Failed to send\n");
 		return;
 	}
 
-	rl_printf("Attempting to send %s to %s\n", argv[1],
+	interactive_printf("Attempting to send %s to %s\n", argv[1],
 						g_dbus_proxy_get_path(proxy));
 }
 
@@ -866,7 +866,7 @@ static void cmd_send(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	interactive_printf("Command not supported\n");
 }
 
 static void change_folder_reply(DBusMessage *message, void *user_data)
@@ -876,12 +876,12 @@ static void change_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ChangeFolder: %s\n", error.name);
+		interactive_printf("Failed to ChangeFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("ChangeFolder successful\n");
+	interactive_printf("ChangeFolder successful\n");
 }
 
 static void change_folder_setup(DBusMessageIter *iter, void *user_data)
@@ -899,14 +899,14 @@ static void select_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Select: %s\n", error.name);
+		interactive_printf("Failed to Select: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
 	dbus_message_iter_init(message, &iter);
 
-	rl_printf("Select successful\n");
+	interactive_printf("Select successful\n");
 }
 
 static void select_setup(DBusMessageIter *iter, void *user_data)
@@ -925,12 +925,12 @@ static void setfolder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to SetFolder: %s\n", error.name);
+		interactive_printf("Failed to SetFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("SetFolder successful\n");
+	interactive_printf("SetFolder successful\n");
 }
 
 static void setfolder_setup(DBusMessageIter *iter, void *user_data)
@@ -971,52 +971,52 @@ static GDBusProxy *find_pbap(const char *path)
 static void ftp_cd(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing path argument\n");
+		interactive_printf("Missing path argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
 					change_folder_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to ChangeFolder\n");
+		interactive_printf("Failed to ChangeFolder\n");
 		return;
 	}
 
-	rl_printf("Attempting to ChangeFolder to %s\n", argv[1]);
+	interactive_printf("Attempting to ChangeFolder to %s\n", argv[1]);
 }
 
 static void pbap_cd(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing path argument\n");
+		interactive_printf("Missing path argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Select", select_setup,
 					select_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to Select\n");
+		interactive_printf("Failed to Select\n");
 		return;
 	}
 
-	rl_printf("Attempting to Select to %s\n", argv[1]);
+	interactive_printf("Attempting to Select to %s\n", argv[1]);
 }
 
 static void map_cd(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing path argument\n");
+		interactive_printf("Missing path argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "SetFolder", setfolder_setup,
 					setfolder_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to SetFolder\n");
+		interactive_printf("Failed to SetFolder\n");
 		return;
 	}
 
-	rl_printf("Attempting to SetFolder to %s\n", argv[1]);
+	interactive_printf("Attempting to SetFolder to %s\n", argv[1]);
 }
 
 static void cmd_cd(int argc, char *argv[])
@@ -1044,7 +1044,7 @@ static void cmd_cd(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	interactive_printf("Command not supported\n");
 }
 
 static void list_folder_reply(DBusMessage *message, void *user_data)
@@ -1055,7 +1055,7 @@ static void list_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ListFolder: %s\n", error.name);
+		interactive_printf("Failed to ListFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1078,11 +1078,11 @@ static void ftp_ls(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "ListFolder", NULL,
 						list_folder_reply, NULL,
 						NULL) == FALSE) {
-		rl_printf("Failed to ls\n");
+		interactive_printf("Failed to ls\n");
 		return;
 	}
 
-	rl_printf("Attempting to ListFolder\n");
+	interactive_printf("Attempting to ListFolder\n");
 }
 
 static void parse_list_reply(DBusMessage *message)
@@ -1119,7 +1119,7 @@ static void list_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to List: %s\n", error.name);
+		interactive_printf("Failed to List: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1148,7 +1148,7 @@ static void search_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Search: %s\n", error.name);
+		interactive_printf("Failed to Search: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1182,11 +1182,11 @@ static void pbap_search(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "Search", search_setup,
 					search_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to Search\n");
+		interactive_printf("Failed to Search\n");
 		return;
 	}
 
-	rl_printf("Attempting to Search\n");
+	interactive_printf("Attempting to Search\n");
 }
 
 static void list_folders_reply(DBusMessage *message, void *user_data)
@@ -1197,7 +1197,7 @@ static void list_folders_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ListFolders: %s\n", error.name);
+		interactive_printf("Failed to ListFolders: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1238,7 +1238,7 @@ static void list_messages_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to ListFolders: %s\n", error.name);
+		interactive_printf("Failed to ListFolders: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1257,7 +1257,7 @@ static void list_messages_reply(DBusMessage *message, void *user_data)
 
 		dbus_message_iter_recurse(&array, &entry);
 		dbus_message_iter_get_basic(&entry, &obj);
-		rl_printf("\t%s\n", obj);
+		interactive_printf("\t%s\n", obj);
 		dbus_message_iter_next(&array);
 	}
 }
@@ -1286,11 +1286,11 @@ static void pbap_list(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (g_dbus_proxy_method_call(proxy, "List", list_setup, list_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to List\n");
+		interactive_printf("Failed to List\n");
 		return;
 	}
 
-	rl_printf("Attempting to List\n");
+	interactive_printf("Attempting to List\n");
 }
 
 static void get_size_reply(DBusMessage *message, void *user_data)
@@ -1302,7 +1302,7 @@ static void get_size_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to GetSize: %s\n", error.name);
+		interactive_printf("Failed to GetSize: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1318,11 +1318,11 @@ static void pbap_get_size(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (g_dbus_proxy_method_call(proxy, "GetSize", NULL, get_size_reply,
 						proxy, NULL) == FALSE) {
-		rl_printf("Failed to GetSize\n");
+		interactive_printf("Failed to GetSize\n");
 		return;
 	}
 
-	rl_printf("Attempting to GetSize\n");
+	interactive_printf("Attempting to GetSize\n");
 }
 
 static void pbap_ls(GDBusProxy *proxy, int argc, char *argv[])
@@ -1343,11 +1343,11 @@ static void map_ls_messages(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "ListMessages", list_messages_setup,
 					list_messages_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to ListMessages\n");
+		interactive_printf("Failed to ListMessages\n");
 		return;
 	}
 
-	rl_printf("Attempting to ListMessages\n");
+	interactive_printf("Attempting to ListMessages\n");
 }
 
 static void map_ls(GDBusProxy *proxy, int argc, char *argv[])
@@ -1360,11 +1360,11 @@ static void map_ls(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "ListFolders", list_folders_setup,
 						list_folders_reply, NULL,
 						NULL) == FALSE) {
-		rl_printf("Failed to ListFolders\n");
+		interactive_printf("Failed to ListFolders\n");
 		return;
 	}
 
-	rl_printf("Attempting to ListFolders\n");
+	interactive_printf("Attempting to ListFolders\n");
 }
 
 static void cmd_ls(int argc, char *argv[])
@@ -1392,7 +1392,7 @@ static void cmd_ls(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	interactive_printf("Command not supported\n");
 }
 
 struct cp_args {
@@ -1449,12 +1449,12 @@ static void copy_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to CopyFile: %s\n", error.name);
+		interactive_printf("Failed to CopyFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("CopyFile successful\n");
+	interactive_printf("CopyFile successful\n");
 }
 
 static void ftp_copy(GDBusProxy *proxy, int argc, char *argv[])
@@ -1465,11 +1465,11 @@ static void ftp_copy(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "CopyFile", cp_setup,
 				copy_file_reply, args, cp_free) == FALSE) {
-		rl_printf("Failed to CopyFile\n");
+		interactive_printf("Failed to CopyFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to CopyFile\n");
+	interactive_printf("Attempting to CopyFile\n");
 }
 
 static void get_file_reply(DBusMessage *message, void *user_data)
@@ -1480,7 +1480,7 @@ static void get_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to GetFile: %s\n", error.name);
+		interactive_printf("Failed to GetFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1509,11 +1509,11 @@ static void ftp_get(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "GetFile", get_file_setup,
 				get_file_reply, args, cp_free) == FALSE) {
-		rl_printf("Failed to GetFile\n");
+		interactive_printf("Failed to GetFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to GetFile\n");
+	interactive_printf("Attempting to GetFile\n");
 }
 
 static void put_file_reply(DBusMessage *message, void *user_data)
@@ -1524,7 +1524,7 @@ static void put_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to PutFile: %s\n", error.name);
+		interactive_printf("Failed to PutFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1539,7 +1539,7 @@ static void ftp_put(GDBusProxy *proxy, int argc, char *argv[])
 	struct cp_args *args;
 
 	if (rindex(argv[2], ':') != NULL) {
-		rl_printf("Invalid target file argument\n");
+		interactive_printf("Invalid target file argument\n");
 		return;
 	}
 
@@ -1547,22 +1547,22 @@ static void ftp_put(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "PutFile", cp_setup, put_file_reply,
 						args, cp_free) == FALSE) {
-		rl_printf("Failed to PutFile\n");
+		interactive_printf("Failed to PutFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to PutFile\n");
+	interactive_printf("Attempting to PutFile\n");
 }
 
 static void ftp_cp(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing source file argument\n");
+		interactive_printf("Missing source file argument\n");
 		return;
 	}
 
 	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
+		interactive_printf("Missing target file argument\n");
 		return;
 	}
 
@@ -1579,13 +1579,13 @@ static void pull_all_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to PullAll: %s\n", error.name);
+		interactive_printf("Failed to PullAll: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
 
-	rl_printf("PullAll successful\n");
+	interactive_printf("PullAll successful\n");
 }
 
 static void pull_all_setup(DBusMessageIter *iter, void *user_data)
@@ -1610,11 +1610,11 @@ static void pbap_pull_all(GDBusProxy *proxy, int argc, char *argv[])
 	if (g_dbus_proxy_method_call(proxy, "PullAll", pull_all_setup,
 					pull_all_reply, g_strdup(argv[2]),
 					g_free) == FALSE) {
-		rl_printf("Failed to PullAll\n");
+		interactive_printf("Failed to PullAll\n");
 		return;
 	}
 
-	rl_printf("Attempting to PullAll\n");
+	interactive_printf("Attempting to PullAll\n");
 }
 
 static void pull_reply(DBusMessage *message, void *user_data)
@@ -1624,13 +1624,13 @@ static void pull_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Pull: %s\n", error.name);
+		interactive_printf("Failed to Pull: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
 
-	rl_printf("Pull successful\n");
+	interactive_printf("Pull successful\n");
 }
 
 static void pull_setup(DBusMessageIter *iter, void *user_data)
@@ -1659,22 +1659,22 @@ static void pbap_pull(GDBusProxy *proxy, int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "Pull", pull_setup, pull_reply,
 						args, cp_free) == FALSE) {
-		rl_printf("Failed to Pull\n");
+		interactive_printf("Failed to Pull\n");
 		return;
 	}
 
-	rl_printf("Attempting to Pull\n");
+	interactive_printf("Attempting to Pull\n");
 }
 
 static void pbap_cp(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing source file argument\n");
+		interactive_printf("Missing source file argument\n");
 		return;
 	}
 
 	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
+		interactive_printf("Missing target file argument\n");
 		return;
 	}
 
@@ -1692,7 +1692,7 @@ static void get_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Get: %s\n", error.name);
+		interactive_printf("Failed to Get: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
@@ -1716,28 +1716,28 @@ static void map_cp(GDBusProxy *proxy, int argc, char *argv[])
 	GDBusProxy *obj;
 
 	if (argc < 2) {
-		rl_printf("Missing message argument\n");
+		interactive_printf("Missing message argument\n");
 		return;
 	}
 
 	obj = find_message(argv[1]);
 	if (obj == NULL) {
-		rl_printf("Invalid message argument\n");
+		interactive_printf("Invalid message argument\n");
 		return;
 	}
 
 	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
+		interactive_printf("Missing target file argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(obj, "Get", get_setup, get_reply,
 					g_strdup(argv[2]), g_free) == FALSE) {
-		rl_printf("Failed to Get\n");
+		interactive_printf("Failed to Get\n");
 		return;
 	}
 
-	rl_printf("Attempting to Get\n");
+	interactive_printf("Attempting to Get\n");
 }
 
 static void cmd_cp(int argc, char *argv[])
@@ -1766,7 +1766,7 @@ static void cmd_cp(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	interactive_printf("Command not supported\n");
 }
 
 static void move_file_reply(DBusMessage *message, void *user_data)
@@ -1776,12 +1776,12 @@ static void move_file_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to MoveFile: %s\n", error.name);
+		interactive_printf("Failed to MoveFile: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("MoveFile successful\n");
+	interactive_printf("MoveFile successful\n");
 }
 
 static void cmd_mv(int argc, char *argv[])
@@ -1793,18 +1793,18 @@ static void cmd_mv(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing source file argument\n");
+		interactive_printf("Missing source file argument\n");
 		return;
 	}
 
 	if (argc < 3) {
-		rl_printf("Missing target file argument\n");
+		interactive_printf("Missing target file argument\n");
 		return;
 	}
 
 	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
 	if (proxy == NULL) {
-		rl_printf("Command not supported\n");
+		interactive_printf("Command not supported\n");
 		return;
 	}
 
@@ -1812,11 +1812,11 @@ static void cmd_mv(int argc, char *argv[])
 
 	if (g_dbus_proxy_method_call(proxy, "MoveFile", cp_setup,
 				move_file_reply, args, cp_free) == FALSE) {
-		rl_printf("Failed to MoveFile\n");
+		interactive_printf("Failed to MoveFile\n");
 		return;
 	}
 
-	rl_printf("Attempting to MoveFile\n");
+	interactive_printf("Attempting to MoveFile\n");
 }
 
 static void delete_reply(DBusMessage *message, void *user_data)
@@ -1826,12 +1826,12 @@ static void delete_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to Delete: %s\n", error.name);
+		interactive_printf("Failed to Delete: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("Delete successful\n");
+	interactive_printf("Delete successful\n");
 }
 
 static void delete_setup(DBusMessageIter *iter, void *user_data)
@@ -1844,26 +1844,26 @@ static void delete_setup(DBusMessageIter *iter, void *user_data)
 static void ftp_rm(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (argc < 2) {
-		rl_printf("Missing file argument\n");
+		interactive_printf("Missing file argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "Delete", delete_setup,
 					delete_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to Delete\n");
+		interactive_printf("Failed to Delete\n");
 		return;
 	}
 
-	rl_printf("Attempting to Delete\n");
+	interactive_printf("Attempting to Delete\n");
 }
 
 static void set_delete_reply(const DBusError *error, void *user_data)
 {
 	if (dbus_error_is_set(error))
-		rl_printf("Failed to set Deleted: %s\n", error->name);
+		interactive_printf("Failed to set Deleted: %s\n", error->name);
 	else
-		rl_printf("Set Deleted successful\n");
+		interactive_printf("Set Deleted successful\n");
 }
 
 static void map_rm(GDBusProxy *proxy, int argc, char *argv[])
@@ -1872,24 +1872,24 @@ static void map_rm(GDBusProxy *proxy, int argc, char *argv[])
 	dbus_bool_t value = TRUE;
 
 	if (argc < 2) {
-		rl_printf("Missing message argument\n");
+		interactive_printf("Missing message argument\n");
 		return;
 	}
 
 	msg = find_message(argv[1]);
 	if (msg == NULL) {
-		rl_printf("Invalid message argument\n");
+		interactive_printf("Invalid message argument\n");
 		return;
 	}
 
 	if (g_dbus_proxy_set_property_basic(msg, "Deleted", DBUS_TYPE_BOOLEAN,
 						&value, set_delete_reply,
 						NULL, NULL) == FALSE) {
-		rl_printf("Failed to set Deleted\n");
+		interactive_printf("Failed to set Deleted\n");
 		return;
 	}
 
-	rl_printf("Attempting to set Deleted\n");
+	interactive_printf("Attempting to set Deleted\n");
 }
 
 static void cmd_rm(int argc, char *argv[])
@@ -1911,7 +1911,7 @@ static void cmd_rm(int argc, char *argv[])
 		return;
 	}
 
-	rl_printf("Command not supported\n");
+	interactive_printf("Command not supported\n");
 }
 
 static void create_folder_reply(DBusMessage *message, void *user_data)
@@ -1921,12 +1921,12 @@ static void create_folder_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
-		rl_printf("Failed to CreateFolder: %s\n", error.name);
+		interactive_printf("Failed to CreateFolder: %s\n", error.name);
 		dbus_error_free(&error);
 		return;
 	}
 
-	rl_printf("CreateFolder successful\n");
+	interactive_printf("CreateFolder successful\n");
 }
 
 static void create_folder_setup(DBusMessageIter *iter, void *user_data)
@@ -1944,24 +1944,24 @@ static void cmd_mkdir(int argc, char *argv[])
 		return;
 
 	if (argc < 2) {
-		rl_printf("Missing folder argument\n");
+		interactive_printf("Missing folder argument\n");
 		return;
 	}
 
 	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
 	if (proxy == NULL) {
-		rl_printf("Command not supported\n");
+		interactive_printf("Command not supported\n");
 		return;
 	}
 
 	if (g_dbus_proxy_method_call(proxy, "CreateFolder", create_folder_setup,
 					create_folder_reply, g_strdup(argv[1]),
 					g_free) == FALSE) {
-		rl_printf("Failed to CreateFolder\n");
+		interactive_printf("Failed to CreateFolder\n");
 		return;
 	}
 
-	rl_printf("Attempting to CreateFolder\n");
+	interactive_printf("Attempting to CreateFolder\n");
 }
 
 static const struct {
@@ -2232,7 +2232,7 @@ static void print_transferred(struct transfer_data *data, const char *str,
 	data->transferred = valu64;
 
 	if (data->size == 0) {
-		rl_printf("%sTransferred: %" PRIu64 " (@%" PRIu64 "KB/s)\n",
+		interactive_printf("%sTransferred: %" PRIu64 " (@%" PRIu64 "KB/s)\n",
 						str, valu64, speed / 1000);
 		return;
 	}
@@ -2240,7 +2240,7 @@ static void print_transferred(struct transfer_data *data, const char *str,
 	seconds = (data->size - data->transferred) / speed;
 	minutes = seconds / 60;
 	seconds %= 60;
-	rl_printf("%sTransferred: %" PRIu64 " (@%" PRIu64 "KB/s %02u:%02u)\n",
+	interactive_printf("%sTransferred: %" PRIu64 " (@%" PRIu64 "KB/s %02u:%02u)\n",
 				str, valu64, speed / 1000, minutes, seconds);
 }
 
-- 
1.9.3

