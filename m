Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 2/7] Bluetooth: Introduce HCI_ADVERTISING_INSTANCE setting and add AD flags
Date: Fri, 20 Mar 2015 19:48:05 -0700
Message-Id: <1426906090-9026-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906090-9026-1-git-send-email-armansito@chromium.org>
References: <1426906090-9026-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the HCI_ADVERTISING_INSTANCE setting, which is set
when an at least one advertising instance has been added using the
"Add Advertising" mgmt command. This patch also adds a macro definition
for the EIR_APPEARANCE field type.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 include/net/bluetooth/hci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 06e7eee..3acecf3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -227,6 +227,7 @@ enum {
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
 	HCI_ADVERTISING_CONNECTABLE,
+	HCI_ADVERTISING_INSTANCE,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LIMITED_DISCOVERABLE,
@@ -465,6 +466,7 @@ enum {
 #define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
 #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
+#define EIR_APPEARANCE		0x19 /* Device appearance */
 #define EIR_LE_BDADDR		0x1B /* LE Bluetooth device address */
 #define EIR_LE_ROLE		0x1C /* LE role */
 #define EIR_LE_SC_CONFIRM	0x22 /* LE SC Confirmation Value */
-- 
2.2.0.rc0.207.ga3a616c

