Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/9] Bluetooth: Use L2CAP resume callback to call smp_distribute_keys
Date: Mon, 11 Aug 2014 22:06:36 +0300
Message-Id: <1407784004-12448-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
References: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no need to export the smp_distribute_keys() function since the
resume callback is called in the same scenario. This patch makes the
smp_notify_keys function private (at the same time moving it higher up
in smp.c to avoid forward declarations) and adds a resume callback for
SMP to call it from there instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |   6 -
 net/bluetooth/smp.c        | 380 +++++++++++++++++++++++----------------------
 net/bluetooth/smp.h        |   1 -
 3 files changed, 196 insertions(+), 191 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 40b6c06ab2c0..4de1e1827055 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7281,12 +7281,6 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p status 0x%2.2x encrypt %u", conn, status, encrypt);
 
-	if (hcon->type == LE_LINK) {
-		if (!status && encrypt)
-			smp_distribute_keys(conn);
-		cancel_delayed_work(&conn->security_timer);
-	}
-
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 744f678ac3e8..28014ad3d2d3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -575,6 +575,189 @@ static u8 smp_random(struct smp_chan *smp)
 	return 0;
 }
 
+static void smp_notify_keys(struct l2cap_conn *conn)
+{
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
+	struct smp_cmd_pairing *req = (void *) &smp->preq[1];
+	struct smp_cmd_pairing *rsp = (void *) &smp->prsp[1];
+	bool persistent;
+
+	if (smp->remote_irk) {
+		mgmt_new_irk(hdev, smp->remote_irk);
+		/* Now that user space can be considered to know the
+		 * identity address track the connection based on it
+		 * from now on.
+		 */
+		bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
+		hcon->dst_type = smp->remote_irk->addr_type;
+		l2cap_conn_update_id_addr(hcon);
+
+		/* When receiving an indentity resolving key for
+		 * a remote device that does not use a resolvable
+		 * private address, just remove the key so that
+		 * it is possible to use the controller white
+		 * list for scanning.
+		 *
+		 * Userspace will have been told to not store
+		 * this key at this point. So it is safe to
+		 * just remove it.
+		 */
+		if (!bacmp(&smp->remote_irk->rpa, BDADDR_ANY)) {
+			list_del(&smp->remote_irk->list);
+			kfree(smp->remote_irk);
+			smp->remote_irk = NULL;
+		}
+	}
+
+	/* The LTKs and CSRKs should be persistent only if both sides
+	 * had the bonding bit set in their authentication requests.
+	 */
+	persistent = !!((req->auth_req & rsp->auth_req) & SMP_AUTH_BONDING);
+
+	if (smp->csrk) {
+		smp->csrk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->csrk->bdaddr, &hcon->dst);
+		mgmt_new_csrk(hdev, smp->csrk, persistent);
+	}
+
+	if (smp->slave_csrk) {
+		smp->slave_csrk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->slave_csrk->bdaddr, &hcon->dst);
+		mgmt_new_csrk(hdev, smp->slave_csrk, persistent);
+	}
+
+	if (smp->ltk) {
+		smp->ltk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->ltk->bdaddr, &hcon->dst);
+		mgmt_new_ltk(hdev, smp->ltk, persistent);
+	}
+
+	if (smp->slave_ltk) {
+		smp->slave_ltk->bdaddr_type = hcon->dst_type;
+		bacpy(&smp->slave_ltk->bdaddr, &hcon->dst);
+		mgmt_new_ltk(hdev, smp->slave_ltk, persistent);
+	}
+}
+
+static int smp_distribute_keys(struct l2cap_conn *conn)
+{
+	struct smp_cmd_pairing *req, *rsp;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
+	__u8 *keydist;
+
+	BT_DBG("conn %p", conn);
+
+	if (!test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
+		return 0;
+
+	rsp = (void *) &smp->prsp[1];
+
+	/* The responder sends its keys first */
+	if (hcon->out && (smp->remote_key_dist & 0x07))
+		return 0;
+
+	req = (void *) &smp->preq[1];
+
+	if (hcon->out) {
+		keydist = &rsp->init_key_dist;
+		*keydist &= req->init_key_dist;
+	} else {
+		keydist = &rsp->resp_key_dist;
+		*keydist &= req->resp_key_dist;
+	}
+
+	BT_DBG("keydist 0x%x", *keydist);
+
+	if (*keydist & SMP_DIST_ENC_KEY) {
+		struct smp_cmd_encrypt_info enc;
+		struct smp_cmd_master_ident ident;
+		struct smp_ltk *ltk;
+		u8 authenticated;
+		__le16 ediv;
+		__le64 rand;
+
+		get_random_bytes(enc.ltk, sizeof(enc.ltk));
+		get_random_bytes(&ediv, sizeof(ediv));
+		get_random_bytes(&rand, sizeof(rand));
+
+		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
+
+		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
+		ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type,
+				  SMP_LTK_SLAVE, authenticated, enc.ltk,
+				  smp->enc_key_size, ediv, rand);
+		smp->slave_ltk = ltk;
+
+		ident.ediv = ediv;
+		ident.rand = rand;
+
+		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
+
+		*keydist &= ~SMP_DIST_ENC_KEY;
+	}
+
+	if (*keydist & SMP_DIST_ID_KEY) {
+		struct smp_cmd_ident_addr_info addrinfo;
+		struct smp_cmd_ident_info idinfo;
+
+		memcpy(idinfo.irk, hdev->irk, sizeof(idinfo.irk));
+
+		smp_send_cmd(conn, SMP_CMD_IDENT_INFO, sizeof(idinfo), &idinfo);
+
+		/* The hci_conn contains the local identity address
+		 * after the connection has been established.
+		 *
+		 * This is true even when the connection has been
+		 * established using a resolvable random address.
+		 */
+		bacpy(&addrinfo.bdaddr, &hcon->src);
+		addrinfo.addr_type = hcon->src_type;
+
+		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
+			     &addrinfo);
+
+		*keydist &= ~SMP_DIST_ID_KEY;
+	}
+
+	if (*keydist & SMP_DIST_SIGN) {
+		struct smp_cmd_sign_info sign;
+		struct smp_csrk *csrk;
+
+		/* Generate a new random key */
+		get_random_bytes(sign.csrk, sizeof(sign.csrk));
+
+		csrk = kzalloc(sizeof(*csrk), GFP_KERNEL);
+		if (csrk) {
+			csrk->master = 0x00;
+			memcpy(csrk->val, sign.csrk, sizeof(csrk->val));
+		}
+		smp->slave_csrk = csrk;
+
+		smp_send_cmd(conn, SMP_CMD_SIGN_INFO, sizeof(sign), &sign);
+
+		*keydist &= ~SMP_DIST_SIGN;
+	}
+
+	/* If there are still keys to be received wait for them */
+	if ((smp->remote_key_dist & 0x07))
+		return 0;
+
+	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
+	cancel_delayed_work_sync(&conn->security_timer);
+	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
+	smp_notify_keys(conn);
+
+	smp_chan_destroy(conn);
+
+	return 0;
+}
+
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
 	struct l2cap_chan *chan = conn->smp;
