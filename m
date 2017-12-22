Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 8/8] tools/obexctl: Add generator for session/transfer
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Message-ID: <34060e99-cbde-82ee-e962-0bb931e73f6c@jp.fujitsu.com>
Date: Fri, 22 Dec 2017 16:36:05 +0900
MIME-Version: 1.0
In-Reply-To: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/obexctl.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 38f0fd506..3f9e5ddc0 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -83,6 +83,27 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	bt_shell_set_prompt(PROMPT_OFF);
 }
 
+static char *generic_generator(const char *text, int state, GList *source)
+{
+	static int index = 0;
+
+	if (!state) {
+		index = 0;
+	}
+
+	return g_dbus_proxy_path_lookup(source, &index, text);
+}
+
+static char *session_generator(const char *text, int state)
+{
+	return generic_generator(text, state, sessions);
+}
+
+static char *transfer_generator(const char *text, int state)
+{
+	return generic_generator(text, state, transfers);
+}
+
 static void connect_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
@@ -1785,14 +1806,21 @@ static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
 	{ "connect",      "<dev> [uuid]", cmd_connect, "Connect session" },
-	{ "disconnect",   "[session]", cmd_disconnect, "Disconnect session" },
+	{ "disconnect",   "[session]", cmd_disconnect, "Disconnect session",
+						session_generator },
 	{ "list",         NULL,       cmd_list, "List available sessions" },
-	{ "show",         "[session]", cmd_show, "Session information" },
-	{ "select",       "<session>", cmd_select, "Select default session" },
-	{ "info",         "<object>", cmd_info, "Object information" },
-	{ "cancel",       "<transfer>", cmd_cancel, "Cancel transfer" },
-	{ "suspend",      "<transfer>", cmd_suspend, "Suspend transfer" },
-	{ "resume",       "<transfer>", cmd_resume, "Resume transfer" },
+	{ "show",         "[session]", cmd_show, "Session information",
+						session_generator },
+	{ "select",       "<session>", cmd_select, "Select default session",
+						session_generator },
+	{ "info",         "<object>", cmd_info, "Object information",
+						transfer_generator },
+	{ "cancel",       "<transfer>", cmd_cancel, "Cancel transfer",
+						transfer_generator },
+	{ "suspend",      "<transfer>", cmd_suspend, "Suspend transfer",
+						transfer_generator },
+	{ "resume",       "<transfer>", cmd_resume, "Resume transfer",
+						transfer_generator },
 	{ "send",         "<file>",   cmd_send, "Send file" },
 	{ "pull",	  "<file>",   cmd_pull,
 					"Pull Vobject & stores in file" },
-- 
2.14.1

