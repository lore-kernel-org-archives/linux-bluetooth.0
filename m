Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA52BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6416506E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhCPO0z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:26:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbhCPO0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:26:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id E63E41F44BD8
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH Bluez v3 2/4] src: Replace calls to g_timeout_add_seconds by timeout_add_seconds
Date:   Tue, 16 Mar 2021 15:26:25 +0100
Message-Id: <20210316142627.23692-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316142627.23692-1-frederic.danis@collabora.com>
References: <20210316142627.23692-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c     | 90 ++++++++++++++++++++++++++---------------------
 src/adv_monitor.c | 14 ++++----
 src/advertising.c | 28 ++++++++-------
 src/device.c      | 60 ++++++++++++++++---------------
 src/main.c        |  7 ++--
 src/sdp-client.c  | 13 +++----
 6 files changed, 115 insertions(+), 97 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cc0849f99..2fa06b73c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -46,6 +46,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
+#include "src/shared/timeout.h"
 
 #include "btio/btio.h"
 #include "btd.h"
@@ -237,10 +238,12 @@ struct btd_adapter {
 	struct discovery_client *client;	/* active discovery client */
 
 	GSList *discovery_found;	/* list of found devices */
-	guint discovery_idle_timeout;	/* timeout between discovery runs */
-	guint passive_scan_timeout;	/* timeout between passive scans */
+	unsigned int discovery_idle_timeout; /* timeout between discovery
+					      * runs
+					      */
+	unsigned int passive_scan_timeout; /* timeout between passive scans */
 
-	guint pairable_timeout_id;	/* pairable timeout id */
+	unsigned int pairable_timeout_id;	/* pairable timeout id */
 	guint auth_idle_id;		/* Pending authorization dequeue */
 	GQueue *auths;			/* Ongoing and pending auths */
 	bool pincode_requested;		/* PIN requested during last bonding */
@@ -268,13 +271,13 @@ struct btd_adapter {
 	struct oob_handler *oob_handler;
 
 	unsigned int load_ltks_id;
-	guint load_ltks_timeout;
+	unsigned int load_ltks_timeout;
 
 	unsigned int confirm_name_id;
-	guint confirm_name_timeout;
+	unsigned int confirm_name_timeout;
 
 	unsigned int pair_device_id;
-	guint pair_device_timeout;
+	unsigned int pair_device_timeout;
 
 	unsigned int db_id;		/* Service event handler for GATT db */
 
@@ -695,7 +698,7 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
 	return false;
 }
 
-static gboolean pairable_timeout_handler(gpointer user_data)
+static bool pairable_timeout_handler(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 
@@ -709,7 +712,7 @@ static gboolean pairable_timeout_handler(gpointer user_data)
 static void trigger_pairable_timeout(struct btd_adapter *adapter)
 {
 	if (adapter->pairable_timeout_id > 0) {
-		g_source_remove(adapter->pairable_timeout_id);
+		timeout_remove(adapter->pairable_timeout_id);
 		adapter->pairable_timeout_id = 0;
 	}
 
@@ -718,8 +721,9 @@ static void trigger_pairable_timeout(struct btd_adapter *adapter)
 
 	if (adapter->pairable_timeout > 0)
 		adapter->pairable_timeout_id =
-			g_timeout_add_seconds(adapter->pairable_timeout,
-					pairable_timeout_handler, adapter);
+			timeout_add_seconds(adapter->pairable_timeout,
+					pairable_timeout_handler, adapter,
+					NULL);
 }
 
 static void local_name_changed_callback(uint16_t index, uint16_t length,
@@ -1323,7 +1327,7 @@ static void passive_scanning_complete(uint8_t status, uint16_t length,
 	}
 }
 
-static gboolean passive_scanning_timeout(gpointer user_data)
+static bool passive_scanning_timeout(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 	struct mgmt_cp_start_discovery cp;
@@ -1347,7 +1351,7 @@ static void trigger_passive_scanning(struct btd_adapter *adapter)
 	DBG("");
 
 	if (adapter->passive_scan_timeout > 0) {
-		g_source_remove(adapter->passive_scan_timeout);
+		timeout_remove(adapter->passive_scan_timeout);
 		adapter->passive_scan_timeout = 0;
 	}
 
@@ -1386,8 +1390,9 @@ static void trigger_passive_scanning(struct btd_adapter *adapter)
 	if (!adapter->connect_list)
 		return;
 
-	adapter->passive_scan_timeout = g_timeout_add_seconds(CONN_SCAN_TIMEOUT,
-					passive_scanning_timeout, adapter);
+	adapter->passive_scan_timeout = timeout_add_seconds(CONN_SCAN_TIMEOUT,
+					passive_scanning_timeout, adapter,
+					NULL);
 }
 
 static void stop_passive_scanning_complete(uint8_t status, uint16_t length,
@@ -1467,7 +1472,7 @@ static void cancel_passive_scanning(struct btd_adapter *adapter)
 	DBG("");
 
 	if (adapter->passive_scan_timeout > 0) {
-		g_source_remove(adapter->passive_scan_timeout);
+		timeout_remove(adapter->passive_scan_timeout);
 		adapter->passive_scan_timeout = 0;
 	}
 }
@@ -1512,7 +1517,7 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
 	adapter->discovery_type = 0x00;
 
 	if (adapter->discovery_idle_timeout > 0) {
-		g_source_remove(adapter->discovery_idle_timeout);
+		timeout_remove(adapter->discovery_idle_timeout);
 		adapter->discovery_idle_timeout = 0;
 	}
 
@@ -1688,7 +1693,7 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 	trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
 }
 
-static gboolean start_discovery_timeout(gpointer user_data)
+static bool start_discovery_timeout(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 	struct mgmt_cp_start_service_discovery *sd_cp;
@@ -1784,7 +1789,7 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
 	cancel_passive_scanning(adapter);
 
 	if (adapter->discovery_idle_timeout > 0) {
-		g_source_remove(adapter->discovery_idle_timeout);
+		timeout_remove(adapter->discovery_idle_timeout);
 		adapter->discovery_idle_timeout = 0;
 	}
 
@@ -1797,8 +1802,8 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
 	if (!btd_adapter_get_powered(adapter))
 		return;
 
-	adapter->discovery_idle_timeout = g_timeout_add_seconds(delay,
-					start_discovery_timeout, adapter);
+	adapter->discovery_idle_timeout = timeout_add_seconds(delay,
+					start_discovery_timeout, adapter, NULL);
 }
 
 static void suspend_discovery_complete(uint8_t status, uint16_t length,
@@ -1837,7 +1842,7 @@ static void suspend_discovery(struct btd_adapter *adapter)
 	 * The restart will be triggered when the discovery is resumed.
 	 */
 	if (adapter->discovery_idle_timeout > 0) {
-		g_source_remove(adapter->discovery_idle_timeout);
+		timeout_remove(adapter->discovery_idle_timeout);
 		adapter->discovery_idle_timeout = 0;
 	}
 
@@ -1918,7 +1923,7 @@ static void discovering_callback(uint16_t index, uint16_t length,
 
 	case 0x01:
 		if (adapter->discovery_idle_timeout > 0) {
-			g_source_remove(adapter->discovery_idle_timeout);
+			timeout_remove(adapter->discovery_idle_timeout);
 			adapter->discovery_idle_timeout = 0;
 		}
 
@@ -2404,7 +2409,7 @@ static bool parse_pathloss(DBusMessageIter *value,
 	return true;
 }
 
-static bool parse_transport(DBusMessageIter *value, 
+static bool parse_transport(DBusMessageIter *value,
 					struct discovery_filter *filter)
 {
 	char *transport_str;
@@ -3931,7 +3936,7 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 							adapter->dev_id);
 }
 
-static gboolean load_ltks_timeout(gpointer user_data)
+static bool load_ltks_timeout(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 
@@ -3959,7 +3964,7 @@ static void load_ltks_complete(uint8_t status, uint16_t length,
 
 	adapter->load_ltks_id = 0;
 
-	g_source_remove(adapter->load_ltks_timeout);
+	timeout_remove(adapter->load_ltks_timeout);
 	adapter->load_ltks_timeout = 0;
 
 	DBG("LTKs loaded for hci%u", adapter->dev_id);
@@ -4036,8 +4041,9 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 	 * and forgets to send a command complete response. However in
 	 * case of failures it does send a command status.
 	 */
-	adapter->load_ltks_timeout = g_timeout_add_seconds(2,
-						load_ltks_timeout, adapter);
+	adapter->load_ltks_timeout = timeout_add_seconds(2,
+						load_ltks_timeout, adapter,
+						NULL);
 }
 
 static void load_irks_complete(uint8_t status, uint16_t length,
@@ -5337,23 +5343,23 @@ static void adapter_free(gpointer user_data)
 	remove_discovery_list(adapter);
 
 	if (adapter->pairable_timeout_id > 0) {
-		g_source_remove(adapter->pairable_timeout_id);
+		timeout_remove(adapter->pairable_timeout_id);
 		adapter->pairable_timeout_id = 0;
 	}
 
 	if (adapter->passive_scan_timeout > 0) {
-		g_source_remove(adapter->passive_scan_timeout);
+		timeout_remove(adapter->passive_scan_timeout);
 		adapter->passive_scan_timeout = 0;
 	}
 
 	if (adapter->load_ltks_timeout > 0)
-		g_source_remove(adapter->load_ltks_timeout);
+		timeout_remove(adapter->load_ltks_timeout);
 
 	if (adapter->confirm_name_timeout > 0)
-		g_source_remove(adapter->confirm_name_timeout);
+		timeout_remove(adapter->confirm_name_timeout);
 
 	if (adapter->pair_device_timeout > 0)
-		g_source_remove(adapter->pair_device_timeout);
+		timeout_remove(adapter->pair_device_timeout);
 
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
@@ -6386,7 +6392,7 @@ const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
 	return &adapter->bdaddr;
 }
 
-static gboolean confirm_name_timeout(gpointer user_data)
+static bool confirm_name_timeout(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 
@@ -6414,7 +6420,7 @@ static void confirm_name_complete(uint8_t status, uint16_t length,
 
 	adapter->confirm_name_id = 0;
 
-	g_source_remove(adapter->confirm_name_timeout);
+	timeout_remove(adapter->confirm_name_timeout);
 	adapter->confirm_name_timeout = 0;
 
 	DBG("Confirm name complete for hci%u", adapter->dev_id);
@@ -6445,7 +6451,7 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	}
 
 	if (adapter->confirm_name_timeout > 0) {
-		g_source_remove(adapter->confirm_name_timeout);
+		timeout_remove(adapter->confirm_name_timeout);
 		adapter->confirm_name_timeout = 0;
 	}
 
@@ -6470,8 +6476,9 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	 * and forgets to send a command complete response. However in
 	 * case of failures it does send a command status.
 	 */
-	adapter->confirm_name_timeout = g_timeout_add_seconds(2,
-						confirm_name_timeout, adapter);
+	adapter->confirm_name_timeout = timeout_add_seconds(2,
+						confirm_name_timeout, adapter,
+						NULL);
 }
 
 static void adapter_msd_notify(struct btd_adapter *adapter,
@@ -7722,7 +7729,7 @@ static void free_pair_device_data(void *user_data)
 	g_free(data);
 }
 
-static gboolean pair_device_timeout(gpointer user_data)
+static bool pair_device_timeout(gpointer user_data)
 {
 	struct pair_device_data *data = user_data;
 	struct btd_adapter *adapter = data->adapter;
@@ -7749,7 +7756,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 	adapter->pair_device_id = 0;
 
 	if (adapter->pair_device_timeout > 0) {
-		g_source_remove(adapter->pair_device_timeout);
+		timeout_remove(adapter->pair_device_timeout);
 		adapter->pair_device_timeout = 0;
 	}
 
@@ -7835,8 +7842,9 @@ int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	 * request never times out. Therefore, add a timer to clean up
 	 * if no response arrives
 	 */
-	adapter->pair_device_timeout = g_timeout_add_seconds(BONDING_TIMEOUT,
-						pair_device_timeout, data);
+	adapter->pair_device_timeout = timeout_add_seconds(BONDING_TIMEOUT,
+						pair_device_timeout, data,
+						NULL);
 
 	return 0;
 }
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 54751db0b..33e7c8454 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -31,6 +31,7 @@
 #include "src/error.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 
 #include "adv_monitor.h"
@@ -125,7 +126,7 @@ struct adv_monitor_device {
 					 */
 	time_t last_seen;		/* Time when last Adv was received */
 	bool found;			/* State of the device - lost/found */
-	guint lost_timer;		/* Timer to track if the device goes
+	unsigned int lost_timer;	/* Timer to track if the device goes
 					 * offline/out-of-range
 					 */
 };
@@ -1385,7 +1386,7 @@ static void monitor_device_free(void *data)
 	}
 
 	if (dev->lost_timer) {
-		g_source_remove(dev->lost_timer);
+		timeout_remove(dev->lost_timer);
 		dev->lost_timer = 0;
 	}
 
@@ -1468,7 +1469,7 @@ static void report_device_state_setup(DBusMessageIter *iter, void *user_data)
 }
 
 /* Handles a situation where the device goes offline/out-of-range */
-static gboolean handle_device_lost_timeout(gpointer user_data)
+static bool handle_device_lost_timeout(gpointer user_data)
 {
 	struct adv_monitor_device *dev = user_data;
 	struct adv_monitor *monitor = dev->monitor;
@@ -1534,7 +1535,7 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	}
 
 	if (dev->lost_timer) {
-		g_source_remove(dev->lost_timer);
+		timeout_remove(dev->lost_timer);
 		dev->lost_timer = 0;
 	}
 
@@ -1609,7 +1610,8 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
 	 */
 	if (dev->found) {
 		dev->lost_timer =
-			g_timeout_add_seconds(monitor->low_rssi_timeout,
-					      handle_device_lost_timeout, dev);
+			timeout_add_seconds(monitor->low_rssi_timeout,
+					    handle_device_lost_timeout, dev,
+							NULL);
 	}
 }
diff --git a/src/advertising.c b/src/advertising.c
index 15a343e52..d76e97a74 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -32,6 +32,7 @@
 #include "src/shared/ad.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
 #include "src/shared/util.h"
 #include "advertising.h"
 
@@ -111,10 +112,10 @@ static void client_free(void *data)
 	struct btd_adv_client *client = data;
 
 	if (client->to_id > 0)
-		g_source_remove(client->to_id);
+		timeout_remove(client->to_id);
 
 	if (client->disc_to_id > 0)
-		g_source_remove(client->disc_to_id);
+		timeout_remove(client->disc_to_id);
 
 	if (client->client) {
 		g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
@@ -574,7 +575,7 @@ static bool parse_duration(DBusMessageIter *iter,
 	return true;
 }
 
-static gboolean client_timeout(void *user_data)
+static bool client_timeout(void *user_data)
 {
 	struct btd_adv_client *client = user_data;
 
@@ -593,7 +594,7 @@ static bool parse_timeout(DBusMessageIter *iter,
 {
 	if (!iter) {
 		client->timeout = 0;
-		g_source_remove(client->to_id);
+		timeout_remove(client->to_id);
 		client->to_id = 0;
 		return true;
 	}
@@ -604,11 +605,12 @@ static bool parse_timeout(DBusMessageIter *iter,
 	dbus_message_iter_get_basic(iter, &client->timeout);
 
 	if (client->to_id)
-		g_source_remove(client->to_id);
+		timeout_remove(client->to_id);
 
 	if (client->timeout > 0)
-		client->to_id = g_timeout_add_seconds(client->timeout,
-							client_timeout, client);
+		client->to_id = timeout_add_seconds(client->timeout,
+							client_timeout, client,
+							NULL);
 
 	return true;
 }
@@ -945,7 +947,7 @@ static int refresh_advertisement(struct btd_adv_client *client,
 	return refresh_legacy_adv(client, func, mgmt_id);
 }
 
-static gboolean client_discoverable_timeout(void *user_data)
+static bool client_discoverable_timeout(void *user_data)
 {
 	struct btd_adv_client *client = user_data;
 
@@ -965,7 +967,7 @@ static bool parse_discoverable_timeout(DBusMessageIter *iter,
 {
 	if (!iter) {
 		client->discoverable_to = 0;
-		g_source_remove(client->disc_to_id);
+		timeout_remove(client->disc_to_id);
 		client->disc_to_id = 0;
 		return true;
 	}
@@ -976,11 +978,11 @@ static bool parse_discoverable_timeout(DBusMessageIter *iter,
 	dbus_message_iter_get_basic(iter, &client->discoverable_to);
 
 	if (client->disc_to_id)
-		g_source_remove(client->disc_to_id);
+		timeout_remove(client->disc_to_id);
 
-	client->disc_to_id = g_timeout_add_seconds(client->discoverable_to,
+	client->disc_to_id = timeout_add_seconds(client->discoverable_to,
 						client_discoverable_timeout,
-						client);
+						client, NULL);
 
 	return true;
 }
@@ -1361,7 +1363,7 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		}
 	} else if (client->disc_to_id) {
 		/* Ignore DiscoverableTimeout if not discoverable */
-		g_source_remove(client->disc_to_id);
+		timeout_remove(client->disc_to_id);
 		client->disc_to_id = 0;
 		client->discoverable_to = 0;
 	}
diff --git a/src/device.c b/src/device.c
index b99f6fbb0..7a6f7643a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -41,6 +41,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/ad.h"
+#include "src/shared/timeout.h"
 #include "btio/btio.h"
 #include "lib/mgmt.h"
 #include "attrib/att.h"
@@ -219,9 +220,9 @@ struct btd_device {
 	GSList		*watches;		/* List of disconnect_data */
 	bool		temporary;
 	bool		connectable;
-	guint		disconn_timer;
-	guint		discov_timer;
-	guint		temporary_timer;	/* Temporary/disappear timer */
+	unsigned int	disconn_timer;
+	unsigned int	discov_timer;
+	unsigned int	temporary_timer;	/* Temporary/disappear timer */
 	struct browse_req *browse;		/* service discover request */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
@@ -691,13 +692,13 @@ static void device_free(gpointer user_data)
 					(sdp_free_func_t) sdp_record_free);
 
 	if (device->disconn_timer)
-		g_source_remove(device->disconn_timer);
+		timeout_remove(device->disconn_timer);
 
 	if (device->discov_timer)
-		g_source_remove(device->discov_timer);
+		timeout_remove(device->discov_timer);
 
 	if (device->temporary_timer)
-		g_source_remove(device->temporary_timer);
+		timeout_remove(device->temporary_timer);
 
 	if (device->connect)
 		dbus_message_unref(device->connect);
@@ -1469,7 +1470,7 @@ static gboolean dev_property_wake_allowed_exist(
 	return device_get_wake_support(device);
 }
 
-static gboolean disconnect_all(gpointer user_data)
+static bool disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -1494,7 +1495,7 @@ int device_block(struct btd_device *device, gboolean update_only)
 		return 0;
 
 	if (device->disconn_timer > 0)
-		g_source_remove(device->disconn_timer);
+		timeout_remove(device->disconn_timer);
 
 	disconnect_all(device);
 
@@ -1644,9 +1645,9 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		return;
 	}
 
-	device->disconn_timer = g_timeout_add_seconds(DISCONNECT_TIMER,
+	device->disconn_timer = timeout_add_seconds(DISCONNECT_TIMER,
 							disconnect_all,
-							device);
+							device, NULL);
 }
 
 bool device_is_disconnecting(struct btd_device *device)
@@ -2991,7 +2992,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 
 	/* Remove temporary timer while connected */
 	if (dev->temporary_timer) {
-		g_source_remove(dev->temporary_timer);
+		timeout_remove(dev->temporary_timer);
 		dev->temporary_timer = 0;
 	}
 
@@ -3014,7 +3015,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	device_set_svc_refreshed(device, false);
 
 	if (device->disconn_timer > 0) {
-		g_source_remove(device->disconn_timer);
+		timeout_remove(device->disconn_timer);
 		device->disconn_timer = 0;
 	}
 
@@ -4268,7 +4269,7 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	store_device_info(device);
 }
 
-static gboolean device_disappeared(gpointer user_data)
+static bool device_disappeared(gpointer user_data)
 {
 	struct btd_device *dev = user_data;
 
@@ -4291,11 +4292,11 @@ void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type)
 
 	/* Restart temporary timer */
 	if (device->temporary_timer)
-		g_source_remove(device->temporary_timer);
+		timeout_remove(device->temporary_timer);
 
-	device->temporary_timer = g_timeout_add_seconds(btd_opts.tmpto,
+	device->temporary_timer = timeout_add_seconds(btd_opts.tmpto,
 							device_disappeared,
-							device);
+							device, NULL);
 }
 
 /* It is possible that we have two device objects for the same device in
@@ -4482,12 +4483,12 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 
 	if (btd_device_is_connected(device)) {
 		if (device->disconn_timer > 0)
-			g_source_remove(device->disconn_timer);
+			timeout_remove(device->disconn_timer);
 		disconnect_all(device);
 	}
 
 	if (device->temporary_timer > 0) {
-		g_source_remove(device->temporary_timer);
+		timeout_remove(device->temporary_timer);
 		device->temporary_timer = 0;
 	}
 
@@ -5636,7 +5637,7 @@ int device_discover_services(struct btd_device *device)
 		err = device_browse_gatt(device, NULL);
 
 	if (err == 0 && device->discov_timer) {
-		g_source_remove(device->discov_timer);
+		timeout_remove(device->discov_timer);
 		device->discov_timer = 0;
 	}
 
@@ -5689,7 +5690,7 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 	device->temporary = temporary;
 
 	if (device->temporary_timer) {
-		g_source_remove(device->temporary_timer);
+		timeout_remove(device->temporary_timer);
 		device->temporary_timer = 0;
 	}
 
@@ -5701,9 +5702,9 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 			device->disable_auto_connect = TRUE;
 			device_set_auto_connect(device, FALSE);
 		}
-		device->temporary_timer = g_timeout_add_seconds(btd_opts.tmpto,
+		device->temporary_timer = timeout_add_seconds(btd_opts.tmpto,
 							device_disappeared,
-							device);
+							device, NULL);
 		return;
 	}
 
@@ -5934,7 +5935,7 @@ bool device_is_connectable(struct btd_device *device)
 	return (device->ad_flags[0] & 0x03);
 }
 
-static gboolean start_discovery(gpointer user_data)
+static bool start_discovery(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
@@ -6083,7 +6084,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		/* If we are initiators remove any discovery timer and just
 		 * start discovering services directly */
 		if (device->discov_timer) {
-			g_source_remove(device->discov_timer);
+			timeout_remove(device->discov_timer);
 			device->discov_timer = 0;
 		}
 
@@ -6100,10 +6101,10 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 			 * active discovery or discovery timer, set discovery
 			 * timer */
 			DBG("setting timer for reverse service discovery");
-			device->discov_timer = g_timeout_add_seconds(
+			device->discov_timer = timeout_add_seconds(
 							DISCOVERY_TIMER,
 							start_discovery,
-							device);
+							device, NULL);
 		}
 	}
 }
