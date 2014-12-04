Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ] lib/uuid: Simplify BT base UUIDs when possible
Date: Thu,  4 Dec 2014 13:56:52 -0800
Message-Id: <1417730212-22785-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When converting a UUID from string to bt_uuid_t, prefer using
the 16-bit version when possible, which should generate shorter
sequences by increasing the number of 16-bit types.
---
 lib/uuid.c       |  4 ++++
 unit/test-uuid.c | 22 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 5c3f986..d110b5e 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -238,6 +238,10 @@ static int bt_string_to_uuid128(bt_uuid_t *uuid, const char *string)
 				&data3, &data4, &data5) != 6)
 		return -EINVAL;
 
+	if (data0 <= 0xFFFF && data1 == 0x0000 && data2 == 0x1000 &&
+	    data3 == 0x8000 && data4 == 0x0805f9bL && data5 == 0x34fb)
+		return bt_uuid16_create(uuid, data0 & 0xFFFF);
+
 	data0 = htonl(data0);
 	data1 = htons(data1);
 	data2 = htons(data2);
diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 6c7e9d0..8647af9 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -46,9 +46,9 @@ static unsigned char uuid_base_binary[] = {
 			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
 
 static struct uuid_test_data uuid_base = {
-	.str = "00000000-0000-1000-8000-00805f9b34fb",
-	.binary = uuid_base_binary,
-	.type = BT_UUID128,
+	.str = "0000",
+	.val16 = 0x0000,
+	.type = BT_UUID16,
 	.str128 = "00000000-0000-1000-8000-00805f9b34fb",
 	.binary128 = uuid_base_binary,
 };
@@ -93,6 +93,18 @@ static struct uuid_test_data uuid_32_2 = {
 	.binary128 = uuid_32_binary,
 };
 
+static unsigned char uuid_128_binary[] = {
+			0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
+
+static struct uuid_test_data uuid_128 = {
+	.str = "F0000000-0000-1000-8000-00805f9b34fb",
+	.binary = uuid_128_binary,
+	.type = BT_UUID128,
+	.str128 = "F0000000-0000-1000-8000-00805f9b34fb",
+	.binary128 = uuid_128_binary,
+};
+
 static void test_uuid(gconstpointer data)
 {
 	const struct uuid_test_data *test_data = data;
@@ -216,6 +228,10 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/uuid/thritytwo2/str", &uuid_32_2, test_str);
 	g_test_add_data_func("/uuid/thirtytwo2/cmp", &uuid_32_2, test_cmp);
 
+	g_test_add_data_func("/uuid/onetwentyeight", &uuid_128, test_uuid);
+	g_test_add_data_func("/uuid/onetwentyeight/str", &uuid_128, test_str);
+	g_test_add_data_func("/uuid/onetwentyeight/cmp", &uuid_128, test_cmp);
+
 	for (i = 0; malformed[i]; i++) {
 		char *testpath;
 
-- 
2.2.0.rc0.207.ga3a616c

