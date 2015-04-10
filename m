Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9] unit/test-crypto: Use tester framework
Date: Fri, 10 Apr 2015 17:05:54 +0300
Message-Id: <1428674761-24609-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-crypto.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index fd2ea78..5fb1c64 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -26,6 +26,8 @@
 #endif
 
 #include "src/shared/crypto.h"
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
 
 #include <string.h>
 #include <glib.h>
@@ -107,14 +109,9 @@ static const struct test_data test_data_4 = {
 	.t = t_msg_4
 };
 
-static void print_buf(const uint8_t *t, uint8_t len)
+static void print_debug(const char *str, void *user_data)
 {
-	int i;
-
-	for (i = 0; i < len; i++)
-		g_print("0x%02x, ", t[i]);
-
-	g_print("\n");
+	tester_debug("%s", str);
 }
 
 static bool result_compare(const uint8_t exp[12], uint8_t res[12])
@@ -136,14 +133,14 @@ static void test_sign(gconstpointer data)
 	if (!bt_crypto_sign_att(crypto, key, d->msg, d->msg_len, 0, t))
 		g_assert(true);
 
-	if (g_test_verbose()) {
-		g_print("Result T: ");
-		print_buf(t, 12);
-		g_print("Expected T:");
-		print_buf(d->t, 12);
-	}
+	tester_debug("Result T:");
+	util_hexdump(' ', t, 12, print_debug, NULL);
+	tester_debug("Expected T:");
+	util_hexdump(' ', d->t, 12, print_debug, NULL);
 
 	g_assert(result_compare(d->t, t));
+
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
@@ -154,14 +151,14 @@ int main(int argc, char *argv[])
 	if (!crypto)
 		return 0;
 
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	g_test_add_data_func("/crypto/sign_att_1", &test_data_1, test_sign);
-	g_test_add_data_func("/crypto/sign_att_2", &test_data_2, test_sign);
-	g_test_add_data_func("/crypto/sign_att_3", &test_data_3, test_sign);
-	g_test_add_data_func("/crypto/sign_att_4", &test_data_4, test_sign);
+	tester_add("/crypto/sign_att_1", &test_data_1, NULL, test_sign, NULL);
+	tester_add("/crypto/sign_att_2", &test_data_2, NULL, test_sign, NULL);
+	tester_add("/crypto/sign_att_3", &test_data_3, NULL, test_sign, NULL);
+	tester_add("/crypto/sign_att_4", &test_data_4, NULL, test_sign, NULL);
 
-	exit_status = g_test_run();
+	exit_status = tester_run();
 
 	bt_crypto_unref(crypto);
 
-- 
2.1.0

