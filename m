Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [RFC 2/4] Bluetooth: Add HCI_PINQUIRY to dev_flags
Date: Mon, 19 Mar 2012 23:32:50 -0300
Message-Id: <1332210772-13806-3-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the HCI_PINQUIRY flag to dev_flags. This flag tracks
if periodic inquiry is enabled or not.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_event.c   |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d74645e..b3e89bf 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -102,6 +102,7 @@ enum {
 	HCI_DISCOVERABLE,
 	HCI_LINK_SECURITY,
 	HCI_PENDING_CLASS,
+	HCI_PINQUIRY,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index af0c5a2..4d13843 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -75,6 +75,11 @@ static void hci_cc_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	if (status)
+		return;
+
+	set_bit(HCI_PINQUIRY, &hdev->dev_flags);
 }
 
 static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
@@ -86,6 +91,8 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
+	clear_bit(HCI_PINQUIRY, &hdev->dev_flags);
+
 	hci_conn_check_pending(hdev);
 }
 
@@ -200,7 +207,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
 	/* Reset all non-persistent flags */
-	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS));
+	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS) |
+							BIT(HCI_PINQUIRY));
 
 	hdev->discovery.state = DISCOVERY_STOPPED;
 }
-- 
1.7.9.4

