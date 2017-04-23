Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client: Always start an agent
Date: Sun, 23 Apr 2017 23:14:57 +0300
Message-Id: <20170423201457.7963-3-luiz.dentz@gmail.com>
In-Reply-To: <20170423201457.7963-1-luiz.dentz@gmail.com>
References: <20170423201457.7963-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Always register agent with default capability.
---
 client/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 8c9d5c3..255cbd5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2355,10 +2355,10 @@ static gboolean option_version = FALSE;
 static gboolean parse_agent(const char *key, const char *value,
 					gpointer user_data, GError **error)
 {
-	if (value)
-		auto_register_agent = g_strdup(value);
-	else
-		auto_register_agent = g_strdup("");
+	if (!value)
+		return FALSE;
+
+	auto_register_agent = g_strdup(value);
 
 	return TRUE;
 }
@@ -2366,8 +2366,7 @@ static gboolean parse_agent(const char *key, const char *value,
 static GOptionEntry options[] = {
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit" },
-	{ "agent", 'a', G_OPTION_FLAG_OPTIONAL_ARG,
-				G_OPTION_ARG_CALLBACK, parse_agent,
+	{ "agent", 'a', 0, G_OPTION_ARG_CALLBACK, parse_agent,
 				"Register agent handler", "CAPABILITY" },
 	{ NULL },
 };
@@ -2385,6 +2384,8 @@ int main(int argc, char *argv[])
 	GDBusClient *client;
 	guint signal;
 
+	auto_register_agent = g_strdup("");
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
-- 
2.9.3

