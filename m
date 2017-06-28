Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] client: Add generic way to request input from user
Date: Wed, 28 Jun 2017 15:54:20 +0300
Message-Id: <20170628125423.26208-7-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds rl_prompt_input which can be used by different parts to ask
user input.
---
 client/display.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/display.h |  5 +++++
 client/main.c    |  3 +++
 3 files changed, 66 insertions(+)

diff --git a/client/display.c b/client/display.c
index d85b9d0..1dc4294 100644
--- a/client/display.c
+++ b/client/display.c
@@ -34,6 +34,11 @@
 
 #include "display.h"
 
+static char *saved_prompt = NULL;
+static int saved_point = 0;
+static rl_prompt_input_func saved_func = NULL;
+static void *saved_user_data = NULL;
+
 void rl_printf(const char *fmt, ...)
 {
 	va_list args;
@@ -104,3 +109,56 @@ void rl_hexdump(const unsigned char *buf, size_t len)
 		rl_printf("%s\n", str);
 	}
 }
+
+void rl_prompt_input(const char *label, const char *msg,
+				rl_prompt_input_func func, void *user_data)
+{
+	char prompt[256];
+
+	/* Normal use should not prompt for user input to the value a second
+	 * time before it releases the prompt, but we take a safe action. */
+	if (saved_prompt)
+		return;
+
+	saved_point = rl_point;
+	saved_prompt = strdup(rl_prompt);
+	saved_func = func;
+	saved_user_data = user_data;
+
+	memset(prompt, 0, sizeof(prompt));
+	snprintf(prompt, sizeof(prompt), COLOR_RED "[%s]" COLOR_OFF " %s ",
+								label, msg);
+	rl_set_prompt(prompt);
+
+	rl_replace_line("", 0);
+	rl_redisplay();
+}
+
+int rl_release_prompt(const char *input)
+{
+	rl_prompt_input_func func;
+	void *user_data;
+
+	if (!saved_prompt)
+		return -1;
+
+	/* This will cause rl_expand_prompt to re-run over the last prompt, but
+	 * our prompt doesn't expand anyway. */
+	rl_set_prompt(saved_prompt);
+	rl_replace_line("", 0);
+	rl_point = saved_point;
+	rl_redisplay();
+
+	free(saved_prompt);
+	saved_prompt = NULL;
+
+	func = saved_func;
+	user_data = saved_user_data;
+
+	saved_func = NULL;
+	saved_user_data = NULL;
+
+	func(input, user_data);
+
+	return 0;
+}
diff --git a/client/display.h b/client/display.h
index 88dbbd0..e991d19 100644
--- a/client/display.h
+++ b/client/display.h
@@ -31,3 +31,8 @@
 
 void rl_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
 void rl_hexdump(const unsigned char *buf, size_t len);
+
+typedef void (*rl_prompt_input_func) (const char *input, void *user_data);
+void rl_prompt_input(const char *label, const char *msg,
+				rl_prompt_input_func func, void *user_data);
+int rl_release_prompt(const char *input);
diff --git a/client/main.c b/client/main.c
index 7eeeefa..e5497f1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2321,6 +2321,9 @@ static void rl_handler(char *input)
 	if (agent_input(dbus_conn, input) == TRUE)
 		goto done;
 
+	if (!rl_release_prompt(input))
+		goto done;
+
 	add_history(input);
 
 	cmd = strtok_r(input, " ", &arg);
-- 
2.9.4

