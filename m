Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Clear LE white list when resetting controller
Date: Wed, 29 Oct 2014 23:37:53 +0100
Message-Id: <1414622273-35237-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The internal representation of the LE white list needs to be cleared
when receiving a successful HCI_Reset command. A reset of the controller
is expected to start with an empty LE white list.

When the LE white list is not cleared on controller reset, the passive
background scanning might skip programming the remote devices. Only
changes to the LE white list are programmed when passive background
is started.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org # 3.17.x
---
 net/bluetooth/hci_event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f5704bae67a2..aa152140c3e2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -205,6 +205,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	hdev->le_scan_type = LE_SCAN_PASSIVE;
 
 	hdev->ssp_debug_mode = 0;
+
+	hci_bdaddr_list_clear(&hdev->le_white_list);
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.9.3

