Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: dan.carpenter@oracle.com,
	linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: btwilink: Fix unexpected skb free
Date: Tue, 23 May 2017 11:51:00 +0200
Message-Id: <1495533060-12855-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The caller (hci_core) still owns the skb in case of error, releasing
it inside the send function can lead to use-after-free errors.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/btwilink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index b6bb58c..85a3978 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -262,7 +262,6 @@ static int ti_st_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	pkt_type = hci_skb_pkt_type(skb);
 	len = hst->st_write(skb);
 	if (len < 0) {
-		kfree_skb(skb);
 		BT_ERR("ST write failed (%ld)", len);
 		/* Try Again, would only fail if UART has gone bad */
 		return -EAGAIN;
-- 
1.9.1
