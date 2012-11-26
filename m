Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/11] network: Fix invalid read on exit
Date: Mon, 26 Nov 2012 15:09:22 +0200
Message-Id: <1353935362-8666-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 1
   at 0x4A09D91: strcmp (mc_replace_strmem.c:729)
   by 0x4C6C768: g_str_equal (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x1446B7: connection_disconnect (connection.c:451)
   by 0x141DEA: disconnect_profile (manager.c:120)
   by 0x4C96C5C: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x182B2D: device_remove (device.c:2034)
   by 0x178809: adapter_remove (adapter.c:2902)
   by 0x173902: manager_cleanup (manager.c:256)
   by 0x1217B9: main (main.c:550)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd

In addition remove owner since it is no longer possible to track the
owner as this is done in the core.
---
 profiles/network/connection.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 912e5b4..a7e45e6 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -70,8 +70,6 @@ struct network_conn {
 	uint16_t	id;		/* Role: Service Class Identifier */
 	conn_state	state;
 	GIOChannel	*io;
-	char		*owner;		/* Connection initiator D-Bus client */
-	guint		watch;		/* Disconnect watch */
 	guint		dc_id;
 	struct network_peer *peer;
 	guint		attempt_cnt;
@@ -124,10 +122,6 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 					NETWORK_PEER_INTERFACE, "UUID");
 	device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
 	nc->dc_id = 0;
-	if (nc->watch) {
-		g_dbus_remove_watch(nc->watch);
-		nc->watch = 0;
-	}
 
 	info("%s disconnected", nc->dev);
 
@@ -146,11 +140,6 @@ static void cancel_connection(struct network_conn *nc, int err)
 		nc->timeout_source = 0;
 	}
 
-	if (nc->watch) {
-		g_dbus_remove_watch(nc->watch);
-		nc->watch = 0;
-	}
-
 	if (nc->cb)
 		nc->cb(nc->peer->device, err, NULL, nc->cb_data);
 
@@ -170,11 +159,6 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
 		bnep_kill_connection(device_get_address(nc->peer->device));
 	} else if (nc->io)
 		cancel_connection(nc, -EIO);
-
-	if (nc->owner) {
-		g_free(nc->owner);
-		nc->owner = NULL;
-	}
 }
 
 static void disconnect_cb(struct btd_device *device, gboolean removal,
@@ -416,16 +400,9 @@ int connection_connect(struct btd_device *device, uint16_t id,
 		return -EIO;
 
 	nc->state = CONNECTING;
-	nc->owner = g_strdup(owner);
 	nc->cb = cb;
 	nc->cb_data = data;
 
-	if (owner)
-		nc->watch = g_dbus_add_disconnect_watch(
-						btd_get_dbus_connection(),
-						owner, connection_destroy,
-						nc, NULL);
-
 	return 0;
 }
 
@@ -446,9 +423,6 @@ int connection_disconnect(struct btd_device *device, uint16_t id,
 	if (nc->state == DISCONNECTED)
 		return 0;
 
-	if (!g_str_equal(nc->owner, caller))
-		return -EPERM;
-
 	connection_destroy(NULL, nc);
 
 	return 0;
-- 
1.7.11.7

