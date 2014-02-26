Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Remove unneeded "force" parameter from smp_distribute_keys()
Date: Wed, 26 Feb 2014 23:33:45 +0200
Message-Id: <1393450427-12438-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
References: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that to-be-received keys are properly tracked we no-longer need the
"force" parameter to smp_distribute_keys(). It was essentially acting as
an indicator whether all keys have been received, but now it's just
redundant together with smp->remote_key_dist.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |  2 +-
 net/bluetooth/smp.c        | 10 +++++-----
 net/bluetooth/smp.h        |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7bd78c5487fb..d8d990215158 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7267,7 +7267,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	if (hcon->type == LE_LINK) {
 		if (!status && encrypt)
-			smp_distribute_keys(conn, 0);
+			smp_distribute_keys(conn);
 		cancel_delayed_work(&conn->security_timer);
 	}
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1b17adfffef8..0de98fe23330 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -960,7 +960,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 			  rp->ediv, rp->rand);
 	smp->ltk = ltk;
 	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
-		smp_distribute_keys(conn, 1);
+		smp_distribute_keys(conn);
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -1018,7 +1018,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	 */
 	if (!bacmp(&info->bdaddr, BDADDR_ANY)) {
 		BT_ERR("Ignoring IRK with no identity address");
-		smp_distribute_keys(conn, 1);
+		smp_distribute_keys(conn);
 		return 0;
 	}
 
@@ -1039,7 +1039,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 
 	l2cap_conn_update_id_addr(hcon);
 
-	smp_distribute_keys(conn, 1);
+	smp_distribute_keys(conn);
 
 	return 0;
 }
@@ -1168,7 +1168,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 }
 
-int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
+int smp_distribute_keys(struct l2cap_conn *conn)
 {
 	struct smp_cmd_pairing *req, *rsp;
 	struct smp_chan *smp = conn->smp_chan;
@@ -1176,7 +1176,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	struct hci_dev *hdev = hcon->hdev;
 	__u8 *keydist;
 
-	BT_DBG("conn %p force %d", conn, force);
+	BT_DBG("conn %p", conn);
 
 	if (!test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return 0;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index f32f1212f650..1b8af35b292c 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -145,7 +145,7 @@ struct smp_chan {
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
-int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
+int smp_distribute_keys(struct l2cap_conn *conn);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
 void smp_chan_destroy(struct l2cap_conn *conn);
-- 
1.8.5.3

