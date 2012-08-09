Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/9] gobex: Add unit test for encoding/decoding apparam headers
Date: Thu,  9 Aug 2012 13:32:28 +0300
Message-Id: <1344508353-24647-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
References: <1344508353-24647-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-header.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/unit/test-gobex-header.c b/unit/test-gobex-header.c
index 86e69f3..feb7d17 100644
--- a/unit/test-gobex-header.c
+++ b/unit/test-gobex-header.c
@@ -47,6 +47,8 @@ static uint8_t hdr_bytes_nval_short[] = { G_OBEX_HDR_BODY, 0xab, 0xcd,
 						0x01, 0x02, 0x03 };
 static uint8_t hdr_bytes_nval_data[] = { G_OBEX_HDR_BODY, 0xab };
 static uint8_t hdr_bytes_nval_len[] = { G_OBEX_HDR_BODY, 0x00, 0x00 };
+static uint8_t hdr_apparam[] = { G_OBEX_HDR_APPARAM, 0x00, 0x09, 0x00, 0x04,
+						0x01, 0x02, 0x03, 0x04 };
 
 static void test_header_name_empty(void)
 {
@@ -115,6 +117,27 @@ static void test_header_bytes(void)
 	g_obex_header_free(header);
 }
 
+static void test_header_apparam(void)
+{
+	GObexHeader *header;
+	GObexApparam *apparam;
+	uint8_t buf[1024];
+	size_t len;
+
+	apparam = g_obex_apparam_set_uint32(NULL, 0, 0x01020304);
+	g_assert(apparam != NULL);
+
+	header = g_obex_header_new_apparam(apparam);
+	g_assert(header != NULL);
+
+	len = g_obex_header_encode(header, buf, sizeof(buf));
+
+	assert_memequal(hdr_apparam, sizeof(hdr_apparam), buf, len);
+
+	g_obex_apparam_free(apparam);
+	g_obex_header_free(header);
+}
+
 static void test_header_uint8(void)
 {
 	GObexHeader *header;
@@ -247,6 +270,26 @@ static void test_header_encode_body(void)
 	g_obex_header_free(header);
 }
 
+static void test_header_encode_apparam(void)
+{
+	GObexHeader *header;
+	GObexApparam *apparam;
+	gboolean ret;
+	guint32 data;
+
+	header = parse_and_encode(hdr_apparam, sizeof(hdr_apparam));
+
+	apparam = g_obex_header_get_apparam(header);
+	g_assert(apparam != NULL);
+
+	ret = g_obex_apparam_get_uint32(apparam, 0x00, &data);
+	g_assert(ret == TRUE);
+	g_assert(data == 0x01020304);
+
+	g_obex_apparam_free(apparam);
+	g_obex_header_free(header);
+}
+
 static void test_header_encode_actionid(void)
 {
 	GObexHeader *header;
@@ -507,6 +550,8 @@ int main(int argc, char *argv[])
 						test_header_encode_body);
 	g_test_add_func("/gobex/test_header_encode_connid",
 						test_header_encode_actionid);
+	g_test_add_func("/gobex/test_header_encode_apparam",
+						test_header_encode_apparam);
 
 	g_test_add_func("/gobex/test_header_name_empty",
 						test_header_name_empty);
@@ -517,6 +562,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gobex/test_header_bytes", test_header_bytes);
 	g_test_add_func("/gobex/test_header_uint8", test_header_uint8);
 	g_test_add_func("/gobex/test_header_uint32", test_header_uint32);
+	g_test_add_func("/gobex/test_header_apparam", test_header_apparam);
 
 	g_test_run();
 
-- 
1.7.11.2

