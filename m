Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/12] android/hal-gatt: Remove unneeded never read initialization
Date: Fri,  4 Jul 2014 16:43:55 +0300
Message-Id: <1404481441-734-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning:
...
android/hal-gatt.c:1021:3: warning: Value stored to 'data' is never read
                data += service_uuid_len;
                ^       ~~~~~~~~~~~~~~~~
1 warning generated.
...
---
 android/hal-gatt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 1cc4897..c563fe9 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1016,10 +1016,8 @@ static bt_status_t set_adv_data_real(int server_if, bool set_scan_rsp,
 		data += service_data_len;
 	}
 
-	if (service_uuid && service_uuid_len) {
+	if (service_uuid && service_uuid_len)
 		memcpy(data, service_uuid, service_uuid_len);
-		data += service_uuid_len;
-	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SET_ADV_DATA,
 						cmd_len, cmd, NULL, NULL, NULL);
-- 
1.9.1

