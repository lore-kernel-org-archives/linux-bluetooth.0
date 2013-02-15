Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 06/13] unit: Add tests for sdp_get_lang_attr()
Date: Fri, 15 Feb 2013 11:07:49 -0400
Message-Id: <1360940876-6314-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-lib.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/unit/test-lib.c b/unit/test-lib.c
index 0be6d80..76e4363 100644
--- a/unit/test-lib.c
+++ b/unit/test-lib.c
@@ -147,6 +147,86 @@ static void test_sdp_get_access_protos_invalid_dtd2(void)
 	sdp_record_free(rec);
 }
 
+static void test_sdp_get_lang_attr_valid(void)
+{
+	sdp_record_t *rec;
+	sdp_list_t *list;
+	int err;
+
+	rec = sdp_record_alloc();
+	sdp_add_lang_attr(rec);
+
+	err = sdp_get_lang_attr(rec, &list);
+	g_assert(err == 0);
+
+	sdp_list_free(list, free);
+	sdp_record_free(rec);
+}
+
+static void test_sdp_get_lang_attr_nodata(void)
+{
+	sdp_record_t *rec;
+	sdp_list_t *list;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	err = sdp_get_lang_attr(rec, &list);
+	g_assert(err == -1 && errno == ENODATA);
+
+	sdp_record_free(rec);
+}
+
+static void test_sdp_get_lang_attr_invalid_dtd(void)
+{
+	uint8_t dtd1 = SDP_UINT16, dtd2 = SDP_UINT32;
+	uint32_t u32 = 0xdeadbeeb;
+	uint16_t u16 = 0x1234;
+	void *dtds1[] = { &dtd1, &dtd2, &dtd2 };
+	void *values1[] = { &u16, &u32, &u32 };
+	void *dtds2[] = { &dtd1, &dtd1, &dtd2 };
+	void *values2[] = { &u16, &u16, &u32 };
+	sdp_record_t *rec;
+	sdp_data_t *data;
+	sdp_list_t *list;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	/* UINT32 */
+	data = sdp_data_alloc(SDP_UINT32, &u32);
+	g_assert(data != NULL);
+	sdp_attr_add(rec, SDP_ATTR_LANG_BASE_ATTR_ID_LIST, data);
+	err = sdp_get_lang_attr(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(UINT32) */
+	data = sdp_seq_alloc(&dtds1[1], &values1[1], 1);
+	sdp_attr_replace(rec, SDP_ATTR_LANG_BASE_ATTR_ID_LIST, data);
+	err = sdp_get_lang_attr(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(UINT16, UINT16) */
+	data = sdp_seq_alloc(dtds2, values2, 2);
+	sdp_attr_replace(rec, SDP_ATTR_LANG_BASE_ATTR_ID_LIST, data);
+	err = sdp_get_lang_attr(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(UINT16, UINT32, UINT32) */
+	data = sdp_seq_alloc(dtds1, values1, 3);
+	sdp_attr_replace(rec, SDP_ATTR_LANG_BASE_ATTR_ID_LIST, data);
+	err = sdp_get_lang_attr(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(UINT16, UINT16, UINT32) */
+	data = sdp_seq_alloc(dtds2, values2, 3);
+	sdp_attr_replace(rec, SDP_ATTR_LANG_BASE_ATTR_ID_LIST, data);
+	err = sdp_get_lang_attr(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	sdp_record_free(rec);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -160,5 +240,12 @@ int main(int argc, char *argv[])
 	g_test_add_func("/lib/sdp_get_access_protos/invalid_dtd2",
 				test_sdp_get_access_protos_invalid_dtd2);
 
+	g_test_add_func("/lib/sdp_get_lang_attr/valid",
+						test_sdp_get_lang_attr_valid);
+	g_test_add_func("/lib/sdp_get_lang_attr/nodata",
+						test_sdp_get_lang_attr_nodata);
+	g_test_add_func("/lib/sdp_get_lang_attr/invalid_dtd",
+					test_sdp_get_lang_attr_invalid_dtd);
+
 	return g_test_run();
 }
-- 
1.7.9.5

