Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/client: Fix reversing send_response values
Date: Fri,  6 Jun 2014 10:35:51 +0200
Message-Id: <1402043752-11390-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add function to parse hex string to uint8_t array and use it in
send_response command.
---
 android/client/if-gatt.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 178770d..4b1c549 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1752,6 +1752,51 @@ static void gatts_send_indication_p(int argc, const char *argv[])
 							len, confirm, data);
 }
 
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
 /* send_response */
 
 static void gatts_send_response_p(int argc, const char *argv[])
@@ -1775,9 +1820,21 @@ static void gatts_send_response_p(int argc, const char *argv[])
 	data.attr_value.len = 0;
 
 	if (argc > 7) {
-		data.attr_value.len = strlen(argv[7]);
-		scan_field(argv[7], data.attr_value.len, data.attr_value.value,
+		const char *str;
+
+		if (strncmp(argv[7], "0X", 2) && strncmp(argv[7], "0x", 2)) {
+			haltest_error("Value must be hex string");
+			return;
+		}
+
+		str = argv[7] + 2;
+
+		data.attr_value.len = fill_buffer(str, data.attr_value.value,
 						sizeof(data.attr_value.value));
+		if (data.attr_value.len == 0) {
+			haltest_error("Failed to parse response value");
+			return;
+		}
 	}
 
 	haltest_info("conn_id %d, trans_id %d, status %d", conn_id, trans_id,
-- 
1.9.3

