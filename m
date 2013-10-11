Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix endless loop with HCI_QUIRK_RESET_ON_CLOSE
Date: Fri, 11 Oct 2013 09:44:12 -0700
Message-Id: <1381509852-64080-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Really early versions of the Bluetooth specification were unclear
with the behavior of HCI Reset for USB devices. They assumed that
also an USB reset needs to be issued. Later Bluetooth specifications
cleared this out and it is safe to call HCI Reset without affecting
the transport.

For old devices that misbehave, the HCI_QUIRK_RESET_ON_CLOSE quirk
was introduced to postpone the HCI Reset until the device was no
longer in use.

One of these devices is the Digianswer BPA-105 Bluetooth Protocol
Analyzer. The only problem now is that with the quirk set, the
HCI Reset is also executed at the end of the setup phase. So the
controller gets configured and then it disconnects from the USB
bus, connects again, gets configured and of course disconnects
again. This game goes on forever.

For devices that need HCI_QUIRK_RESET_ON_CLOSE it is important
that the HCI Reset is not executed after the setup phase. In
specific when HCI_AUTO_OFF is set, do not call HCI Reset when
closing the device.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1910dc2..8f70a35 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1378,6 +1378,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags) &&
+	    !test_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
 	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_req_sync(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT);
-- 
1.8.3.1

