Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 8/8] android/bluetooth: Add send_adapter_property helper function
Date: Tue, 10 Dec 2013 16:06:22 +0100
Message-Id: <1386687982-1799-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
References: <1386687982-1799-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter property notification are send from multiple places so it make
sense to have helper for that. This is especially usefull for 'simple'
properties.
---
 android/bluetooth.c | 88 +++++++++++++++--------------------------------------
 1 file changed, 25 insertions(+), 63 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b1d2c71..e456f3c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -164,24 +164,26 @@ static struct device *get_device(const bdaddr_t *bdaddr)
 	return create_device(bdaddr);
 }
 
-static void adapter_name_changed(const uint8_t *name)
+static  void send_adapter_property(uint8_t type, uint16_t len, const void *val)
 {
-	struct hal_ev_adapter_props_changed *ev;
-	size_t len = strlen((const char *) name);
 	uint8_t buf[BASELEN_PROP_CHANGED + len];
+	struct hal_ev_adapter_props_changed *ev = (void *) buf;
 
-	memset(buf, 0, sizeof(buf));
-	ev = (void *) buf;
-
-	ev->num_props = 1;
 	ev->status = HAL_STATUS_SUCCESS;
-	ev->props[0].type = HAL_PROP_ADAPTER_NAME;
-	/* Android expects value without NULL terminator */
+	ev->num_props = 1;
+	ev->props[0].type = type;
 	ev->props[0].len = len;
-	memcpy(ev->props->val, name, len);
+	memcpy(ev->props[0].val, val, len);
 
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-							sizeof(buf), ev);
+							sizeof(buf), buf);
+}
+
+static void adapter_name_changed(const uint8_t *name)
+{
+	/* Android expects string value without NULL terminator */
+	send_adapter_property(HAL_PROP_ADAPTER_NAME,
+					strlen((const char *) name), name);
 }
 
 static void adapter_set_name(const uint8_t *name)
@@ -243,39 +245,19 @@ static uint8_t settings2scan_mode(void)
 
 static void scan_mode_changed(void)
 {
-	uint8_t buf[BASELEN_PROP_CHANGED + 1];
-	struct hal_ev_adapter_props_changed *ev = (void *) buf;
-	uint8_t *mode;
-
-	ev->num_props = 1;
-	ev->status = HAL_STATUS_SUCCESS;
-
-	ev->props[0].type = HAL_PROP_ADAPTER_SCAN_MODE;
-	ev->props[0].len = 1;
+	uint8_t mode;
 
-	mode = ev->props[0].val;
-	*mode = settings2scan_mode();
+	mode = settings2scan_mode();
 
-	DBG("mode %u", *mode);
+	DBG("mode %u", mode);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-							sizeof(buf), buf);
+	send_adapter_property(HAL_PROP_ADAPTER_SCAN_MODE, sizeof(mode), &mode);
 }
 
 static void adapter_class_changed(void)
 {
-	uint8_t buf[BASELEN_PROP_CHANGED + sizeof(uint32_t)];
-	struct hal_ev_adapter_props_changed *ev = (void *) buf;
-
-	ev->num_props = 1;
-	ev->status = HAL_STATUS_SUCCESS;
-
-	ev->props[0].type = HAL_PROP_ADAPTER_CLASS;
-	ev->props[0].len = sizeof(uint32_t);
-	memcpy(ev->props->val, &adapter.dev_class, sizeof(uint32_t));
-
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-							sizeof(buf), buf);
+	send_adapter_property(HAL_PROP_ADAPTER_CLASS, sizeof(adapter.dev_class),
+							&adapter.dev_class);
 }
 
 static void settings_changed(uint32_t settings)
@@ -1663,18 +1645,11 @@ static bool set_discoverable(uint8_t mode, uint16_t timeout)
 
 static uint8_t get_adapter_address(void)
 {
-	uint8_t buf[BASELEN_PROP_CHANGED + sizeof(bdaddr_t)];
-	struct hal_ev_adapter_props_changed *ev = (void *) buf;
-
-	ev->num_props = 1;
-	ev->status = HAL_STATUS_SUCCESS;
+	uint8_t buf[6];
 
-	ev->props[0].type = HAL_PROP_ADAPTER_ADDR;
-	ev->props[0].len = sizeof(bdaddr_t);
-	bdaddr2android(&adapter.bdaddr, ev->props[0].val);
+	bdaddr2android(&adapter.bdaddr, buf);
 
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-							sizeof(buf), buf);
+	send_adapter_property(HAL_PROP_ADAPTER_ADDR, sizeof(buf), buf);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -1737,22 +1712,9 @@ static uint8_t get_adapter_bonded_devices(void)
 
 static uint8_t get_adapter_discoverable_timeout(void)
 {
-	struct hal_ev_adapter_props_changed *ev;
-	uint8_t buf[BASELEN_PROP_CHANGED + sizeof(uint32_t)];
-
-	memset(buf, 0, sizeof(buf));
-	ev = (void *) buf;
-
-	ev->num_props = 1;
-	ev->status = HAL_STATUS_SUCCESS;
-
-	ev->props[0].type = HAL_PROP_ADAPTER_DISC_TIMEOUT;
-	ev->props[0].len = sizeof(uint32_t);
-	memcpy(&ev->props[0].val, &adapter.discoverable_timeout,
-							sizeof(uint32_t));
-
-	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, HAL_EV_ADAPTER_PROPS_CHANGED,
-							sizeof(buf), ev);
+	send_adapter_property(HAL_PROP_ADAPTER_DISC_TIMEOUT,
+					sizeof(adapter.discoverable_timeout),
+					&adapter.discoverable_timeout);
 
 	return HAL_STATUS_SUCCESS;
 }
-- 
1.8.3.2

