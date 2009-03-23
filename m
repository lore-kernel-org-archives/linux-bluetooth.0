Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
From: Zygo Blaxell <zygo.blaxell@xandros.com>
Date: Mon, 23 Mar 2009 14:39:59 -0400
Subject: [PATCH] Prevent discovery failure if the adapter is already in periodic inquiry mode
Message-Id: <E1LlpPd-000847-0b@dactyl.ottawa.xandros.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If an adapter is put into periodic inquiry mode from outside of
bluetoothd, bluetoothd will get errors when it tries to enter periodic
inquiry mode itself.  This error prevents bluetoothd from creating a
discovery session in the btd_adapter data structure, which in turn
prevents bluetoothd from clearing the list of devices for which it has
emitted dbus signals.  This causes discovery sessions initiated over
dbus to fail to detect many devices (specifically, any devices that
were previously detected by bluetoothd before the dbus client called
StartDiscovery, and that are still in range).

This patch creates a discovery session object in the btd_adapter structure
even if the request to initiate periodic inquiry fails.  This in turn
enables the existing discovery session handling machinery to properly
manage the list of devices found in the current discovery session.
---
 src/adapter.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 52b58c4..de68958 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1127,7 +1127,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	struct session_req *req;
 	struct btd_adapter *adapter = data;
 	const char *sender = dbus_message_get_sender(msg);
-	int err;
+	int err = 0;
 
 	if (!adapter->up)
 		return adapter_not_ready(msg);
@@ -1146,15 +1146,15 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	else
 		err = start_periodic_inquiry(adapter);
 
-	if (err < 0)
-		return failed_strerror(msg, -err);
-
 done:
 	req = create_session(adapter, conn, msg, 0,
 				session_owner_exit);
 
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 
+	if (err < 0)
+		return failed_strerror(msg, -err);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.6.2

