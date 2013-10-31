Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 05/10] android/client: Add helper macros to verify args
Date: Thu, 31 Oct 2013 11:45:10 +0100
Message-ID: <1383216315-30627-6-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds bunch of macros that will simplify
common arguments checking for methods.
---
 android/client/if-gatt.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 90cc805..60b1ec5 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -30,6 +30,63 @@ const btgatt_interface_t *if_gatt = NULL;
 #define MAX_READ_PARAMS_STR_LEN (MAX_SRVC_ID_STR_LEN + MAX_CHAR_ID_STR_LEN \
 		+ MAX_UUID_STR_LEN + MAX_HEX_VAL_STR_LEN + 80)
 
+#define VERIFY_INT_ARG(n, v, err) \
+	do { \
+		if (n < argc) \
+			v = atoi(argv[n]); \
+		else { \
+			haltest_error(err); \
+			return;\
+		} \
+	} while (0)
+
+#define VERIFY_HEX_ARG(n, v, err) \
+	do { \
+		if (n < argc) \
+			v = strtol(argv[n], NULL, 16); \
+		else { \
+			haltest_error(err); \
+			return;\
+		} \
+	} while (0)
+
+/* Helper macros to verify arguments of methods */
+#define VERIFY_CLIENT_IF(n, v) VERIFY_INT_ARG(n, v, "No client_if specified\n")
+#define VERIFY_SERVER_IF(n, v) VERIFY_INT_ARG(n, v, "No server_if specified\n")
+#define VERIFY_CONN_ID(n, v) VERIFY_INT_ARG(n, v, "No conn_if specified\n")
+#define VERIFY_HANDLE(n, v) VERIFY_HEX_ARG(n, v, "No "#v" specified\n")
+#define VERIFY_SERVICE_HANDLE(n, v) VERIFY_HANDLE(n, v)
+
+#define VERIFY_UUID(n, v) \
+	do { \
+		if (n < argc) \
+			gatt_str2bt_uuid_t(argv[n], -1, v); \
+		else { \
+			haltest_error("No uuid specified\n"); \
+			return;\
+		} \
+	} while (0)
+
+#define VERIFY_SRVC_ID(n, v) \
+	do { \
+		if (n < argc) \
+			str2btgatt_srvc_id_t(argv[n], v); \
+		else { \
+			haltest_error("No srvc_id specified\n"); \
+			return;\
+		} \
+	} while (0)
+
+#define VERIFY_CHAR_ID(n, v) \
+	do { \
+		if (n < argc) \
+			str2btgatt_char_id_t(argv[n], v); \
+		else { \
+			haltest_error("No char_id specified\n"); \
+			return;\
+		} \
+	} while (0)
+
 /* Gatt uses little endian uuid */
 static const char GATT_BASE_UUID[] = {
 	0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
-- 
1.7.9.5

