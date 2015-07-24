Return-Path: <cyrus@holtmann.org>
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 2317/2317] Staging : bluetooth Trailing whitespaces
Date: Fri, 24 Jul 2015 23:20:46 +0530
Message-Id: <1437760246-12177-1-git-send-email-shraddha.6596@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes trailing whitespaces in the file bfusb.c

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/bluetooth/bfusb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index fcfb72e..68c2717 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -148,8 +148,7 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
-		BT_ERR("%s bulk tx submit failed urb %p err %d", 
-					data->hdev->name, urb, err);
+		BT_ERR("%s bulk tx submit failed urb %p err %d", data->hdev->name, urb, err);
 		skb_unlink(skb, &data->pending_q);
 		usb_free_urb(urb);
 	} else
-- 
2.1.0
