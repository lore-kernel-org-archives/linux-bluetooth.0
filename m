Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] android/tester: Add att pdu remote receive debug log
Date: Fri, 17 Oct 2014 15:38:16 +0200
Message-Id: <1413553099-19689-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds additional logs with received opcode of att pdu by remote
---
 android/tester-gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index d123619..c0065a7 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1457,6 +1457,8 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	const uint8_t *pdu = data;
 	struct iovec *gatt_pdu = queue_peek_head(t_data->pdus);
 
+	tester_debug("Received att pdu with opcode 0x%02x", pdu[0]);
+
 	switch (pdu[0]) {
 	case L2CAP_ATT_EXCHANGE_MTU_REQ:
 		tester_print("Exchange MTU request received.");
-- 
1.9.3

