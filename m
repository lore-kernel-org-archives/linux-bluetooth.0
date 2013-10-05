Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Bluetooth: Remove check for number of AMP controller
Date: Sat,  5 Oct 2013 11:47:47 -0700
Message-Id: <1380998869-64411-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The number of controllers for the AMP discover response has already
been calculated. And since the hci_dev_list lock is held, it can not
change. So there is no need for any extra checks.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a1aae5c..529789d 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -76,7 +76,7 @@ u8 __next_ident(struct amp_mgr *mgr)
 }
 
 /* hci_dev_list shall be locked */
-static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
+static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl)
 {
 	int i = 0;
 	struct hci_dev *hdev;
@@ -91,8 +91,7 @@ static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
 			continue;
 
 		/* Starting from second entry */
-		if (++i >= num_ctrl)
-			return;
+		++i;
 
 		cl[i].id = hdev->id;
 		cl[i].type = hdev->amp_type;
@@ -166,7 +165,7 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	rsp->mtu = __constant_cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
 	rsp->ext_feat = 0;
 
-	__a2mp_add_cl(mgr, rsp->cl, num_ctrl);
+	__a2mp_add_cl(mgr, rsp->cl);
 
 	read_unlock(&hci_dev_list_lock);
 
-- 
1.8.3.1

