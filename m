Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 20/22] unit: Circular buffer overflow test
Date: Mon, 14 Oct 2013 10:34:36 +0200
Message-Id: <1381739678-16260-21-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-blueatchat.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/unit/test-blueatchat.c b/unit/test-blueatchat.c
index e0cd23b..e0c51cd 100644
--- a/unit/test-blueatchat.c
+++ b/unit/test-blueatchat.c
@@ -595,6 +595,50 @@ static void tc_blueat_atbac(struct blueat_fixture *fix,
 	g_assert_cmpint(called, ==, 1);
 }
 
+static void tc_blueat_overflow(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n"
+		"\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n\r\nOK\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 180);
+}
+
 /******************************************************************************
  * Parser configuration and command registration
  ******************************************************************************/
@@ -850,5 +894,8 @@ int main(int argc, char **argv)
 	g_test_add("/blueatchat/cind_2", struct blueat_fixture, 0,
 				blueat_fix_setup, tc_blueat_cind2,
 				blueat_fix_teardown);
+	g_test_add("/blueatchat/overflow", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_overflow,
+				blueat_fix_teardown);
 	return g_test_run();
 }
-- 
1.7.9.5

