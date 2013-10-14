Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/22] unit: Add test cases for cbuffer seek, check, get_length
Date: Mon, 14 Oct 2013 10:34:24 +0200
Message-Id: <1381739678-16260-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-cbuffer.c |  153 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/unit/test-cbuffer.c b/unit/test-cbuffer.c
index d5507a1..d51ce64 100644
--- a/unit/test-cbuffer.c
+++ b/unit/test-cbuffer.c
@@ -317,6 +317,151 @@ static void cbt_get_freechunk(struct cbt_fixture *fix, gconstpointer test_data)
 				==, cbuffer_get_size(fix->cbuff) - 1);
 }
 
+static void cbt_seek_head(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	int found = -128;
+
+	/* tail */
+	cbuffer_write(fix->cbuff, '<');
+	cbuffer_write(fix->cbuff, '.');
+	cbuffer_write(fix->cbuff, '>');
+	cbuffer_write(fix->cbuff, 'a');
+	cbuffer_write(fix->cbuff, 'b');
+	cbuffer_write(fix->cbuff, 'c');
+	/* head */
+
+	found = cbuffer_seek_head_for_seq(fix->cbuff, "<.>", 0);
+	g_assert_cmpint(found, ==, 0);
+
+	g_assert_cmpint('<', ==, *cbuffer_peek_tail(fix->cbuff, found));
+	g_assert_cmpint('.', ==, *cbuffer_peek_tail(fix->cbuff, found + 1));
+	g_assert_cmpint('>', ==, *cbuffer_peek_tail(fix->cbuff, found + 2));
+
+	found = cbuffer_seek_head_for_seq(fix->cbuff, ">.>", 0);
+	g_assert_cmpint(found, <, 0);
+	found = cbuffer_seek_head_for_seq(fix->cbuff, "<>", 0);
+	g_assert_cmpint(found, <, 0);
+
+	found = cbuffer_seek_head_for_seq(fix->cbuff, "a", 1);
+	g_assert_cmpint(found, ==, 3);
+	found = cbuffer_seek_head_for_seq(fix->cbuff, "b", 2);
+	g_assert_cmpint(found, ==, 4);
+	found = cbuffer_seek_head_for_seq(fix->cbuff, "c", 3);
+	g_assert_cmpint(found, ==, 5);
+
+	found = cbuffer_seek_head_for_seq(fix->cbuff, "abc", 0);
+	g_assert(found == 3);
+	g_assert_cmpint('a', ==, *cbuffer_peek_tail(fix->cbuff, found));
+	g_assert_cmpint('b', ==, *cbuffer_peek_tail(fix->cbuff, found + 1));
+	g_assert_cmpint('c', ==, *cbuffer_peek_tail(fix->cbuff, found + 2));
+}
+
+static void cbt_seek_tail(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	int found = -1;
+
+	/* tail */
+	cbuffer_write(fix->cbuff, 'z');
+	cbuffer_write(fix->cbuff, 'x');
+	cbuffer_write(fix->cbuff, 'c');
+	cbuffer_write(fix->cbuff, 'v');
+	cbuffer_write(fix->cbuff, 'b');
+	cbuffer_write(fix->cbuff, 'n');
+	cbuffer_write(fix->cbuff, 'm');
+	/* head */
+
+	/* starts seeking for the exact sequence 3 bytes from the end */
+	found = cbuffer_seek_tail_for_seq(fix->cbuff, "bnm", 3);
+	/* should return its distance from the begining */
+	g_assert_cmpint(found, ==, 4);
+	found = cbuffer_seek_tail_for_seq(fix->cbuff, "zxc", 0);
+	g_assert_cmpint(found, ==, 0);
+}
+
+static void cbt_check_for(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	/* tail */
+	cbuffer_write(fix->cbuff, 'z');
+	cbuffer_write(fix->cbuff, 'x');
+	cbuffer_write(fix->cbuff, 'c');
+	cbuffer_write(fix->cbuff, 'v');
+	cbuffer_write(fix->cbuff, 'b');
+	cbuffer_write(fix->cbuff, 'n');
+	cbuffer_write(fix->cbuff, 'm');
+	/* head */
+
+	g_assert_cmpint(0, ==,
+		cbuffer_starts_with_seq(fix->cbuff, "zxcvbm", 0));
+	g_assert_cmpint(1, ==,
+		cbuffer_starts_with_seq(fix->cbuff, "zxcvbn", 0));
+	g_assert_cmpint(0, ==,
+		cbuffer_starts_with_seq(fix->cbuff, "cvb", 1));
+	g_assert_cmpint(1, ==,
+		cbuffer_starts_with_seq(fix->cbuff, "cvb", 2));
+	g_assert_cmpint(0, ==,
+		cbuffer_starts_with_seq(fix->cbuff, "cvb", 3));
+	g_assert_cmpint(1, ==,
+		cbuffer_starts_with_seq(fix->cbuff, "nm", 5));
+}
+
+static void cbt_get_length(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	char ch = 0;
+	int unsigned i;
+	g_assert_cmpint(0, ==, cbuffer_get_length(fix->cbuff));
+
+	/* tail */
+	cbuffer_write(fix->cbuff, 'z');
+	cbuffer_write(fix->cbuff, 'x');
+	cbuffer_write(fix->cbuff, 'c');
+	/* head */
+	g_assert_cmpint(3, ==, cbuffer_get_length(fix->cbuff));
+
+	cbuffer_write(fix->cbuff, 'v');
+	cbuffer_write(fix->cbuff, 'b');
+	cbuffer_write(fix->cbuff, 'n');
+	cbuffer_write(fix->cbuff, 'm');
+	/* head */
+	g_assert_cmpint(7, ==, cbuffer_get_length(fix->cbuff));
+
+	cbuffer_read(fix->cbuff, &ch);
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(5, ==, cbuffer_get_length(fix->cbuff));
+
+	cbuffer_drain(fix->cbuff);
+	g_assert_cmpint(0, ==, cbuffer_get_length(fix->cbuff));
+
+	/* test for buffer wrapping around */
+
+	/* fill the whole buffer */
+	for (i = 0; i < cbuffer_get_size(fix->cbuff); ++i) {
+		g_assert(!cbuffer_is_full(fix->cbuff));
+		cbuffer_write(fix->cbuff, 'a');
+	}
+	g_assert_cmpint(cbuffer_get_size(fix->cbuff), ==,
+						cbuffer_get_length(fix->cbuff));
+
+	/* read half of the data */
+	for (i = 0; i < cbuffer_get_size(fix->cbuff) / 2; ++i) {
+		g_assert(!cbuffer_is_empty(fix->cbuff));
+		cbuffer_read(fix->cbuff, &ch);
+		g_assert_cmpint('a', ==, ch);
+
+	}
+	g_assert_cmpint(cbuffer_get_size(fix->cbuff) / 2, ==,
+				cbuffer_get_length(fix->cbuff));
+
+	/* fill it again */
+	for (i = 0; i < cbuffer_get_size(fix->cbuff) / 2; ++i) {
+		g_assert(!cbuffer_is_full(fix->cbuff));
+		cbuffer_write(fix->cbuff, 'a');
+	}
+
+	/* after refilling should be full */
+	g_assert_cmpint(cbuffer_get_size(fix->cbuff), ==,
+						cbuffer_get_length(fix->cbuff));
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -338,5 +483,13 @@ int main(int argc, char **argv)
 			cbt_peek, cbt_fix_teardown);
 	g_test_add("/cbuffer/get_freechunk", struct cbt_fixture, 0,
 			cbt_fix_setup, cbt_get_freechunk, cbt_fix_teardown);
+	g_test_add("/cbuffer/seek_head", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_seek_head, cbt_fix_teardown);
+	g_test_add("/cbuffer/seek_tail", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_seek_tail, cbt_fix_teardown);
+	g_test_add("/cbuffer/check_for", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_check_for, cbt_fix_teardown);
+	g_test_add("/cbuffer/get_length", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_get_length, cbt_fix_teardown);
 	return g_test_run();
 }
-- 
1.7.9.5

