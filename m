Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check status of command complete for HCI_Reset
Date: Sun,  2 Nov 2014 02:45:58 +0100
Message-Id: <1414892758-77105-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the HCI_Reset command returns, the status needs to be checked. It
is unlikely that HCI_Reset actually fails, but when it fails, it is a
bad idea to reset all values since the controller will have not reset
its values in that case.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aa152140c3e2..3dd2550b4c07 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -189,6 +189,9 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	clear_bit(HCI_RESET, &hdev->flags);
 
+	if (status)
+		return;
+
 	/* Reset all non-persistent flags */
 	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
-- 
1.9.3

