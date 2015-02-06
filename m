Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ 1/4] core: adapter: Add StartFilteredDiscovery method
Date: Fri,  6 Feb 2015 15:13:28 -0800
Message-Id: <1423264411-19439-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces StartFilteredDiscovery method.
---
 src/adapter.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1839286..af6fafb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1744,6 +1744,12 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *start_filtered_discovery(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return btd_error_failed(msg, "Not implemented yet");
+}
+
 static DBusMessage *stop_discovery(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -2278,6 +2284,9 @@ static DBusMessage *remove_device(DBusConnection *conn,
 
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
+	{ GDBUS_METHOD("StartFilteredDiscovery",
+		GDBUS_ARGS({ "properties", "a{sv}s" }), NULL,
+		start_filtered_discovery) },
 	{ GDBUS_METHOD("StopDiscovery", NULL, NULL, stop_discovery) },
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL, remove_device) },
-- 
2.2.0.rc0.207.ga3a616c

