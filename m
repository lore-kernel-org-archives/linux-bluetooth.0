Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Remove l2cap_conn->src and l2cap_conn->dst usage from SMP
Date: Sun, 13 Oct 2013 02:23:39 -0700
Message-Id: <1381656221-9821-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The l2cap_conn->src and l2cap_conn->dst addresses are just a pointer
to hci_conn->hdev->bdaddr and hci_conn->dst structures. Use the data
provided by hci_conn directly. This is done for hci_conn->dst_type
already anyway and with this change it makes it a lot clearer were
the address information comes from.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9272094..06a082ea 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -266,13 +266,13 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 								&reason);
 
-	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
-	mgmt_auth_failed(conn->hcon->hdev, conn->dst, hcon->type,
-			 hcon->dst_type, HCI_ERROR_AUTH_FAILURE);
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags);
+	mgmt_auth_failed(hcon->hdev, &hcon->dst, hcon->type, hcon->dst_type,
+			 HCI_ERROR_AUTH_FAILURE);
 
 	cancel_delayed_work_sync(&conn->security_timer);
 
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		smp_chan_destroy(conn);
 }
 
@@ -355,10 +355,10 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	hci_dev_lock(hcon->hdev);
 
 	if (method == REQ_PASSKEY)
-		ret = mgmt_user_passkey_request(hcon->hdev, conn->dst,
+		ret = mgmt_user_passkey_request(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type);
 	else
-		ret = mgmt_user_confirm_request(hcon->hdev, conn->dst,
+		ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type,
 						cpu_to_le32(passkey), 0);
 
@@ -388,11 +388,12 @@ static void confirm_work(struct work_struct *work)
 
 	if (conn->hcon->out)
 		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
-			     conn->src, conn->hcon->dst_type, conn->dst, res);
+			     &conn->hcon->hdev->bdaddr, conn->hcon->dst_type,
+			     &conn->hcon->dst, res);
 	else
 		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
-			     conn->hcon->dst_type, conn->dst, 0, conn->src,
-			     res);
+			     conn->hcon->dst_type, &conn->hcon->dst, 0,
+			     &conn->hcon->hdev->bdaddr, res);
 	if (ret) {
 		reason = SMP_UNSPECIFIED;
 		goto error;
@@ -427,10 +428,12 @@ static void random_work(struct work_struct *work)
 
 	if (hcon->out)
 		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp, 0,
-			     conn->src, hcon->dst_type, conn->dst, res);
+			     &hcon->hdev->bdaddr, hcon->dst_type, &hcon->dst,
+			     res);
 	else
 		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
-			     hcon->dst_type, conn->dst, 0, conn->src, res);
+			     hcon->dst_type, &hcon->dst, 0, &hcon->hdev->bdaddr,
+			     res);
 	if (ret) {
 		reason = SMP_UNSPECIFIED;
 		goto error;
@@ -480,7 +483,7 @@ static void random_work(struct work_struct *work)
 		memset(stk + smp->enc_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
-		hci_add_ltk(hcon->hdev, conn->dst, hcon->dst_type,
+		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
 			    HCI_SMP_STK_SLAVE, 0, 0, stk, smp->enc_key_size,
 			    ediv, rand);
 	}
@@ -715,7 +718,7 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
 
-	key = hci_find_ltk_by_addr(hcon->hdev, conn->dst, hcon->dst_type);
+	key = hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type);
 	if (!key)
 		return 0;
 
@@ -836,9 +839,9 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
-	authenticated = (conn->hcon->sec_level == BT_SECURITY_HIGH);
-	hci_add_ltk(conn->hcon->hdev, conn->dst, hcon->dst_type,
-		    HCI_SMP_LTK, 1, authenticated, smp->tk, smp->enc_key_size,
+	authenticated = (hcon->sec_level == BT_SECURITY_HIGH);
+	hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, HCI_SMP_LTK, 1,
+		    authenticated, smp->tk, smp->enc_key_size,
 		    rp->ediv, rp->rand);
 	smp_distribute_keys(conn, 1);
 	hci_dev_unlock(hdev);
@@ -986,7 +989,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
-		hci_add_ltk(conn->hcon->hdev, conn->dst, hcon->dst_type,
+		hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
 			    HCI_SMP_LTK_SLAVE, 1, authenticated,
 			    enc.ltk, smp->enc_key_size, ediv, ident.rand);
 
@@ -1008,7 +1011,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		/* Just public address */
 		memset(&addrinfo, 0, sizeof(addrinfo));
-		bacpy(&addrinfo.bdaddr, conn->src);
+		bacpy(&addrinfo.bdaddr, &conn->hcon->hdev->bdaddr);
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
 								&addrinfo);
-- 
1.8.3.1

