Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/6] client: Get rid of gchar
Date: Wed,  1 May 2013 01:51:57 -0300
Message-Id: <1367383921-19129-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain char instead of gchar.
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index dabb836..b0a66d8 100644
--- a/client/main.c
+++ b/client/main.c
@@ -53,7 +53,7 @@ static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
 
 static GDBusProxy *agent_manager;
-static gchar *auto_register_agent = NULL;
+static char *auto_register_agent = NULL;
 
 static GDBusProxy *default_ctrl;
 static GList *ctrl_list;
-- 
1.8.2.2

