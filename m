Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Remove pointless inline function
Date: Sat,  5 Oct 2013 11:47:46 -0700
Message-Id: <1380998869-64411-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The inline function for BR/EDR controller AMP discover response
info is rather useless. Just include the code into the function
that builds the whole response.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6dfef73..a1aae5c 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -75,20 +75,15 @@ u8 __next_ident(struct amp_mgr *mgr)
 	return mgr->ident;
 }
 
-static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
-{
-	cl->id = AMP_ID_BREDR;
-	cl->type = AMP_TYPE_BREDR;
-	cl->status = AMP_STATUS_BLUETOOTH_ONLY;
-}
-
 /* hci_dev_list shall be locked */
 static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
 {
 	int i = 0;
 	struct hci_dev *hdev;
 
-	__a2mp_cl_bredr(cl);
+	cl[0].id = AMP_ID_BREDR;
+	cl[0].type = AMP_TYPE_BREDR;
+	cl[0].status = AMP_STATUS_BLUETOOTH_ONLY;
 
 	list_for_each_entry(hdev, &hci_dev_list, list) {
 		/* Iterate through AMP controllers */
-- 
1.8.3.1

