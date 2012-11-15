Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] core: Make use of g_dbus_disconnect
Date: Thu, 15 Nov 2012 16:05:25 +0200
Message-Id: <1352988325-10782-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
References: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 414849a..c180e09 100644
--- a/src/main.c
+++ b/src/main.c
@@ -383,7 +383,7 @@ static void disconnect_dbus(void)
 
 	set_dbus_connection(NULL);
 
-	dbus_connection_unref(conn);
+	g_dbus_disconnect(conn);
 }
 
 static void disconnected_dbus(DBusConnection *conn, void *data)
-- 
1.7.11.7

