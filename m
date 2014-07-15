Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 01/10] android/tester-ng: Use loop for adding cases to the queue
Date: Tue, 15 Jul 2014 10:24:50 +0200
Message-Id: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be simplier to add new cases.
---
 android/tester-bluetooth.c | 35 +++++++++++++++--------------------
 android/tester-gatt.c      | 11 +++++++++--
 android/tester-hidhost.c   | 11 +++++++++--
 android/tester-socket.c    | 11 +++++++++--
 4 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 56518ea..202d085 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -235,30 +235,25 @@ static struct test_case bluetooth_setprop_disctimeout_success_tc = {
 				bluetooth_setprop_disctimeout_success_steps),
 };
 
+static struct test_case *test_cases[] = {
+	&bluetooth_init,
+	&bluetooth_enable_success_tc,
+	&bluetooth_enable_success2_tc,
+	&bluetooth_disable_success_tc,
+	&bluetooth_setprop_bdname_success_tc,
+	&bluetooth_setprop_scanmode_success_tc,
+	&bluetooth_setprop_disctimeout_success_tc,
+};
+
 struct queue *get_bluetooth_tests(void)
 {
-	list = queue_new();
-
-	if (!queue_push_tail(list, &bluetooth_init))
-		return NULL;
-
-	if (!queue_push_tail(list, &bluetooth_enable_success_tc))
-		return NULL;
+	uint16_t i = 0;
 
-	if (!queue_push_tail(list, &bluetooth_enable_success2_tc))
-		return NULL;
-
-	if (!queue_push_tail(list, &bluetooth_disable_success_tc))
-		return NULL;
-
-	if (!queue_push_tail(list, &bluetooth_setprop_bdname_success_tc))
-		return NULL;
-
-	if (!queue_push_tail(list, &bluetooth_setprop_scanmode_success_tc))
-		return NULL;
+	list = queue_new();
 
-	if (!queue_push_tail(list, &bluetooth_setprop_disctimeout_success_tc))
-		return NULL;
+	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
+		if (!queue_push_tail(list, test_cases[i]))
+			return NULL;
 
 	return list;
 }
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b58886f..4a7c9b1 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -30,12 +30,19 @@ static struct test_case gatt_init = {
 	.step_num = get_test_case_step_num(dummy_steps),
 };
 
+static struct test_case *test_cases[] = {
+	&gatt_init,
+};
+
 struct queue *get_gatt_tests(void)
 {
+	uint16_t i = 0;
+
 	list = queue_new();
 
-	if (!queue_push_tail(list, &gatt_init))
-		return NULL;
+	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
+		if (!queue_push_tail(list, test_cases[i]))
+			return NULL;
 
 	return list;
 }
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 87c9452..413c6b8 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -30,12 +30,19 @@ static struct test_case hidhost_init = {
 	.step_num = get_test_case_step_num(dummy_steps),
 };
 
+static struct test_case *test_cases[] = {
+	&hidhost_init,
+};
+
 struct queue *get_hidhost_tests(void)
 {
+	uint16_t i = 0;
+
 	list = queue_new();
 
-	if (!queue_push_tail(list, &hidhost_init))
-		return NULL;
+	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
+		if (!queue_push_tail(list, test_cases[i]))
+			return NULL;
 
 	return list;
 }
diff --git a/android/tester-socket.c b/android/tester-socket.c
index 8e8b6d2..a57b324 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -30,12 +30,19 @@ static struct test_case socket_init = {
 	.step_num = get_test_case_step_num(dummy_steps),
 };
 
+static struct test_case *test_cases[] = {
+	&socket_init,
+};
+
 struct queue *get_socket_tests(void)
 {
+	uint16_t i = 0;
+
 	list = queue_new();
 
-	if (!queue_push_tail(list, &socket_init))
-		return NULL;
+	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
+		if (!queue_push_tail(list, test_cases[i]))
+			return NULL;
 
 	return list;
 }
-- 
1.9.1

