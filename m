Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH Bluez 7/7] Add unit tests for sdp_attr_remove func
Date: Wed,  8 Feb 2012 12:40:55 +0100
Message-Id: <1328701255-24245-8-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
References: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2 new test cases sdp_attr_remove from lib/sdp.c
---
 unit/test-sdp.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 9f7dc83..897a147 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -327,6 +327,49 @@ START_TEST(tc_sdp_attr_add_twice_add)
 }
 END_TEST
 
+/* sdp_attr_remove testcases */
+START_TEST(tc_sdp_attr_remove_basic)
+{
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
+	ck_assert(rec->attrlist != NULL);
+
+	sdp_attr_remove(rec, attr);
+
+	/* after removing single entry, list should be empty*/
+	ck_assert(rec->attrlist == NULL);
+
+	/* sdp_record_free will free also internal sdp data (sdp_data_t *d) */
+	sdp_record_free(rec);
+}
+END_TEST
+
+START_TEST(tc_sdp_attr_remove_class_id)
+{
+	sdp_record_t *rec;
+
+	rec = sdp_record_alloc();
+	rec->svclass.type = SDP_UUID16;
+	rec->svclass.value.uuid16 = 0x01;
+
+	sdp_attr_remove(rec, SDP_ATTR_SVCLASS_ID_LIST);
+
+	/* after removing single entry, list should be empty*/
+	ck_assert(rec->svclass.type == 0);
+	ck_assert(rec->svclass.value.uuid16 == 0);
+
+	sdp_record_free(rec);
+}
+END_TEST
+
 static void add_test(Suite *s, const char *name, TFun func)
 {
 	TCase *t;
@@ -385,6 +428,9 @@ int main(int argc, char *argv[])
 	/* sdp_attr_add testcases */
 	add_test(s, "sdp_attr_add:add twice same value",
 						tc_sdp_attr_add_twice_add);
+	/* sdp_attr_remove testcases */
+	add_test(s, "sdp_attr_remove: basic", tc_sdp_attr_remove_basic);
+	add_test(s, "sdp_attr_remove: class id", tc_sdp_attr_remove_class_id);
 
 	sr = srunner_create(s);
 
-- 
1.7.0.4

