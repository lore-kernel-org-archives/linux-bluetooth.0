Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/22] unit: Add test case for cbuffer's discard
Date: Mon, 14 Oct 2013 10:34:28 +0200
Message-Id: <1381739678-16260-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-cbuffer.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/unit/test-cbuffer.c b/unit/test-cbuffer.c
index d51ce64..cb99506 100644
--- a/unit/test-cbuffer.c
+++ b/unit/test-cbuffer.c
@@ -462,6 +462,59 @@ static void cbt_get_length(struct cbt_fixture *fix, gconstpointer test_data)
 						cbuffer_get_length(fix->cbuff));
 }
 
+static void cbt_discard(struct cbt_fixture *fix, gconstpointer test_data)
+{
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
+	cbuffer_discard(fix->cbuff, 2);
+	g_assert_cmpint(5, ==, cbuffer_get_length(fix->cbuff));
+	g_assert_cmpint('c', ==, *cbuffer_peek_tail(fix->cbuff, 0));
+
+	cbuffer_drain(fix->cbuff);
+	g_assert_cmpint(0, ==, cbuffer_get_length(fix->cbuff));
+
+	/* unsuccessful discard */
+	g_assert_cmpint(cbuffer_discard(fix->cbuff, 2), ==, 0);
+	g_assert_cmpint(0, ==, cbuffer_get_length(fix->cbuff));
+
+	cbuffer_write(fix->cbuff, 'z');
+	cbuffer_write(fix->cbuff, 'x');
+	cbuffer_write(fix->cbuff, 'c');
+	cbuffer_write(fix->cbuff, 'v');
+	cbuffer_write(fix->cbuff, 'b');
+	cbuffer_write(fix->cbuff, 'n');
+	cbuffer_write(fix->cbuff, 'm');
+
+	g_assert_cmpint(cbuffer_discard(fix->cbuff, 1), ==, 1);
+	g_assert_cmpint(6, ==, cbuffer_get_length(fix->cbuff));
+	g_assert_cmpint('x', ==, *cbuffer_peek_tail(fix->cbuff, 0));
+
+	g_assert_cmpint(cbuffer_discard(fix->cbuff, 2), ==, 2);
+	g_assert_cmpint(4, ==, cbuffer_get_length(fix->cbuff));
+	g_assert_cmpint('v', ==, *cbuffer_peek_tail(fix->cbuff, 0));
+
+	g_assert_cmpint(cbuffer_discard(fix->cbuff, 3), ==, 3);
+	g_assert_cmpint(1, ==, cbuffer_get_length(fix->cbuff));
+	g_assert_cmpint('m', ==, *cbuffer_peek_tail(fix->cbuff, 0));
+
+	g_assert_cmpint(cbuffer_discard(fix->cbuff, 4), ==, 1);
+	g_assert_cmpint(0, ==, cbuffer_get_length(fix->cbuff));
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -491,5 +544,7 @@ int main(int argc, char **argv)
 			cbt_check_for, cbt_fix_teardown);
 	g_test_add("/cbuffer/get_length", struct cbt_fixture, 0, cbt_fix_setup,
 			cbt_get_length, cbt_fix_teardown);
+	g_test_add("/cbuffer/discard", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_discard, cbt_fix_teardown);
 	return g_test_run();
 }
-- 
1.7.9.5

