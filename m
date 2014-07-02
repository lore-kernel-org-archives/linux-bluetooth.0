Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/client: Fix data parsing for write descriptor
Date: Wed,  2 Jul 2014 12:34:57 +0200
Message-Id: <1404297298-28417-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix data parsing for write descriptor by using fill buffer function.
Fill buffer helper has been moved upper to be visible for write descriptor
function.
---
 android/client/if-gatt.c | 100 ++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 49 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 4b1c549..8154bfd 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -782,6 +782,51 @@ static const btgatt_callbacks_t gatt_cbacks = {
 	.server = &btgatt_server_callbacks
 };
 
+/*
+ * convert hex string to uint8_t array
+ */
+static int fill_buffer(const char *str, uint8_t *out, int out_size)
+{
+	int str_len;
+	int i, j;
+	char c;
+	uint8_t b;
+
+	str_len = strlen(str);
+
+	for (i = 0, j = 0; i < out_size && j < str_len; i++, j++) {
+		c = str[j];
+
+		if (c >= 'a' && c <= 'f')
+			c += 'A' - 'a';
+
+		if (c >= '0' && c <= '9')
+			b = c - '0';
+		else if (c >= 'A' && c <= 'F')
+			b = 10 + c - 'A';
+		else
+			return 0;
+
+		j++;
+
+		c = str[j];
+
+		if (c >= 'a' && c <= 'f')
+			c += 'A' - 'a';
+
+		if (c >= '0' && c <= '9')
+			b = b * 16 + c - '0';
+		else if (c >= 'A' && c <= 'F')
+			b = b * 16 + 10 + c - 'A';
+		else
+			return 0;
+
+		out[i] = b;
+	}
+
+	return i;
+}
+
 /* gatt client methods */
 
 /* init */
@@ -1238,10 +1283,12 @@ static void write_descriptor_p(int argc, const char **argv)
 	}
 
 	/* len in chars */
-	len = strlen(argv[7]);
-	scan_field(argv[7], len, value, sizeof(value));
-	/* len in bytes converted from ascii chars */
-	len = (len + 1) / 2;
+	if (strncmp(argv[7], "0X", 2) && strncmp(argv[7], "0x", 2)) {
+		haltest_error("Value must be hex string");
+		return;
+	}
+
+	len = fill_buffer(argv[7] + 2, value, sizeof(value));
 
 	/* auth_req */
 	if (argc > 8)
@@ -1752,51 +1799,6 @@ static void gatts_send_indication_p(int argc, const char *argv[])
 							len, confirm, data);
 }
 
-/*
- * convert hex string to uint8_t array
- */
-static int fill_buffer(const char *str, uint8_t *out, int out_size)
-{
-	int str_len;
-	int i, j;
-	char c;
-	uint8_t b;
-
-	str_len = strlen(str);
-
-	for (i = 0, j = 0; i < out_size && j < str_len; i++, j++) {
-		c = str[j];
-
-		if (c >= 'a' && c <= 'f')
-			c += 'A' - 'a';
-
-		if (c >= '0' && c <= '9')
-			b = c - '0';
-		else if (c >= 'A' && c <= 'F')
-			b = 10 + c - 'A';
-		else
-			return 0;
-
-		j++;
-
-		c = str[j];
-
-		if (c >= 'a' && c <= 'f')
-			c += 'A' - 'a';
-
-		if (c >= '0' && c <= '9')
-			b = b * 16 + c - '0';
-		else if (c >= 'A' && c <= 'F')
-			b = b * 16 + 10 + c - 'A';
-		else
-			return 0;
-
-		out[i] = b;
-	}
-
-	return i;
-}
-
 /* send_response */
 
 static void gatts_send_response_p(int argc, const char *argv[])
-- 
1.9.3

