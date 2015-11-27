Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v2 10/11] shared/gatt-db: Add API to get extended prop
Date: Fri, 27 Nov 2015 12:11:49 +0100
Message-Id: <1448622711-17562-11-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds way to get extended properties from
characteristic extended property descriptor
---
 src/shared/gatt-db.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  4 ++++
 unit/test-gatt.c     | 14 ++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index cc49458..1a1704b 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -52,6 +52,8 @@ static const bt_uuid_t characteristic_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_CHARAC_UUID };
 static const bt_uuid_t included_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_INCLUDE_UUID };
+static const bt_uuid_t ext_desc_uuid = { .type = BT_UUID16,
+				.value.u16 = GATT_CHARAC_EXT_PROPER_UUID };
 
 struct gatt_db {
 	int ref_count;
@@ -1456,6 +1458,66 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 	return le_to_uuid(decl->value, decl->value_len, uuid);
 }
 
+struct ext_prop_data {
+	bool present;
+	uint8_t prop;
+};
+
+static void set_ext_prop_data(struct gatt_db_attribute *attrib,
+						int err, const uint8_t *value,
+						size_t length, void *user_data)
+{
+	struct ext_prop_data *ext_prop_data = user_data;
+
+	if (err || (length != sizeof(uint8_t)))
+		return;
+
+	ext_prop_data->prop = value[0];
+}
+
+static void check_reliable_supported(struct gatt_db_attribute *attrib,
+							void *user_data)
+{
+	struct ext_prop_data *ext_prop_data = user_data;
+
+	if (ext_prop_data->present)
+		return;
+
+	if (bt_uuid_cmp(&ext_desc_uuid, &attrib->uuid))
+		return;
+
+	ext_prop_data->present = true;
+	ext_prop_data->prop = gatt_db_attribute_read(attrib, 0,
+						BT_ATT_OP_READ_REQ, NULL,
+						set_ext_prop_data, user_data);
+}
+
+bool gatt_db_attribute_get_characteristic_extended_prop(
+					const struct gatt_db_attribute *attrib,
+					uint8_t *ext_prop)
+{
+	struct ext_prop_data ext_prop_data;
+
+	if (!attrib)
+		return false;
+
+	if (bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
+		return false;
+
+	memset(&ext_prop_data, 0, sizeof(ext_prop_data));
+
+	/*
+	 * Cast needed for foreach function. We do not change attrib during
+	 * this call
+	 */
+	gatt_db_service_foreach_desc((struct gatt_db_attribute *) attrib,
+						check_reliable_supported,
+						&ext_prop_data);
+
+	*ext_prop = ext_prop_data.prop;
+	return ext_prop_data.present;
+}
+
 bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *value_handle,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 96cceb9..0cb713e 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -195,6 +195,10 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 							bool *primary,
 							bt_uuid_t *uuid);
 
+bool gatt_db_attribute_get_characteristic_extended_prop(
+					const struct gatt_db_attribute *attrib,
+					uint8_t *ext_prop);
+
 bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *handle,
 							uint16_t *value_handle,
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6b65525..ceed486 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -4440,5 +4440,19 @@ int main(int argc, char *argv[])
 				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
 			raw_pdu(0x01, 0x16, 0x04, 0x00, 0x03));
 
+	define_test_server("/robustness/no-reliable-characteristic", test_server,
+			ts_large_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x16, 0x82, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x82, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x16, 0x25, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x17, 0x25, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x16, 0x82, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x17, 0x82, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x16, 0x25, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x17, 0x25, 0x00, 0x03, 0x00, 0x04, 0x05, 0x06),
+			raw_pdu(0x18, 0x01),
+			raw_pdu(0x01, 0x18, 0x25, 0x00, 0x06));
+
 	return tester_run();
 }
-- 
2.5.0

