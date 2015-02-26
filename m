Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 13/16] shared/gatt-helpers: Improve robustness of get characteristics
Date: Thu, 26 Feb 2015 10:39:40 +0100
Message-Id: <1424943583-30061-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that we do get into infinite loop when doing
search for characteristics

It could happen if we got bogus read by type response
---
 src/shared/gatt-helpers.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 1a60f31..cd0ffe2 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1203,10 +1203,22 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 		goto done;
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
 		uint8_t pdu[6];
 
-		put_le16(last_handle + 1, pdu);
+		put_le16(op->start_handle, pdu);
 		put_le16(op->end_handle, pdu + 2);
 		put_le16(GATT_CHARAC_UUID, pdu + 4);
 
@@ -1249,6 +1261,7 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 	op->callback = callback;
 	op->user_data = user_data;
 	op->destroy = destroy;
+	op->start_handle = start;
 	op->end_handle = end;
 
 	put_le16(start, pdu);
-- 
1.8.4

