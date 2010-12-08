Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] convert error to btd_error_not_supported()
Date: Wed,  8 Dec 2010 18:26:00 -0200
Message-Id: <1291839961-14940-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291839961-14940-5-git-send-email-padovan@profusion.mobi>
References: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-2-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-3-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-4-git-send-email-padovan@profusion.mobi>
 <1291839961-14940-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 input/device.c       |    8 +-------
 network/connection.c |    2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/input/device.c b/input/device.c
index f7f96be..3c3f9fd 100644
--- a/input/device.c
+++ b/input/device.c
@@ -315,12 +315,6 @@ failed:
 	return FALSE;
 }
 
-static inline DBusMessage *not_supported(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"Not supported");
-}
-
 static inline DBusMessage *already_connected(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyConnected",
@@ -937,7 +931,7 @@ static DBusMessage *input_device_connect(DBusConnection *conn,
 
 	iconn = find_connection(idev->connections, "HID");
 	if (!iconn)
-		return not_supported(msg);
+		return btd_error_not_supported(msg);
 
 	if (iconn->pending_connect)
 		return btd_error_in_progress(msg);
diff --git a/network/connection.c b/network/connection.c
index d24d96c..a652b98 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -393,7 +393,7 @@ static DBusMessage *connection_connect(DBusConnection *conn,
 	id = bnep_service_id(svc);
 	nc = find_connection(peer->connections, id);
 	if (!nc)
-		return not_supported(msg);
+		return btd_error_not_supported(msg);
 
 	if (nc->state != DISCONNECTED)
 		return already_connected(msg);
-- 
1.7.3.2

