Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 2/3] mgmt-tester: Add test_le_full
Date: Fri,  9 Feb 2018 18:26:26 +0100
Message-Id: <20180209172627.20500-3-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20180209172627.20500-1-lukasz.rymanowski@codecoup.pl>
References: <20180209172627.20500-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1078d185e..191c1cd4d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -373,7 +373,7 @@ static void test_condition_complete(struct test_data *data)
 				test_post_teardown, 2, user, free); \
 	} while (0)
 
-#define test_le(name, data, setup, func) \
+#define test_le_full(name, data, setup, func, timeout) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
@@ -386,9 +386,12 @@ static void test_condition_complete(struct test_data *data)
 		user->initial_settings = 0x00000200; \
 		tester_add_full(name, data, \
 				test_pre_setup, test_setup, func, NULL, \
-				test_post_teardown, 2, user, free); \
+				test_post_teardown, timeout, user, free); \
 	} while (0)
 
+#define test_le(name, data, setup, func) \
+	test_le_full(name, data, setup, func, 2)
+
 static void controller_setup(const void *test_data)
 {
 	tester_test_passed();
-- 
2.14.1

