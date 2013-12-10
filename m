Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] core: Fix not replying to DisconnectProfile
Date: Tue, 10 Dec 2013 10:41:16 +0200
Message-Id: <1386664877-10137-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_service_disconnect may cause a service to disconnect before returning
which cause dev->disconnect to be set after device_profile_disconnected.
---
 src/device.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index d7a00ec..953a338 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1434,11 +1434,14 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (!service)
 		return btd_error_invalid_args(msg);
 
+	dev->disconnect = dbus_message_ref(msg);
+
 	err = btd_service_disconnect(service);
-	if (err == 0) {
-		dev->disconnect = dbus_message_ref(msg);
+	if (err == 0)
 		return NULL;
-	}
+
+	dbus_message_unref(dev->disconnect);
+	dev->disconnect = NULL;
 
 	if (err == -ENOTSUP)
 		return btd_error_not_supported(msg);
-- 
1.8.3.1

