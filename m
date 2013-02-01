Return-Path: <cyrus@holtmann.org>
From: patrik.flykt@linux.intel.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] network: Fix user data handling on unregister
Date: Fri,  1 Feb 2013 13:19:51 +0200
Message-Id: <1359717591-32532-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Patrik Flykt <patrik.flykt@linux.intel.com>

User data in unregister_server() is a network_adapter struct. Unregistering
using full UUID will now also work.
---
 profiles/network/server.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 864b49c..c8bfed5 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -676,7 +676,8 @@ static DBusMessage *register_server(DBusConnection *conn,
 static DBusMessage *unregister_server(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	struct network_server *ns = data;
+	struct network_adapter *na = data;
+	struct network_server *ns;
 	DBusMessage *reply;
 	const char *uuid;
 
@@ -684,7 +685,9 @@ static DBusMessage *unregister_server(DBusConnection *conn,
 							DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	if (g_strcmp0(uuid, "nap"))
+	ns = find_server_by_uuid(na->servers, uuid);
+
+	if (ns == NULL)
 		return btd_error_failed(msg, "Invalid UUID");
 
 	reply = dbus_message_new_method_return(msg);
-- 
1.7.10.4

