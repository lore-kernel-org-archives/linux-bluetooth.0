Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] Bluetooth: Enable support for remote IRK distribution
Date: Tue, 18 Feb 2014 10:19:36 +0200
Message-Id: <1392711577-31431-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch does the necessary changes to request the remote device to
distribute its IRK to us during the SMP pairing procedure. This includes
setting the right key distribution values in the pairing
request/response and handling of the two related SMP PDUs, i.e. Identity
Information and Identity Address Information.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 net/bluetooth/smp.h |  4 +++
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5f500b479f45..024baa789eb9 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -249,31 +249,42 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 			      struct smp_cmd_pairing *req,
 			      struct smp_cmd_pairing *rsp, __u8 authreq)
 {
-	u8 dist_keys = 0;
+	struct smp_chan *smp = conn->smp_chan;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
+	u8 local_dist = 0, remote_dist = 0;
 
 	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags)) {
-		dist_keys = SMP_DIST_ENC_KEY;
+		local_dist = SMP_DIST_ENC_KEY;
+		remote_dist = SMP_DIST_ENC_KEY;
 		authreq |= SMP_AUTH_BONDING;
 	} else {
 		authreq &= ~SMP_AUTH_BONDING;
 	}
 
+	if (test_bit(HCI_RPA_RESOLVING, &hdev->dev_flags))
+		remote_dist |= SMP_DIST_ID_KEY;
+
 	if (rsp == NULL) {
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = SMP_OOB_NOT_PRESENT;
 		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-		req->init_key_dist = dist_keys;
-		req->resp_key_dist = dist_keys;
+		req->init_key_dist = local_dist;
+		req->resp_key_dist = remote_dist;
 		req->auth_req = (authreq & AUTH_REQ_MASK);
+
+		smp->remote_key_dist = remote_dist;
 		return;
 	}
 
 	rsp->io_capability = conn->hcon->io_capability;
 	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
 	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
-	rsp->init_key_dist = req->init_key_dist & dist_keys;
-	rsp->resp_key_dist = req->resp_key_dist & dist_keys;
+	rsp->init_key_dist = req->init_key_dist & remote_dist;
+	rsp->resp_key_dist = req->resp_key_dist & local_dist;
 	rsp->auth_req = (authreq & AUTH_REQ_MASK);
+
+	smp->remote_key_dist = rsp->init_key_dist;
 }
 
 static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
@@ -907,12 +918,61 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	hci_add_ltk(hdev, &hcon->dst, hcon->dst_type, HCI_SMP_LTK, 1,
 		    authenticated, smp->tk, smp->enc_key_size,
 		    rp->ediv, rp->rand);
-	smp_distribute_keys(conn, 1);
+	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
+		smp_distribute_keys(conn, 1);
 	hci_dev_unlock(hdev);
 
 	return 0;
 }
 
+static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_ident_info *info = (void *) skb->data;
+	struct smp_chan *smp = conn->smp_chan;
+
+	BT_DBG("");
+
+	if (skb->len < sizeof(*info))
+		return SMP_UNSPECIFIED;
+
+	skb_pull(skb, sizeof(*info));
+
+	memcpy(smp->irk, info->irk, 16);
+
+	return 0;
+}
+
+static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
+				   struct sk_buff *skb)
+{
+	struct smp_cmd_ident_addr_info *info = (void *) skb->data;
+	struct smp_chan *smp = conn->smp_chan;
+	struct hci_conn *hcon = conn->hcon;
+	bdaddr_t rpa;
+
+	BT_DBG("");
+
+	if (skb->len < sizeof(*info))
+		return SMP_UNSPECIFIED;
+
+	skb_pull(skb, sizeof(*info));
+
+	bacpy(&smp->id_addr, &info->bdaddr);
+	smp->id_addr_type = info->addr_type;
+
+	if (hci_bdaddr_is_rpa(&hcon->dst, hcon->dst_type))
+		bacpy(&rpa, &hcon->dst);
+	else
+		bacpy(&rpa, BDADDR_ANY);
+
+	hci_add_irk(conn->hcon->hdev, &smp->id_addr, smp->id_addr_type,
+		    smp->irk, &rpa);
+
+	smp_distribute_keys(conn, 1);
+
+	return 0;
+}
+
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
@@ -987,7 +1047,13 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case SMP_CMD_IDENT_INFO:
+		reason = smp_cmd_ident_info(conn, skb);
+		break;
+
 	case SMP_CMD_IDENT_ADDR_INFO:
+		reason = smp_cmd_ident_addr_info(conn, skb);
+		break;
+
 	case SMP_CMD_SIGN_INFO:
 		/* Just ignored */
 		reason = 0;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 950d039c2ea2..4f373bc56ad7 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -128,6 +128,10 @@ struct smp_chan {
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
 	u8		enc_key_size;
+	u8		remote_key_dist;
+	bdaddr_t	id_addr;
+	u8		id_addr_type;
+	u8		irk[16];
 	unsigned long	smp_flags;
 	struct crypto_blkcipher	*tfm;
 	struct work_struct confirm;
-- 
1.8.5.3