@@ -6142,8 +6143,11 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 	if (state->svc_resolved || !btd_opts.reverse_discovery)
 		cb->idle_id = g_idle_add(svc_idle_cb, cb);
 	else if (dev->discov_timer > 0) {
-		g_source_remove(dev->discov_timer);
-		dev->discov_timer = g_idle_add(start_discovery, dev);
+		timeout_remove(dev->discov_timer);
+		dev->discov_timer = timeout_add_seconds(
+						0,
+						start_discovery,
+						dev, NULL);
 	}
 
 	return cb->id;
diff --git a/src/main.c b/src/main.c
index 572dc939c..c32bda7d4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -41,6 +41,7 @@
 
 #include "shared/att-types.h"
 #include "shared/mainloop.h"
+#include "shared/timeout.h"
 #include "lib/uuid.h"
 #include "shared/util.h"
 #include "btd.h"
@@ -853,7 +854,7 @@ void btd_exit(void)
 	mainloop_quit();
 }
 
-static gboolean quit_eventloop(gpointer user_data)
+static bool quit_eventloop(gpointer user_data)
 {
 	btd_exit();
 	return FALSE;
@@ -868,8 +869,8 @@ static void signal_callback(int signum, void *user_data)
 	case SIGTERM:
 		if (!terminated) {
 			info("Terminating");
-			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
-							quit_eventloop, NULL);
+			timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
+						quit_eventloop, NULL, NULL);
 
 			mainloop_sd_notify("STATUS=Powering down");
 			adapter_shutdown();
