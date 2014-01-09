Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/tester: Use common property check function for all test props
Date: Thu,  9 Jan 2014 12:01:33 +0100
Message-Id: <1389265295-3344-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1389265295-3344-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389265295-3344-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes discovery device found test case to use generic
property check method.
---
 android/android-tester.c | 73 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4f733e1..a63d836 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -110,35 +110,6 @@ static void test_update_state(void)
 	tester_test_passed();
 }
 
-static void test_device_property(bt_property_t *property,
-			bt_property_type_t type, const void *value, int len)
-{
-	if (value == NULL) {
-		tester_warn("NULL property passed");
-		tester_test_failed();
-		return;
-	}
-
-	if (property->type != type) {
-		tester_warn("Wrong remote property type %d, expected %d",
-							type, property->type);
-		tester_test_failed();
-		return;
-	}
-
-	if (property->len != len) {
-		tester_warn("Wrong remote property len %d, expected %d",
-							len, property->len);
-		tester_test_failed();
-		return;
-	}
-
-	if (memcmp(property->val, value, len)) {
-		tester_warn("Wrong remote property value");
-		tester_test_failed();
-	}
-}
-
 static void test_mgmt_settings_set(struct test_data *data)
 {
 	data->mgmt_settings_set = true;
@@ -583,12 +554,14 @@ static void discovery_device_found_cb(int num_properties,
 						bt_property_t *properties)
 {
 	struct test_data *data = tester_get_data();
-	const uint8_t *remote_bdaddr =
-					hciemu_get_client_bdaddr(data->hciemu);
-	const uint32_t emu_remote_type = BT_DEVICE_DEVTYPE_BREDR;
-	const int32_t emu_remote_rssi = -60;
+	uint8_t *remote_bdaddr =
+			(uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	uint32_t emu_remote_type = BT_DEVICE_DEVTYPE_BREDR;
+	int32_t emu_remote_rssi = -60;
 	bt_bdaddr_t emu_remote_bdaddr;
 	int i;
+	bt_property_t expected_prop;
+	bt_property_t received_prop;
 
 	data->cb_count--;
 
@@ -598,34 +571,36 @@ static void discovery_device_found_cb(int num_properties,
 	bdaddr2android((const bdaddr_t *) remote_bdaddr, &emu_remote_bdaddr);
 
 	for (i = 0; i < num_properties; i++) {
-		int prop_len;
-		const void *prop_data;
+		received_prop = properties[i];
 
 		switch (properties[i].type) {
 		case BT_PROPERTY_BDADDR:
-			prop_len = sizeof(emu_remote_bdaddr);
-			prop_data = &emu_remote_bdaddr;
-
+			expected_prop.type = BT_PROPERTY_BDADDR;
+			expected_prop.len = sizeof(emu_remote_bdaddr);
+			expected_prop.val = &emu_remote_bdaddr;
 			break;
-		case BT_PROPERTY_TYPE_OF_DEVICE:
-			prop_len = sizeof(emu_remote_type);
-			prop_data = &emu_remote_type;
 
+		case BT_PROPERTY_TYPE_OF_DEVICE:
+			expected_prop.type = BT_PROPERTY_TYPE_OF_DEVICE;
+			expected_prop.len = sizeof(emu_remote_type);
+			expected_prop.val = &emu_remote_type;
 			break;
-		case BT_PROPERTY_REMOTE_RSSI:
-			prop_len = sizeof(emu_remote_rssi);
-			prop_data = &emu_remote_rssi;
 
+		case BT_PROPERTY_REMOTE_RSSI:
+			expected_prop.type = BT_PROPERTY_REMOTE_RSSI;
+			expected_prop.len = sizeof(emu_remote_rssi);
+			expected_prop.val = &emu_remote_rssi;
 			break;
-		default:
-			prop_len = 0;
-			prop_data = NULL;
 
+		default:
+			expected_prop.type = 0;
+			expected_prop.len = 0;
+			expected_prop.val = NULL;
 			break;
 		}
 
-		test_device_property(&properties[i], properties[i].type,
-							prop_data, prop_len);
+		if (!check_test_property(received_prop, expected_prop))
+			tester_test_failed();
 	}
 }
 
-- 
1.8.5.2