@@ -1294,189 +1477,6 @@ done:
 	return err;
 }
 
-static void smp_notify_keys(struct l2cap_conn *conn)
-{
-	struct l2cap_chan *chan = conn->smp;
-	struct smp_chan *smp = chan->data;
-	struct hci_conn *hcon = conn->hcon;
-	struct hci_dev *hdev = hcon->hdev;
-	struct smp_cmd_pairing *req = (void *) &smp->preq[1];
-	struct smp_cmd_pairing *rsp = (void *) &smp->prsp[1];
-	bool persistent;
-
-	if (smp->remote_irk) {
-		mgmt_new_irk(hdev, smp->remote_irk);
-		/* Now that user space can be considered to know the
-		 * identity address track the connection based on it
-		 * from now on.
-		 */
-		bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
-		hcon->dst_type = smp->remote_irk->addr_type;
-		l2cap_conn_update_id_addr(hcon);
-
-		/* When receiving an indentity resolving key for
-		 * a remote device that does not use a resolvable
-		 * private address, just remove the key so that
-		 * it is possible to use the controller white
-		 * list for scanning.
-		 *
-		 * Userspace will have been told to not store
-		 * this key at this point. So it is safe to
-		 * just remove it.
-		 */
-		if (!bacmp(&smp->remote_irk->rpa, BDADDR_ANY)) {
-			list_del(&smp->remote_irk->list);
-			kfree(smp->remote_irk);
-			smp->remote_irk = NULL;
-		}
-	}
-
-	/* The LTKs and CSRKs should be persistent only if both sides
-	 * had the bonding bit set in their authentication requests.
-	 */
-	persistent = !!((req->auth_req & rsp->auth_req) & SMP_AUTH_BONDING);
-
-	if (smp->csrk) {
-		smp->csrk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->csrk, persistent);
-	}
-
-	if (smp->slave_csrk) {
-		smp->slave_csrk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->slave_csrk->bdaddr, &hcon->dst);
-		mgmt_new_csrk(hdev, smp->slave_csrk, persistent);
-	}
-
-	if (smp->ltk) {
-		smp->ltk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->ltk, persistent);
-	}
-
-	if (smp->slave_ltk) {
-		smp->slave_ltk->bdaddr_type = hcon->dst_type;
-		bacpy(&smp->slave_ltk->bdaddr, &hcon->dst);
-		mgmt_new_ltk(hdev, smp->slave_ltk, persistent);
-	}
-}
-
-int smp_distribute_keys(struct l2cap_conn *conn)
-{
-	struct smp_cmd_pairing *req, *rsp;
-	struct l2cap_chan *chan = conn->smp;
-	struct smp_chan *smp = chan->data;
-	struct hci_conn *hcon = conn->hcon;
-	struct hci_dev *hdev = hcon->hdev;
-	__u8 *keydist;
-
-	BT_DBG("conn %p", conn);
-
-	if (!test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
-		return 0;
-
-	rsp = (void *) &smp->prsp[1];
-
-	/* The responder sends its keys first */
-	if (hcon->out && (smp->remote_key_dist & 0x07))
-		return 0;
-
-	req = (void *) &smp->preq[1];
-
-	if (hcon->out) {
-		keydist = &rsp->init_key_dist;
-		*keydist &= req->init_key_dist;
-	} else {
-		keydist = &rsp->resp_key_dist;
-		*keydist &= req->resp_key_dist;
-	}
-
-	BT_DBG("keydist 0x%x", *keydist);
-
-	if (*keydist & SMP_DIST_ENC_KEY) {
-		struct smp_cmd_encrypt_info enc;
-		struct smp_cmd_master_ident ident;
-		struct smp_ltk *ltk;
-		u8 authenticated;
-		__le16 ediv;
-		__le64 rand;
-
-		get_random_bytes(enc.ltk, sizeof(enc.ltk));
-		get_random_bytes(&ediv, sizeof(ediv));
-		get_random_bytes(&rand, sizeof(rand));
-
-		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
-
-		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
-		ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type,
-				  SMP_LTK_SLAVE, authenticated, enc.ltk,
-				  smp->enc_key_size, ediv, rand);
-		smp->slave_ltk = ltk;
-
-		ident.ediv = ediv;
-		ident.rand = rand;
-
-		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
-
-		*keydist &= ~SMP_DIST_ENC_KEY;
-	}
-
-	if (*keydist & SMP_DIST_ID_KEY) {
-		struct smp_cmd_ident_addr_info addrinfo;
-		struct smp_cmd_ident_info idinfo;
-
-		memcpy(idinfo.irk, hdev->irk, sizeof(idinfo.irk));
-
-		smp_send_cmd(conn, SMP_CMD_IDENT_INFO, sizeof(idinfo), &idinfo);
-
-		/* The hci_conn contains the local identity address
-		 * after the connection has been established.
-		 *
-		 * This is true even when the connection has been
-		 * established using a resolvable random address.
-		 */
-		bacpy(&addrinfo.bdaddr, &hcon->src);
-		addrinfo.addr_type = hcon->src_type;
-
-		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
-			     &addrinfo);
-
-		*keydist &= ~SMP_DIST_ID_KEY;
-	}
-
-	if (*keydist & SMP_DIST_SIGN) {
-		struct smp_cmd_sign_info sign;
-		struct smp_csrk *csrk;
-
-		/* Generate a new random key */
-		get_random_bytes(sign.csrk, sizeof(sign.csrk));
-
-		csrk = kzalloc(sizeof(*csrk), GFP_KERNEL);
-		if (csrk) {
-			csrk->master = 0x00;
-			memcpy(csrk->val, sign.csrk, sizeof(csrk->val));
-		}
-		smp->slave_csrk = csrk;
-
-		smp_send_cmd(conn, SMP_CMD_SIGN_INFO, sizeof(sign), &sign);
-
-		*keydist &= ~SMP_DIST_SIGN;
-	}
-
-	/* If there are still keys to be received wait for them */
-	if ((smp->remote_key_dist & 0x07))
-		return 0;
-
-	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
-	cancel_delayed_work_sync(&conn->security_timer);
-	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
-	smp_notify_keys(conn);
-
-	smp_chan_destroy(conn);
-
-	return 0;
-}
-
 static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1492,6 +1492,18 @@ static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 	l2cap_chan_put(chan);
 }
 
