Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] convert errors to btd_error_does_not_exist()
Date: Wed,  8 Dec 2010 18:25:57 -0200
Message-Id: <1291839961-14940-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291839961-14940-2-git-send-email-padovan@profusion.mobi>
References: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c   |    4 +---
 audio/media.c     |    3 +--
 plugins/service.c |    2 +-
 src/device.c      |    4 +---
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 7aec623..05b9ff7 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -522,9 +522,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	if (strcmp(gw->agent->path, path) != 0)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
-				"Unknown object path");
+		return btd_error_does_not_exist(msg);
 
 	g_dbus_remove_watch(device->conn, gw->agent->watch);
 
diff --git a/audio/media.c b/audio/media.c
index b893231..0e6ccc9 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -351,8 +351,7 @@ static DBusMessage *unregister_endpoint(DBusConnection *conn, DBusMessage *msg,
 
 	endpoint = media_adapter_find_endpoint(adapter, sender, path, NULL);
 	if (endpoint == NULL)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-				"Endpoint not registered");
+		return btd_error_does_not_exist(msg);
 
 	media_endpoint_remove(endpoint);
 
diff --git a/plugins/service.c b/plugins/service.c
index 5267671..a442d53 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -600,7 +600,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 
 	sender = dbus_message_get_sender(msg);
 	if (find_pending_by_sender(serv_adapter, sender))
-		return failed(msg);
+		return btd_error_does_not_exist(msg);
 
 	user_record = find_record(serv_adapter, handle, sender);
 	if (!user_record) {
diff --git a/src/device.c b/src/device.c
index 1b8d581..cc8131b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -723,9 +723,7 @@ static DBusMessage *cancel_discover(DBusConnection *conn,
 	const char *requestor;
 
 	if (!device->browse)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
-				"No pending discovery");
+		return btd_error_does_not_exist(msg);
 
 	if (!dbus_message_is_method_call(device->browse->msg, DEVICE_INTERFACE,
 					"DiscoverServices"))
-- 
1.7.3.2

