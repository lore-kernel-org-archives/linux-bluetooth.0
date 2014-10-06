Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] shared/gatt: Add function bt_gatt_result_included_count()
Date: Mon,  6 Oct 2014 07:55:44 +0200
Message-Id: <1412574944-5304-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412574944-5304-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412574944-5304-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will return number of included services in result.
---
 src/shared/gatt-helpers.c | 21 +++++++++++++++++++++
 src/shared/gatt-helpers.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index c23fd06..1157412 100644
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
index abd218c..fb045fb 100644
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

