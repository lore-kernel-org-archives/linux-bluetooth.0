Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] convert errors to btd_error_not_authorized()
Date: Wed,  8 Dec 2010 18:25:56 -0200
Message-Id: <1291839961-14940-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
References: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c      |    3 +--
 audio/transport.c    |    8 ++++----
 network/connection.c |    2 +-
 serial/port.c        |    2 +-
 serial/proxy.c       |    4 ++--
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 93c4301..7aec623 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -514,8 +514,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 		goto done;
 
 	if (strcmp(gw->agent->name, dbus_message_get_sender(msg)) != 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"Permission denied");
+		return btd_error_not_authorized(msg);
 
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_OBJECT_PATH, &path,
diff --git a/audio/transport.c b/audio/transport.c
index 48af0ea..e2ee400 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -443,10 +443,10 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 
 	owner = media_transport_find_owner(transport, sender);
 	if (owner != NULL)
-		return error_failed(msg, strerror(EPERM));
+		return btd_error_not_authorized(msg);
 
 	if (media_transport_acquire(transport, accesstype) == FALSE)
-		return error_failed(msg, strerror(EPERM));
+		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(transport, msg, accesstype);
 	req = g_new0(struct acquire_request, 1);
@@ -476,7 +476,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 
 	owner = media_transport_find_owner(transport, sender);
 	if (owner == NULL)
-		return error_failed(msg, strerror(EPERM));
+		return btd_error_not_authorized(msg);
 
 	if (g_strcmp0(owner->accesstype, accesstype) == 0)
 		media_owner_remove(owner);
@@ -484,7 +484,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 		media_transport_release(transport, accesstype);
 		g_strdelimit(owner->accesstype, accesstype, ' ');
 	} else
-		return error_failed(msg, strerror(EPERM));
+		return btd_error_not_authorized(msg);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
diff --git a/network/connection.c b/network/connection.c
index 7380cbe..37a7511 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -438,7 +438,7 @@ static DBusMessage *connection_cancel(DBusConnection *conn,
 	const char *caller = dbus_message_get_sender(msg);
 
 	if (!g_str_equal(owner, caller))
-		return not_permited(msg);
+		return btd_error_not_authorized(msg);
 
 	connection_destroy(conn, nc);
 
diff --git a/serial/port.c b/serial/port.c
index add8ae0..1d0bfc1 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -538,7 +538,7 @@ static DBusMessage *port_disconnect(DBusConnection *conn,
 	owner = dbus_message_get_sender(port->msg);
 	caller = dbus_message_get_sender(msg);
 	if (!g_str_equal(owner, caller))
-		return failed(msg, "Operation not permited");
+		return btd_error_not_authorized(msg);
 
 	port_release(port);
 
diff --git a/serial/proxy.c b/serial/proxy.c
index 778deb0..c779c4e 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -728,7 +728,7 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 
 	/* Don't allow change TTY settings if it is open */
 	if (prx->local)
-		return failed(msg, "Not allowed");
+		return btd_error_not_authorized(msg);
 
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &ratestr,
@@ -1112,7 +1112,7 @@ static DBusMessage *remove_proxy(DBusConnection *conn,
 
 	sender = dbus_message_get_sender(msg);
 	if (g_strcmp0(prx->owner, sender) != 0)
-		return failed(msg, "Permission denied");
+		return btd_error_not_authorized(msg);
 
 	unregister_proxy(prx);
 
-- 
1.7.3.2

