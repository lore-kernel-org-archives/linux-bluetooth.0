Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 14/14] shared/gatt: Add function bt_gatt_result_included_count()
Date: Thu, 16 Oct 2014 12:17:26 +0200
Message-Id: <1413454646-23076-15-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will return number of included services in result.
---
 src/shared/gatt-helpers.c | 21 +++++++++++++++++++++
 src/shared/gatt-helpers.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 48e7379..92d0696 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -140,6 +140,27 @@ unsigned int bt_gatt_result_descriptor_count(struct bt_gatt_result *result)
 	return result_element_count(result);
 }
 
+unsigned int bt_gatt_result_included_count(struct bt_gatt_result *result)
+{
+	struct bt_gatt_result *cur;
+	unsigned int count = 0;
+
+	if (!result)
+		return 0;
+
+	if (result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
+		return 0;
+
+	if (result->data_len != 6 && result->data_len != 8)
+		return 0;
+
+	for (cur = result; cur; cur = cur->next)
+		if (cur->opcode == BT_ATT_OP_READ_BY_TYPE_RSP)
+			count += cur->pdu_len / cur->data_len;
+
+	return count;
+}
+
 bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result)
 {
 	if (!iter || !result)
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index f2c7ec5..07c145d 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -38,6 +38,7 @@ struct bt_gatt_iter {
 unsigned int bt_gatt_result_service_count(struct bt_gatt_result *result);
 unsigned int bt_gatt_result_characteristic_count(struct bt_gatt_result *result);
 unsigned int bt_gatt_result_descriptor_count(struct bt_gatt_result *result);
+unsigned int bt_gatt_result_included_count(struct bt_gatt_result *result);
 
 bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result);
 bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
-- 
1.9.3

