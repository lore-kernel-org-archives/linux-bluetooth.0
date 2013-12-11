Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/9] android/bluetooth: Add support for remote device class
Date: Wed, 11 Dec 2013 11:31:23 +0100
Message-Id: <1386757887-29018-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to cache remote device CoD and get it with get property
command.
---
 android/bluetooth.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d6cefb7..0515468 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -96,6 +96,7 @@ struct device {
 	int bond_state;
 	char *name;
 	char *friendly_name;
+	uint32_t class;
 };
 
 struct browse_req {
@@ -594,6 +595,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_pin_code_request *ev = param;
 	struct hal_ev_pin_request hal_ev;
+	struct device *dev;
 	char dst[18];
 
 	if (length < sizeof(*ev)) {
@@ -603,19 +605,21 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	ba2str(&ev->addr.bdaddr, dst);
 
+	dev = get_device(&ev->addr.bdaddr);
+
 	/* Workaround for Android Bluetooth.apk issue: send remote
 	 * device property */
-	get_device_name(get_device(&ev->addr.bdaddr));
+	get_device_name(dev);
 
 	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
-	/* TODO CoD of remote devices should probably be cached
-	 * Name we already send in remote device prop */
+	/* Name already sent in remote device prop */
 	memset(&hal_ev, 0, sizeof(hal_ev));
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
+	hal_ev.class_of_dev = dev->class;
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
 						sizeof(hal_ev), &hal_ev);
@@ -810,6 +814,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	}
 
 	if (eir.class) {
+		dev->class = eir.class;
+
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
 						sizeof(eir.class), &eir.class);
 		(*num_prop)++;
@@ -2263,11 +2269,10 @@ static uint8_t get_device_uuids(struct device *dev)
 
 static uint8_t get_device_class(struct device *dev)
 {
-	DBG("Not implemented");
+	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_CLASS,
+					sizeof(dev->class), &dev->class);
 
-	/* TODO */
-
-	return HAL_STATUS_FAILED;
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t get_device_type(struct device *dev)
-- 
1.8.3.2

