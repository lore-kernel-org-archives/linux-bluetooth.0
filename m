Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: use buffer priority to mark URB_ISO_ASAP flag
Date: Tue,  1 Nov 2011 10:59:02 +0200
Message-Id: <1320137942-25780-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
References: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index abfc4ee..9db2476 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -727,6 +727,9 @@ static int btusb_send_frame(struct sk_buff *skb)
 		usb_fill_bulk_urb(urb, data->udev, pipe,
 				skb->data, skb->len, btusb_tx_complete, skb);
 
+		if (skb->priority >= HCI_PRIO_MAX - 1)
+			urb->transfer_flags  = URB_ISO_ASAP;
+
 		hdev->stat.acl_tx++;
 		break;
 
-- 
1.7.6.4

