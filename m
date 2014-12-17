Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 06/19] android/gatt: Improve LE connection after pair
Date: Wed, 17 Dec 2014 16:49:04 +0100
Message-Id: <1418831357-23100-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, GATT keeps ATT connection for 30 sec during bonding,
and once bonding is completed GATT starts service search.

It is needed for example when user choose HOG device from Settings
Application. So far scenario looks like that:

1. Bonding started
2. GATT Service search
3. Bonding ended and LE connection dropped
4. Initiated connection to HOG device

Now it looks like that:

1. Bonding Started
2. Bonding Ended
3. GATT Search Service
4. Connect to HOG device on existing LE connection
---
 android/gatt.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index c47e948..a19c907 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -70,6 +70,7 @@
 #define GATT_PERM_WRITE_SIGNED_MITM	0x00020000
 #define GATT_PERM_NONE			0x10000000
 
+#define GATT_PAIR_CONN_TIMEOUT 30
 #define GATT_CONN_TIMEOUT 2
 
 static const uint8_t BLUETOOTH_UUID[] = {
@@ -1404,6 +1405,17 @@ static void send_app_connect_notifications(void *data, void *user_data)
 		send_app_connect_notify(conn, con_data->status);
 }
 
+static struct app_connection *find_conn_without_app(struct gatt_device *dev)
+{
+	struct app_connection conn_match;
+
+	conn_match.device = dev;
+	conn_match.app = NULL;
+
+	return queue_find(app_connections, match_connection_by_device_and_app,
+								&conn_match);
+}
+
 static struct app_connection *find_conn(const bdaddr_t *addr, int32_t app_id)
 {
 	struct app_connection conn_match;
@@ -1561,7 +1573,22 @@ reply:
 		if (!conn)
 			return;
 
-		search_dev_for_srvc(conn, NULL);
+		if (bt_is_pairing(&dev->bdaddr))
+			/*
+			 * If there is bonding ongoing lets wait for paired
+			 * callback. Once we get that we can start search
+			 * services
+			 */
+			conn->timeout_id = g_timeout_add_seconds(
+						GATT_PAIR_CONN_TIMEOUT,
+						connection_timeout, conn);
+		else
+			/*
+			 * There is no ongoing bonding, lets search for primary
+			 * services
+			 *
+			 */
+			search_dev_for_srvc(conn, NULL);
 	}
 
 	data.dev = dev;
@@ -7041,6 +7068,7 @@ static void gatt_paired_cb(const bdaddr_t *addr, uint8_t type)
 {
 	struct gatt_device *dev;
 	char address[18];
+	struct app_connection *conn;
 
 	dev = find_device_by_addr(addr);
 	if (!dev)
@@ -7052,7 +7080,17 @@ static void gatt_paired_cb(const bdaddr_t *addr, uint8_t type)
 	ba2str(addr, address);
 	DBG("Paired device %s", address);
 
-	/* Find Service Changed and register for it.*/
+	/* conn without app is internal one used for search primary services */
+	conn = find_conn_without_app(dev);
+	if (!conn)
+		return;
+
+	if (conn->timeout_id > 0) {
+		g_source_remove(conn->timeout_id);
+		conn->timeout_id = 0;
+	}
+
+	search_dev_for_srvc(conn, NULL);
 }
 
 static void gatt_unpaired_cb(const bdaddr_t *addr, uint8_t type)
-- 
1.8.4

