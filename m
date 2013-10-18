Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Store local version information only during setup phase
Date: Fri, 18 Oct 2013 12:04:50 -0700
Message-Id: <1382123092-35256-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The local version information from the controller can not change
since they are static. So store them only once during setup
phase and not bother overwriting them every time this command
gets executed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c171c07..8480452 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -468,14 +468,13 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	hdev->hci_ver = rp->hci_ver;
-	hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
-	hdev->lmp_ver = rp->lmp_ver;
-	hdev->manufacturer = __le16_to_cpu(rp->manufacturer);
-	hdev->lmp_subver = __le16_to_cpu(rp->lmp_subver);
-
-	BT_DBG("%s manufacturer 0x%4.4x hci ver %d:%d", hdev->name,
-	       hdev->manufacturer, hdev->hci_ver, hdev->hci_rev);
+	if (test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		hdev->hci_ver = rp->hci_ver;
+		hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
+		hdev->lmp_ver = rp->lmp_ver;
+		hdev->manufacturer = __le16_to_cpu(rp->manufacturer);
+		hdev->lmp_subver = __le16_to_cpu(rp->lmp_subver);
+	}
 }
 
 static void hci_cc_read_local_commands(struct hci_dev *hdev,
-- 
1.8.3.1

