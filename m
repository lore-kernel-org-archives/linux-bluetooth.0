Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] android/tester: Define write types for GATT test cases
Date: Fri, 17 Oct 2014 15:38:13 +0200
Message-Id: <1413553099-19689-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gatt test cases should use defined write types.
---
 android/tester-gatt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 8b95e9c..38dd0ee 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -41,6 +41,11 @@
 #define GATT_SERVER_TRANSPORT_BREDR		0x01
 #define GATT_SERVER_TRANSPORT_LE_BREDR		0x02
 
+#define GATT_WRITE_TYPE_NO_RESPONSE	0x01
+#define GATT_WRITE_TYPE_DEFAULT		0x02
+#define GATT_WRITE_TYPE_PREPARE		0x03
+#define GATT_WRITE_TYPE_SIGNED		0x04
+
 static struct queue *list; /* List of gatt test cases */
 
 static int srvc1_handle;
@@ -368,7 +373,7 @@ static struct write_char_data write_char_data_1 = {
 	.conn_id = CONN1_ID,
 	.service = &service_1,
 	.characteristic = &characteristic_1,
-	.write_type = 1,
+	.write_type = GATT_WRITE_TYPE_NO_RESPONSE,
 	.len = sizeof(value_2),
 	.p_value = value_2,
 	.auth_req = 0
@@ -378,7 +383,7 @@ static struct write_char_data write_char_data_2 = {
 	.conn_id = CONN1_ID,
 	.service = &service_1,
 	.characteristic = &characteristic_1,
-	.write_type = 2,
+	.write_type = GATT_WRITE_TYPE_DEFAULT,
 	.len = sizeof(value_2),
 	.p_value = value_2,
 	.auth_req = 0
-- 
1.9.3

