Return-Path: <SRS0=54w9=ZB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B253AC17441
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Nov 2019 01:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C357214DA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Nov 2019 01:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfKIBd4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:33:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:25478 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfKIBd4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Nov 2019 20:33:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 17:33:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="206174192"
Received: from ingas-nuc1.sea.intel.com ([10.254.33.193])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2019 17:33:54 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Add full support for numeric input
Date:   Fri,  8 Nov 2019 17:33:53 -0800
Message-Id: <20191109013353.8574-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for all the forms of numeric input requests to
the Provisioner from a remote device:
"blink", "beep", "vibrate", "in-numeric"
---
 tools/mesh-cfgclient.c | 41 ++++++++++++++++++++++++++++++++++++++---
 tools/mesh-gatt/prov.c |  9 +++++----
 tools/mesh/agent.c     | 21 ++++++++++++++-------
 tools/mesh/agent.h     |  4 ++--
 4 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 444b9e5aa..58181f0cd 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -402,23 +402,58 @@ static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
 	}
 }
 
+struct requested_action {
+	const char *action;
+	const char *description;
+};
+
+static struct requested_action prompt_numeric_action_table[] = {
+	{ "blink", "Enter the number of times remote LED blinked"},
+	{ "beep", "Enter the number of times remote device beeped"},
+	{ "vibrate", "Enter the number of times remote device vibrated"},
+	{ "in-numeric", "Enter the number displayed on remote device"}
+};
+
+static int get_action(char *str)
+{
+	size_t len;
+	int i, sz;
+
+	if (!str)
+		return -1;
+
+	len = strlen(str);
+	sz = L_ARRAY_SIZE(prompt_numeric_action_table);
+
+	for (i = 0; i < sz; ++i)
+		if (len == strlen(prompt_numeric_action_table[i].action) &&
+			!strcmp(str, prompt_numeric_action_table[i].action))
+			return i;
+
+	return -1;
+}
+
 static struct l_dbus_message *prompt_numeric_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
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
+	action_index = get_action(str);
+	if (action_index < 0)
 		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
 
+	desc = prompt_numeric_action_table[action_index].description;
+
 	l_dbus_message_ref(msg);
-	agent_input_request(DECIMAL, 8, agent_input_done, msg);
+	agent_input_request(DECIMAL, 8, desc, agent_input_done, msg);
 
 	return NULL;
 }
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

