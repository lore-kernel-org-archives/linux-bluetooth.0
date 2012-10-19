Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 02/15] network: Trivial function rename
Date: Fri, 19 Oct 2012 17:39:19 +0200
Message-Id: <1350661172-18125-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Avoid the connection_ prefix for local functions implementing the D-Bus
API.
---
 profiles/network/connection.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 8564bca..afa8a6b 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -397,7 +397,7 @@ failed:
 }
 
 /* Connect and initiate BNEP session */
-static DBusMessage *connection_connect(DBusConnection *conn,
+static DBusMessage *local_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct network_peer *peer = data;
@@ -465,7 +465,7 @@ static DBusMessage *connection_cancel(DBusConnection *conn,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
-static DBusMessage *connection_disconnect(DBusConnection *conn,
+static DBusMessage *local_disconnect(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct network_peer *peer = data;
@@ -483,7 +483,7 @@ static DBusMessage *connection_disconnect(DBusConnection *conn,
 	return btd_error_not_connected(msg);
 }
 
-static DBusMessage *connection_get_properties(DBusConnection *conn,
+static DBusMessage *local_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct network_peer *peer = data;
@@ -568,12 +568,12 @@ static const GDBusMethodTable connection_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect",
 				GDBUS_ARGS({"uuid", "s"}),
 				GDBUS_ARGS({"interface", "s"}),
-				connection_connect) },
+				local_connect) },
 	{ GDBUS_METHOD("Disconnect",
-			NULL, NULL, connection_disconnect) },
+			NULL, NULL, local_disconnect) },
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			connection_get_properties) },
+			local_get_properties) },
 	{ }
 };
 
-- 
1.7.11.7

