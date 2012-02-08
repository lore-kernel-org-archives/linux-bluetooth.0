Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH Bluez 3/7] Add unit tests for sdp_data_alloc_with_length func
Date: Wed,  8 Feb 2012 12:40:51 +0100
Message-Id: <1328701255-24245-4-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
References: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

14 new tests for sdp_data_alloc_with_length function from
lib/sdp.c code
---
 unit/test-sdp.c |  223 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 223 insertions(+), 0 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index ee7e9b4..c53ce21 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -82,6 +82,200 @@ START_TEST(tc_uuid2strn_undefined)
 }
 END_TEST
 
+/* sdp_data_alloc_with_length testcases */
+START_TEST(tc_sdp_data_alloc_with_length_sdp_data_nil)
+{
+	sdp_data_t *ret;
+
+	ret = sdp_data_alloc_with_length(SDP_DATA_NIL, NULL, 0);
+	ck_assert(ret->dtd == SDP_DATA_NIL);
+	ck_assert(ret->unitSize == sizeof(uint8_t));
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_int8)
+{
+	sdp_data_t *ret;
+	int8_t test_val = 7;
+
+	ret = sdp_data_alloc_with_length(SDP_INT8, &test_val, 1);
+	ck_assert(ret->dtd == SDP_INT8);
+	ck_assert(ret->unitSize == 2 * sizeof(uint8_t));
+	ck_assert(ret->val.int8 == 7);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_int16)
+{
+	sdp_data_t *ret;
+	int16_t test_val = 32767;
+
+	ret = sdp_data_alloc_with_length(SDP_INT16, &test_val, 1);
+	ck_assert(ret->dtd == SDP_INT16);
+	ck_assert(ret->unitSize == sizeof(int16_t) + sizeof(uint8_t));
+	ck_assert(ret->val.int16 == 32767);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_int32)
+{
+	sdp_data_t *ret;
+	int32_t test_val = -1000000;
+
+	ret = sdp_data_alloc_with_length(SDP_INT32, &test_val, 1);
+	ck_assert(ret->dtd == SDP_INT32);
+	ck_assert(ret->unitSize == sizeof(int32_t) + sizeof(uint8_t));
+	ck_assert(ret->val.int32 == -1000000);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_int64)
+{
+	sdp_data_t *ret;
+	int64_t test_val = -1000000000;
+
+	ret = sdp_data_alloc_with_length(SDP_INT64, &test_val, 1);
+	ck_assert(ret->dtd == SDP_INT64);
+	ck_assert(ret->unitSize == sizeof(int64_t) + sizeof(uint8_t));
+	ck_assert(ret->val.int64 == -1000000000);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_uint64)
+{
+	sdp_data_t *ret;
+	uint64_t test_val = 1000000000;
+
+	ret = sdp_data_alloc_with_length(SDP_UINT64, &test_val, 1);
+	ck_assert(ret->dtd == SDP_UINT64);
+	ck_assert(ret->unitSize == sizeof(uint64_t) + sizeof(uint8_t));
+	ck_assert(ret->val.uint64 == 1000000000);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_uint128)
+{
+	sdp_data_t *ret;
+	uint128_t test_val;
+	int i;
+
+	ret = sdp_data_alloc_with_length(SDP_UINT128, &test_val, 1);
+
+	ck_assert(ret->dtd == SDP_UINT128);
+	ck_assert(ret->unitSize == sizeof(uint128_t) + sizeof(uint8_t));
+
+	for (i = 0; i < 16; ++i)
+		ck_assert(ret->val.uint128.data[i] == test_val.data[i]);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_int128)
+{
+	sdp_data_t *ret;
+	uint128_t test_val;
+	int i;
+
+	ret = sdp_data_alloc_with_length(SDP_INT128, &test_val, 1);
+
+	ck_assert(ret->dtd == SDP_INT128);
+	ck_assert(ret->unitSize == sizeof(uint128_t) + sizeof(uint8_t));
+
+	for (i = 0; i < 16; ++i)
+		ck_assert(ret->val.uint128.data[i] == test_val.data[i]);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_uuid32)
+{
+	sdp_data_t *ret;
+	uint32_t test_val = 1000000;
+
+	ret = sdp_data_alloc_with_length(SDP_UUID32, &test_val, 1);
+
+	ck_assert(ret->dtd == SDP_UUID32);
+	ck_assert(ret->unitSize == sizeof(uint32_t) + sizeof(uint8_t));
+	ck_assert(ret->val.uuid.value.uuid32 == 1000000);
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_text_str16_null)
+{
+	sdp_data_t *ret;
+
+	ret = sdp_data_alloc_with_length(SDP_TEXT_STR16, NULL, 0);
+
+	ck_assert(ret == NULL);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_text_str16_short_max)
+{
+	sdp_data_t *ret;
+	char *test_data = g_strdup("test data");
+
+	ret = sdp_data_alloc_with_length(SDP_TEXT_STR16, test_data,
+								USHRT_MAX+1);
+
+	ck_assert(ret == NULL);
+
+	g_free(test_data);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_text_seq16)
+{
+	sdp_data_t *ret;
+
+	ret = sdp_data_alloc_with_length(SDP_SEQ16, NULL, 0);
+
+	ck_assert(ret->val.dataseq == NULL);
+	ck_assert(ret->unitSize == sizeof(uint16_t) + sizeof(uint8_t));
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_text_seq32)
+{
+	sdp_data_t *ret;
+
+	ret = sdp_data_alloc_with_length(SDP_SEQ32, NULL, 0);
+
+	ck_assert(ret->val.dataseq == NULL);
+	ck_assert(ret->unitSize == sizeof(uint32_t) + sizeof(uint8_t));
+
+	sdp_data_free(ret);
+}
+END_TEST
+
+START_TEST(tc_sdp_data_alloc_with_length_text_unspec)
+{
+	sdp_data_t *ret;
+
+	ret = sdp_data_alloc_with_length(SDP_UUID_UNSPEC, NULL, 0);
+
+	ck_assert(ret == NULL);
+}
+END_TEST
+
 static void add_test(Suite *s, const char *name, TFun func)
 {
 	TCase *t;
@@ -103,6 +297,35 @@ int main(int argc, char *argv[])
 	add_test(s, "uuid2strn:NULL param", tc_uuid2strn_null);
 	add_test(s, "uuid2strn:SDP_UUID32 param", tc_uuid2strn_sdp_uuid_32);
 	add_test(s, "uuid2strn:undefined param", tc_uuid2strn_undefined);
+	/* sdp_data_alloc_with_length testcases */
+	add_test(s, "sdp_data_alloc_with_length:SDP_DATA_NIL param",
+				tc_sdp_data_alloc_with_length_sdp_data_nil);
+	add_test(s, "sdp_data_alloc_with_length:SDP_INT8 param",
+					tc_sdp_data_alloc_with_length_int8);
+	add_test(s, "sdp_data_alloc_with_length:SDP_INT16 param",
+					tc_sdp_data_alloc_with_length_int16);
+	add_test(s, "sdp_data_alloc_with_length:SDP_INT32 param",
+					tc_sdp_data_alloc_with_length_int32);
+	add_test(s, "sdp_data_alloc_with_length:SDP_INT64 param",
+					tc_sdp_data_alloc_with_length_int64);
+	add_test(s, "sdp_data_alloc_with_length:SDP_UINT64 param",
+					tc_sdp_data_alloc_with_length_uint64);
+	add_test(s, "sdp_data_alloc_with_length:SDP_UINT128 param",
+					tc_sdp_data_alloc_with_length_uint128);
+	add_test(s, "sdp_data_alloc_with_length:SDP_INT128 param",
+					tc_sdp_data_alloc_with_length_int128);
+	add_test(s, "sdp_data_alloc_with_length:SDP_UUID32 param",
+					tc_sdp_data_alloc_with_length_uuid32);
+	add_test(s, "sdp_data_alloc_with_length:SDP_STR16 NULL param",
+				tc_sdp_data_alloc_with_length_text_str16_null);
+	add_test(s, "sdp_data_alloc_with_length:SDP_STR16 too long param",
+			tc_sdp_data_alloc_with_length_text_str16_short_max);
+	add_test(s, "sdp_data_alloc_with_length:SDP_SEQ16 param",
+				tc_sdp_data_alloc_with_length_text_seq16);
+	add_test(s, "sdp_data_alloc_with_length:SDP_SEQ32 param",
+				tc_sdp_data_alloc_with_length_text_seq32);
+	add_test(s, "sdp_data_alloc_with_length:indefined param",
+				tc_sdp_data_alloc_with_length_text_unspec);
 
 	sr = srunner_create(s);
 
-- 
1.7.0.4

