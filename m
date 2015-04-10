Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/9] unit/test-ecc: Use tester framework
Date: Fri, 10 Apr 2015 17:05:55 +0300
Message-Id: <1428674761-24609-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-ecc.c | 99 ++++++++++++++++++++++++---------------------------------
 1 file changed, 42 insertions(+), 57 deletions(-)

diff --git a/unit/test-ecc.c b/unit/test-ecc.c
index 8f80118..9b48d0b 100644
--- a/unit/test-ecc.c
+++ b/unit/test-ecc.c
@@ -37,33 +37,33 @@
 #include <fcntl.h>
 
 #include "src/shared/ecc.h"
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
 
-static void vli_print(uint8_t *vli, size_t size)
+static void print_dump(const char *str, void *user_data)
 {
-	while (size) {
-		printf("%02X ", vli[size - 1]);
-		size--;
-	}
+	tester_debug("%s", str);
+}
+
+static void print_buf(const char *label, uint8_t *buf, size_t len)
+{
+	tester_debug("%s", label);
+
+	util_hexdump(' ', buf, len, print_dump, NULL);
 }
 
 #define PAIR_COUNT 200
 
-static void test_multi(void)
+static void test_multi(const void *data)
 {
 	uint8_t public1[64], public2[64];
 	uint8_t private1[32], private2[32];
 	uint8_t shared1[32], shared2[32];
 	int i;
 
-	if (g_test_verbose())
-		g_print("Testing %u random private key pairs", PAIR_COUNT);
+	tester_debug("Testing %u random private key pairs", PAIR_COUNT);
 
 	for (i = 0; i < PAIR_COUNT; i++) {
-		if (g_test_verbose()) {
-			printf(".");
-			fflush(stdout);
-		}
-
 		ecc_make_key(public1, private1);
 		ecc_make_key(public2, private2);
 
@@ -71,37 +71,20 @@ static void test_multi(void)
 		ecdh_shared_secret(public2, private1, shared2);
 
 		if (memcmp(shared1, shared2, sizeof(shared1)) != 0) {
-			printf("Shared secrets are not identical!\n");
-			printf("Shared secret 1 = ");
-			vli_print(shared1, sizeof(shared1));
-			printf("\n");
-			printf("Shared secret 2 = ");
-			vli_print(shared2, sizeof(shared2));
-			printf("\n");
-			printf("Private key 1 = ");
-			vli_print(private1, sizeof(private1));
-			printf("\n");
-			printf("Private key 2 = ");
-			vli_print(private2, sizeof(private2));
-			printf("\n");
+			tester_debug("Shared secrets are not identical!\n");
+			print_buf("Shared secret 1 = ", shared1,
+							sizeof(shared1));
+			print_buf("Shared secret 2 = ", shared2,
+							sizeof(shared2));
+			print_buf("Private key 1 = ", private1,
+							sizeof(private1));
+			print_buf("Private key 2 = ", private2,
+							sizeof(private2));
 			g_assert_not_reached();
 		}
 	}
 
-	if (g_test_verbose())
-		printf("\n");
-}
-
-static void print_buf(const char *label, uint8_t *buf, size_t len)
-{
-	size_t i;
-
-	printf("%s ", label);
-
-	for (i = 0; i < len; i++)
-		printf("%02x", buf[i]);
-
-	printf("\n");
+	tester_test_passed();
 }
 
 static int test_sample(uint8_t priv_a[32], uint8_t priv_b[32],
@@ -121,27 +104,23 @@ static int test_sample(uint8_t priv_a[32], uint8_t priv_b[32],
 	}
 
 	if (memcmp(dhkey_a, dhkey, 32)) {
-		if (g_test_verbose())
-			printf("DHKey A doesn't match!\n");
+		tester_debug("DHKey A doesn't match!");
 		fails++;
 	} else {
-		if (g_test_verbose())
-			printf("DHKey A matches :)\n");
+		tester_debug("DHKey A matches :)");
 	}
 
 	if (memcmp(dhkey_b, dhkey, 32)) {
-		if (g_test_verbose())
-			printf("DHKey B doesn't match!\n");
+		tester_debug("DHKey B doesn't match!");
 		fails++;
 	} else {
-		if (g_test_verbose())
-			printf("DHKey B matches :)\n");
+		tester_debug("DHKey B matches :)");
 	}
 
 	return fails;
 }
 
-static void test_sample_1(void)
+static void test_sample_1(const void *data)
 {
 	uint8_t priv_a[32] = {	0xbd, 0x1a, 0x3c, 0xcd, 0xa6, 0xb8, 0x99, 0x58,
 				0x99, 0xb7, 0x40, 0xeb, 0x7b, 0x60, 0xff, 0x4a,
@@ -183,9 +162,11 @@ static void test_sample_1(void)
 	fails = test_sample(priv_a, priv_b, pub_a, pub_b, dhkey);
 
 	g_assert(fails == 0);
+
+	tester_test_passed();
 }
 
-static void test_sample_2(void)
+static void test_sample_2(const void *data)
 {
 	uint8_t priv_a[32] = {	0x63, 0x76, 0x45, 0xd0, 0xf7, 0x73, 0xac, 0xb7,
 				0xff, 0xdd, 0x03, 0x72, 0xb9, 0x72, 0x85, 0xb4,
@@ -227,9 +208,11 @@ static void test_sample_2(void)
 	fails = test_sample(priv_a, priv_b, pub_a, pub_b, dhkey);
 
 	g_assert(fails == 0);
+
+	tester_test_passed();
 }
 
-static void test_sample_3(void)
+static void test_sample_3(const void *data)
 {
 	uint8_t priv_a[32] = {	0xbd, 0x1a, 0x3c, 0xcd, 0xa6, 0xb8, 0x99, 0x58,
 				0x99, 0xb7, 0x40, 0xeb, 0x7b, 0x60, 0xff, 0x4a,
@@ -256,17 +239,19 @@ static void test_sample_3(void)
 	fails = test_sample(priv_a, priv_a, pub_a, pub_a, dhkey);
 
 	g_assert(fails == 0);
+
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	g_test_add_func("/ecdh/multi", test_multi);
+	tester_add("/ecdh/multi", NULL, NULL, test_multi, NULL);
 
-	g_test_add_func("/ecdh/sample/1", test_sample_1);
-	g_test_add_func("/ecdh/sample/2", test_sample_2);
-	g_test_add_func("/ecdh/sample/3", test_sample_3);
+	tester_add("/ecdh/sample/1", NULL, NULL, test_sample_1, NULL);
+	tester_add("/ecdh/sample/2", NULL, NULL, test_sample_2, NULL);
+	tester_add("/ecdh/sample/3", NULL, NULL, test_sample_3, NULL);
 
-	return g_test_run();
+	return tester_run();
 }
-- 
2.1.0

