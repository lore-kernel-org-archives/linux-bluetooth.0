Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check for non BR/EDR controller in AMP discover response
Date: Sat,  5 Oct 2013 13:57:53 -0700
Message-Id: <1381006673-14570-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Within the AMP discover response, all controllers that are not the
primary BR/EDR controller are valid.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5278a65..9410e27 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -206,7 +206,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 		BT_DBG("Remote AMP id %d type %d status %d", cl->id, cl->type,
 		       cl->status);
 
-		if (cl->id != AMP_ID_BREDR && cl->type == HCI_AMP) {
+		if (cl->id != AMP_ID_BREDR && cl->type != AMP_TYPE_BREDR) {
 			struct a2mp_info_req req;
 
 			found = true;
-- 
1.8.3.1

