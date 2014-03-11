Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/tester: Fix TOD test cases to support dual mode
Date: Tue, 11 Mar 2014 15:25:04 +0100
Message-Id: <1394547904-19100-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1394547904-19100-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394547904-19100-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This modifies test cases to support dual mode type of device.
---
 android/android-tester.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 111299f..ade5b40 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1422,7 +1422,7 @@ static bt_uuid_t enable_done_uuids_val = {
 	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
 					0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
 };
-static bt_device_type_t enable_done_tod_val = BT_DEVICE_DEVTYPE_BREDR;
+static bt_device_type_t enable_done_tod_val = BT_DEVICE_DEVTYPE_DUAL;
 static bt_scan_mode_t enable_done_scanmode_val = BT_SCAN_MODE_NONE;
 static uint32_t enable_done_disctimeout_val = 120;
 
@@ -1615,7 +1615,7 @@ static const struct generic_data bluetooth_setprop_cod_invalid_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
-static bt_device_type_t setprop_type_of_device = BT_DEVICE_DEVTYPE_BREDR;
+static bt_device_type_t setprop_type_of_device = BT_DEVICE_DEVTYPE_DUAL;
 
 static struct priority_property setprop_tod_props[] = {
 	{
@@ -1730,7 +1730,7 @@ static const struct generic_data bluetooth_getprop_cod_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
-static bt_device_type_t getprop_tod = BT_DEVICE_DEVTYPE_BREDR;
+static bt_device_type_t getprop_tod = BT_DEVICE_DEVTYPE_DUAL;
 
 static struct priority_property getprop_tod_props[] = {
 	{
-- 
1.8.5.2

