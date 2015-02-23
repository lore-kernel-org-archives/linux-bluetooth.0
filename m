Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] gdbus: Fix not calling disconnect function
Date: Mon, 23 Feb 2015 19:33:00 +0100
Message-Id: <1424716380-13720-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If daemon gets disconnected from D-Bus sender is NULL. Watches that
was explicitly added with NULL sender (ie disconnected_signal in
g_dbus_set_disconnect_function) should be called anyway.
---
 gdbus/watch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 0d0054c..b60f650 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -523,9 +523,7 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 	member = dbus_message_get_member(message);
 	dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &arg, DBUS_TYPE_INVALID);
 
-	/* Sender is always the owner */
-	if (sender == NULL)
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	/* If sender != NULL it is always the owner */
 
 	for (current = listeners; current != NULL; current = current->next) {
 		data = current->data;
@@ -533,6 +531,9 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 		if (connection != data->connection)
 			continue;
 
+		if (!sender && data->owner)
+			continue;
+
 		if (data->owner && g_str_equal(sender, data->owner) == FALSE)
 			continue;
 
-- 
1.9.3

