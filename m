Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Filter device found events based on RSSI threshold
Date: Fri,  5 Dec 2014 10:55:56 +0100
Message-Id: <1417773359-122811-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using Start Service Discovery allows to provide a RSSI threshold. This
patch implements support for filtering out device found events based
on the provided value.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b6a0f3e6b719..1715c91dfa28 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6821,6 +6821,15 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
+	/* When using service discovery with a RSSI threshold, then check
+	 * if such a RSSI threshold is specified. If a RSSI threshold has
+	 * been specified, then all results with a RSSI smaller than the
+	 * RSSI threshold will be dropped.
+	 */
+	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
+	    rssi < hdev->discovery.rssi)
+		return;
+
 	/* Make sure that the buffer is big enough. The 5 extra bytes
 	 * are for the potential CoD field.
 	 */
-- 
1.9.3

