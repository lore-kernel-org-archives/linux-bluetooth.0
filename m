Return-Path: <SRS0=BO69=ZH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE7FC43215
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Nov 2019 23:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0661D20730
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Nov 2019 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKOXRZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:17:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:62386 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfKOXRZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Nov 2019 18:17:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 15:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,310,1569308400"; 
   d="scan'208";a="288694613"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.205.168])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2019 15:17:18 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, aurelien@aurel32.net
Subject: [PATCH BlueZ v2 2/2] tools/mesh-cfgclient: Add full support inOOB and outOOB
Date:   Fri, 15 Nov 2019 15:17:05 -0800
Message-Id: <20191115231705.5596-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115231705.5596-1-brian.gix@intel.com>
References: <20191115231705.5596-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

Add support for all the forms of inOOB and outOOB prompt and display
requests from the Provisioner for a remote device:
"push", "twist", "blink", "beep", "vibrate", "in-numeric",
"out-numeric", "in-alpha", and "out-alpha"
---
 tools/mesh-cfgclient.c | 178 ++++++++++++++++++++++++++++++++++-------
 tools/mesh-gatt/prov.c |   9 ++-
 tools/mesh/agent.c     |  21 +++--
 tools/mesh/agent.h     |   4 +-
 4 files changed, 168 insertions(+), 44 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 444b9e5aa..1c617a37b 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -353,53 +353,141 @@ static bool caps_getter(struct l_dbus *dbus,
 	return true;
 }
 
+static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
+								void *user_data)
+{
+	struct l_dbus_message *msg = user_data;
+	struct l_dbus_message *reply = NULL;
+	struct l_dbus_message_builder *builder;
+	uint32_t val_u32;
+	uint8_t ascii[16];
+
+	switch (type) {
+	case NONE:
+	case OUTPUT:
+	case HEXADECIMAL:
+	default:
+		break;
+
+	case ASCII:
+		if (len > 8) {
+			bt_shell_printf("Bad input length\n");
+			break;
+		}
+
+		memset(ascii, 0, 16);
+		memcpy(ascii, buf, len);
+		reply = l_dbus_message_new_method_return(msg);
+		builder = l_dbus_message_builder_new(reply);
+		append_byte_array(builder, ascii, 16);
+		l_dbus_message_builder_finalize(builder);
+		l_dbus_message_builder_destroy(builder);
+		break;
+
+	case DECIMAL:
+		if (len > 8) {
+			bt_shell_printf("Bad input length\n");
+			break;
+		}
+
+		val_u32 = l_get_be32(buf);
+		reply = l_dbus_message_new_method_return(msg);
+		l_dbus_message_set_arguments(reply, "u", val_u32);
+		break;
+	}
+
+	if (!reply)
+		reply = l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+
+	l_dbus_send(dbus, reply);
+}
+
+struct requested_action {
+	const char *action;
+	const char *description;
+};
+
+static struct requested_action display_numeric_table[] = {
+	{ "push", "Push remote button %d times"},
+	{ "twist", "Twist remote nob %d times"},
+	{ "in-numeric", "Enter %d on remote device"},
+	{ "out-numeric", "Enter %d on remote device"}
+};
+
+static struct requested_action prompt_numeric_table[] = {
+	{ "blink", "Enter the number of times remote LED blinked"},
+	{ "beep", "Enter the number of times remote device beeped"},
+	{ "vibrate", "Enter the number of times remote device vibrated"},
+	{ "in-numeric", "Enter the number displayed on remote device"},
+	{ "out-numeric", "Enter the number displayed on remote device"}
+};
+
+static int get_action(char *str, bool prompt)
+{
+	struct requested_action *action_table;
+	size_t len;
+	int i, sz;
+
+	if (!str)
+		return -1;
+
+	if (prompt) {
+		len = strlen(str);
+		sz = L_ARRAY_SIZE(prompt_numeric_table);
+		action_table = prompt_numeric_table;
+	} else {
+		len = strlen(str);
+		sz = L_ARRAY_SIZE(display_numeric_table);
+		action_table = display_numeric_table;
+	}
+
+	for (i = 0; i < sz; ++i)
+		if (len == strlen(action_table[i].action) &&
+			!strcmp(str, action_table[i].action))
+			return i;
+
+	return -1;
+}
+
 static struct l_dbus_message *disp_numeric_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
 	char *str;
 	uint32_t n;
