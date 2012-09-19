Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 02/17] core: Make D-Bus connection valid for entire bluetoothd lifetime
Date: Wed, 19 Sep 2012 12:22:04 +0200
Message-ID: <1348050139-27883-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

D-Bus is connected before any subsystem needs to use it and disconnected only
after nothing uses it (i.e. plugins). This is to guarantee that every call to
btd_get_dbus_connection() will return valid DBusConnection object so various
components and plugins do not need to store it somewhere and care about ref
counting.
---
 src/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/main.c b/src/main.c
index 249d29e..31af12a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -388,8 +388,6 @@ static void disconnect_dbus(void)
 	if (!conn || !dbus_connection_get_is_connected(conn))
 		return;
 
-	manager_cleanup(conn, "/");
-
 	set_dbus_connection(NULL);
 
 	dbus_connection_unref(conn);
@@ -418,9 +416,6 @@ static int connect_dbus(void)
 		return -EALREADY;
 	}
 
-	if (!manager_init(conn, "/"))
-		return -EIO;
-
 	set_dbus_connection(conn);
 
 	g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
@@ -532,6 +527,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!manager_init(btd_get_dbus_connection(), "/")) {
+		error("Can't register manager interface");
+		exit(1);
+	}
+
 	start_sdp_server(mtu, SDP_SERVER_COMPAT);
 
 	/* Loading plugins has to be done after D-Bus has been setup since
@@ -554,7 +554,7 @@ int main(int argc, char *argv[])
 
 	g_source_remove(signal);
 
-	disconnect_dbus();
+	manager_cleanup(btd_get_dbus_connection(), "/");
 
 	rfkill_exit();
 
@@ -571,6 +571,8 @@ int main(int argc, char *argv[])
 
 	mgmt_cleanup();
 
+	disconnect_dbus();
+
 	info("Exit");
 
 	__btd_log_cleanup();
-- 
1.7.11.3

