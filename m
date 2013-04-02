Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ v2 06/13] gatttool: Replace more usages of printf() with rl_printf()
Date: Tue,  2 Apr 2013 19:31:23 -0400
Message-Id: <1364945490-17059-7-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

rl_printf() works better with readline than plain printf(), specially on
asynchronous callbacks.
---
 attrib/interactive.c |  177 ++++++++++++++++++++++++--------------------------
 1 file changed, 84 insertions(+), 93 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index d5da9ad..4fd2280 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -110,27 +110,31 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	uint8_t *opdu;
 	uint16_t handle, i, olen;
 	size_t plen;
+	GString *s;
 
 	handle = att_get_u16(&pdu[1]);
 
-	printf("\n");
 	switch (pdu[0]) {
 	case ATT_OP_HANDLE_NOTIFY:
-		printf("Notification handle = 0x%04x value: ", handle);
+		s = g_string_new(NULL);
+		g_string_printf(s, "Notification handle = 0x%04x value: ",
+									handle);
 		break;
 	case ATT_OP_HANDLE_IND:
-		printf("Indication   handle = 0x%04x value: ", handle);
+		s = g_string_new(NULL);
+		g_string_printf(s, "Indication   handle = 0x%04x value: ",
+									handle);
 		break;
 	default:
-		printf("Invalid opcode\n");
+		rl_printf("Invalid opcode\n");
 		return;
 	}
 
 	for (i = 3; i < len; i++)
-		printf("%02x ", pdu[i]);
+		g_string_append_printf(s, "%02x ", pdu[i]);
 
-	printf("\n");
-	rl_forced_update_display();
+	rl_printf("%s\n", s->str);
+	g_string_free(s, TRUE);
 
 	if (pdu[0] == ATT_OP_HANDLE_NOTIFY)
 		return;
