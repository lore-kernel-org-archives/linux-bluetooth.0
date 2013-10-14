Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/22] unit: Add test cases for cbuffer memory acess routines
Date: Mon, 14 Oct 2013 10:34:22 +0200
Message-Id: <1381739678-16260-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds unit tests for cbuffer's memory direct access
finctionality and browsing methods.
---
 unit/test-cbuffer.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/unit/test-cbuffer.c b/unit/test-cbuffer.c
index 5a3482d..d5507a1 100644
--- a/unit/test-cbuffer.c
+++ b/unit/test-cbuffer.c
@@ -200,6 +200,123 @@ static void cbt_manual(struct cbt_fixture *fix, gconstpointer test_data)
 	g_assert(cbuffer_is_empty(fix->cbuff));
 }
 
+static void cbt_peek(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	char ch = 1;
+	/* tail */
+	cbuffer_write(fix->cbuff, 'a');
+	cbuffer_write(fix->cbuff, 'b');
+	cbuffer_write(fix->cbuff, 'c');
+	cbuffer_write(fix->cbuff, 'd');
+	/* head */
+
+	/* peek from head of "abcd" string */
+	g_assert_cmpint('a', ==, *cbuffer_peek_tail(fix->cbuff, 0));
+	g_assert_cmpint('b', ==, *cbuffer_peek_tail(fix->cbuff, 1));
+	g_assert_cmpint('c', ==, *cbuffer_peek_tail(fix->cbuff, 2));
+	g_assert_cmpint('d', ==, *cbuffer_peek_tail(fix->cbuff, 3));
+	/* no boundary check here - will wrap around if index  > buffer size */
+	/* g_assert_cmpint('\0', ==, *cbuffer_peek_head(fix->cbuff, 4)); */
+
+	/* peek from tail of "abcd" string */
+	g_assert_cmpint('d', ==, *cbuffer_peek_head(fix->cbuff, 0));
+	g_assert_cmpint('c', ==, *cbuffer_peek_head(fix->cbuff, 1));
+	g_assert_cmpint('b', ==, *cbuffer_peek_head(fix->cbuff, 2));
+	g_assert_cmpint('a', ==, *cbuffer_peek_head(fix->cbuff, 3));
+	/* no boundary check here - will wrap around if index  > buffer size */
+	/* g_assert_cmpint('\0', ==, *cbuffer_peek_tail(fix->cbuff, 4)); */
+
+	/* now read peeked chars in the right sequence */
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint('a', ==, ch);
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint('b', ==, ch);
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint('c', ==, ch);
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint('d', ==, ch);
+	ch = 1;
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint(1, ==, ch);
+	g_assert(cbuffer_is_empty(fix->cbuff));
+}
+
+static void cbt_get_freechunk(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	char ch = 0;
+	unsigned int i;
+
+	g_assert_cmpuint(cbuffer_get_free_chunk_size(fix->cbuff),
+				==, cbuffer_get_size(fix->cbuff));
+
+	/* fill the whole buffer */
+	for (i = 0; i < cbuffer_get_size(fix->cbuff); ++i) {
+		g_assert(!cbuffer_is_full(fix->cbuff));
+		cbuffer_write(fix->cbuff, 'a');
+	}
+	g_assert_cmpint(cbuffer_get_size(fix->cbuff),
+					==, cbuffer_get_length(fix->cbuff));
+	g_assert_cmpuint(cbuffer_get_free_chunk_size(fix->cbuff), ==, 0);
+
+	/* read more than a half of the data */
+	for (i = 0; i <= cbuffer_get_size(fix->cbuff) / 2; ++i) {
+		g_assert(!cbuffer_is_empty(fix->cbuff));
+		cbuffer_read(fix->cbuff, &ch);
+		g_assert_cmpint('a', ==, ch);
+	}
+	g_assert_cmpint((cbuffer_get_size(fix->cbuff) / 2) - 1, ==,
+				cbuffer_get_length(fix->cbuff));
+
+	/* fill it again leaving 2 empty spaces */
+	for (i = 0; i < (cbuffer_get_size(fix->cbuff) / 2) - 1; ++i) {
+		g_assert(!cbuffer_is_full(fix->cbuff));
+		cbuffer_write(fix->cbuff, 'b');
+	}
+	g_assert_cmpint(cbuffer_get_size(fix->cbuff) - 2, ==,
+				cbuffer_get_length(fix->cbuff));
+
+	/* s- buffers start offset
+	 * e- buffers end offset
+	 * n- place where new data will be appended
+	 */
+	/* [XXXX|n...|XXXXX]
+	 *      e    s
+	 */
+	g_assert_cmpuint(cbuffer_get_free_chunk_size(fix->cbuff), ==, 2);
+
+	/* [|n.............]
+	 * s/e
+	 */
+	cbuffer_drain(fix->cbuff);
+	g_assert_cmpuint(cbuffer_get_free_chunk_size(fix->cbuff),
+				==, cbuffer_get_size(fix->cbuff));
+
+	/* [|X|n...........]
+	 *  s e
+	 */
+	cbuffer_drain(fix->cbuff);
+	cbuffer_write(fix->cbuff, 'b');
+	g_assert_cmpuint(cbuffer_get_free_chunk_size(fix->cbuff),
+				==, cbuffer_get_size(fix->cbuff) - 1);
+
+	/* [n...........|X|]
+	 *		e s
+	 */
+	cbuffer_drain(fix->cbuff);
+	for (i = 0; i < cbuffer_get_size(fix->cbuff); ++i) {
+		g_assert(!cbuffer_is_full(fix->cbuff));
+		cbuffer_write(fix->cbuff, 'a');
+	}
+	/* read all but one */
+	for (i = 0; i < cbuffer_get_size(fix->cbuff) - 1; ++i) {
+		g_assert(!cbuffer_is_empty(fix->cbuff));
+		cbuffer_read(fix->cbuff, &ch);
+		g_assert_cmpint('a', ==, ch);
+	}
+	g_assert_cmpuint(cbuffer_get_free_chunk_size(fix->cbuff),
+				==, cbuffer_get_size(fix->cbuff) - 1);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -217,5 +334,9 @@ int main(int argc, char **argv)
 			cbt_drain, cbt_fix_teardown);
 	g_test_add("/cbuffer/manual", struct cbt_fixture, 0, cbt_fix_setup,
 			cbt_manual, cbt_fix_teardown);
+	g_test_add("/cbuffer/peek", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_peek, cbt_fix_teardown);
+	g_test_add("/cbuffer/get_freechunk", struct cbt_fixture, 0,
+			cbt_fix_setup, cbt_get_freechunk, cbt_fix_teardown);
 	return g_test_run();
 }
-- 
1.7.9.5