+static void smp_resume_cb(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct hci_conn *hcon = conn->hcon;
+
+	BT_DBG("chan %p", chan);
+
+	if (test_bit(HCI_CONN_ENCRYPT, &hcon->flags))
+		smp_distribute_keys(conn);
+	cancel_delayed_work(&conn->security_timer);
+}
+
 static void smp_ready_cb(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1524,13 +1536,13 @@ static const struct l2cap_ops smp_chan_ops = {
 	.recv			= smp_recv_cb,
 	.alloc_skb		= smp_alloc_skb_cb,
 	.teardown		= smp_teardown_cb,
+	.resume			= smp_resume_cb,
 
 	.new_connection		= l2cap_chan_no_new_connection,
 	.state_change		= l2cap_chan_no_state_change,
 	.close			= l2cap_chan_no_close,
 	.defer			= l2cap_chan_no_defer,
 	.suspend		= l2cap_chan_no_suspend,
-	.resume			= l2cap_chan_no_resume,
 	.set_shutdown		= l2cap_chan_no_set_shutdown,
 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
 	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 161ace3c3234..59a594278a85 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -126,7 +126,6 @@ enum {
 /* SMP Commands */
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
-int smp_distribute_keys(struct l2cap_conn *conn);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
 void smp_chan_destroy(struct l2cap_conn *conn);
-- 
1.9.3

