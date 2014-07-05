Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Store Bluetooth address from controller setup
Date: Sat,  5 Jul 2014 10:48:03 +0200
Message-Id: <1404550083-29418-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During the setup phase of a controller, the Bluetooth address will be
read and to have that original address available for later use, store
it as setup address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_event.c        | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1cae4d3a629d..aff285698c85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -171,6 +171,7 @@ struct hci_dev {
 	__u8		bus;
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
+	bdaddr_t	setup_addr;
 	bdaddr_t	public_addr;
 	bdaddr_t	random_addr;
 	bdaddr_t	static_addr;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 013c371d3c87..c2ba79c8fe51 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -645,8 +645,14 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (!rp->status)
+	if (rp->status)
+		return;
+
+	if (test_bit(HCI_INIT, &hdev->flags))
 		bacpy(&hdev->bdaddr, &rp->bdaddr);
+
+	if (test_bit(HCI_SETUP, &hdev->dev_flags))
+		bacpy(&hdev->setup_addr, &rp->bdaddr);
 }
 
 static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
-- 
1.9.3

