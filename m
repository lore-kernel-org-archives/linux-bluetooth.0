Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 2/2] Remove unused old test db structures
Date: Thu,  4 Dec 2014 09:03:55 -0800
Message-Id: <1417712635-12428-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1417712635-12428-1-git-send-email-jamuraa@chromium.org>
References: <1417712635-12428-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 83 --------------------------------------------------------
 1 file changed, 83 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index ff3dbba..c3767dd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -56,31 +56,6 @@ enum context_type {
 	SERVER
 };
 
-struct gatt_desc {
-	uint16_t handle;
-	uint8_t uuid[16];
-};
-
-struct gatt_chrc {
-	uint16_t handle;
-	uint16_t value_handle;
-	uint8_t properties;
-	uint8_t uuid[16];
-
-	const struct gatt_desc *descs;
-	size_t num_descs;
-};
-
-struct gatt_service {
-	bool primary;
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint8_t uuid[16];
-
-	const struct gatt_chrc **chars;
-	size_t num_chars;
-};
-
 struct test_data {
 	char *test_name;
 	struct test_pdu *pdu_list;
@@ -193,64 +168,6 @@ static bt_uuid_t uuid_char_128 = {
 			0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f}
 };
 
-const struct gatt_desc descriptor_1 = {
-	.handle = 0x0004,
-	.uuid = {0x00, 0x00, 0x29, 0x01, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
-};
-
-const struct gatt_chrc characteristic_1 = {
-	.handle = 0x0002,
-	.value_handle = 0x0003,
-	.properties = 0x02,
-	.uuid = {0x00, 0x00, 0x2a, 0x00, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
-	.descs = &descriptor_1,
-	.num_descs = 1
-};
-
-const struct gatt_desc descriptor_2 = {
-	.handle = 0x0008,
-	.uuid = {0x00, 0x00, 0x29, 0x01, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
-};
-
-const struct gatt_chrc characteristic_2 = {
-	.handle = 0x0006,
-	.value_handle = 0x0007,
-	.properties = 0x02,
-	.uuid = {0x00, 0x00, 0x2a, 0x29, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
-	.descs = &descriptor_2,
-	.num_descs = 1
-};
-
-const struct gatt_chrc *characteristics_1[] = {&characteristic_1};
-const struct gatt_chrc *characteristics_2[] = {&characteristic_2};
-
-const struct gatt_service gatt_service_1 = {
-	.primary = true,
-	.start_handle = 0x0001,
-	.end_handle = 0x0004,
-	.uuid = {0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
-	.chars = characteristics_1,
-	.num_chars = sizeof(characteristics_1) / sizeof(characteristics_1[0])
-};
-
-const struct gatt_service gatt_service_2 = {
-	.primary = true,
-	.start_handle = 0x0005,
-	.end_handle = 0x0008,
-	.uuid = {0x00, 0x00, 0x18, 0x0d, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
-	.chars = characteristics_2,
-	.num_chars = sizeof(characteristics_2) / sizeof(characteristics_2[0])
-};
-
-const struct gatt_service *service_data_1[] = {&gatt_service_1,
-							&gatt_service_2};
-
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
-- 
2.2.0.rc0.207.ga3a616c

