Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 28/30] Bluetooth: Define AMP controller statuses
Date: Thu, 15 Mar 2012 14:30:19 +0200
Message-Id: <1331814621-13905-29-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AMP status codes copied from Bluez patch sent by Peter Krystad
<pkrystad@codeaurora.org>.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2096898..b642038 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -60,6 +60,15 @@
 
 #define HCI_BREDR_ID	0
 
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
1.7.9.1

