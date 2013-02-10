Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 12/13] unit: Add tests for sdp_get_profile_descs()
Date: Sun, 10 Feb 2013 17:26:36 -0400
Message-Id: <1360531597-3506-13-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-sdp-lib.c |  171 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/unit/test-sdp-lib.c b/unit/test-sdp-lib.c
index 51e5873..346942f 100644
--- a/unit/test-sdp-lib.c
+++ b/unit/test-sdp-lib.c
@@ -226,6 +226,167 @@ static void test_language_base_invalid_dtd(void)
 	sdp_record_free(rec);
 }
 
+static void test_profile_desc_valid(void)
+{
+	sdp_profile_desc_t profile;
+	sdp_record_t *rec;
+	sdp_list_t *list;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	sdp_uuid16_create(&profile.uuid, NAP_PROFILE_ID);
+	profile.version = 0x0100;
+	list = sdp_list_append(NULL, &profile);
+	err = sdp_set_profile_descs(rec, list);
+	sdp_list_free(list, NULL);
+	g_assert(err == 0);
+
+	list = NULL;
+	err = sdp_get_profile_descs(rec, &list);
+	sdp_list_free(list, free);
+	g_assert(err == 0 && list != NULL);
+
+	sdp_record_free(rec);
+}
+
+static void test_profile_desc_nodata(void)
+{
+	sdp_record_t *rec;
+	sdp_list_t *list;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == ENODATA);
+
+	sdp_record_free(rec);
+}
+
+static void test_profile_desc_invalid_dtd(void)
+{
+	uint8_t dtd1 = SDP_UUID16, dtd2 = SDP_UINT32;
+	uint32_t u32 = 0xdeadbeeb;
+	uint16_t u16 = 0x1234;
+	void *dtds[1], *values[1];
+	void *dtds2[] = { &dtd1, &dtd2 };
+	void *values2[] = { &u16, &u32 };
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
+	sdp_attr_add(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8() */
+	data = sdp_seq_alloc(NULL, NULL, 0);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(UINT32) */
+	data = sdp_seq_alloc(&dtds2[1], &values2[1], 1);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(SEQ8()) */
+	data = sdp_seq_alloc(NULL, NULL, 0);
+	dtds[0] = &data->dtd;
+	values[0] = data;
+	data = sdp_seq_alloc(dtds, values, 1);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(SEQ8(UINT32)) */
+	data = sdp_seq_alloc(&dtds2[1], &values2[1], 1);
+	dtds[0] = &data->dtd;
+	values[0] = data;
+	data = sdp_seq_alloc(dtds, values, 1);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(SEQ8(UUID16)) */
+	data = sdp_seq_alloc(dtds2, values2, 1);
+	dtds[0] = &data->dtd;
+	values[0] = data;
+	data = sdp_seq_alloc(dtds, values, 1);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	/* SEQ8(SEQ8(UUID16, UINT32)) */
+	data = sdp_seq_alloc(dtds2, values2, 2);
+	dtds[0] = &data->dtd;
+	values[0] = data;
+	data = sdp_seq_alloc(dtds, values, 1);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	sdp_record_free(rec);
+}
+
+static void test_profile_desc_workaround(void)
+{
+	uint8_t dtd1 = SDP_UUID16, dtd2 = SDP_UINT16, dtd3 = SDP_UINT32;
+	uint16_t u16 = 0x1234;
+	uint32_t u32 = 0xdeadbeeb;
+	void *dtds[] = { &dtd1, &dtd2 };
+	void *values[] = { &u16, &u16 };
+	void *dtds2[] = { &dtd1, &dtd3 };
+	void *values2[] = { &u16, &u32 };
+	sdp_record_t *rec;
+	sdp_data_t *data;
+	sdp_list_t *list;
+	int err;
+
+	rec = sdp_record_alloc();
+
+	/* SEQ8(UUID16) */
+	data = sdp_seq_alloc(dtds, values, 1);
+	sdp_attr_add(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	list = NULL;
+	err = sdp_get_profile_descs(rec, &list);
+	sdp_list_free(list, free);
+	g_assert(err == 0 && list != NULL);
+
+	/* SEQ8(UUID16, UINT16) */
+	data = sdp_seq_alloc(dtds, values, 2);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	list = NULL;
+	err = sdp_get_profile_descs(rec, &list);
+	sdp_list_free(list, free);
+	g_assert(err == 0 && list != NULL);
+
+	/* SEQ8(UUID16) */
+	data = sdp_seq_alloc(dtds, values, 1);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	list = NULL;
+	err = sdp_get_profile_descs(rec, &list);
+	sdp_list_free(list, free);
+	g_assert(err == 0 && list != NULL);
+
+	/* SEQ8(UUID16, UINT32) */
+	data = sdp_seq_alloc(dtds2, values2, 2);
+	sdp_attr_replace(rec, SDP_ATTR_PFILE_DESC_LIST, data);
+	list = NULL;
+	err = sdp_get_profile_descs(rec, &list);
+	g_assert(err == -1 && errno == EINVAL);
+
+	sdp_record_free(rec);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -246,5 +407,15 @@ int main(int argc, char *argv[])
 	g_test_add_func("/sdp/lib/language_base/invalid_dtd",
 						test_language_base_invalid_dtd);
 
+	g_test_add_func("/sdp/lib/profile_desc/valid",
+						test_profile_desc_valid);
+	g_test_add_func("/sdp/lib/profile_desc/nodata",
+						test_profile_desc_nodata);
+	g_test_add_func("/sdp/lib/profile_desc/invalid_dtd",
+						test_profile_desc_invalid_dtd);
+	/* Test for workaround commented on sdp_get_profile_descs() */
+	g_test_add_func("/sdp/lib/profile_desc/workaround",
+						test_profile_desc_workaround);
+
 	return g_test_run();
 }
-- 
1.7.9.5

