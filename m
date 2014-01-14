Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 1/5] android/bluetooth: Split devices list to devices and bonded_devices
Date: Tue, 14 Jan 2014 12:11:41 +0100
Message-Id: <1389697905-18532-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
References: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Bonded devices are permament until unbondedn. Non-bonded devices will
be held in (size limited) cache based on timestamp property so split
list to ease separation.
---
 android/bluetooth.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 735b03e..78e98c1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -133,6 +133,8 @@ static const uint16_t uuid_list[] = {
 };
 
 static struct mgmt *mgmt_if = NULL;
+
+static GSList *bonded_devices = NULL;
 static GSList *devices = NULL;
 
 /* This list contains addresses which are asked for records */
@@ -284,6 +286,10 @@ static struct device *find_device(const bdaddr_t *bdaddr)
 {
 	GSList *l;
 
+	l = g_slist_find_custom(bonded_devices, bdaddr, device_match);
+	if (l)
+		return l->data;
+
 	l = g_slist_find_custom(devices, bdaddr, device_match);
 	if (l)
 		return l->data;
@@ -560,12 +566,30 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 	if (!dev)
 		return;
 
-	if (dev->bond_state != state) {
-		dev->bond_state = state;
-		send_bond_state_change(&dev->bdaddr, status, state);
+	if (dev->bond_state == state)
+		return;
 
-		store_device_info(dev);
+	switch (state) {
+	case HAL_BOND_STATE_NONE:
+		if (dev->bond_state == HAL_BOND_STATE_BONDED) {
+			bonded_devices = g_slist_remove(bonded_devices, dev);
+			devices = g_slist_prepend(devices, dev);
+		}
+		break;
+	case HAL_BOND_STATE_BONDED:
+		devices = g_slist_remove(devices, dev);
+		bonded_devices = g_slist_prepend(bonded_devices, dev);
+		break;
+	case HAL_BOND_STATE_BONDING:
+	default:
+		break;
 	}
+
+	dev->bond_state = state;
+
+	store_device_info(dev);
+
+	send_bond_state_change(&dev->bdaddr, status, state);
 }
 
 static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
@@ -2134,18 +2158,15 @@ static uint8_t get_adapter_scan_mode(void)
 
 static uint8_t get_adapter_bonded_devices(void)
 {
-	uint8_t buf[sizeof(bdaddr_t) * g_slist_length(devices)];
+	uint8_t buf[sizeof(bdaddr_t) * g_slist_length(bonded_devices)];
 	int i = 0;
 	GSList *l;
 
 	DBG("");
 
-	for (l = devices; l; l = g_slist_next(l)) {
+	for (l = bonded_devices; l; l = g_slist_next(l)) {
 		struct device *dev = l->data;
 
-		if (dev->bond_state != HAL_BOND_STATE_BONDED)
-			continue;
-
 		bdaddr2android(&dev->bdaddr, buf + (i * sizeof(bdaddr_t)));
 		i++;
 	}
@@ -2697,11 +2718,10 @@ static void send_bonded_devices_props(void)
 {
 	GSList *l;
 
-	for (l = devices; l; l = g_slist_next(l)) {
+	for (l = bonded_devices; l; l = g_slist_next(l)) {
 		struct device *dev = l->data;
 
-		if (dev->bond_state == HAL_BOND_STATE_BONDED)
-			get_remote_device_props(dev);
+		get_remote_device_props(dev);
 	}
 }
 
@@ -3099,6 +3119,9 @@ void bt_bluetooth_unregister(void)
 {
 	DBG("");
 
+	g_slist_free_full(bonded_devices, (GDestroyNotify) free_device);
+	bonded_devices = NULL;
+
 	g_slist_free_full(devices, (GDestroyNotify) free_device);
 	devices = NULL;
 
-- 
1.8.3.2

