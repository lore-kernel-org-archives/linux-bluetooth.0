Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 33/35] tools/mgmt-tester: Increase timeout for dual mode controller
Date: Wed, 12 Jun 2013 08:57:19 -0400
Message-Id: <1371041841-21793-34-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is need increase the test timeout to let the interleaved discovery
running until the end because LE scanning is controlled by kernel
running about 5 seconds before calling inquiry.
---
 tools/mgmt-tester.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 150c76f..92ae2ea 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -466,7 +466,7 @@ static void test_condition_complete(struct test_data *data)
 		user->unmet_conditions = 0; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, free); \
+				test_post_teardown, 6, user, free); \
 	} while (0)
 
 #define test_bredr(name, data, setup, func) \
-- 
1.7.9.5

