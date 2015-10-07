Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix interaction of HCI_QUIRK_RESET_ON_CLOSE and HCI_AUTO_OFF
Date: Thu,  8 Oct 2015 01:53:55 +0200
Message-Id: <1444262035-69957-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the controller requires the HCI Reset command to be send when
closing the transport, the HCI_AUTO_OFF needs to be accounted for. The
current code tries to actually do that, but the flag gets cleared to
early. So store its value and use it that stored value instead of
checking for a flag that is always cleared.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e75bc545b48e..43a1f2d8ffd3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1614,6 +1614,8 @@ static void hci_pend_le_actions_clear(struct hci_dev *hdev)
 
 int hci_dev_do_close(struct hci_dev *hdev)
 {
+	bool auto_off;
+
 	BT_DBG("%s %p", hdev->name, hdev);
 
 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
@@ -1669,10 +1671,10 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	if (!hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
-		if (hdev->dev_type == HCI_BREDR)
-			mgmt_powered(hdev, 0);
-	}
+	auto_off = hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF);
+
+	if (!auto_off && hdev->dev_type == HCI_BREDR)
+		mgmt_powered(hdev, 0);
 
 	hci_inquiry_cache_flush(hdev);
 	hci_pend_le_actions_clear(hdev);
@@ -1689,9 +1691,8 @@ int hci_dev_do_close(struct hci_dev *hdev)
 	/* Reset device */
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
-	if (!hci_dev_test_flag(hdev, HCI_AUTO_OFF) &&
-	    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
-	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
+	if (test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks) &&
+	    !auto_off && !hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_req_sync(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT);
 		clear_bit(HCI_INIT, &hdev->flags);
-- 
2.4.3

