Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/client: Fix reversing send_response values
Date: Thu,  5 Jun 2014 18:32:34 +0200
Message-Id: <1401985955-13502-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We don't want to reverse data passed to send_response.
---
 android/client/if-gatt.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 0375126..a9c8644 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1750,6 +1750,30 @@ static void gatts_send_indication_p(int argc, const char *argv[])
 							len, confirm, data);
 }
 
+/*
+ * convert hex string to uint8_t array
+ */
+static int fill_buffer(const char *str, uint8_t *out, int out_size)
+{
+	int len = strlen(str);
+	int length = 0;
+	int i;
+
+	memset(out, 0, out_size);
+	if (out_size * 2 > len + 1)
+		out_size = (len + 1) / 2;
+
+	for (i = 0; i < out_size && len > length; ++i) {
+		if (len >= length)
+			sscanf(str + length, "%02hhx", &out[i]);
+		else
+			sscanf(str, "%1hhx", &out[i]);
+		length += 2;
+	}
+
+	return len/2;
+}
+
 /* send_response */
 
 static void gatts_send_response_p(int argc, const char *argv[])
@@ -1772,15 +1796,13 @@ static void gatts_send_response_p(int argc, const char *argv[])
 	data.attr_value.auth_req = 0;
 	data.attr_value.len = 0;
 
-	if (argc > 7) {
-		data.attr_value.len = strlen(argv[7]);
-		scan_field(argv[7], data.attr_value.len, data.attr_value.value,
+	if (argc > 7)
+		data.attr_value.len = fill_buffer(argv[7],
+						data.attr_value.value,
 						sizeof(data.attr_value.value));
-	}
 
 	haltest_info("conn_id %d, trans_id %d, status %d", conn_id, trans_id,
 									status);
-
 	EXEC(if_gatt->server->send_response, conn_id, trans_id, status, &data);
 }
 
-- 
1.9.0

