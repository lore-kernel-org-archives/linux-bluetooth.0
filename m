Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Make use of rl_prompt_input
Date: Thu, 24 Aug 2017 16:38:05 +0300
Message-Id: <20170824133805.4894-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes unnecessary code to ask user input which is already
supported by rl_prompt_input.
---
 mesh/agent.c | 127 ++++++++++++++---------------------------------------------
 mesh/main.c  |   4 +-
 2 files changed, 31 insertions(+), 100 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 026f26058..c789b0c1a 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -38,11 +38,6 @@
 #include "mesh/util.h"
 #include "mesh/agent.h"
 
-#define AGENT_PROMPT	COLOR_RED "[agent]" COLOR_OFF " "
-
-static char *agent_saved_prompt = NULL;
-static int agent_saved_point = 0;
-
 struct input_request {
 	oob_type_t type;
 	uint16_t len;
@@ -52,45 +47,6 @@ struct input_request {
 
 static struct input_request pending_request = {NONE, 0, NULL, NULL};
 
-static void agent_prompt(const char *msg)
-{
-	char *prompt;
-
-	/* Normal use should not prompt for user input to the agent a second
-	 * time before it releases the prompt, but we take a safe action. */
-	if (agent_saved_prompt)
-		return;
-
-	agent_saved_point = rl_point;
-	agent_saved_prompt = g_strdup(rl_prompt);
-
-	rl_set_prompt("");
-	rl_redisplay();
-
-	prompt = g_strdup_printf(AGENT_PROMPT "%s", msg);
-	rl_set_prompt(prompt);
-	g_free(prompt);
-
-	rl_replace_line("", 0);
-	rl_redisplay();
-}
-
-static void agent_release_prompt(void)
-{
-	if (!agent_saved_prompt)
-		return;
-
-	/* This will cause rl_expand_prompt to re-run over the last prompt, but
-	 * our prompt doesn't expand anyway. */
-	rl_set_prompt(agent_saved_prompt);
-	rl_replace_line("", 0);
-	rl_point = agent_saved_point;
-	rl_redisplay();
-
-	g_free(agent_saved_prompt);
-	agent_saved_prompt = NULL;
-}
-
 bool agent_completion(void)
 {
 	if (pending_request.type == NONE)
@@ -99,28 +55,37 @@ bool agent_completion(void)
 	return true;
 }
 
-static bool response_hexadecimal(const char *input)
+static void reset_input_request(void)
+{
+	pending_request.type = NONE;
+	pending_request.len = 0;
+	pending_request.cb = NULL;
+	pending_request.user_data = NULL;
+}
+
+static void response_hexadecimal(const char *input, void *user_data)
 {
 	uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];
 
 	if (!str2hex(input, strlen(input), buf, pending_request.len) ) {
 		rl_printf("Incorrect input: expecting %d hex octets\n",
 			  pending_request.len);
-		return false;
+		return;
 	}
 
 	if (pending_request.cb)
 		pending_request.cb(HEXADECIMAL, buf, pending_request.len,
 					pending_request.user_data);
-	return true;
+
+	reset_input_request();
 }
 
-static bool response_decimal(const char *input)
+static void response_decimal(const char *input, void *user_data)
 {
 	uint8_t buf[DECIMAL_OOB_LEN];
 
 	if (strlen(input) > pending_request.len)
-		return false;
+		return;
 
 	bt_put_be32(atoi(input), buf);
 
@@ -128,57 +93,16 @@ static bool response_decimal(const char *input)
 		pending_request.cb(DECIMAL, buf, DECIMAL_OOB_LEN,
 					pending_request.user_data);
 
-	return true;
+	reset_input_request();
 }
 
-static void response_ascii(const char *input)
+static void response_ascii(const char *input, void *user_data)
 {
 	if (pending_request.cb)
 		pending_request.cb(ASCII, (uint8_t *) input, strlen(input),
 					pending_request.user_data);
-}
-
-bool agent_input(const char *input)
-{
-	bool repeat = false;
-
-	if (pending_request.type == NONE)
-		return false;
-
-	switch (pending_request.type) {
-	case HEXADECIMAL:
-		if (!response_hexadecimal(input))
-			repeat = true;
-		break;
-	case DECIMAL:
-		if (!response_decimal(input))
-			repeat = true;
-		break;
-	case ASCII:
-		response_ascii(input);
-		break;
-	case OUTPUT:
-		repeat = true;
-	case NONE:
-	default:
-		break;
-	};
-
-	if (!repeat) {
-		pending_request.type = NONE;
-		pending_request.len = 0;
-		pending_request.cb = NULL;
-		pending_request.user_data = NULL;
-
-		agent_release_prompt();
-	}
 
-	return true;
-}
-
-void agent_release(void)
-{
-	agent_release_prompt();
+	reset_input_request();
 }
 
 static bool request_hexadecimal(uint16_t len)
@@ -187,7 +111,8 @@ static bool request_hexadecimal(uint16_t len)
 		return false;
 
 	rl_printf("Request hexadecimal key (hex %d octets)\n", len);
-	agent_prompt("Enter key (hex number): ");
+	rl_prompt_input("mesh", "Enter key (hex number):", response_hexadecimal,
+								NULL);
 
 	return true;
 }
@@ -205,7 +130,7 @@ static uint32_t power_ten(uint8_t power)
 static bool request_decimal(uint16_t len)
 {
 	rl_printf("Request decimal key (0 - %d)\n", power_ten(len) - 1);
-	agent_prompt("Enter Numeric key: ");
+	rl_prompt_input("mesh", "Enter Numeric key:", response_decimal, NULL);
 
 	return true;
 }
@@ -216,7 +141,8 @@ static bool request_ascii(uint16_t len)
 		return false;
 
 	rl_printf("Request ASCII key (max characters %d)\n", len);
-	agent_prompt("Enter key (ascii string): ");
+	rl_prompt_input("mesh", "Enter key (ascii string):", response_ascii,
+									NULL);
 
 	return true;
 }
@@ -257,13 +183,18 @@ bool agent_input_request(oob_type_t type, uint16_t max_len, agent_input_cb cb,
 	return false;
 }
 
+static void response_output(const char *input, void *user_data)
+{
+	reset_input_request();
+}
+
 bool agent_output_request(const char* str)
 {
 	if (pending_request.type != NONE)
 		return false;
 
 	pending_request.type = OUTPUT;
-	agent_prompt(str);
+	rl_prompt_input("mesh", str, response_output, NULL);
 	return true;
 }
 
@@ -272,5 +203,5 @@ void agent_output_request_cancel(void)
 	if (pending_request.type != OUTPUT)
 		return;
 	pending_request.type = NONE;
-	agent_release_prompt();
+	rl_release_prompt("");
 }
diff --git a/mesh/main.c b/mesh/main.c
index 0a7fc1ee9..b06f4352a 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -2005,7 +2005,7 @@ static void rl_handler(char *input)
 		goto done;
 	}
 
-	if (agent_input(input) == TRUE)
+	if (!rl_release_prompt(input))
 		goto done;
 
 	add_history(input);
@@ -2263,7 +2263,7 @@ int main(int argc, char *argv[])
 	g_list_free(service_list);
 	g_list_free_full(ctrl_list, proxy_leak);
 
-	agent_release();
+	rl_release_prompt("");
 
 	return 0;
 }
-- 
2.13.5