@@ -180,19 +184,16 @@ static void primary_all_cb(GSList *services, guint8 status, gpointer user_data)
 	GSList *l;
 
 	if (status) {
-		printf("Discover all primary services failed: %s\n",
+		rl_printf("Discover all primary services failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
-	printf("\n");
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
-		printf("attr handle: 0x%04x, end grp handle: 0x%04x "
-			"uuid: %s\n", prim->range.start, prim->range.end, prim->uuid);
+		rl_printf("attr handle: 0x%04x, end grp handle: 0x%04x uuid: %s\n",
+				prim->range.start, prim->range.end, prim->uuid);
 	}
-
-	rl_forced_update_display();
 }
 
 static void primary_by_uuid_cb(GSList *ranges, guint8 status,
@@ -201,19 +202,16 @@ static void primary_by_uuid_cb(GSList *ranges, guint8 status,
 	GSList *l;
 
 	if (status) {
-		printf("Discover primary services by UUID failed: %s\n",
+		rl_printf("Discover primary services by UUID failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
-	printf("\n");
 	for (l = ranges; l; l = l->next) {
 		struct att_range *range = l->data;
-		g_print("Starting handle: 0x%04x Ending handle: 0x%04x\n",
+		rl_printf("Starting handle: 0x%04x Ending handle: 0x%04x\n",
 						range->start, range->end);
 	}
-
-	rl_forced_update_display();
 }
 
 static void included_cb(GSList *includes, guint8 status, gpointer user_data)
@@ -221,27 +219,23 @@ static void included_cb(GSList *includes, guint8 status, gpointer user_data)
 	GSList *l;
 
 	if (status) {
-		printf("Find included services failed: %s\n",
+		rl_printf("Find included services failed: %s\n",
 							att_ecode2str(status));
-		goto done;
+		return;
 	}
 
 	if (includes == NULL) {
-		printf("No included services found for this range\n");
-		goto done;
+		rl_printf("No included services found for this range\n");
+		return;
 	}
 
-	printf("\n");
 	for (l = includes; l; l = l->next) {
 		struct gatt_included *incl = l->data;
-		printf("handle: 0x%04x, start handle: 0x%04x, "
+		rl_printf("handle: 0x%04x, start handle: 0x%04x, "
 					"end handle: 0x%04x uuid: %s\n",
 					incl->handle, incl->range.start,
 					incl->range.end, incl->uuid);
 	}
-
-done:
-	rl_forced_update_display();
 }
 
 static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
@@ -249,22 +243,19 @@ static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 	GSList *l;
 
 	if (status) {
-		printf("Discover all characteristics failed: %s\n",
+		rl_printf("Discover all characteristics failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
-	printf("\n");
 	for (l = characteristics; l; l = l->next) {
 		struct gatt_char *chars = l->data;
 
-		printf("handle: 0x%04x, char properties: 0x%02x, char value "
+		rl_printf("handle: 0x%04x, char properties: 0x%02x, char value "
 				"handle: 0x%04x, uuid: %s\n", chars->handle,
 				chars->properties, chars->value_handle,
 				chars->uuid);
 	}
-
-	rl_forced_update_display();
 }
 
 static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -276,7 +267,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	int i;
 
 	if (status != 0) {
-		printf("Discover descriptors finished: %s\n",
+		rl_printf("Discover descriptors finished: %s\n",
 						att_ecode2str(status));
 		return;
 	}
@@ -285,7 +276,6 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (list == NULL)
 		return;
 
-	printf("\n");
 	for (i = 0; i < list->num; i++) {
 		char uuidstr[MAX_LEN_UUID_STR];
 		uint8_t *value;
@@ -300,15 +290,13 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			uuid = att_get_uuid128(&value[2]);
 
 		bt_uuid_to_string(&uuid, uuidstr, MAX_LEN_UUID_STR);
-		printf("handle: 0x%04x, uuid: %s\n", handle, uuidstr);
+		rl_printf("handle: 0x%04x, uuid: %s\n", handle, uuidstr);
 	}
 
 	att_data_list_free(list);
 
 	if (handle != 0xffff && handle < end)
 		gatt_find_info(attrib, handle + 1, end, char_desc_cb, NULL);
-	else
-		rl_forced_update_display();
 }
 
 static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -317,25 +305,26 @@ static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	uint8_t value[plen];
 	ssize_t vlen;
 	int i;
+	GString *s;
 
 	if (status != 0) {
-		printf("Characteristic value/descriptor read failed: %s\n",
+		rl_printf("Characteristic value/descriptor read failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
 	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
 	if (vlen < 0) {
-		printf("Protocol error\n");
+		rl_printf("Protocol error\n");
 		return;
 	}
 
-	printf("\nCharacteristic value/descriptor: ");
+	s = g_string_new("Characteristic value/descriptor: ");
 	for (i = 0; i < vlen; i++)
-		printf("%02x ", value[i]);
-	printf("\n");
+		g_string_append_printf(s, "%02x ", value[i]);
 
-	rl_forced_update_display();
+	rl_printf("%s\n", s->str);
+	g_string_free(s, TRUE);
 }
 
 static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
@@ -344,13 +333,14 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 	struct characteristic_data *char_data = user_data;
 	struct att_data_list *list;
 	int i;
+	GString *s;
 
 	if (status == ATT_ECODE_ATTR_NOT_FOUND &&
 				char_data->start != char_data->orig_start)
 		goto done;
 
 	if (status != 0) {
-		printf("Read characteristics by UUID failed: %s\n",
+		rl_printf("Read characteristics by UUID failed: %s\n",
 							att_ecode2str(status));
 		goto done;
 	}
@@ -359,22 +349,23 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 	if (list == NULL)
 		goto done;
 
+	s = g_string_new(NULL);
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value = list->data[i];
 		int j;
 
 		char_data->start = att_get_u16(value) + 1;
-
-		printf("\nhandle: 0x%04x \t value: ", att_get_u16(value));
+		g_string_printf(s, "handle: 0x%04x \t value: ",
+							att_get_u16(value));
 		value += 2;
 		for (j = 0; j < list->len - 2; j++, value++)
-			printf("%02x ", *value);
-		printf("\n");
+			g_string_append_printf(s, "%02x ", *value);
+
+		rl_printf("%s\n", s->str);
 	}
 
 	att_data_list_free(list);
-
-	rl_forced_update_display();
+	g_string_free(s, TRUE);
 
 done:
 	g_free(char_data);
@@ -438,7 +429,7 @@ static void cmd_primary(int argcp, char **argvp)
 	bt_uuid_t uuid;
 
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
+		rl_printf("Command failed: disconnected\n");
 		return;
 	}
 
@@ -448,7 +439,7 @@ static void cmd_primary(int argcp, char **argvp)
 	}
 
 	if (bt_string_to_uuid(&uuid, argvp[1]) < 0) {
-		printf("Invalid UUID\n");
+		rl_printf("Invalid UUID\n");
 		return;
 	}
 
@@ -474,14 +465,14 @@ static void cmd_included(int argcp, char **argvp)
 	int end = 0xffff;
 
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
+		rl_printf("Command failed: disconnected\n");
 		return;
 	}
 
 	if (argcp > 1) {
 		start = strtohandle(argvp[1]);
 		if (start < 0) {
-			printf("Invalid start handle: %s\n", argvp[1]);
+			rl_printf("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 		end = start;
@@ -490,7 +481,7 @@ static void cmd_included(int argcp, char **argvp)
 	if (argcp > 2) {
 		end = strtohandle(argvp[2]);
 		if (end < 0) {
-			printf("Invalid end handle: %s\n", argvp[2]);
+			rl_printf("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	}
@@ -504,14 +495,14 @@ static void cmd_char(int argcp, char **argvp)
 	int end = 0xffff;
 
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
+		rl_printf("Command failed: disconnected\n");
 		return;
 	}
 
 	if (argcp > 1) {
 		start = strtohandle(argvp[1]);
 		if (start < 0) {
-			printf("Invalid start handle: %s\n", argvp[1]);
+			rl_printf("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 	}
@@ -519,7 +510,7 @@ static void cmd_char(int argcp, char **argvp)
 	if (argcp > 2) {
 		end = strtohandle(argvp[2]);
 		if (end < 0) {
-			printf("Invalid end handle: %s\n", argvp[2]);
+			rl_printf("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	}
@@ -528,7 +519,7 @@ static void cmd_char(int argcp, char **argvp)
 		bt_uuid_t uuid;
 
 		if (bt_string_to_uuid(&uuid, argvp[3]) < 0) {
-			printf("Invalid UUID\n");
+			rl_printf("Invalid UUID\n");
 			return;
 		}
 
@@ -542,14 +533,14 @@ static void cmd_char(int argcp, char **argvp)
 static void cmd_char_desc(int argcp, char **argvp)
 {
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
+		rl_printf("Command failed: disconnected\n");
 		return;
 	}
 
 	if (argcp > 1) {
 		start = strtohandle(argvp[1]);
 		if (start < 0) {
-			printf("Invalid start handle: %s\n", argvp[1]);
+			rl_printf("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 	} else
@@ -558,7 +549,7 @@ static void cmd_char_desc(int argcp, char **argvp)
 	if (argcp > 2) {
 		end = strtohandle(argvp[2]);
 		if (end < 0) {
-			printf("Invalid end handle: %s\n", argvp[2]);
+			rl_printf("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	} else
@@ -572,18 +563,18 @@ static void cmd_read_hnd(int argcp, char **argvp)
 	int handle;
 
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
+		rl_printf("Command failed: disconnected\n");
 		return;
 	}
 
 	if (argcp < 2) {
-		printf("Missing argument: handle\n");
+		rl_printf("Missing argument: handle\n");
 		return;
 	}
 
 	handle = strtohandle(argvp[1]);
 	if (handle < 0) {
-		printf("Invalid handle: %s\n", argvp[1]);
+		rl_printf("Invalid handle: %s\n", argvp[1]);
 		return;
 	}
 
@@ -598,24 +589,24 @@ static void cmd_read_uuid(int argcp, char **argvp)
 	bt_uuid_t uuid;
 
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
+		rl_printf("Command failed: disconnected\n");
 		return;
 	}
 
 	if (argcp < 2) {
-		printf("Missing argument: UUID\n");
+		rl_printf("Missing argument: UUID\n");
 		return;
 	}
 
 	if (bt_string_to_uuid(&uuid, argvp[1]) < 0) {
-		printf("Invalid UUID\n");
+		rl_printf("Invalid UUID\n");
 		return;
 	}
 
 	if (argcp > 2) {
 		start = strtohandle(argvp[2]);
 		if (start < 0) {
-			printf("Invalid start handle: %s\n", argvp[1]);
+			rl_printf("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
 	}
@@ -623,7 +614,7 @@ static void cmd_read_uuid(int argcp, char **argvp)
 	if (argcp > 3) {
 		end = strtohandle(argvp[3]);
 		if (end < 0) {
-			printf("Invalid end handle: %s\n", argvp[2]);
+			rl_printf("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
 	}
@@ -642,17 +633,17 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
 	if (status != 0) {
-		printf("Characteristic Write Request failed: "
+		rl_printf("Characteristic Write Request failed: "
 						"%s\n", att_ecode2str(status));
 		return;
 	}
 
 	if (!dec_write_resp(pdu, plen) && !dec_exec_write_resp(pdu, plen)) {
-		printf("Protocol error\n");
+		rl_printf("Protocol error\n");
 		return;
 	}
 
-	printf("Characteristic value was written successfully\n");
+	rl_printf("Characteristic value was written successfully\n");
 }
 
 static void cmd_char_write(int argcp, char **argvp)
@@ -662,24 +653,24 @@ static void cmd_char_write(int argcp, char **argvp)
 	int handle;
 
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: disconnected\n");
+		rl_printf("Command failed: disconnected\n");
 		return;
 	}
 
 	if (argcp < 3) {
-		printf("Usage: %s <handle> <new value>\n", argvp[0]);
+		rl_printf("Usage: %s <handle> <new value>\n", argvp[0]);
 		return;
 	}
 
 	handle = strtohandle(argvp[1]);
 	if (handle <= 0) {
-		printf("A valid handle is required\n");
+		rl_printf("A valid handle is required\n");
 		return;
 	}
 
 	plen = gatt_attr_data_from_string(argvp[2], &value);
 	if (plen == 0) {
-		g_printerr("Invalid value\n");
+		rl_printf("Invalid value\n");
 		return;
 	}
 
@@ -698,7 +689,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 	BtIOSecLevel sec_level;
 
 	if (argcp < 2) {
-		printf("sec-level: %s\n", opt_sec_level);
+		rl_printf("sec-level: %s\n", opt_sec_level);
 		return;
 	}
 
@@ -709,7 +700,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 	else if (strcasecmp(argvp[1], "low") == 0)
 		sec_level = BT_IO_SEC_LOW;
 	else {
-		printf("Allowed values: low | medium | high\n");
+		rl_printf("Allowed values: low | medium | high\n");
 		return;
 	}
 
@@ -720,7 +711,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 		return;
 
 	if (opt_psm) {
-		printf("It must be reconnected to this change take effect\n");
+		rl_printf("Change will take effect on reconnection\n");
 		return;
 	}
 
@@ -728,7 +719,7 @@ static void cmd_sec_level(int argcp, char **argvp)
 			BT_IO_OPT_SEC_LEVEL, sec_level,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
-		printf("Error: %s\n", gerr->message);
+		rl_printf("Error: %s\n", gerr->message);
 		g_error_free(gerr);
 	}
 }
@@ -739,44 +730,44 @@ static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	uint16_t mtu;
 
 	if (status != 0) {
-		printf("Exchange MTU Request failed: %s\n",
+		rl_printf("Exchange MTU Request failed: %s\n",
 							att_ecode2str(status));
 		return;
 	}
 
 	if (!dec_mtu_resp(pdu, plen, &mtu)) {
-		printf("Protocol error\n");
+		rl_printf("Protocol error\n");
 		return;
 	}
 
 	mtu = MIN(mtu, opt_mtu);
 	/* Set new value for MTU in client */
 	if (g_attrib_set_mtu(attrib, mtu))
-		printf("MTU was exchanged successfully: %d\n", mtu);
+		rl_printf("MTU was exchanged successfully: %d\n", mtu);
 	else
-		printf("Error exchanging MTU\n");
+		rl_printf("Error exchanging MTU\n");
 }
 
 static void cmd_mtu(int argcp, char **argvp)
 {
 	if (conn_state != STATE_CONNECTED) {
-		printf("Command failed: not connected.\n");
+		rl_printf("Command failed: not connected.\n");
 		return;
 	}
 
 	if (opt_psm) {
-		printf("Command failed: operation is only available for LE"
+		rl_printf("Command failed: operation is only available for LE"
 							" transport.\n");
 		return;
 	}
 
 	if (argcp < 2) {
-		printf("Usage: mtu <value>\n");
+		rl_printf("Usage: mtu <value>\n");
 		return;
 	}
 
 	if (opt_mtu) {
-		printf("Command failed: MTU exchange can only occur once per"
+		rl_printf("Command failed: MTU exchange can only occur once per"
 							" connection.\n");
 		return;
 	}
@@ -784,7 +775,7 @@ static void cmd_mtu(int argcp, char **argvp)
 	errno = 0;
 	opt_mtu = strtoll(argvp[1], NULL, 0);
 	if (errno != 0 || opt_mtu < ATT_DEFAULT_LE_MTU) {
-		printf("Invalid value. Minimum MTU size is %d\n",
+		rl_printf("Invalid value. Minimum MTU size is %d\n",
 							ATT_DEFAULT_LE_MTU);
 		return;
 	}
@@ -836,7 +827,7 @@ static void cmd_help(int argcp, char **argvp)
 	int i;
 
 	for (i = 0; commands[i].cmd; i++)
-		printf("%-15s %-30s %s\n", commands[i].cmd,
+		rl_printf("%-15s %-30s %s\n", commands[i].cmd,
 				commands[i].params, commands[i].desc);
 }
 
@@ -847,7 +838,7 @@ static void parse_line(char *line_read)
 	int i;
 
 	if (line_read == NULL) {
-		printf("\n");
+		rl_printf("\n");
 		cmd_exit(0, NULL);
 		return;
 	}
@@ -868,7 +859,7 @@ static void parse_line(char *line_read)
 	if (commands[i].cmd)
 		commands[i].func(argcp, argvp);
 	else
-		printf("%s: command not found\n", argvp[0]);
+		rl_printf("%s: command not found\n", argvp[0]);
 
 	g_strfreev(argvp);
 
-- 
1.7.9.5

