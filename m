Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Check if hex string is byte format
Date: Fri,  5 Sep 2014 15:55:41 +0200
Message-Id: <1409925341-32033-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data strings should be byte format.
---
 android/client/if-gatt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index c8352b5..0dee225 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -114,11 +114,17 @@ const btgatt_interface_t *if_gatt = NULL;
 
 #define GET_VERIFY_HEX_STRING(n, v, l) \
 	do { \
+		int ll;\
 		if (n[0] != '0' || (n[1] != 'X' && n[1] != 'x')) { \
 			haltest_error("Value must be hex string\n"); \
 			return; \
 		} \
-		l = fill_buffer(n + 2, (uint8_t *) v, sizeof(v)); \
+		ll = fill_buffer(n + 2, (uint8_t *) v, sizeof(v)); \
+		if (ll < 0) { \
+			haltest_error("Value must be byte hex string\n"); \
+			return; \
+		} \
+		l = ll; \
 	} while (0)
 
 /* Gatt uses little endian uuid */
@@ -803,6 +809,10 @@ static int fill_buffer(const char *str, uint8_t *out, int out_size)
 
 	str_len = strlen(str);
 
+	/* Hex string must be byte format */
+	if (str_len%2 != 0)
+		return -1;
+
 	for (i = 0, j = 0; i < out_size && j < str_len; i++, j++) {
 		c = str[j];
 
-- 
1.9.3

