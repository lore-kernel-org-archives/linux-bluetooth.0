Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/22] unit: Add test case for cbuffer's manual mode
Date: Mon, 14 Oct 2013 10:34:20 +0200
Message-Id: <1381739678-16260-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test cbuffers direct memory access functionality.
---
 unit/test-cbuffer.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/unit/test-cbuffer.c b/unit/test-cbuffer.c
index 4af73b8..5a3482d 100644
--- a/unit/test-cbuffer.c
+++ b/unit/test-cbuffer.c
@@ -167,6 +167,39 @@ static void cbt_drain(struct cbt_fixture *fix, gconstpointer test_data)
 	g_assert_cmpint(cbuffer_is_empty(fix->cbuff), >, 0);
 }
 
+/* test cbuffer's manual mode */
+static void cbt_manual(struct cbt_fixture *fix, gconstpointer test_data)
+{
+	char ch = 1;
+	char *inbuffer = NULL;
+
+	inbuffer = cbuffer_get_free_cell(fix->cbuff);
+	g_assert(cbuffer_is_empty(fix->cbuff));
+	g_assert(inbuffer != NULL);
+
+	/* write directly to buffers memory */
+	if (inbuffer)
+		*inbuffer = 'a';
+
+	/* mark cell as written */
+	g_assert_cmpint(cbuffer_consume_next_cell(fix->cbuff),
+			>=, 0);
+	inbuffer = NULL;
+	inbuffer = cbuffer_get_free_cell(fix->cbuff);
+	g_assert(inbuffer != NULL);
+
+	if (inbuffer)
+		*inbuffer = 'b';
+
+	g_assert_cmpint(cbuffer_consume_next_cell(fix->cbuff),
+			>=, 0);
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint('a', ==, ch);
+	cbuffer_read(fix->cbuff, &ch);
+	g_assert_cmpint('b', ==, ch);
+	g_assert(cbuffer_is_empty(fix->cbuff));
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -182,5 +215,7 @@ int main(int argc, char **argv)
 			cbt_overflow, cbt_fix_teardown);
 	g_test_add("/cbuffer/drain", struct cbt_fixture, 0, cbt_fix_setup,
 			cbt_drain, cbt_fix_teardown);
+	g_test_add("/cbuffer/manual", struct cbt_fixture, 0, cbt_fix_setup,
+			cbt_manual, cbt_fix_teardown);
 	return g_test_run();
 }
-- 
1.7.9.5

