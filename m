Return-Path: <cyrus@holtmann.org>
From: Connor Hansen <cmdkhh@gmail.com>
To: marcel@holtmann.org
Cc: padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Connor Hansen <cmdkhh@gmail.com>
Subject: [PATCH] :V2 drivers/bluetooth/bpa10x.c: missing kfrees
Date: Sat, 11 Jun 2011 14:36:11 -0700
Message-Id: <1307828171-22010-1-git-send-email-cmdkhh@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

both bpa10x_submit_initr_urb() and bpa10x_submit_bulk_urb()
malloc a char buffer(buf) for usb_fill_init_usb() but fail to
free it after freeing the urb.

Likewise, bpa10x_send_frame() allocates a usb_ctrlrequest(dr)
for sending packets but does not free it after the
usb_fill_control_urb() call.

Signed-off-by: Connor Hansen <cmdkhh@gmail.com>
---
 drivers/bluetooth/bpa10x.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 751b338..0a2dd9e 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -254,6 +254,7 @@ static inline int bpa10x_submit_intr_urb(struct hci_dev *hdev)
 	}
 
 	usb_free_urb(urb);
+	kfree(buf);
 
 	return err;
 }
@@ -295,6 +296,7 @@ static inline int bpa10x_submit_bulk_urb(struct hci_dev *hdev)
 	}
 
 	usb_free_urb(urb);
+	kfree(buf);
 
 	return err;
 }
@@ -393,6 +395,7 @@ static int bpa10x_send_frame(struct sk_buff *skb)
 				skb->data, skb->len, bpa10x_tx_complete, skb);
 
 		hdev->stat.cmd_tx++;
+		kfree(dr);
 		break;
 
 	case HCI_ACLDATA_PKT:
-- 
1.7.4.4
