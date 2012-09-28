Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: A2MP: Fix potential NULL dereference
Date: Fri, 28 Sep 2012 14:28:50 +0300
Message-Id: <1348831731-12934-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20120928012323.GG5522@localhost>
References: <20120928012323.GG5522@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Return INVALID_CTRL_ID for unknown AMP controller and for BR/EDR
controller and fixes dereference possible NULL pointer.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 61e657a..a55449e 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -278,7 +278,7 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	BT_DBG("id %d", req->id);
 
 	hdev = hci_dev_get(req->id);
-	if (!hdev) {
+	if (!hdev || hdev->dev_type != HCI_AMP) {
 		struct a2mp_info_rsp rsp;
 
 		rsp.id = req->id;
@@ -286,14 +286,16 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 		a2mp_send(mgr, A2MP_GETINFO_RSP, hdr->ident, sizeof(rsp),
 			  &rsp);
-	}
 
-	if (hdev->dev_type != HCI_BREDR) {
-		mgr->state = READ_LOC_AMP_INFO;
-		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+		goto done;
 	}
 
-	hci_dev_put(hdev);
+	mgr->state = READ_LOC_AMP_INFO;
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+
+done:
+	if (hdev)
+		hci_dev_put(hdev);
 
 	skb_pull(skb, sizeof(*req));
 	return 0;
-- 
1.7.9.5

