Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: LE support for MGMT stop discovery
Date: Thu, 15 Mar 2012 16:52:08 -0300
Message-Id: <1331841128-1396-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
References: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds LE support to MGMT stop discovery command. So,
now we are able to cancel LE discovery procedures (LE-only and
interleaved).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |    6 +++++-
 net/bluetooth/mgmt.c      |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66ffe45..3efb033 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1092,8 +1092,12 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		break;
 
 	case LE_SCANNING_DISABLED:
-		if (status)
+		if (status) {
+			hci_dev_lock(hdev);
+			mgmt_stop_discovery_failed(hdev, status);
+			hci_dev_unlock(hdev);
 			return;
+		}
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 97b5b6c..eeb656d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2382,7 +2382,11 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (hdev->discovery.state == DISCOVERY_FINDING) {
-		err = hci_cancel_inquiry(hdev);
+		if (test_bit(HCI_INQUIRY, &hdev->flags))
+			err = hci_cancel_inquiry(hdev);
+		else
+			err = hci_cancel_le_scan(hdev);
+
 		if (err < 0)
 			mgmt_pending_remove(cmd);
 		else
-- 
1.7.9.4

