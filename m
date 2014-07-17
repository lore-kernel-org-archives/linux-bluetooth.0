Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] android/gatt: Fix incorrect status in read characteristic cb
Date: Thu, 17 Jul 2014 10:42:50 +0200
Message-Id: <1405586570-16851-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass correct status to upper layer.
---
 android/gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 852c50b..2ddbf29 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2769,11 +2769,12 @@ static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 
 	ev->conn_id = conn_id;
 	ev->status = status;
+	ev->data.status = status;
 
 	element_id_to_hal_srvc_id(s_id, primary, &ev->data.srvc_id);
 	element_id_to_hal_gatt_id(ch_id, &ev->data.char_id);
 
-	if (pdu) {
+	if (status == 0 && pdu) {
 		vlen = dec_read_resp(pdu, len, ev->data.value, sizeof(buf));
 		if (vlen < 0) {
 			error("gatt: Protocol error");
-- 
1.9.0