+	int action_index;
 
 	if (!l_dbus_message_get_arguments(msg, "su", &str, &n)) {
 		l_error("Cannot parse \"DisplayNumeric\" arguments");
 		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
 	}
 
-	if (!str || strlen(str) != strlen("in-numeric") ||
-			strncmp(str, "in-numeric", strlen("in-numeric")))
+	action_index = get_action(str, false);
+	if (action_index < 0)
 		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
 
-	bt_shell_printf(COLOR_YELLOW "Enter %u on remote device" COLOR_OFF, n);
+	str = l_strdup_printf(display_numeric_table[action_index].description,
+									n);
+	bt_shell_printf(COLOR_YELLOW "%s\n" COLOR_OFF, str);
+	l_free(str);
 
 	return l_dbus_message_new_method_return(msg);
 }
 
-static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
-								void *user_data)
+static struct l_dbus_message *disp_string_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
 {
-	struct l_dbus_message *msg = user_data;
-	struct l_dbus_message *reply;
-	uint32_t val_u32;
-
-	switch (type) {
-	case NONE:
-	case OUTPUT:
-	case ASCII:
-	case HEXADECIMAL:
-	default:
-		return;
-	case DECIMAL:
-		if (len >= 8) {
-			bt_shell_printf("Bad input length");
-			return;
-		}
+	char *str;
 
-		val_u32 = l_get_be32(buf);
-		reply = l_dbus_message_new_method_return(msg);
-		l_dbus_message_set_arguments(reply, "u", val_u32);
-		l_dbus_send(dbus, reply);
-		break;
+	if (!l_dbus_message_get_arguments(msg, "s", &str)) {
+		l_error("Cannot parse \"DisplayString\" arguments");
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
 	}
+
+	bt_shell_printf(COLOR_YELLOW "Enter AlphaNumeric code on remote device: %s\n" COLOR_OFF, str);
+
+	return l_dbus_message_new_method_return(msg);
 }
 
 static struct l_dbus_message *prompt_numeric_call(struct l_dbus *dbus,
@@ -407,18 +495,43 @@ static struct l_dbus_message *prompt_numeric_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	char *str;
+	int action_index;
+	const char *desc;
 
 	if (!l_dbus_message_get_arguments(msg, "s", &str)) {
 		l_error("Cannot parse \"PromptNumeric\" arguments");
 		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
 	}
 
-	if (!str || strlen(str) != strlen("out-numeric") ||
-			strncmp(str, "out-numeric", strlen("out-numeric")))
+	action_index = get_action(str, true);
+	if (action_index < 0)
 		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
 
+	desc = prompt_numeric_table[action_index].description;
+
 	l_dbus_message_ref(msg);
-	agent_input_request(DECIMAL, 8, agent_input_done, msg);
+	agent_input_request(DECIMAL, 8, desc, agent_input_done, msg);
+
+	return NULL;
+}
+
+static struct l_dbus_message *prompt_static_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	char *str;
+
+	if (!l_dbus_message_get_arguments(msg, "s", &str) || !str) {
+		l_error("Cannot parse \"PromptStatic\" arguments");
+		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
+	}
+
+	if (!strcmp(str, "in-alpha") && !strcmp(str, "out-alpha"))
+		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
+
+	l_dbus_message_ref(msg);
+	agent_input_request(ASCII, 8, "Enter displayed Ascii code",
+							agent_input_done, msg);
 
 	return NULL;
 }
@@ -428,11 +541,14 @@ static void setup_agent_iface(struct l_dbus_interface *iface)
 	l_dbus_interface_property(iface, "Capabilities", 0, "as", caps_getter,
 								NULL);
 	/* TODO: Other properties */
+	l_dbus_interface_method(iface, "DisplayString", 0, disp_string_call,
+						"", "s", "value");
 	l_dbus_interface_method(iface, "DisplayNumeric", 0, disp_numeric_call,
 						"", "su", "type", "number");
 	l_dbus_interface_method(iface, "PromptNumeric", 0, prompt_numeric_call,
-						"u", "s", "number", "type");
-
+						"u", "s", "type");
+	l_dbus_interface_method(iface, "PromptStatic", 0, prompt_static_call,
+						"ay", "s", "type");
 }
 
 static bool register_agent(void)
