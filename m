Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH v2 2/4] android/gatt: Fix status in write descriptor cb
Date: Mon,  6 Oct 2014 16:28:47 +0200
Message-Id: <1412605729-21818-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1412605729-21818-1-git-send-email-mariusz.skamra@tieto.com>
References: <1412605729-21818-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes problem with status value.
Status should be updated in hal_gatt_write_params as well.
---
 android/gatt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/gatt.c b/android/gatt.c
index 718b137..ea20941 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3480,6 +3480,7 @@ static void send_client_descr_write_notify(int32_t status, int32_t conn_id,
 	element_id_to_hal_srvc_id(srvc, primary, &ev->data.srvc_id);
 	element_id_to_hal_gatt_id(ch, &ev->data.char_id);
 	element_id_to_hal_gatt_id(descr, &ev->data.descr_id);
+	ev->data.status = status;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_CLIENT_WRITE_DESCRIPTOR,
-- 
1.9.1

