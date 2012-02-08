Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH Bluez 6/7] Add unit test for sdp_attr_add func
Date: Wed,  8 Feb 2012 12:40:54 +0100
Message-Id: <1328701255-24245-7-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
References: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1 new test case sdp_attr_add from lib/sdp.c code.
---
 unit/test-sdp.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 76a8435..9f7dc83 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -302,6 +302,31 @@ START_TEST(tc_sdp_seq_alloc_with_length_zero)
 }
 END_TEST
 
+/* sdp_attr_add testcases */
+START_TEST(tc_sdp_attr_add_twice_add)
+{
+	int ret;
+	sdp_record_t *rec;
+	sdp_data_t *d;
+	uint16_t attr = SDP_ATTR_SUPPORTED_FEATURES;
+	uint16_t test_uid = 0x0019;
+
+	d = sdp_data_alloc(SDP_UINT16, &test_uid);
+	d->attrId = attr;
+
+	rec = sdp_record_alloc();
+	rec->attrlist = sdp_list_append(rec->attrlist, d);
+
+	ret = sdp_attr_add(rec, attr, d);
+
+	/* trying to add attribute that already exist, so func should fail
+	 * with -1 */
+	ck_assert(ret == -1);
+
+	sdp_record_free(rec);
+}
+END_TEST
+
 static void add_test(Suite *s, const char *name, TFun func)
 {
 	TCase *t;
@@ -357,6 +382,9 @@ int main(int argc, char *argv[])
 	/* sdp_seq_alloc_with_length testcases */
 	add_test(s, "sdp_seq_alloc_with_length:zero length param",
 					tc_sdp_seq_alloc_with_length_zero);
+	/* sdp_attr_add testcases */
+	add_test(s, "sdp_attr_add:add twice same value",
+						tc_sdp_attr_add_twice_add);
 
 	sr = srunner_create(s);
 
-- 
1.7.0.4

