Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 02/11] shared/gatt-helpers: Added result count functions.
Date: Wed, 20 Aug 2014 13:15:28 -0700
Message-Id: <1408565737-8187-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1408565737-8187-1-git-send-email-armansito@chromium.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added functions that return the number of services, characteristics, and
descriptors contained in a bt_gatt_result.
---
 src/shared/gatt-helpers.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.h |  4 ++++
 2 files changed, 53 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index ff49867..00813f5 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -88,6 +88,55 @@ static void result_destroy(struct bt_gatt_result *result)
 	}
 }
 
+static unsigned int result_element_count(struct bt_gatt_result *result)
+{
+	unsigned int count = 0;
+	struct bt_gatt_result *cur;
+
+	cur = result;
+
+	while (cur) {
+		count += cur->pdu_len / cur->data_len;
+		cur = cur->next;
+	}
+
+	return count;
+}
+
+unsigned int bt_gatt_result_service_count(struct bt_gatt_result *result)
+{
+	if (!result)
+		return 0;
+
+	if (result->opcode != BT_ATT_OP_READ_BY_GRP_TYPE_RSP &&
+			result->opcode != BT_ATT_OP_FIND_BY_TYPE_VAL_RSP)
+		return 0;
+
+	return result_element_count(result);
+}
+
+unsigned int bt_gatt_result_characteristic_count(struct bt_gatt_result *result)
+{
+	if (!result)
+		return 0;
+
+	if (result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
+		return 0;
+
+	return result_element_count(result);
+}
+
+unsigned int bt_gatt_result_descriptor_count(struct bt_gatt_result *result)
+{
+	if (!result)
+		return 0;
+
+	if (result->opcode != BT_ATT_OP_FIND_INFO_RSP)
+		return 0;
+
+	return result_element_count(result);
+}
+
 bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result)
 {
 	if (!iter || !result)
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index cdf83ba..d63fac1 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -35,6 +35,10 @@ struct bt_gatt_iter {
 	uint16_t pos;
 };
 
+unsigned int bt_gatt_result_service_count(struct bt_gatt_result *result);
+unsigned int bt_gatt_result_characteristic_count(struct bt_gatt_result *result);
+unsigned int bt_gatt_result_descriptor_count(struct bt_gatt_result *result);
+
 bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result);
 bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 				uint16_t *start_handle, uint16_t *end_handle,
-- 
2.1.0.rc2.206.gedb03e5

