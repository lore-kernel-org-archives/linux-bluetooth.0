Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next] Bluetooth: fix sending LE data over USB
Date: Mon, 14 Mar 2011 18:20:33 -0300
Message-Id: <1300137633-24495-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have support for LE connections, before discarding a
frame we must check if there's a LE connection over that transport.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 drivers/bluetooth/btusb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 411ae9c..59dd4ae 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -690,7 +690,8 @@ static int btusb_send_frame(struct sk_buff *skb)
 		break;
 
 	case HCI_ACLDATA_PKT:
-		if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
+		if (!data->bulk_tx_ep || (hdev->conn_hash.acl_num < 1 &&
+						hdev->conn_hash.le_num < 1))
 			return -ENODEV;
 
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
-- 
1.7.4.1

