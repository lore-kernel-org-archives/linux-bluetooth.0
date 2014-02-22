Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/15] Bluetooth: Add helper variables to smp_distribute_keys()
Date: Sat, 22 Feb 2014 19:06:31 +0200
Message-Id: <1393088805-28658-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch a couple of helper variables to the smp_distribute_keys
function in order to avoid long chains of dereferences and thereby help
readability.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f06068072bdd..6355a460e9d0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1132,22 +1132,24 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 {
 	struct smp_cmd_pairing *req, *rsp;
 	struct smp_chan *smp = conn->smp_chan;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
 	__u8 *keydist;
 
 	BT_DBG("conn %p force %d", conn, force);
 
-	if (!test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
+	if (!test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return 0;
 
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (!force && conn->hcon->out && (rsp->resp_key_dist & 0x07))
+	if (!force && hcon->out && (rsp->resp_key_dist & 0x07))
 		return 0;
 
 	req = (void *) &smp->preq[1];
 
-	if (conn->hcon->out) {
+	if (hcon->out) {
 		keydist = &rsp->init_key_dist;
 		*keydist &= req->init_key_dist;
 	} else {
@@ -1160,7 +1162,6 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	if (*keydist & SMP_DIST_ENC_KEY) {
 		struct smp_cmd_encrypt_info enc;
 		struct smp_cmd_master_ident ident;
-		struct hci_conn *hcon = conn->hcon;
 		struct smp_ltk *ltk;
 		u8 authenticated;
 		__le16 ediv;
@@ -1172,7 +1173,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
-		ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
+		ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type,
 				  HCI_SMP_LTK_SLAVE, authenticated, enc.ltk,
 				  smp->enc_key_size, ediv, ident.rand);
 		smp->slave_ltk = ltk;
@@ -1195,7 +1196,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		/* Just public address */
 		memset(&addrinfo, 0, sizeof(addrinfo));
-		bacpy(&addrinfo.bdaddr, &conn->hcon->src);
+		bacpy(&addrinfo.bdaddr, &hcon->src);
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
 			     &addrinfo);
@@ -1214,8 +1215,8 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		*keydist &= ~SMP_DIST_SIGN;
 	}
 
-	if (conn->hcon->out || force || !(rsp->init_key_dist & 0x07)) {
-		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
+	if (hcon->out || force || !(rsp->init_key_dist & 0x07)) {
+		clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
 		cancel_delayed_work_sync(&conn->security_timer);
 		set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
 		smp_notify_keys(conn);
-- 
1.8.5.3

