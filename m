Return-Path: <cyrus@holtmann.org>
Message-ID: <1384017487.3880.42.camel@nuvo>
Subject: [PATCH] obex: Use GLib helper function to manipulate paths
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 09 Nov 2013 18:18:07 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Instead of trying to do it by hand. This also makes sure that
relative paths aren't used by the agent.
---
 obexd/src/manager.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index cec8a39..f18896e 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -651,14 +651,14 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 				DBUS_TYPE_STRING, &name,
 				DBUS_TYPE_INVALID)) {
 		/* Splits folder and name */
-		const char *slash = strrchr(name, '/');
+		gboolean is_relative = !g_path_is_absolute(name);
 		DBG("Agent replied with %s", name);
-		if (!slash) {
-			agent->new_name = g_strdup(name);
+		if (is_relative) {
+			agent->new_name = g_path_get_basename(name);
 			agent->new_folder = NULL;
 		} else {
-			agent->new_name = g_strdup(slash + 1);
-			agent->new_folder = g_strndup(name, slash - name);
+			agent->new_name = g_path_get_basename(name);
+			agent->new_folder = g_path_get_dirname(name);
 		}
 	}
 
-- 
1.8.4.2


