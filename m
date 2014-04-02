Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix passing wrong event len in le dev found
Date: Wed,  2 Apr 2014 13:36:57 +0200
Message-Id: <1396438617-19549-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix wrong notification length passing to ipc.
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8bd7028..5069f98 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -604,7 +604,7 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 						HAL_EV_GATT_CLIENT_SCAN_RESULT,
-						sizeof(ev) + ev->len, ev);
+						sizeof(*ev) + ev->len, ev);
 
 connect:
 	if (!is_device_wating_for_connect(addr, addr_type))
-- 
1.9.1

