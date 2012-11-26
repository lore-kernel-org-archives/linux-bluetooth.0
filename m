Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/11] network: Remove Network.Connect and Network.Disconnect
Date: Mon, 26 Nov 2012 15:09:18 +0200
Message-Id: <1353935362-8666-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These method are no longer necessary as Device interface has similar
functionality.
---
 doc/network-api.txt           | 36 -------------------
 profiles/network/connection.c | 81 +------------------------------------------
 2 files changed, 1 insertion(+), 116 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 4dd3e58..b640b9a 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -11,42 +11,6 @@ Service		org.bluez
 Interface	org.bluez.Network
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		string Connect(string uuid)
-
-			Connect to the network device and return the network
-			interface name. Examples of the interface name are
-			bnep0, bnep1 etc.
-
-			uuid can be either one of "gn", "panu" or "nap" (case
-			insensitive) or a traditional string representation of
-			UUID or a hexadecimal number.
-
-			The connection will be closed and network device
-			released either upon calling Disconnect() or when
-			the client disappears from the message bus.
-
-			Possible errors: org.bluez.Error.AlreadyConnected
-					 org.bluez.Error.ConnectionAttemptFailed
-
-		void Disconnect()
-
-			Disconnect from the network device.
-
-			To abort a connection attempt in case of errors or
-			timeouts in the client it is fine to call this method.
-
-			Possible errors: org.bluez.Error.Failed
-
-		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
 Properties	boolean Connected [readonly]
 
 			Indicates if the device is connected.
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index d9961f8..231164b 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -378,50 +378,6 @@ failed:
 	cancel_connection(nc, -EIO);
 }
 
-static void local_connect_cb(struct btd_device *device, int err,
-						const char *pdev, void *data)
-{
-	DBusMessage *msg = data;
-	DBusMessage *reply;
-
-	if (err < 0) {
-		reply = btd_error_failed(msg, strerror(-err));
-		g_dbus_send_message(btd_get_dbus_connection(), reply);
-		dbus_message_unref(msg);
-		return;
-	}
-
-	g_dbus_send_reply(btd_get_dbus_connection(), msg,
-						DBUS_TYPE_STRING, &pdev,
-						DBUS_TYPE_INVALID);
-
-	dbus_message_unref(msg);
-}
-
-static DBusMessage *local_connect(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	struct network_peer *peer = data;
-	const char *svc;
-	uint16_t id;
-	int err;
-
-	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &svc,
-						DBUS_TYPE_INVALID) == FALSE)
-		return btd_error_invalid_args(msg);
-
-	id = bnep_service_id(svc);
-
-	err = connection_connect(peer->device, id, dbus_message_get_sender(msg),
-							local_connect_cb, msg);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
 /* Connect and initiate BNEP session */
 int connection_connect(struct btd_device *device, uint16_t id,
 					const char *owner,
@@ -496,30 +452,6 @@ int connection_disconnect(struct btd_device *device, uint16_t id,
 	return 0;
 }
 
-static DBusMessage *local_disconnect(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct network_peer *peer = data;
-	const char *caller = dbus_message_get_sender(msg);
-	GSList *l;
-
-	for (l = peer->connections; l; l = l->next) {
-		struct network_conn *nc = l->data;
-		int err;
-
-		if (nc->state == DISCONNECTED)
-			continue;
-
-		err = connection_disconnect(peer->device, nc->id, caller);
-		if (err < 0)
-			return btd_error_failed(msg, strerror(-err));
-
-		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-	}
-
-	return btd_error_not_connected(msg);
-}
-
 static gboolean
 network_property_get_connected(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -616,16 +548,6 @@ static void path_unregister(void *data)
 	peer_free(peer);
 }
 
-static const GDBusMethodTable connection_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect",
-				GDBUS_ARGS({"uuid", "s"}),
-				GDBUS_ARGS({"interface", "s"}),
-				local_connect) },
-	{ GDBUS_METHOD("Disconnect",
-			NULL, NULL, local_disconnect) },
-	{ }
-};
-
 static const GDBusPropertyTable connection_properties[] = {
 	{ "Connected", "b", network_property_get_connected },
 	{ "Interface", "s", network_property_get_interface },
@@ -661,8 +583,7 @@ static struct network_peer *create_peer(struct btd_device *device)
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(), path,
 					NETWORK_PEER_INTERFACE,
-					connection_methods,
-					NULL, connection_properties,
+					NULL, NULL, connection_properties,
 					peer, path_unregister) == FALSE) {
 		error("D-Bus failed to register %s interface",
 			NETWORK_PEER_INTERFACE);
-- 
1.7.11.7