diff --git a/src/sdp-client.c b/src/sdp-client.c
index 55f5bc323..71d3d9e95 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -21,6 +21,7 @@
 #include "lib/sdp_lib.h"
 
 #include "btio/btio.h"
+#include "shared/timeout.h"
 #include "log.h"
 #include "sdp-client.h"
 
@@ -31,7 +32,7 @@ struct cached_sdp_session {
 	bdaddr_t src;
 	bdaddr_t dst;
 	sdp_session_t *session;
-	guint timer;
+	unsigned int timer;
 	guint io_id;
 };
 
@@ -44,7 +45,7 @@ static void cleanup_cached_session(struct cached_sdp_session *cached)
 	g_free(cached);
 }
 
-static gboolean cached_session_expired(gpointer user_data)
+static bool cached_session_expired(gpointer user_data)
 {
 	struct cached_sdp_session *cached = user_data;
 
@@ -66,7 +67,7 @@ static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src,
 		if (bacmp(&c->src, src) || bacmp(&c->dst, dst))
 			continue;
 
-		g_source_remove(c->timer);
+		timeout_remove(c->timer);
 		g_source_remove(c->io_id);
 
 		session = c->session;
@@ -85,7 +86,7 @@ static gboolean disconnect_watch(GIOChannel *chan, GIOCondition cond,
 {
 	struct cached_sdp_session *cached = user_data;
 
-	g_source_remove(cached->timer);
+	timeout_remove(cached->timer);
 	cleanup_cached_session(cached);
 
 	return FALSE;
@@ -107,9 +108,9 @@ static void cache_sdp_session(bdaddr_t *src, bdaddr_t *dst,
 
 	cached_sdp_sessions = g_slist_append(cached_sdp_sessions, cached);
 
-	cached->timer = g_timeout_add_seconds(CACHE_TIMEOUT,
+	cached->timer = timeout_add_seconds(CACHE_TIMEOUT,
 						cached_session_expired,
-						cached);
+						cached, NULL);
 
 	/* Watch the connection state during cache timeout */
 	sk = sdp_get_socket(session);
-- 
2.18.0

