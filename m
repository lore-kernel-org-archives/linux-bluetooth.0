Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 3/8] core: adapter: Add SetDiscoveryFilter method
Date: Thu, 26 Mar 2015 01:29:11 -0700
Message-Id: <1427358556-3276-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1427358556-3276-1-git-send-email-jpawlowski@google.com>
References: <1427358556-3276-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds SetDiscoveryFilter method, as described in
doc/adapter-api.txt to DBus interface. Method content wil follow in
next patches.
---
 src/adapter.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 23a9a81..8bf23d1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1759,6 +1759,12 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *set_discovery_filter(DBusConnection *conn,
+					 DBusMessage *msg, void *user_data)
+{
+	return btd_error_failed(msg, "Not implemented yet");
+}
+
 static DBusMessage *stop_discovery(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -2331,6 +2337,9 @@ static DBusMessage *remove_device(DBusConnection *conn,
 
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
+	{ GDBUS_METHOD("SetDiscoveryFilter",
+		GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
+		set_discovery_filter) },
 	{ GDBUS_METHOD("StopDiscovery", NULL, NULL, stop_discovery) },
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL, remove_device) },
-- 
2.2.0.rc0.207.ga3a616c

