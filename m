Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 10/15] tools/mgmt-tester: make test timeout configurable
Date: Sat, 13 Jun 2015 05:42:54 +0200
Message-Id: <1434166979-21824-11-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently tests have a hard coded timeout of two seconds. To prepare for
multi-advertising tests we need to be able to extend that timeout, so
that we can test whether instances are switching and expiring as
expected.

This patch therefore introduces a "full" version of the
test_bredrle() macro called test_bredrle_full() that takes an additional
timout parameter.
---
 tools/mgmt-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 52a8a19..91d154c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -300,7 +300,7 @@ static void test_condition_complete(struct test_data *data)
 	tester_test_passed();
 }
 
-#define test_bredrle(name, data, setup, func) \
+#define test_bredrle_full(name, data, setup, func, timeout) \
 	do { \
 		struct test_data *user; \
 		user = malloc(sizeof(struct test_data)); \
@@ -316,9 +316,12 @@ static void test_condition_complete(struct test_data *data)
 		user->unmet_conditions = 0; \
 		tester_add_full(name, data, \
 				test_pre_setup, test_setup, func, NULL, \
-				test_post_teardown, 2, user, free); \
+				test_post_teardown, timeout, user, free); \
 	} while (0)
 
+#define test_bredrle(name, data, setup, func) \
+	test_bredrle_full(name, data, setup, func, 2)
+
 #define test_bredr20(name, data, setup, func) \
 	do { \
 		struct test_data *user; \
-- 
1.9.1

