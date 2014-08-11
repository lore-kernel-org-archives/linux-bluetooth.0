Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Always call smp_distribute_keys() from a workqueue
Date: Mon, 11 Aug 2014 15:40:18 +0300
Message-Id: <1407760819-25734-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407760819-25734-1-git-send-email-johan.hedberg@gmail.com>
References: <1407760819-25734-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The smp_distribute_keys() function calls smp_notify_keys() which in turn
calls l2cap_conn_update_id_addr(). The l2cap_conn_update_id_addr()
function will iterate through all L2CAP channels for the respective
connection: lock the channel, update the address information and unlock
the channel.

Since SMP is now using l2cap_chan callbacks each callback is called with
the channel lock held. Therefore, calling l2cap_conn_update_id_addr()
would cause a deadlock calling l2cap_chan_lock() on the SMP channel.
This patch moves calling smp_distribute_keys() through a workqueue so
that it is never called from an L2CAP channel callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 161117b792c3..ae91a1cc4b6a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -46,6 +46,7 @@ enum {
 struct smp_chan {
 	struct l2cap_conn	*conn;
 	struct delayed_work	security_timer;
+	struct work_struct	distribute_work;
 
 	u8		preq[7]; /* SMP Pairing Request */
 	u8		prsp[7]; /* SMP Pairing Response */
@@ -656,11 +657,12 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 }
 
-static int smp_distribute_keys(struct l2cap_conn *conn)
+static void smp_distribute_keys(struct work_struct *work)
 {
+	struct smp_chan *smp = container_of(work, struct smp_chan,
+					    distribute_work);
 	struct smp_cmd_pairing *req, *rsp;
-	struct l2cap_chan *chan = conn->smp;
-	struct smp_chan *smp = chan->data;
+	struct l2cap_conn *conn = smp->conn;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	__u8 *keydist;
@@ -668,13 +670,13 @@ static int smp_distribute_keys(struct l2cap_conn *conn)
 	BT_DBG("conn %p", conn);
 
 	if (!test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
-		return 0;
+		return;
 
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
 	if (hcon->out && (smp->remote_key_dist & 0x07))
-		return 0;
+		return;
 
 	req = (void *) &smp->preq[1];
 
@@ -760,15 +762,13 @@ static int smp_distribute_keys(struct l2cap_conn *conn)
 
 	/* If there are still keys to be received wait for them */
 	if ((smp->remote_key_dist & 0x07))
-		return 0;
+		return;
 
 	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
 	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	smp_notify_keys(conn);
 
 	smp_chan_destroy(conn);
-
-	return 0;
 }
 
 static void smp_timeout(struct work_struct *work)
@@ -804,6 +804,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	smp->conn = conn;
 	chan->data = smp;
 
+	INIT_WORK(&smp->distribute_work, smp_distribute_keys);
 	INIT_DELAYED_WORK(&smp->security_timer, smp_timeout);
 
 	hci_conn_hold(conn->hcon);
@@ -824,6 +825,12 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 	if (!chan->data)
 		return;
 
+	if (work_pending(&smp->distribute_work)) {
+		cancel_work_sync(&smp->distribute_work);
+		if (!chan->data)
+			return;
+	}
+
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
@@ -1287,7 +1294,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 			  rp->ediv, rp->rand);
 	smp->ltk = ltk;
 	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
-		smp_distribute_keys(conn);
+		queue_work(hdev->workqueue, &smp->distribute_work);
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -1322,6 +1329,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
 	bdaddr_t rpa;
 
 	BT_DBG("");
@@ -1364,7 +1372,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 				      smp->id_addr_type, smp->irk, &rpa);
 
 distribute:
-	smp_distribute_keys(conn);
+	queue_work(hdev->workqueue, &smp->distribute_work);
 
 	hci_dev_unlock(hcon->hdev);
 
@@ -1400,7 +1408,7 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 		memcpy(csrk->val, rp->csrk, sizeof(csrk->val));
 	}
 	smp->csrk = csrk;
-	smp_distribute_keys(conn);
+	queue_work(hdev->workqueue, &smp->distribute_work);
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -1510,7 +1518,6 @@ done:
 static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 {
 	struct l2cap_conn *conn = chan->conn;
-	struct smp_chan *smp = chan->data;
 
 	BT_DBG("chan %p", chan);
 
@@ -1526,14 +1533,17 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 	struct smp_chan *smp = chan->data;
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
 
 	BT_DBG("chan %p", chan);
 
-	if (test_bit(HCI_CONN_ENCRYPT, &hcon->flags))
-		smp_distribute_keys(conn);
+	if (!smp)
+		return;
 
-	if (smp)
-		cancel_delayed_work(&smp->security_timer);
+	cancel_delayed_work(&smp->security_timer);
+
+	if (test_bit(HCI_CONN_ENCRYPT, &hcon->flags))
+		queue_work(hdev->workqueue, &smp->distribute_work);
 }
 
 static void smp_ready_cb(struct l2cap_chan *chan)
-- 
1.9.3

