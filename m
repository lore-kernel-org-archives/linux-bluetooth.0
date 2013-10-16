Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 13/15] Bluetooth: Fix background trigger/untrigger functions
Date: Wed, 16 Oct 2013 20:18:03 -0300
Message-Id: <1381965485-9159-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes to hci_trigger_background_scan() and hci_untrigger_
background_scan() so they can be called concurrently with the device
discovery procedure.

In hci_trigger_background_scan(), if it is the first trigger, we are
supposed to start the background scanning. However, if device discovery
is running, we should not send any HCI command. The background scanning
will be started once the discovery procedure is finished.

In hci_untrigger_background_scan(), if it is the last trigger, we are
supposed to stop the background scanning. However, if discovery is
running, it means the background is stopped so we don't need to send
any HCI command.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ed5ce58..ace77e3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3929,6 +3929,12 @@ int hci_trigger_background_scan(struct hci_dev *hdev)
 	if (atomic_read(&hdev->background_scan_cnt) > 0)
 		goto done;
 
+	/* If discovery is running, we should not start the background
+	 * scanning. It will be started once the discovery procedure finishes.
+	 */
+	if (hdev->discovery.state == DISCOVERY_FINDING)
+		goto done;
+
 	err = start_background_scan(hdev);
 	if (err)
 		return err;
@@ -3958,6 +3964,10 @@ int hci_untrigger_background_scan(struct hci_dev *hdev)
 	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
 		goto done;
 
+	/* If device discovery is running, don't stop scanning. */
+	if (hdev->discovery.state == DISCOVERY_FINDING)
+		goto done;
+
 	hci_req_init(&req, hdev);
 
 	memset(&cp, 0, sizeof(cp));
-- 
1.8.4

