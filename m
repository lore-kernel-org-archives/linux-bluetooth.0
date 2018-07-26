Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] adapter: Fix not keeping discovery filters
Date: Thu, 26 Jul 2018 17:17:23 +0300
Message-Id: <20180726141723.20199-5-luiz.dentz@gmail.com>
In-Reply-To: <20180726141723.20199-1-luiz.dentz@gmail.com>
References: <20180726141723.20199-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the discovery has been stopped and the client has set filters those
should be put back into filter list since the client may still be
interested in using them the next time it start a scanning.
---
 src/adapter.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bd9edddc6..822bd3472 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1854,7 +1854,7 @@ static bool set_filtered_discoverable(struct btd_adapter *adapter, bool enable)
 	return set_discoverable(adapter, enable, 0);
 }
 
-static void discovery_remove(struct watch_client *client)
+static void discovery_remove(struct watch_client *client, bool exit)
 {
 	struct btd_adapter *adapter = client->adapter;
 
@@ -1882,7 +1882,11 @@ static void discovery_remove(struct watch_client *client)
 			set_filtered_discoverable(adapter, false);
 	}
 
-	discovery_free(client);
+	if (!exit && client->discovery_filter)
+		adapter->set_filter_list = g_slist_prepend(
+					adapter->set_filter_list, client);
+	else
+		discovery_free(client);
 
 	/*
 	 * If there are other client discoveries in progress, then leave
@@ -1911,8 +1915,11 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 		goto done;
 	}
 
-	if (client->msg)
+	if (client->msg) {
 		g_dbus_send_reply(dbus_conn, client->msg, DBUS_TYPE_INVALID);
+		dbus_message_unref(client->msg);
+		client->msg = NULL;
+	}
 
 	adapter->discovery_type = 0x00;
 	adapter->discovery_enable = 0x00;
@@ -1925,7 +1932,7 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	trigger_passive_scanning(adapter);
 
 done:
-	discovery_remove(client);
+	discovery_remove(client, false);
 }
 
 static int compare_sender(gconstpointer a, gconstpointer b)
@@ -2146,14 +2153,14 @@ static int update_discovery_filter(struct btd_adapter *adapter)
 	return -EINPROGRESS;
 }
 
-static int discovery_stop(struct watch_client *client)
+static int discovery_stop(struct watch_client *client, bool exit)
 {
 	struct btd_adapter *adapter = client->adapter;
 	struct mgmt_cp_stop_discovery cp;
 
 	/* Check if there are more client discovering */
 	if (g_slist_next(adapter->discovery_list)) {
-		discovery_remove(client);
+		discovery_remove(client, exit);
 		update_discovery_filter(adapter);
 		return 0;
 	}
@@ -2163,7 +2170,7 @@ static int discovery_stop(struct watch_client *client)
 	 * and so it is enough to send out the signal and just return.
 	 */
 	if (adapter->discovery_enable == 0x00) {
-		discovery_remove(client);
+		discovery_remove(client, exit);
 		adapter->discovering = false;
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
@@ -2188,7 +2195,7 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 
 	DBG("owner %s", client->owner);
 
-	discovery_stop(client);
+	discovery_stop(client, true);
 }
 
 /*
@@ -2586,7 +2593,7 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	if (client->msg)
 		return btd_error_busy(msg);
 
-	err = discovery_stop(client);
+	err = discovery_stop(client, false);
 	switch (err) {
 	case 0:
 		return dbus_message_new_method_return(msg);
-- 
2.17.1

