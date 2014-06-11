Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/3] android: Update HAL API to Android 4.4.3-r1.1
Date: Wed, 11 Jun 2014 13:30:59 +0200
Message-Id: <1402486261-22488-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c                | 4 +++-
 android/hardware/bt_gatt_client.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 6f0d2c5..a4ad0f2 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -975,7 +975,9 @@ static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
 				bool include_name, bool include_txpower,
 				int min_interval, int max_interval,
 				int appearance, uint16_t manufacturer_len,
-				char *manufacturer_data)
+				char *manufacturer_data,
+				uint16_t service_data_len, char *service_data,
+				uint16_t service_uuid_len, char *service_uuid)
 {
 	char buf[IPC_MTU];
 	struct hal_cmd_gatt_client_set_adv_data *cmd = (void *) buf;
diff --git a/android/hardware/bt_gatt_client.h b/android/hardware/bt_gatt_client.h
index d6b0cb4..cf4fabe 100644
--- a/android/hardware/bt_gatt_client.h
+++ b/android/hardware/bt_gatt_client.h
@@ -278,7 +278,9 @@ typedef struct {
     /** Set the advertising data or scan response data */
     bt_status_t (*set_adv_data)(int server_if, bool set_scan_rsp, bool include_name,
                     bool include_txpower, int min_interval, int max_interval, int appearance,
-                    uint16_t manufacturer_len, char* manufacturer_data);
+                    uint16_t manufacturer_len, char* manufacturer_data,
+                    uint16_t service_data_len, char* service_data,
+                    uint16_t service_uuid_len, char* service_uuid);
 
     /** Test mode interface */
     bt_status_t (*test_command)( int command, btgatt_test_params_t* params);
-- 
1.9.1

