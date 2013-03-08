Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/6] Bluetooth: Return ENODATA in hci_req_run
Date: Fri,  8 Mar 2013 11:20:14 -0300
Message-Id: <1362752418-8688-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
References: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case the HCI request queue is empty, hci_req_run should return
ENODATA instead of EINVAL. This way, hci_req_run returns a more
meaningful error value.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a3e3c96..5f625e0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2452,7 +2452,7 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 
 	/* Do not allow empty requests */
 	if (skb_queue_empty(&req->cmd_q))
-		return -EINVAL;
+		return -ENODATA;
 
 	skb = skb_peek_tail(&req->cmd_q);
 	bt_cb(skb)->req.complete = complete;
-- 
1.8.1.2

