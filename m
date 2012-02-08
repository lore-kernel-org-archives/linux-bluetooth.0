Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH Bluez 4/7] Add unit test for sdp_data_alloc func
Date: Wed,  8 Feb 2012 12:40:52 +0100
Message-Id: <1328701255-24245-5-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
References: <1328701255-24245-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1 new test case sdp_data_alloc function from
lib/sdp.c code.
---
 unit/test-sdp.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index c53ce21..8ce802d 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -276,6 +276,17 @@ START_TEST(tc_sdp_data_alloc_with_length_text_unspec)
 }
 END_TEST
 
+/* sdp_data_alloc testcases */
+START_TEST(tc_sdp_data_alloc_null)
+{
+	sdp_data_t *ret;
+
+	ret = sdp_data_alloc(SDP_TEXT_STR16, NULL);
+
+	ck_assert(ret == NULL);
+}
+END_TEST
+
 static void add_test(Suite *s, const char *name, TFun func)
 {
 	TCase *t;
@@ -326,6 +337,8 @@ int main(int argc, char *argv[])
 				tc_sdp_data_alloc_with_length_text_seq32);
 	add_test(s, "sdp_data_alloc_with_length:indefined param",
 				tc_sdp_data_alloc_with_length_text_unspec);
+	/* sdp_data_alloc testcases */
+	add_test(s, "sdp_data_alloc:NULL param", tc_sdp_data_alloc_null);
 
 	sr = srunner_create(s);
 
-- 
1.7.0.4

