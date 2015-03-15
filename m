Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add defines for LE Bluetooth Device Address and LE Role
Date: Sat, 14 Mar 2015 22:43:18 -0700
Message-Id: <1426398199-11977-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The OOB data requires to include LE Bluetooth Device Address and LE Role
and so add the type constants for these fields.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f41c7741e76..af9893b704ff 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -456,6 +456,8 @@ enum {
 #define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
 #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
+#define EIR_LE_BDADDR		0x1B /* LE Bluetooth device address */
+#define EIR_LE_ROLE		0x1C /* LE role */
 
 /* Low Energy Advertising Flags */
 #define LE_AD_LIMITED		0x01 /* Limited Discoverable */
-- 
2.1.0

