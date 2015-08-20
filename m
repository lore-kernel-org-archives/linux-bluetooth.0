Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix error handling in the function a2mp_getinfo_req
Date: Wed, 19 Aug 2015 21:51:33 -0400
Message-Id: <1440035493-22298-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error handling in the function a2mp_getinfo_req by
assigning the return value of the internal call to the function
hci_send_cmd to a new variable, err and returning this value
at the end of this function's body as we need to cleanup allocated
resources used by this function before signaling to the caller
that a internal failure has occurred that is required to be handled
by the caller of the function a2mp_getinfo_req.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/a2mp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5a04eb1..d230a38 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -291,6 +291,7 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 {
 	struct a2mp_info_req *req  = (void *) skb->data;
 	struct hci_dev *hdev;
+	int err;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -311,14 +312,14 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	}
 
 	set_bit(READ_LOC_AMP_INFO, &mgr->state);
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+	err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
 
 done:
 	if (hdev)
 		hci_dev_put(hdev);
 
 	skb_pull(skb, sizeof(*req));
-	return 0;
+	return err;
 }
 
 static int a2mp_getinfo_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
-- 
2.1.4
