Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/tester: Add new id to hal_bluetooth_callbacks_id
Date: Fri, 13 Dec 2013 09:05:04 +0100
Message-ID: <1386921905-28047-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added adapter_prop_tod id to represents BT_PROPERTY_TYPE_OF_DEVICE
property changed.
---
 android/android-tester.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a50ed7b..16ddcc4 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -55,6 +55,7 @@ enum hal_bluetooth_callbacks_id {
 	adapter_prop_uuids,
 	adapter_prop_cod,
 	adapter_prop_scan_mode,
+	adapter_prop_tod,
 	adapter_prop_disc_timeout,
 	adapter_prop_service_record,
 	adapter_prop_bonded_devices
@@ -484,7 +485,7 @@ static void adapter_properties_cb(bt_status_t status, int num_properties,
 			remove_expected_hal_cb();
 			break;
 		case BT_PROPERTY_TYPE_OF_DEVICE:
-			if (hal_cb != adapter_prop_bdaddr) {
+			if (hal_cb != adapter_prop_tod) {
 				tester_test_failed();
 				return;
 			}
-- 
1.8.4

