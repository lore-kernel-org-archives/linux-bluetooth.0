Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/5] shared/gatt-helpers: Improve robustness read by type request
Date: Thu, 19 Mar 2015 10:56:30 +0100
Message-Id: <1426758991-20055-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1426758991-20055-1-git-send-email-szymon.janc@tieto.com>
References: <1426758991-20055-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

This patch makes sure that we do get into infinite loop when doing
read by type request.

It could happen if we got bogus read by type response
---
 src/shared/gatt-helpers.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 78aca7d..87a2be7 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1364,10 +1364,22 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 	}
 
 	last_handle = get_le16(pdu + length - data_length);
+
+	/*
+	 * If last handle is lower from previous start handle then it is smth
+	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 */
+	if (last_handle < op->start_handle) {
+		success = false;
+		goto done;
+	}
+
+	op->start_handle = last_handle + 1;
+
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[4 + get_uuid_len(&op->uuid)];
 
-		put_le16(last_handle + 1, pdu);
+		put_le16(op->start_handle, pdu);
 		put_le16(op->end_handle, pdu + 2);
 		bt_uuid_to_le(&op->uuid, pdu + 4);
 
@@ -1409,6 +1421,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 	op->callback = callback;
 	op->user_data = user_data;
 	op->destroy = destroy;
+	op->start_handle = start;
 	op->end_handle = end;
 	op->uuid = *uuid;
 
-- 
1.9.3

