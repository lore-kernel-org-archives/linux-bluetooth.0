Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 04/14] shared/gatt: Add extra check in characteristic iterator
Date: Thu, 23 Oct 2014 12:15:27 +0200
Message-Id: <1414059337-12040-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid incorrect reading of included service discovery results.
---
 src/shared/gatt-helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index d689c56..0dbd999 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -123,6 +123,16 @@ unsigned int bt_gatt_result_characteristic_count(struct bt_gatt_result *result)
 	if (result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
 		return 0;
 
+	/*
+	 * Data length contains 7 or 21 octets:
+	 * 2 octets: Attribute handle
+	 * 1 octet: Characteristic properties
+	 * 2 octets: Characteristic value handle
+	 * 2 or 16 octets: characteristic UUID
+	 */
+	if (result->data_len != 21 && result->data_len != 7)
+		return 0;
+
 	return result_element_count(result);
 }
 
@@ -239,6 +249,16 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
 		return false;
 
+	/*
+	 * Data length contains 7 or 21 octets:
+	 * 2 octets: Attribute handle
+	 * 1 octet: Characteristic properties
+	 * 2 octets: Characteristic value handle
+	 * 2 or 16 octets: characteristic UUID
+	 */
+	if (iter->result->data_len != 21 && iter->result->data_len != 7)
+		return false;
+
 	op = iter->result->op;
 	pdu_ptr = iter->result->pdu + iter->pos;
 
-- 
1.9.3

