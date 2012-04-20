Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 19/23] Bluetooth: Define AMP controller statuses
Date: Fri, 20 Apr 2012 14:09:47 +0300
Message-Id: <1334920191-29308-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AMP status codes copied from Bluez patch sent by Peter Krystad
<pkrystad@codeaurora.org>.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 49bf231..1320c06 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -58,6 +58,18 @@
 #define HCI_BREDR	0x00
 #define HCI_AMP		0x01
 
+/* First BR/EDR Controller shall have ID = 0 */
+#define HCI_BREDR_ID	0
+
+/* AMP controller status */
+#define AMP_CTRL_POWERED_DOWN			0x00
+#define AMP_CTRL_BLUETOOTH_ONLY			0x01
+#define AMP_CTRL_NO_CAPACITY			0x02
+#define AMP_CTRL_LOW_CAPACITY			0x03
+#define AMP_CTRL_MEDIUM_CAPACITY		0x04
+#define AMP_CTRL_HIGH_CAPACITY			0x05
+#define AMP_CTRL_FULL_CAPACITY			0x06
+
 /* HCI device quirks */
 enum {
 	HCI_QUIRK_NO_RESET,
-- 
1.7.9.5

