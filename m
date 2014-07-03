Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/19] android/tester-hidhost: Add initial test case
Date: Thu,  3 Jul 2014 18:00:14 +0200
Message-Id: <1404403222-26911-12-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 1df7e7c..87c9452 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -19,10 +19,24 @@
 
 static struct queue *list; /* List of hidhost test cases */
 
+static struct step dummy_steps[] = {
+	{
+		.action = dummy_action,
+	},
+};
+static struct test_case hidhost_init = {
+	.step = dummy_steps,
+	.title = "Hidhost Init",
+	.step_num = get_test_case_step_num(dummy_steps),
+};
+
 struct queue *get_hidhost_tests(void)
 {
 	list = queue_new();
 
+	if (!queue_push_tail(list, &hidhost_init))
+		return NULL;
+
 	return list;
 }
 
-- 
1.9.3

