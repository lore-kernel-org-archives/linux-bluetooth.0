Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] android: Fix const to non-const issue on android-tester
Date: Sat, 18 Jan 2014 10:54:26 -0400
Message-Id: <1390056866-21560-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to definition from hardware/bluetooth.h, the "val" field does
not have const modifier.

Fix clang errors like:

android/android-tester.c:760:14: error: initializing 'void *' with an
expression of type 'const char (*)[18]' discards qualifiers
[-Werror,-Wincompatible-pointer-types-discards-qualifiers]
---
 android/android-tester.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 6f0e962..0e44bc8 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -897,7 +897,7 @@ static void remote_device_properties_cb(bt_status_t status,
 }
 
 static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
-static const char enable_done_bdname_val[] = "BlueZ for Android";
+static char enable_done_bdname_val[] = "BlueZ for Android";
 static bt_uuid_t enable_done_uuids_val = {
 	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
 					0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
@@ -1344,7 +1344,7 @@ static const struct generic_data bluetooth_discovery_device_found_test = {
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
-static const char remote_get_properties_bdname_val[] = "00:AA:01:01:00:00";
+static char remote_get_properties_bdname_val[] = "00:AA:01:01:00:00";
 static uint32_t remote_get_properties_cod_val = 0;
 static bt_device_type_t remote_get_properties_tod_val = BT_DEVICE_DEVTYPE_BREDR;
 static int32_t remote_get_properties_rssi_val = -60;
@@ -1400,7 +1400,7 @@ static const struct generic_data bt_dev_getprops_success_test = {
 	.expected_adapter_status = BT_STATUS_NOT_EXPECTED,
 };
 
-static const char remote_getprop_bdname_val[] = "00:AA:01:01:00:00";
+static char remote_getprop_bdname_val[] = "00:AA:01:01:00:00";
 
 static struct priority_property remote_getprop_bdname_props[] = {
 	{
@@ -1675,7 +1675,7 @@ static const struct generic_data bt_dev_getprop_fname_fail_test = {
 	.expected_adapter_status = BT_STATUS_FAIL,
 };
 
-static const char remote_setprop_fname_val[] = "set_fname_test";
+static char remote_setprop_fname_val[] = "set_fname_test";
 
 static struct priority_property remote_setprop_fname_props[] = {
 	{
@@ -1702,7 +1702,7 @@ static const struct generic_data bt_dev_setprop_fname_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
-static const char remote_setprop_bdname_val[] = "setprop_bdname_fail";
+static char remote_setprop_bdname_val[] = "setprop_bdname_fail";
 
 static struct priority_property remote_setprop_bdname_props[] = {
 	{
-- 
1.8.3.2

