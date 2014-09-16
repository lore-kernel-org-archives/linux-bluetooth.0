Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/8] android/tester: Expose gatt-tester's pdu definition to other testers
Date: Tue, 16 Sep 2014 10:49:30 +0200
Message-Id: <1410857377-3162-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is not to reinvent this mechanism again for every tester that needs
to send raw pdu data.
---
 android/tester-a2dp.c  |  2 +-
 android/tester-avrcp.c |  2 +-
 android/tester-gatt.c  | 15 ---------------
 android/tester-main.h  | 15 +++++++++++++++
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 1b2a8ce..ab3936e 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -50,7 +50,7 @@ static const uint8_t rsp_start[] = { 0x42, 0x07 };
 static const uint8_t req_suspend[] = { 0x50, 0x09, 0x04 };
 static const uint8_t rsp_suspend[] = { 0x52, 0x09 };
 
-const struct pdu {
+const struct pdu_set {
 	const uint8_t *req;
 	size_t req_len;
 	const uint8_t *rsp;
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 07b95f5..b539e0e 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -71,7 +71,7 @@ static const uint8_t rsp_start[] = { 0x42, 0x07 };
 static const uint8_t req_suspend[] = { 0x50, 0x09, 0x04 };
 static const uint8_t rsp_suspend[] = { 0x52, 0x09 };
 
-static const struct pdu {
+static const struct pdu_set {
 	const uint8_t *req;
 	size_t req_len;
 	const uint8_t *rsp;
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index f22cdae..3b7297c 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -33,23 +33,8 @@
 #define CONN1_ID	1
 #define CONN2_ID	2
 
-#define data(args...) ((const unsigned char[]) { args })
-
-#define raw_pdu(args...)					\
-	{							\
-		.data = data(args),				\
-		.size = sizeof(data(args)),			\
-	}
-
-#define end_pdu { .data = NULL }
-
 static struct queue *list; /* List of gatt test cases */
 
-struct pdu {
-	const uint8_t *data;
-	uint16_t size;
-};
-
 static bt_uuid_t client_app_uuid = {
 	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
diff --git a/android/tester-main.h b/android/tester-main.h
index 6f59330..237242f 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -55,6 +55,21 @@
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
 
+struct pdu {
+	const uint8_t *data;
+	uint16_t size;
+};
+
+#define raw_data(args...) ((const unsigned char[]) { args })
+
+#define raw_pdu(args...)					\
+	{							\
+		.data = raw_data(args),				\
+		.size = sizeof(raw_data(args)),			\
+	}
+
+#define end_pdu { .data = NULL }
+
 #define TEST_CASE_BREDR(text, ...) { \
 		HCIEMU_TYPE_BREDR, \
 		text, \
-- 
1.9.3

