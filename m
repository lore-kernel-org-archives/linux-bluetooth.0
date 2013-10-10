Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remote return value from hci_send_frame() function
Date: Thu, 10 Oct 2013 13:36:00 -0700
Message-Id: <1381437360-55235-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of hci_send_frame() is never checked. So just make
this function void and print an error when the hdev->send driver
callback returns a negative value.

Having the error printed is actually an improvement over the
current situation where any driver error just gets ignored.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 47cf3a9..6cc2f86 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2697,7 +2697,7 @@ int hci_unregister_cb(struct hci_cb *cb)
 }
 EXPORT_SYMBOL(hci_unregister_cb);
 
-static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	BT_DBG("%s type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
@@ -2717,7 +2717,8 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb->dev = (void *) hdev;
 
-	return hdev->send(skb);
+	if (hdev->send(skb) < 0)
+		BT_ERR("%s sending frame failed", hdev->name);
 }
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
-- 
1.8.3.1

