Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Do not automatically remove watches for service names
Date: Mon,  6 Sep 2010 13:26:19 +0300
Message-Id: <1283768782-4283-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto Von Dentz <luiz.dentz-von@nokia.com>

Services can be owned again so it is perfectly fine to keep the watch.
---
 gdbus/watch.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 29f23e2..b686c85 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -386,18 +386,19 @@ static DBusHandlerResult service_filter(DBusConnection *connection,
 				cb->conn_func(connection, cb->user_data);
 		}
 
+		/* Only auto remove if it is a bus name watch */
+		if (data->argument[0] == ':' &&
+				(!cb->conn_func || !cb->disc_func)) {
+			filter_data_remove_callback(data, cb);
+			continue;
+		}
+
 		/* Check if the watch was removed/freed by the callback
 		 * function */
 		if (!g_slist_find(data->callbacks, cb))
 			continue;
 
 		data->callbacks = g_slist_remove(data->callbacks, cb);
-
-		if (!cb->conn_func || !cb->disc_func) {
-			g_free(cb);
-			continue;
-		}
-
 		data->processed = g_slist_append(data->processed, cb);
 	}
 
-- 
1.7.0.4

