Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] android/client: Allow zero length responses
Date: Wed, 28 May 2014 11:19:06 +0200
Message-Id: <1401268747-21901-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 252e89d..0375126 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1772,15 +1772,11 @@ static void gatts_send_response_p(int argc, const char *argv[])
 	data.attr_value.auth_req = 0;
 	data.attr_value.len = 0;
 
-	if (argc <= 7) {
-		haltest_error("No data specified\n");
-		return;
-	}
-
-	data.attr_value.len = strlen(argv[7]);
-	scan_field(argv[7], data.attr_value.len, data.attr_value.value,
+	if (argc > 7) {
+		data.attr_value.len = strlen(argv[7]);
+		scan_field(argv[7], data.attr_value.len, data.attr_value.value,
 						sizeof(data.attr_value.value));
-
+	}
 
 	haltest_info("conn_id %d, trans_id %d, status %d", conn_id, trans_id,
 									status);
-- 
1.9.3

