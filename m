Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrick.ohly@intel.com
Subject: [PATCH BlueZ 4/8] tools/obexctl: Add resume command
Date: Fri, 14 Feb 2014 17:53:00 +0200
Message-Id: <1392393184-15266-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add support for resume command which can be used to resume ongoing
transfers.
---
 tools/obexctl.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 000e44d..fc051d7 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -636,6 +636,46 @@ static void cmd_suspend(int argc, char *argv[])
 						g_dbus_proxy_get_path(proxy));
 }
 
+static void resume_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to resume: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("Resume successful\n");
+}
+
+static void cmd_resume(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	if (argc < 2) {
+		rl_printf("Missing transfer address argument\n");
+		return;
+	}
+
+	proxy = find_transfer(argv[1]);
+	if (!proxy) {
+		rl_printf("Transfer %s not available\n", argv[1]);
+		return;
+	}
+
+	if (g_dbus_proxy_method_call(proxy, "Resume", NULL, resume_reply,
+						NULL, NULL) == FALSE) {
+		rl_printf("Failed to resume transfer\n");
+		return;
+	}
+
+	rl_printf("Attempting to resume transfer %s\n",
+						g_dbus_proxy_get_path(proxy));
+}
+
 static GDBusProxy *find_opp(const char *path)
 {
 	GSList *l;
@@ -1897,6 +1937,7 @@ static const struct {
 	{ "info",         "<object>", cmd_info, "Object information" },
 	{ "cancel",       "<transfer>", cmd_cancel, "Cancel transfer" },
 	{ "suspend",      "<transfer>", cmd_suspend, "Suspend transfer" },
+	{ "resume",       "<transfer>", cmd_resume, "Resume transfer" },
 	{ "send",         "<file>",   cmd_send, "Send file" },
 	{ "cd",           "<path>",   cmd_cd, "Change current folder" },
 	{ "ls",           NULL,       cmd_ls, "List current folder" },
-- 
1.8.5.3

