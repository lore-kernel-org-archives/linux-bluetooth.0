Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] core: Fix emitting changes to properties on power off
Date: Mon, 17 Dec 2012 17:45:55 +0200
Message-Id: <1355759155-27921-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
References: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Discoverable and pairable are independent to the powered state so they
should not be changed just because the controller power state is set to
off.
---
 src/adapter.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b15c8b7..5fe3010 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1688,7 +1688,6 @@ static void unload_drivers(struct btd_adapter *adapter)
 int btd_adapter_stop(struct btd_adapter *adapter)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
-	bool emit_discoverable = false, emit_pairable = false;
 	bool emit_discovering = false;
 
 	/* check pending requests */
@@ -1711,24 +1710,10 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 		adapter_remove_connection(adapter, device);
 	}
 
-	if (adapter->discoverable)
-		emit_discoverable = true;
-
-	if (adapter->connectable && adapter->pairable == TRUE)
-		emit_pairable = true;
-
-	adapter->discoverable = FALSE;
 	adapter->connectable = false;
 
 	adapter->off_requested = FALSE;
 
-	if (emit_discoverable)
-		g_dbus_emit_property_changed(conn, adapter->path,
-					ADAPTER_INTERFACE, "Discoverable");
-	if (emit_pairable)
-		g_dbus_emit_property_changed(conn, adapter->path,
-					ADAPTER_INTERFACE, "Pairable");
-
 	if (emit_discovering)
 		g_dbus_emit_property_changed(conn, adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
-- 
1.7.11.7

