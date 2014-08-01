Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] gdbus: Fix use after free
Date: Fri,  1 Aug 2014 11:29:12 +0300
Message-Id: <1406881752-24897-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406881752-24897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CABBYNZJSfWa8r8Ab-Dp3cmSwcxQc_7t7W0Cb2EALobM4RQnLkw@mail.gmail.com>
 <1406881752-24897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactor filter_data_remove_callback so that we do not iterate over
freed pointer.
---
 gdbus/watch.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 0f99f4f..e18ca1f 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -362,6 +362,7 @@ static void service_data_free(struct service_data *data)
 	callback->data = NULL;
 }
 
+/* Returns TRUE if data is freed */
 static gboolean filter_data_remove_callback(struct filter_data *data,
 						struct filter_callback *cb)
 {
@@ -383,7 +384,7 @@ static gboolean filter_data_remove_callback(struct filter_data *data,
 	/* Don't remove the filter if other callbacks exist or data is lock
 	 * processing callbacks */
 	if (data->callbacks || data->lock)
-		return TRUE;
+		return FALSE;
 
 	if (data->registered && !remove_match(data))
 		return FALSE;
@@ -405,7 +406,9 @@ static DBusHandlerResult signal_filter(DBusConnection *connection,
 
 		if (cb->signal_func && !cb->signal_func(connection, message,
 							cb->user_data)) {
-			filter_data_remove_callback(data, cb);
+			if (filter_data_remove_callback(data, cb))
+				break;
+
 			continue;
 		}
 
@@ -489,7 +492,9 @@ static DBusHandlerResult service_filter(DBusConnection *connection,
 		/* Only auto remove if it is a bus name watch */
 		if (data->argument[0] == ':' &&
 				(cb->conn_func == NULL || cb->disc_func == NULL)) {
-			filter_data_remove_callback(data, cb);
+			if(filter_data_remove_callback(data, cb))
+				break;
+
 			continue;
 		}
 
-- 
1.9.1

