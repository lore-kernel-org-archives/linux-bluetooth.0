Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] android/gatt: Send proper status of read descriptor callback
Date: Thu, 17 Jul 2014 10:42:49 +0200
Message-Id: <1405586570-16851-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass proper status to upper layer.
---
 android/gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6253d28..852c50b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3140,12 +3140,13 @@ static void send_client_descr_read_notify(int32_t status, const uint8_t *pdu,
 
 	ev->status = status;
 	ev->conn_id = conn_id;
+	ev->data.status = ev->status;
 
 	element_id_to_hal_srvc_id(srvc, primary, &ev->data.srvc_id);
 	element_id_to_hal_gatt_id(ch, &ev->data.char_id);
 	element_id_to_hal_gatt_id(descr, &ev->data.descr_id);
 
-	if (len && pdu) {
+	if (status == 0 && pdu) {
 		ssize_t ret;
 
 		ret = dec_read_resp(pdu, len, ev->data.value,
-- 
1.9.0

