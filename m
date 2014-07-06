Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Clear HCI_RAW flag when controller becomes configured
Date: Sun,  6 Jul 2014 12:11:16 +0200
Message-Id: <1404641476-24971-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an unconfigured controllers reaches the configured state, it is
important to change the HCI_RAW flag. It indicates to userspace that
the controller is fully operational.

External configuration allows to bring the controller back into an
unconfigured state. In that case make sure HCI_RAW flag is set again.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 6 ++++++
 net/bluetooth/mgmt.c     | 1 +
 2 files changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eae00836b739..21ad3500eec8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2887,6 +2887,12 @@ static void hci_power_on(struct work_struct *work)
 		 */
 		mgmt_index_added(hdev);
 	} else if (test_and_clear_bit(HCI_CONFIG, &hdev->dev_flags)) {
+		/* When the controller is now configured, then it
+		 * is important to clear the HCI_RAW flag.
+		 */
+		if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+			clear_bit(HCI_RAW, &hdev->flags);
+
 		/* Powering on the controller with HCI_CONFIG set only
 		 * happens with the transition from unconfigured to
 		 * configured. This will send the Index Added event.
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9ef6f90021ad..b49d96b1e61a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5438,6 +5438,7 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 
 			queue_work(hdev->req_workqueue, &hdev->power_on);
 		} else {
+			set_bit(HCI_RAW, &hdev->flags);
 			mgmt_index_added(hdev);
 		}
 	}
-- 
1.9.3

