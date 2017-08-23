Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, josephsih@chromium.org,
        sonnysasaka@chromium.org, Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH] adapter: Guard StartDiscovery and StopDiscovery with discovering check
Date: Wed, 23 Aug 2017 16:55:50 -0700
Message-Id: <20170823235550.45934-1-mcchou@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Miao-chen Chou <mcchou@chromium.org>

There is a race condition where a start/stop discovery is requested before the
previous stop/start discovery finish, and checking the adapter->discovery_list
is insufficient to guard to race condition. For example, if start_discovery is
called right after stop discovery, the callback, stop_discovery_complete, may
not be called before calling start_discovery. Then start_discovery will
proceed and fail.

Test steps:
Add delay in kernel for the stop discovery callback.
Check if the start discovery can happen before the completion of the previous
stop discovery, and the other way around.

Please refer to https://bugs.chromium.org/p/chromium/issues/detail?id=738237
for more details.
---
 src/adapter.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 83f38ddbe..395b430d2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2119,20 +2119,30 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	struct btd_adapter *adapter = user_data;
 	const char *sender = dbus_message_get_sender(msg);
 	struct watch_client *client;
-	bool is_discovering;
+	bool discovery_client_exists;

 	DBG("sender %s", sender);

 	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
 		return btd_error_not_ready(msg);

-	is_discovering = get_discovery_client(adapter, sender, &client);
+	discovery_client_exists = get_discovery_client(
+			adapter, sender, &client);

 	/*
 	 * Every client can only start one discovery, if the client
 	 * already started a discovery then return an error.
 	 */
-	if (is_discovering)
+	if (discovery_client_exists)
+		return btd_error_busy(msg);
+
+	/*
+	 * adapter->discovery_list being empty but adapter->discovering being
+	 * true indicates that there is a stop discovery operation in progress.
+	 * Prevent a new start discovery request when the previous
+	 * stop discovery is in progress.
+	 */
+	if (!adapter->discovery_list && adapter->discovering)
 		return btd_error_busy(msg);

 	/*
@@ -2420,6 +2430,16 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	if (!list)
 		return btd_error_failed(msg, "No discovery started");

+	/*
+	 * adapter->discovery_list being not empty but adapter->discovering
+	 * being false indicates that there is a start discovery operation in
+	 * progress.
+	 * Prevent a new stop discovery request when the previous start
+	 * discovery is in progress.
+	 */
+	if (!adapter->discovering)
+		return btd_error_busy(msg);
+
 	client = list->data;

 	cp.type = adapter->discovery_type;
--
2.14.1.342.g6490525c54-goog

