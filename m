Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/19] android/tester-gatt: Add initial test case
Date: Thu,  3 Jul 2014 18:00:16 +0200
Message-Id: <1404403222-26911-14-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b16a844..b58886f 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -19,10 +19,24 @@
 
 static struct queue *list; /* List of gatt test cases */
 
+static struct step dummy_steps[] = {
+	{
+		.action = dummy_action,
+	},
+};
+static struct test_case gatt_init = {
+	.step = dummy_steps,
+	.title = "Socket Init",
+	.step_num = get_test_case_step_num(dummy_steps),
+};
+
 struct queue *get_gatt_tests(void)
 {
 	list = queue_new();
 
+	if (!queue_push_tail(list, &gatt_init))
+		return NULL;
+
 	return list;
 }
 
-- 
1.9.3

