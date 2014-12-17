Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] android/tester: Add verification for test case list creators
Date: Wed, 17 Dec 2014 11:58:17 +0100
Message-Id: <1418813900-29056-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418813900-29056-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418813900-29056-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To be safe it must be chcecked if queue_new and add test case to list
was successful.
---
 android/tester-a2dp.c      | 7 ++++++-
 android/tester-avrcp.c     | 7 ++++++-
 android/tester-bluetooth.c | 7 ++++++-
 android/tester-gatt.c      | 7 ++++++-
 android/tester-hdp.c       | 7 ++++++-
 android/tester-hidhost.c   | 7 ++++++-
 android/tester-pan.c       | 7 ++++++-
 android/tester-socket.c    | 7 ++++++-
 8 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index eb88244..70bc356 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -237,9 +237,14 @@ struct queue *get_a2dp_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 24953a2..d33dbeb 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -585,9 +585,14 @@ struct queue *get_avrcp_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index c61b87c..746c6e5 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -1225,9 +1225,14 @@ struct queue *get_bluetooth_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 9ba2049..f1cd53b 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -3395,9 +3395,14 @@ struct queue *get_gatt_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index 7397de4..98765cf 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -550,9 +550,14 @@ struct queue *get_hdp_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index b3880b3..63cc477 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -720,9 +720,14 @@ struct queue *get_hidhost_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
diff --git a/android/tester-pan.c b/android/tester-pan.c
index 4feb6cf..331b300 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -227,9 +227,14 @@ struct queue *get_pan_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
diff --git a/android/tester-socket.c b/android/tester-socket.c
index 3b1dd54..cec5062 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -448,9 +448,14 @@ struct queue *get_socket_tests(void)
 
 	list = queue_new();
 
+	if (!list)
+		return NULL;
+
 	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
-		if (!queue_push_tail(list, &test_cases[i]))
+		if (!queue_push_tail(list, &test_cases[i])) {
+			queue_destroy(list, NULL);
 			return NULL;
+		}
 
 	return list;
 }
-- 
1.9.3

