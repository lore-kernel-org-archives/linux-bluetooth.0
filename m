Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 5/6] android/gatt: Use kernel auto connect feature if possible
Date: Fri,  1 Aug 2014 15:31:24 +0200
Message-Id: <1406899885-5338-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 448bcb8..52bc9c0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1383,6 +1383,8 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	device_set_state(dev, DEVICE_CONNECTED);
 
+	bt_auto_connect_remove(&dev->bdaddr);
+
 	/* Send exchange mtu request as we assume being client and server */
 	/* TODO: Dont exchange mtu if no client apps */
 	send_exchange_mtu_request(dev);
@@ -1529,6 +1531,10 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 						sizeof(*ev) + ev->len, ev);
 
 connect:
+	/* We use auto connect feature from kernel if possible */
+	if (main_opts.kernel_conn_control)
+		return;
+
 	dev = find_device_by_addr(addr);
 	if (!dev) {
 		if (!bonded)
@@ -1749,6 +1755,19 @@ static int connect_bredr(struct gatt_device *dev)
 	return 0;
 }
 
+static bool auto_connect(struct gatt_device *dev)
+{
+	bool err;
+
+	err = bt_auto_connect_add(&dev->bdaddr);
+	if (!err)
+		return false;
+
+	device_set_state(dev, DEVICE_CONNECT_INIT);
+
+	return true;
+}
+
 static bool trigger_connection(struct app_connection *connection)
 {
 	bool ret;
@@ -1763,6 +1782,13 @@ static bool trigger_connection(struct app_connection *connection)
 								BDADDR_BREDR)
 			return connect_bredr(connection->device) == 0;
 
+		/*
+		 * For LE devices use auto connect feature if possible
+		 * Note: Connection state is handled inside auto_connect() func
+		 */
+		if (main_opts.kernel_conn_control)
+			return auto_connect(connection->device);
+
 		/* Trigger discovery if not already started */
 		if (!scanning) {
 			if (!bt_le_discovery_start()) {
@@ -1771,6 +1797,7 @@ static bool trigger_connection(struct app_connection *connection)
 				break;
 			}
 		}
+
 		ret = true;
 		device_set_state(connection->device, DEVICE_CONNECT_INIT);
 		break;
@@ -6091,7 +6118,9 @@ static void connect_confirm(GIOChannel *io, void *user_data)
 
 		dev->bdaddr_type = dst_type;
 	} else {
-		if (dev->state != DEVICE_DISCONNECTED) {
+		if ((dev->state != DEVICE_DISCONNECTED) &&
+					!(dev->state == DEVICE_CONNECT_INIT &&
+					main_opts.kernel_conn_control)) {
 			char addr[18];
 
 			ba2str(&dst, addr);
-- 
1.8.4

