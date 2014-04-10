Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/gatt: Fix for scan non discoverable devices
Date: Thu, 10 Apr 2014 15:36:33 +0200
Message-Id: <1397136993-28133-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch Android framework will not be notify with non
discoverable LE devices.
---
 android/gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index a33ce25..e10324e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -41,6 +41,7 @@
 #include "src/log.h"
 #include "hal-msg.h"
 #include "utils.h"
+#include "src/eir.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "attrib/gattrib.h"
@@ -710,6 +711,7 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
 	char bda[18];
+	struct eir_data e;
 
 	if (!scanning)
 		goto connect;
@@ -717,6 +719,17 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 	ba2str(addr, bda);
 	DBG("LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi, !!eir);
 
+	if (eir_len > 0) {
+		memset(&e, 0 ,sizeof(e));
+		eir_parse(&e, eir, eir_len);
+
+		/* Check if device is discoverable. If not then just try to
+		 * connect
+		 */
+		if (!(e.flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
+			goto connect;
+	}
+
 	bdaddr2android(addr, ev->bda);
 	ev->rssi = rssi;
 	ev->len = eir_len;
-- 
1.8.4

