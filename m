Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] android/client: Fix incorrect data parsing
Date: Mon, 25 Aug 2014 15:50:53 +0200
Message-Id: <1408974654-22836-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use fill_buffer function in processing write_characteristic
and send_indication functions.
---
 android/client/if-gatt.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 8154bfd..a4c6bc9 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1191,11 +1191,12 @@ static void write_characteristic_p(int argc, const char **argv)
 		return;
 	}
 
-	/* len in chars */
-	len = strlen(argv[6]);
-	scan_field(argv[6], len, value, sizeof(value));
-	/* len in bytes converted from ascii chars */
-	len = (len + 1) / 2;
+	if (strncmp(argv[6], "0X", 2) && strncmp(argv[6], "0x", 2)) {
+		haltest_error("Value must be hex string");
+		return;
+	}
+
+	len = fill_buffer(argv[6] + 2, value, sizeof(value));
 
 	/* auth_req */
 	if (argc > 7)
@@ -1775,7 +1776,7 @@ static void gatts_send_indication_p(int argc, const char *argv[])
 	int attr_handle;
 	int conn_id;
 	int confirm;
-	char data[200];
+	uint8_t data[200];
 	int len = 0;
 
 	RETURN_IF_NULL(if_gatt);
@@ -1791,12 +1792,16 @@ static void gatts_send_indication_p(int argc, const char *argv[])
 	confirm = atoi(argv[5]);
 
 	if (argc > 6) {
-		len = strlen(argv[6]);
-		scan_field(argv[6], len, (uint8_t *) data, sizeof(data));
+		if (strncmp(argv[6], "0X", 2) && strncmp(argv[6], "0x", 2)) {
+			haltest_error("Value must be hex string");
+			return;
+		}
+
+		len = fill_buffer(argv[6] + 2, data, sizeof(data));
 	}
 
 	EXEC(if_gatt->server->send_indication, server_if, attr_handle, conn_id,
-							len, confirm, data);
+						len, confirm, (char *) data);
 }
 
 /* send_response */
-- 
1.9.3

