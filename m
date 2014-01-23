Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v3 1/5] android/bluetooth: Split devices list to devices and bonded_devices
Date: Thu, 23 Jan 2014 23:18:06 +0100
Message-Id: <1390515490-29538-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390515490-29538-1-git-send-email-szymon.janc@gmail.com>
References: <1390515490-29538-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bonded devices are permament until unbondedn. Non-bonded devices will
be held in (size limited) cache based on timestamp property so split
list to ease separation.
---
 android/bluetooth.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4849dab..5d222e1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -132,6 +132,8 @@ static const uint16_t uuid_list[] = {
 
 static uint16_t option_index = MGMT_INDEX_NONE;
 static struct mgmt *mgmt_if = NULL;
+
+static GSList *bonded_devices = NULL;
 static GSList *devices = NULL;
 
 /* This list contains addresses which are asked for records */
@@ -283,6 +285,10 @@ static struct device *find_device(const bdaddr_t *bdaddr)
 {
 	GSList *l;
 
+	l = g_slist_find_custom(bonded_devices, bdaddr, device_match);
+	if (l)
+		return l->data;
+
 	l = g_slist_find_custom(devices, bdaddr, device_match);
 	if (l)
 		return l->data;
@@ -559,12 +565,30 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
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
@@ -935,6 +959,7 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 	if (adapter.discovering) {
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
 	} else {
+		g_slist_foreach(bonded_devices, clear_device_found, NULL);
 		g_slist_foreach(devices, clear_device_found, NULL);
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
 	}
@@ -2128,18 +2153,15 @@ static uint8_t get_adapter_scan_mode(void)
 
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
@@ -2691,11 +2713,10 @@ static void send_bonded_devices_props(void)
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
 
@@ -3093,6 +3114,9 @@ void bt_bluetooth_unregister(void)
 {
 	DBG("");
 
+	g_slist_free_full(bonded_devices, (GDestroyNotify) free_device);
+	bonded_devices = NULL;
+
 	g_slist_free_full(devices, (GDestroyNotify) free_device);
 	devices = NULL;
 
-- 
1.8.5.3

