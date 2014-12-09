Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 1/8] lib/uuid: Simplify BT base UUIDs when possible
Date: Tue,  9 Dec 2014 15:08:33 -0800
Message-Id: <1418166520-32993-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
References: <1418166520-32993-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When converting a UUID from string to bt_uuid_t, prefer using
the 16-bit version when possible, which should generate shorter
sequences by increasing the number of 16-bit types.
---
 lib/uuid.c       | 17 +++++++++++++++--
 unit/test-uuid.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 186a7e6..29d4239 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -190,6 +190,17 @@ static inline int is_uuid128(const char *string)
 			string[23] == '-');
 }
 
+static inline int is_base_uuid128(const char *string)
+{
+	uint16_t uuid;
+	char dummy;
+	if (!is_uuid128(string))
+		return 0;
+
+	return sscanf(string, "0000%04hx-0000-1000-8000-00805%1[fF]9%1[bB]34%1[fF]%1[bB]",
+				&uuid, &dummy, &dummy, &dummy, &dummy) == 5;
+}
+
 static inline int is_uuid32(const char *string)
 {
 	return (strlen(string) == 8 || strlen(string) == 10);
@@ -206,7 +217,7 @@ static int bt_string_to_uuid16(bt_uuid_t *uuid, const char *string)
 	char *endptr = NULL;
 
 	u16 = strtol(string, &endptr, 16);
-	if (endptr && *endptr == '\0') {
+	if (endptr && (*endptr == '\0' || *endptr == '-')) {
 		bt_uuid16_create(uuid, u16);
 		return 0;
 	}
@@ -261,7 +272,9 @@ static int bt_string_to_uuid128(bt_uuid_t *uuid, const char *string)
 
 int bt_string_to_uuid(bt_uuid_t *uuid, const char *string)
 {
-	if (is_uuid128(string))
+	if (is_base_uuid128(string))
+		return bt_string_to_uuid16(uuid, string + 4);
+	else if (is_uuid128(string))
 		return bt_string_to_uuid128(uuid, string);
 	else if (is_uuid32(string))
 		return bt_string_to_uuid32(uuid, string);
diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 49ea031..d7ee54d 100644
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
@@ -164,6 +176,26 @@ static void test_cmp(gconstpointer data)
 	g_assert(bt_uuid_cmp(&uuid1, &uuid2) == 0);
 }
 
+static const struct uuid_test_data compress[] = {
+	{
+		.str = "00001234-0000-1000-8000-00805f9b34fb",
+		.type = BT_UUID16,
+		.val16 = 0x1234,
+	}, {
+		.str = "0000FFFF-0000-1000-8000-00805f9b34fb",
+		.type = BT_UUID16,
+		.val16 = 0xFFFF,
+	}, {
+		.str = "0000FFFF-0000-1000-8000-00805F9B34FB",
+		.type = BT_UUID16,
+		.val16 = 0xFFFF,
+	}, {
+		.str = "F0000000-0000-1000-8000-00805f9b34fb",
+		.type = BT_UUID128,
+		.binary = uuid_128_binary,
+	},
+};
+
 static const char *malformed[] = {
 	"0",
 	"01",
@@ -193,7 +225,7 @@ static void test_malformed(gconstpointer data)
 
 int main(int argc, char *argv[])
 {
-	int i;
+	size_t i;
 
 	g_test_init(&argc, &argv, NULL);
 
@@ -217,6 +249,10 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/uuid/thritytwo2/str", &uuid_32_2, test_str);
 	g_test_add_data_func("/uuid/thirtytwo2/cmp", &uuid_32_2, test_cmp);
 
+	g_test_add_data_func("/uuid/onetwentyeight", &uuid_128, test_uuid);
+	g_test_add_data_func("/uuid/onetwentyeight/str", &uuid_128, test_str);
+	g_test_add_data_func("/uuid/onetwentyeight/cmp", &uuid_128, test_cmp);
+
 	for (i = 0; malformed[i]; i++) {
 		char *testpath;
 
@@ -225,5 +261,13 @@ int main(int argc, char *argv[])
 		g_free(testpath);
 	}
 
+	for (i = 0; i < (sizeof(compress) / sizeof(compress[0])); i++) {
+		char *testpath;
+		testpath = g_strdup_printf("/uuid/compress/%s",
+							compress[i].str);
+		g_test_add_data_func(testpath, compress + i, test_uuid);
+		g_free(testpath);
+	}
+
 	return g_test_run();
 }
-- 
2.2.0.rc0.207.ga3a616c

