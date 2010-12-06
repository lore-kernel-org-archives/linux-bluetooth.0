Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Add btd_error_does_not_exist()
Date: Mon,  6 Dec 2010 17:10:47 -0200
Message-Id: <1291662648-10651-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291662648-10651-7-git-send-email-padovan@profusion.mobi>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-4-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-5-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-6-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/service.c |   10 ++--------
 serial/port.c     |   12 ++----------
 serial/proxy.c    |    9 +--------
 src/adapter.c     |   13 ++++---------
 src/error.c       |    7 +++++++
 src/error.h       |    1 +
 6 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index a71540c..406ee7d 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -354,12 +354,6 @@ static inline DBusMessage *not_authorized(DBusMessage *msg)
 					"Not Authorized");
 }
 
-static inline DBusMessage *does_not_exist(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
-					"Does Not Exist");
-}
-
 static int add_xml_record(DBusConnection *conn, const char *sender,
 			struct service_adapter *serv_adapter,
 			const char *record, dbus_uint32_t *handle)
@@ -656,7 +650,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 
 	auth = next_pending(serv_adapter);
 	if (auth == NULL)
-		return does_not_exist(msg);
+		return btd_error_does_not_exist(msg);
 
 	if (serv_adapter->adapter)
 		adapter_get_address(serv_adapter->adapter, &src);
@@ -687,7 +681,7 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 
 	auth = find_pending_by_sender(serv_adapter, sender);
 	if (auth == NULL)
-		return does_not_exist(msg);
+		return btd_error_does_not_exist(msg);
 
 	if (serv_adapter->adapter)
 		adapter_get_address(serv_adapter->adapter, &src);
diff --git a/serial/port.c b/serial/port.c
index b593311..add8ae0 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -57,7 +57,6 @@
 #include "port.h"
 
 #define SERIAL_PORT_INTERFACE	"org.bluez.Serial"
-#define ERROR_DOES_NOT_EXIST	"org.bluez.Error.DoesNotExist"
 
 #define MAX_OPEN_TRIES		5
 #define OPEN_WAIT		300	/* ms. udev node creation retry wait */
@@ -235,13 +234,6 @@ void port_release_all(void)
 	g_slist_free(devices);
 }
 
-static inline DBusMessage *does_not_exist(DBusMessage *msg,
-					const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
-							"%s", description);
-}
-
 static inline DBusMessage *failed(DBusMessage *msg, const char *description)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
@@ -497,7 +489,7 @@ static DBusMessage *port_connect(DBusConnection *conn,
 
 		channel = strtol(pattern, &endptr, 10);
 		if ((endptr && *endptr != '\0') || channel < 1 || channel > 30)
-			return does_not_exist(msg, "Does not match");
+			return btd_error_does_not_exist(msg);
 
 		port = create_port(device, NULL, channel);
 	}
@@ -538,7 +530,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 
 	port = find_port(device->ports, dev);
 	if (!port)
-		return does_not_exist(msg, "Port does not exist");
+		return btd_error_does_not_exist(msg);
 
 	if (!port->listener_id)
 		return failed(msg, "Not connected");
diff --git a/serial/proxy.c b/serial/proxy.c
index b2ced98..778deb0 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -131,13 +131,6 @@ static void proxy_free(struct serial_proxy *prx)
 	g_free(prx);
 }
 
-static inline DBusMessage *does_not_exist(DBusMessage *msg,
-					const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
-							"%s", description);
-}
-
 static inline DBusMessage *failed(DBusMessage *msg, const char *description)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
@@ -1113,7 +1106,7 @@ static DBusMessage *remove_proxy(DBusConnection *conn,
 
 	l = g_slist_find_custom(adapter->proxies, path, proxy_pathcmp);
 	if (!l)
-		return does_not_exist(msg, "Invalid proxy path");
+		return btd_error_does_not_exist(msg);
 
 	prx = l->data;
 
diff --git a/src/adapter.c b/src/adapter.c
index 2aa9977..2d47856 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1794,9 +1794,8 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 	l = g_slist_find_custom(adapter->devices,
 			path, (GCompareFunc) device_path_cmp);
 	if (!l)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".DoesNotExist",
-				"Device does not exist");
+		return btd_error_does_not_exist(msg);
+
 	device = l->data;
 
 	if (device_is_temporary(device) || device_is_busy(device))
@@ -1832,9 +1831,7 @@ static DBusMessage *find_device(DBusConnection *conn, DBusMessage *msg,
 	l = g_slist_find_custom(adapter->devices,
 			address, (GCompareFunc) device_address_cmp);
 	if (!l)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".DoesNotExist",
-				"Device does not exist");
+		return btd_error_does_not_exist(msg);
 
 	device = l->data;
 
@@ -1905,9 +1902,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 	name = dbus_message_get_sender(msg);
 
 	if (!adapter->agent || !agent_matches(adapter->agent, name, path))
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".DoesNotExist",
-					"No such agent");
+		return btd_error_does_not_exist(msg);
 
 	agent_free(adapter->agent);
 	adapter->agent = NULL;
diff --git a/src/error.c b/src/error.c
index cf3c54d..7c7d14e 100644
--- a/src/error.c
+++ b/src/error.c
@@ -96,3 +96,10 @@ DBusMessage *btd_error_not_available(DBusMessage *msg)
 					".NotAvailable",
 					"Operation currently not available");
 }
+
+DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".DoesNotExist",
+					"Does Not Exist");
+}
diff --git a/src/error.h b/src/error.h
index 7ffd8b7..0ecbf6e 100644
--- a/src/error.h
+++ b/src/error.h
@@ -37,3 +37,4 @@ DBusMessage *btd_error_not_supported(DBusMessage *msg);
 DBusMessage *btd_error_not_connected(DBusMessage *msg);
 DBusMessage *btd_error_not_available(DBusMessage *msg);
 DBusMessage *btd_error_in_progress(DBusMessage *msg);
+DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
-- 
1.7.3.2

