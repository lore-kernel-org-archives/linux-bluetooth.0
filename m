Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH Bluez 5/7] Add unit test for sdp_seq_alloc_with_length func
Date: Wed,  8 Feb 2012 12:40:53 +0100
Message-Id: <1328701255-24245-6-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
References: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1 new test case sdp_seq_alloc_with_length from
lib/sdp.c code.
---
 unit/test-sdp.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 8ce802d..76a8435 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -287,6 +287,21 @@ START_TEST(tc_sdp_data_alloc_null)
 }
 END_TEST
 
+/* sdp_seq_alloc_with_length testcases */
+START_TEST(tc_sdp_seq_alloc_with_length_zero)
+{
+	sdp_data_t *ret;
+	int lengths[2] = {0, 0};
+
+	ret = sdp_seq_alloc_with_length(NULL, NULL, lengths, 0);
+
+	ck_assert(ret->val.dataseq == NULL);
+	ck_assert(ret->unitSize == 2 * sizeof(uint8_t));
+
+	sdp_data_free(ret);
+}
+END_TEST
+
 static void add_test(Suite *s, const char *name, TFun func)
 {
 	TCase *t;
@@ -339,6 +354,9 @@ int main(int argc, char *argv[])
 				tc_sdp_data_alloc_with_length_text_unspec);
 	/* sdp_data_alloc testcases */
 	add_test(s, "sdp_data_alloc:NULL param", tc_sdp_data_alloc_null);
+	/* sdp_seq_alloc_with_length testcases */
+	add_test(s, "sdp_seq_alloc_with_length:zero length param",
+					tc_sdp_seq_alloc_with_length_zero);
 
 	sr = srunner_create(s);
 
-- 
1.7.0.4

