Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/client: Add Android 5.0 new value verifiers for gatt client
Date: Thu, 20 Nov 2014 16:34:02 +0100
Message-Id: <1416497645-6313-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416497645-6313-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-gatt.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 9d6fafd..c412d58 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -73,6 +73,68 @@ const btgatt_interface_t *if_gatt = NULL;
 #define VERIFY_STATUS(n, v) VERIFY_INT_ARG(n, v, "No status specified\n")
 #define VERIFY_OFFSET(n, v) VERIFY_INT_ARG(n, v, "No offset specified\n")
 #define VERIFY_TEST_ARG(n, v) VERIFY_INT_ARG(n, v, "No test arg specified\n")
+#define VERIFY_ACTION(n, v) VERIFY_INT_ARG(n, v, "No action specified\n")
+#define VERIFY_FILT_TYPE(n, v) VERIFY_INT_ARG(n, v, "No filter specified\n")
+#define VERIFY_FILT_INDEX(n, v) VERIFY_INT_ARG(n, v, \
+						"No filter index specified\n")
+#define VERIFY_FEAT_SELN(n, v) VERIFY_INT_ARG(n, v, "No feat seln specified\n")
+#define VERIFY_LIST_LOGIC_TYPE(n, v) VERIFY_INT_ARG(n, v, \
+					"No list logic type specified\n")
+#define VERIFY_FILT_LOGIC_TYPE(n, v) VERIFY_INT_ARG(n, v, \
+					"No filt logic type specified\n")
+#define VERIFY_RSSI_HI_THR(n, v) VERIFY_INT_ARG(n, v, \
+					"No rssi hi threshold specified\n")
+#define VERIFY_RSSI_LOW_THR(n, v) VERIFY_INT_ARG(n, v, \
+						"No low threshold specified\n")
+#define VERIFY_DELY_MODE(n, v) VERIFY_INT_ARG(n, v, "No delay mode specified\n")
+#define VERIFY_FND_TIME(n, v) VERIFY_INT_ARG(n, v, "No found time specified\n")
+#define VERIFY_LOST_TIME(n, v) VERIFY_INT_ARG(n, v, "No lost time specified\n")
+#define VERIFY_FND_TIME_CNT(n, v) VERIFY_INT_ARG(n, v, \
+					"No found timer counter specified\n")
+#define VERIFY_COMP_ID(n, v) VERIFY_INT_ARG(n, v, "No company id specified\n")
+#define VERIFY_COMP_ID_MASK(n, v) VERIFY_INT_ARG(n, v, \
+						"No comp. id mask specified\n")
+#define VERIFY_DATA_LEN(n, v) VERIFY_INT_ARG(n, v, "No data len specified\n")
+#define VERIFY_MASK_LEN(n, v) VERIFY_INT_ARG(n, v, "No mask len specified\n")
+#define VERIFY_MIN_INTERVAL(n, v) VERIFY_INT_ARG(n, v, \
+						"No min interval specified\n")
+#define VERIFY_MAX_INTERVAL(n, v) VERIFY_INT_ARG(n, v, \
+						"No max interval specified\n")
+#define VERIFY_APPEARANCE(n, v) VERIFY_INT_ARG(n, v, "No apperance specified\n")
+#define VERIFY_MANUFACTURER_LEN(n, v) VERIFY_INT_ARG(n, v, \
+					"No manufacturer len specified\n")
+#define VERIFY_SERVICE_DATA_LEN(n, v) VERIFY_INT_ARG(n, v, \
+					"No service data len specified\n")
+#define VERIFY_SERVICE_UUID_LEN(n, v) VERIFY_INT_ARG(n, v, \
+					"No service uuid len specified\n")
+#define VERIFY_MTU(n, v) VERIFY_INT_ARG(n, v, "No mtu specified\n")
+#define VERIFY_LATENCY(n, v) VERIFY_INT_ARG(n, v, \
+						"No latency specified\n")
+#define VERIFY_TIMEOUT(n, v) VERIFY_INT_ARG(n, v, "No timeout specified\n")
+#define VERIFY_SCAN_INTERVAL(n, v) VERIFY_INT_ARG(n, v, \
+						"No scan interval specified\n")
+#define VERIFY_SCAN_WINDOW(n, v) VERIFY_INT_ARG(n, v, \
+						"No scan window specified\n")
+#define VERIFY_ADV_TYPE(n, v) VERIFY_INT_ARG(n, v, \
+					"No advertising type specified\n")
+#define VERIFY_CHNL_MAP(n, v) VERIFY_INT_ARG(n, v, \
+						"No channel map specified\n")
+#define VERIFY_TX_POWER(n, v) VERIFY_INT_ARG(n, v, \
+						"No tx power specified\n")
+#define VERIFY_TIMEOUT_S(n, v) VERIFY_INT_ARG(n, v, \
+						"No timeout in sec specified\n")
+#define VERIFY_BATCH_SCAN_FULL_MAX(n, v) VERIFY_INT_ARG(n, v, \
+					"No batch scan full max specified\n")
+#define VERIFY_BATCH_SCAN_TRUNC_MAX(n, v) VERIFY_INT_ARG(n, v, \
+					"No batch scan trunc max specified\n")
+#define VERIFY_BATCH_SCAN_NOTIFY_THR(n, v) VERIFY_INT_ARG(n, v, \
+				"No batch scan notify threshold specified\n")
+#define VERIFY_SCAN_MODE(n, v) VERIFY_INT_ARG(n, v, \
+						"No scan mode specified\n")
+#define VERIFY_ADDR_TYPE(n, v) VERIFY_INT_ARG(n, v, \
+						"No address type specified\n")
+#define VERIFY_DISCARD_RULE(n, v) VERIFY_INT_ARG(n, v, \
+						"No discard rule specified\n")
 #define VERIFY_HANDLE(n, v) VERIFY_HEX_ARG(n, v, "No "#v" specified\n")
 #define VERIFY_SERVICE_HANDLE(n, v) VERIFY_HANDLE(n, v)
 
-- 
1.9.3

