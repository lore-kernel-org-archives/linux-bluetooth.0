Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  7/7] shared/tester: Fix divide by zero error
Date: Wed, 18 Mar 2015 15:35:41 +0530
Message-id: <1426673141-17700-8-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
References: <1426673141-17700-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before adding a check - o/p:
Total: 0, Passed: 0 (-nan%), Failed: 0, Not Run: 0

After check - o/p:
Total: 0, Passed: 0 (0.0%), Failed: 0, Not Run: 0
---
 src/shared/tester.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index d05bf08..3c3089f 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -319,7 +319,8 @@ static int tester_summarize(void)
 		COLOR_RED "Failed: %d" COLOR_OFF ", "
 		COLOR_YELLOW "Not Run: %d" COLOR_OFF "\n",
 			not_run + passed + failed, passed,
-			(float) passed * 100 / (not_run + passed + failed),
+			(not_run + passed + failed) ?
+			(float) passed * 100 / (not_run + passed + failed) : 0,
 			failed, not_run);
 
 	execution_time = g_timer_elapsed(test_timer, NULL);
-- 
1.9.1

