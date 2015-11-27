Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove redundant check for req.cmd_q
Date: Fri, 27 Nov 2015 11:11:52 +0200
Message-Id: <1448615512-32120-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_req_run() function already checks for empty cmd_q and bails
out if necessary. Also, req.cmd_q should really be treated as private
data of the request and not accessed directly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index edf2199de4ff..f1529d7740f6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1187,8 +1187,7 @@ static void adv_timeout_expire(struct work_struct *work)
 	if (list_empty(&hdev->adv_instances))
 		__hci_req_disable_advertising(&req);
 
-	if (!skb_queue_empty(&req.cmd_q))
-		hci_req_run(&req, NULL);
+	hci_req_run(&req, NULL);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.5.0

