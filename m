Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] Bluetooth: Add constants for LE SC Confirmation and Random values
Date: Mon, 16 Mar 2015 01:10:20 -0700
Message-Id: <1426493425-7427-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE Secure Connections Confirmation Value and LE Secure Connections
Random Value contants are required for the out-of-band data and so
just define them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index af9893b704ff..ce757303dc07 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -458,6 +458,8 @@ enum {
 #define EIR_DEVICE_ID		0x10 /* device ID */
 #define EIR_LE_BDADDR		0x1B /* LE Bluetooth device address */
 #define EIR_LE_ROLE		0x1C /* LE role */
+#define EIR_LE_SC_CONFIRM	0x22 /* LE SC Confirmation Value */
+#define EIR_LE_SC_RANDOM	0x23 /* LE SC Random Value */
 
 /* Low Energy Advertising Flags */
 #define LE_AD_LIMITED		0x01 /* Limited Discoverable */
-- 
2.1.0

