Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@holtmann.org, deymo@chromium.org
Subject: [PATCH 3/6] "agent" command capability argument and autocompletion
Date: Thu, 14 Mar 2013 11:22:03 -0700
Message-Id: <1363285326-20089-4-git-send-email-deymo@chromium.org>
In-Reply-To: <1363285326-20089-1-git-send-email-deymo@chromium.org>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables argument autocompletion for the agent command with the
list of capabilities an agent can have, adding also "on" (for the default "")
and "off". The command passes the argument (parsing and verifying it) to the
dbus method call.
---
 client/main.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 704cf46..12b08b5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -59,6 +59,27 @@ static GDBusProxy *default_ctrl;
 static GList *ctrl_list;
 static GList *dev_list;
 
+static const char* agent_arguments[] = {
+	"on",
+	"off",
+	"DisplayOnly",
+	"DisplayYesNo",
+	"KeyboardDisplay",
+	"KeyboardOnly",
+	"NoInputNoOutput",
+	NULL
+};
+
+static const char* agent_capability_options[] = {
+	"", /* default */
+	"DisplayOnly",
+	"DisplayYesNo",
+	"KeyboardDisplay",
+	"KeyboardOnly",
+	"NoInputNoOutput",
+	NULL
+};
+
 static void proxy_leak(gpointer data)
 {
 	printf("Leaking proxy %p\n", data);
@@ -413,6 +434,39 @@ static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *value)
 	return FALSE;
 }
 
+static gboolean parse_argument_agent(const char *arg, dbus_bool_t *value,
+							const char **capability)
+{
+	const char **opt;
+
+	if (!arg || !strlen(arg)) {
+		rl_printf("Missing on/off/capability argument\n");
+		return FALSE;
+	}
+
+	if (!strcmp(arg, "on") || !strcmp(arg, "yes")) {
+		*value = TRUE;
+		*capability = "";
+		return TRUE;
+	}
+
+	if (!strcmp(arg, "off") || !strcmp(arg, "no")) {
+		*value = FALSE;
+		return TRUE;
+	}
+
+	for (opt = agent_arguments; *opt; opt++) {
+		if (!strcmp(arg, *opt)) {
+			*value = TRUE;
+			*capability = *opt;
+			return TRUE;
+		}
+	}
+
+	rl_printf("Invalid argument %s\n", arg);
+	return FALSE;
+}
+
 static void cmd_list(const char *arg)
 {
 	GList *list;
@@ -610,13 +664,14 @@ static void cmd_discoverable(const char *arg)
 static void cmd_agent(const char *arg)
 {
 	dbus_bool_t enable;
+	const char* capability;
 
-	if (parse_argument_on_off(arg, &enable) == FALSE)
+	if (parse_argument_agent(arg, &enable, &capability) == FALSE)
 		return;
 
 	if (enable == TRUE) {
 		g_free(auto_register_agent);
-		auto_register_agent = g_strdup("");
+		auto_register_agent = g_strdup(capability);
 
 		if (agent_manager)
 			agent_register(dbus_conn, agent_manager,
@@ -968,6 +1023,26 @@ static char *dev_generator(const char *text, int state)
 	return generic_generator(text, state, dev_list, "Address");
 }
 
+static char *capability_generator(const char *text, int state)
+{
+	static int index, len;
+	const char *arg;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((arg = agent_arguments[index])) {
+		index++;
+
+		if (!strncmp(arg, text, len))
+			return strdup(arg);
+	}
+
+	return NULL;
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -989,7 +1064,8 @@ static const struct {
 					"Set controller pairable mode" },
 	{ "discoverable", "<on/off>", cmd_discoverable,
 					"Set controller discoverable mode" },
-	{ "agent",        "<on/off>", cmd_agent, "Enable/disable agent" },
+	{ "agent",        "<on/off/capability>", cmd_agent,
+	"Enable/disable agent with given capability", capability_generator},
 	{ "default-agent",NULL,       cmd_default_agent },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices" },
 	{ "info",         "<dev>",    cmd_info, "Device information",
-- 
1.8.1.3

