Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_uart: Include vendor headers if required
Date: Tue, 16 Jun 2015 21:55:20 +0900
Message-id: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Vendor specific headers should be included only when enabled because
hci_uart does not need it always.

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ac87346..231c622 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -45,8 +45,12 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#ifdef CONFIG_BT_HCIUART_INTEL
 #include "btintel.h"
+#endif
+#ifdef CONFIG_BT_HCIUART_BCM
 #include "btbcm.h"
+#endif
 #include "hci_uart.h"
 
 #define VERSION "2.3"
-- 
2.1.4

