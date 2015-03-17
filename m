Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 1/6] Bluetooth: Introduce HCI_QUIRK_SIMULTANEOUS_DISCOVERY
Date: Mon, 16 Mar 2015 21:19:28 -0700
Message-Id: <1426565973-27545-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some controllers allow both LE scan and BR/EDR inquiry to run at
the same time, while others allow only one, LE SCAN or BR/EDR
inquiry at given time.

Since this is specific to each controller, add a new quirk setting
that allows drivers to tell the core wether given controller can
do both LE scan and BR/EDR inquiry at same time.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ce75730..9b3efc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -160,6 +160,14 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_STRICT_DUPLICATE_FILTER,
+
+	/* When this quirk is set, LE scan and BR/EDR inquiry is done
+	 * simultaneously, otherwise it's interleaved.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
 };
 
 /* HCI device flags */
-- 
2.2.0.rc0.207.ga3a616c

