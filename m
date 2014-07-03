Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/19] android/tester-socket: Add initial test case
Date: Thu,  3 Jul 2014 18:00:12 +0200
Message-Id: <1404403222-26911-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is patch with initial test case testing setup for socket hal test
cases.
---
 android/tester-socket.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index 4b06b15..8e8b6d2 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -19,10 +19,24 @@
 
 static struct queue *list; /* List of socket test cases */
 
+static struct step dummy_steps[] = {
+	{
+		.action = dummy_action,
+	},
+};
+static struct test_case socket_init = {
+	.step = dummy_steps,
+	.title = "Socket Init",
+	.step_num = get_test_case_step_num(dummy_steps),
+};
+
 struct queue *get_socket_tests(void)
 {
 	list = queue_new();
 
+	if (!queue_push_tail(list, &socket_init))
+		return NULL;
+
 	return list;
 }
 
-- 
1.9.3

