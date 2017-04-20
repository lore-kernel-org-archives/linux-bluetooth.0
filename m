Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client: Always start an agent
Date: Thu, 20 Apr 2017 15:32:33 +0300
Message-Id: <20170420123233.8747-3-luiz.dentz@gmail.com>
In-Reply-To: <20170420123233.8747-1-luiz.dentz@gmail.com>
References: <20170420123233.8747-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Always register agent with 'KeyboardDisplay' capability.
---
 client/main.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/client/main.c b/client/main.c
index 8c9d5c3..7043081 100644
--- a/client/main.c
+++ b/client/main.c
@@ -54,6 +54,8 @@
 #define PROMPT_ON	COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
 #define PROMPT_OFF	"Waiting to connect to bluetoothd..."
 
+#define AGENT_CAP	"KeyboardDisplay"
+
 static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
 
@@ -2352,23 +2354,9 @@ static guint setup_signalfd(void)
 
 static gboolean option_version = FALSE;
 
-static gboolean parse_agent(const char *key, const char *value,
-					gpointer user_data, GError **error)
-{
-	if (value)
-		auto_register_agent = g_strdup(value);
-	else
-		auto_register_agent = g_strdup("");
-
-	return TRUE;
-}
-
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit" },
-	{ "agent", 'a', G_OPTION_FLAG_OPTIONAL_ARG,
-				G_OPTION_ARG_CALLBACK, parse_agent,
-				"Register agent handler", "CAPABILITY" },
 	{ NULL },
 };
 
@@ -2399,6 +2387,8 @@ int main(int argc, char *argv[])
 
 	g_option_context_free(context);
 
+	auto_register_agent = g_strdup(AGENT_CAP);
+
 	if (option_version == TRUE) {
 		printf("%s\n", VERSION);
 		exit(0);
-- 
2.9.3

