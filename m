Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/client: Add additional support for handling hex values
Date: Thu,  5 Jun 2014 13:08:40 +0200
Message-Id: <1401966521-32270-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1401966521-32270-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1401966521-32270-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to handle properly hex values prefixed by "0x" or
"0X" as function parameter.
---
 android/client/if-gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index f6e6327..652c0f8 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -40,10 +40,11 @@ const btgatt_interface_t *if_gatt = NULL;
 #define MAX_READ_PARAMS_STR_LEN (MAX_SRVC_ID_STR_LEN + MAX_CHAR_ID_STR_LEN \
 		+ MAX_UUID_STR_LEN + MAX_HEX_VAL_STR_LEN + 80)
 
+/* Hex arguments must have "0x" or "0X" prefix */
 #define VERIFY_INT_ARG(n, v, err) \
 	do { \
 		if (n < argc) \
-			v = atoi(argv[n]); \
+			v = strtol(argv[n], NULL, 0); \
 		else { \
 			haltest_error(err); \
 			return;\
-- 
1.9.2