diff --git a/tools/mesh-gatt/prov.c b/tools/mesh-gatt/prov.c
index 0f9d85d01..598c94ebf 100644
--- a/tools/mesh-gatt/prov.c
+++ b/tools/mesh-gatt/prov.c
@@ -333,18 +333,18 @@ static void prov_calc_ecdh(DBusMessage *message, void *node)
 
 		case 1: /* Static OOB */
 			agent_input_request(HEXADECIMAL,
-					16,
+					16, NULL,
 					prov_out_oob_done, node);
 			break;
 
 		case 2: /* Output OOB */
 			if (action <= 3)
 				agent_input_request(DECIMAL,
-						size,
+						size, NULL,
 						prov_out_oob_done, node);
 			else
 				agent_input_request(ASCII,
-						size,
+						size, NULL,
 						prov_out_oob_done, node);
 			break;
 
@@ -421,7 +421,8 @@ static void prov_start_cmplt(DBusMessage *message, void *node)
 	if (prov == NULL) return;
 
 	if (prov->conf_in.start.pub_key)
-		agent_input_request(HEXADECIMAL, 64, prov_oob_pub_key, node);
+		agent_input_request(HEXADECIMAL, 64, NULL, prov_oob_pub_key,
+									node);
 	else
 		prov_send_pub_key(node);
 }
diff --git a/tools/mesh/agent.c b/tools/mesh/agent.c
index 0ec76f3b7..1f83347bf 100644
--- a/tools/mesh/agent.c
+++ b/tools/mesh/agent.c
@@ -35,6 +35,8 @@
 #include "src/shared/shell.h"
 #include "tools/mesh/agent.h"
 
+#define AGENT_PROMPT	COLOR_BLUE "[mesh-agent]" COLOR_OFF "# "
+
 struct input_request {
 	oob_type_t type;
 	uint16_t len;
@@ -124,7 +126,7 @@ static bool request_hexadecimal(uint16_t len)
 		return false;
 
 	bt_shell_printf("Request hexadecimal key (hex %d octets)\n", len);
-	bt_shell_prompt_input("mesh", "Enter key (hex number):",
+	bt_shell_prompt_input(AGENT_PROMPT, "Enter key (hex number):",
 						response_hexadecimal, NULL);
 
 	return true;
@@ -140,10 +142,15 @@ static uint32_t power_ten(uint8_t power)
 	return ret;
 }
 
-static bool request_decimal(uint16_t len)
+static bool request_decimal(const char *desc, uint16_t len)
 {
-	bt_shell_printf("Request decimal key (0 - %d)\n", power_ten(len) - 1);
-	bt_shell_prompt_input("mesh-agent", "Enter Numeric key:",
+	if (!desc)
+		bt_shell_printf("Request decimal key (0 - %d)\n",
+				power_ten(len) - 1);
+	else
+		bt_shell_printf("%s (0 - %d)\n", desc, power_ten(len) - 1);
+
+	bt_shell_prompt_input(AGENT_PROMPT, "Enter decimal number:",
 							response_decimal, NULL);
 
 	return true;
@@ -161,8 +168,8 @@ static bool request_ascii(uint16_t len)
 	return true;
 }
 
-bool agent_input_request(oob_type_t type, uint16_t max_len, agent_input_cb cb,
-				void *user_data)
+bool agent_input_request(oob_type_t type, uint16_t max_len, const char *desc,
+					agent_input_cb cb, void *user_data)
 {
 	bool result;
 
@@ -174,7 +181,7 @@ bool agent_input_request(oob_type_t type, uint16_t max_len, agent_input_cb cb,
 		result = request_hexadecimal(max_len);
 		break;
 	case DECIMAL:
-		result = request_decimal(max_len);
+		result = request_decimal(desc, max_len);
 		break;
 	case ASCII:
 		result = request_ascii(max_len);
diff --git a/tools/mesh/agent.h b/tools/mesh/agent.h
index 9db4321fc..7f95798f1 100644
--- a/tools/mesh/agent.h
+++ b/tools/mesh/agent.h
@@ -35,8 +35,8 @@ typedef enum {
 
 typedef void (*agent_input_cb)(oob_type_t type, void *input, uint16_t len,
 					void *user_data);
-bool agent_input_request(oob_type_t type, uint16_t max_len, agent_input_cb cb,
-				void *user_data);
+bool agent_input_request(oob_type_t type, uint16_t max_len, const char *desc,
+					agent_input_cb cb, void *user_data);
 
 bool agent_output_request(const char* str);
 void agent_output_request_cancel(void);
-- 
2.21.0

