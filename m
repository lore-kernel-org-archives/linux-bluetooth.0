Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 04/14] shared/gatt: Add extra check in characteristic iterator
Date: Fri, 10 Oct 2014 11:15:38 +0200
Message-Id: <1412932548-28363-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid incorrect reading of included service discovery results.
---
 src/shared/gatt-helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index c18f738..58104d9 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -123,6 +123,9 @@ unsigned int bt_gatt_result_characteristic_count(struct bt_gatt_result *result)
 	if (result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
 		return 0;
 
+	if (result->data_len != 21 && result->data_len != 7)
+		return 0;
+
 	return result_element_count(result);
 }
 
@@ -239,6 +242,9 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
 		return false;
 
+	if (iter->result->data_len != 21 && iter->result->data_len != 7)
+		return false;
+
 	op = iter->result->op;
 	pdu_ptr = iter->result->pdu + iter->pos;
 
-- 
1.9.3

