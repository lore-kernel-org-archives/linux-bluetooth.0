Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/12] profiles/network: Minor style fix
Date: Thu, 26 Feb 2015 12:53:23 +0100
Message-Id: <1424951614-8527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes style issues e.g. line aligns, braces.
---
 profiles/network/bnep.c   |  6 ++++--
 profiles/network/server.c | 11 +++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 09d4b65..e3a2b89 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -508,8 +508,9 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
 		err = -errno;
 		error("bnep: Can't add %s to the bridge %s: %s(%d)",
 					devname, bridge, strerror(-err), -err);
-	} else
+	} else {
 		info("bridge %s: interface %s added", bridge, devname);
+	}
 
 	close(sk);
 
@@ -539,8 +540,9 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 		err = -errno;
 		error("bnep: Can't delete %s from the bridge %s: %s(%d)",
 					devname, bridge, strerror(-err), -err);
-	} else
+	} else {
 		info("bridge %s: interface %s removed", bridge, devname);
+	}
 
 	close(sk);
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 3fb031f..ebbe056 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -650,8 +650,7 @@ static struct network_adapter *create_adapter(struct btd_adapter *adapter)
 	na = g_new0(struct network_adapter, 1);
 	na->adapter = btd_adapter_ref(adapter);
 
-	na->io = bt_io_listen(NULL, confirm_event, na,
-				NULL, &err,
+	na->io = bt_io_listen(NULL, confirm_event, na, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(adapter),
 				BT_IO_OPT_PSM, BNEP_PSM,
@@ -697,10 +696,10 @@ int server_register(struct btd_adapter *adapter, uint16_t id)
 	if (g_slist_length(na->servers) > 0)
 		goto done;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					path, NETWORK_SERVER_INTERFACE,
-					server_methods, NULL, NULL,
-					na, path_unregister)) {
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), path,
+						NETWORK_SERVER_INTERFACE,
+						server_methods, NULL, NULL, na,
+						path_unregister)) {
 		error("D-Bus failed to register %s interface",
 						NETWORK_SERVER_INTERFACE);
 		server_free(ns);
-- 
2.1.0

