Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 12/16] shated/gatt-helpers: Improve robustness of search service
Date: Thu, 26 Feb 2015 10:39:39 +0100
Message-Id: <1424943583-30061-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes sure that we do get into infinite loop when doing
search service request

It could happen if we got bogus read by group or find by type response
---
 src/shared/gatt-helpers.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 2d07a83..1a60f31 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -212,6 +212,7 @@ static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
 struct discovery_op {
 	struct bt_att *att;
 	unsigned int id;
+	uint16_t start_handle;
 	uint16_t end_handle;
 	int ref_count;
 	bt_uuid_t uuid;
@@ -663,10 +664,22 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	}
 
 	last_end = get_le16(pdu + length - data_length + 2);
+
+	/*
+	 * If last handle is lower from previous start handle then it is smth
+	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 */
+	if (last_end < op->start_handle) {
+		success = false;
+		goto done;
+	}
+
+	op->start_handle = last_end + 1;
+
 	if (last_end < op->end_handle) {
 		uint8_t pdu[6];
 
-		put_le16(last_end + 1, pdu);
+		put_le16(op->start_handle, pdu);
 		put_le16(op->end_handle, pdu + 2);
 		put_le16(op->service_type, pdu + 4);
 
@@ -738,10 +751,22 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 	 * last_end is end handle of last data set
 	 */
 	last_end = get_le16(pdu + length - 2);
+
+	/*
+	* If last handle is lower from previous start handle then it is smth
+	* wrong. Let's stop search, otherwise we might enter infinite loop.
+	*/
+	if (last_end < op->start_handle) {
+		success = false;
+		goto done;
+	}
+
+	op->start_handle = last_end + 1;
+
 	if (last_end < op->end_handle) {
 		uint8_t pdu[6 + get_uuid_len(&op->uuid)];
 
-		put_le16(last_end + 1, pdu);
+		put_le16(op->start_handle, pdu);
 		put_le16(op->end_handle, pdu + 2);
 		put_le16(op->service_type, pdu + 4);
 		bt_uuid_to_le(&op->uuid, pdu + 6);
@@ -782,6 +807,7 @@ static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
 		return false;
 
 	op->att = att;
+	op->start_handle = start;
 	op->end_handle = end;
 	op->callback = callback;
 	op->user_data = user_data;
-- 
1.8.4

