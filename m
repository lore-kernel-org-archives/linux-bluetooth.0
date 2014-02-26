Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 14/17] android/tester: Increase timeout for test failure
Date: Wed, 26 Feb 2014 02:57:25 +0100
Message-ID: <1393379848-4031-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inquiry command is sent with inquiry lenght 10.24 sec. There are
testcases where that time is needed to end the test, therefore change
timeout to 12 sec (number choosed based on strong feelings ;))
---
 android/android-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 65516c1..b09834a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3707,7 +3707,7 @@ static void test_hidhost_get_report(const void *test_data)
 		user->test_data = data; \
 		tester_add_full(name, data, test_pre_setup, test_setup, \
 				test, test_teardown, test_post_teardown, \
-							3, user, g_free); \
+							12, user, g_free); \
 	} while (0)
 
 int main(int argc, char *argv[])
-- 
1.8.4

