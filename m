Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/gatt: Fix incorrect status in read characteristic cb
Date: Tue, 15 Jul 2014 12:54:54 +0200
Message-Id: <1405421694-13466-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405421694-13466-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405421694-13466-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should pass correct status to upper layer.
---
 android/gatt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4cd94b8..c4e9a29 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2772,7 +2772,7 @@ static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 	element_id_to_hal_srvc_id(s_id, primary, &ev->data.srvc_id);
 	element_id_to_hal_gatt_id(ch_id, &ev->data.char_id);
 
-	if (pdu) {
+	if (status == 0 && pdu) {
 		vlen = dec_read_resp(pdu, len, ev->data.value, sizeof(buf));
 		if (vlen < 0) {
 			error("gatt: Protocol error");
@@ -2782,6 +2782,8 @@ static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 		}
 	}
 
+	ev->data.status = ev->status;
+
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_CLIENT_READ_CHARACTERISTIC,
 					sizeof(*ev) + ev->data.len, ev);
-- 
1.9.0

