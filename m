Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/8] Bluetooth: Remove unnecessary deferred work for SMP key distribution
Date: Fri,  5 Sep 2014 22:19:51 +0300
Message-Id: <1409944795-21916-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409944795-21916-1-git-send-email-johan.hedberg@gmail.com>
References: <1409944795-21916-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the identity address update happens through its own deferred
work there's no need to have smp_distribute_keys anymore behind a second
deferred work. This patch removes this extra construction and makes the
code do direct calls to smp_distribute_keys() again.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 795c603bed30..0b4403f3dce1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -46,7 +46,6 @@ enum {
 struct smp_chan {
 	struct l2cap_conn	*conn;
 	struct delayed_work	security_timer;
-	struct work_struct	distribute_work;
 
 	u8		preq[7]; /* SMP Pairing Request */
 	u8		prsp[7]; /* SMP Pairing Response */
@@ -375,12 +374,6 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 
 	cancel_delayed_work_sync(&smp->security_timer);
 
-	if (work_pending(&smp->distribute_work)) {
-		cancel_work_sync(&smp->distribute_work);
-		if (!chan->data)
-			return;
-	}
-
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
@@ -703,10 +696,8 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 }
 
-static void smp_distribute_keys(struct work_struct *work)
+static void smp_distribute_keys(struct smp_chan *smp)
 {
-	struct smp_chan *smp = container_of(work, struct smp_chan,
-					    distribute_work);
 	struct smp_cmd_pairing *req, *rsp;
 	struct l2cap_conn *conn = smp->conn;
 	struct hci_conn *hcon = conn->hcon;
@@ -850,7 +841,6 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	smp->conn = conn;
 	chan->data = smp;
 
-	INIT_WORK(&smp->distribute_work, smp_distribute_keys);
 	INIT_DELAYED_WORK(&smp->security_timer, smp_timeout);
 
 	hci_conn_hold(conn->hcon);
@@ -1290,7 +1280,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 			  rp->ediv, rp->rand);
 	smp->ltk = ltk;
 	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
-		queue_work(hdev->workqueue, &smp->distribute_work);
+		smp_distribute_keys(smp);
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -1368,7 +1358,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 				      smp->id_addr_type, smp->irk, &rpa);
 
 distribute:
-	queue_work(hdev->workqueue, &smp->distribute_work);
+	smp_distribute_keys(smp);
 
 	hci_dev_unlock(hcon->hdev);
 
@@ -1404,7 +1394,7 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 		memcpy(csrk->val, rp->csrk, sizeof(csrk->val));
 	}
 	smp->csrk = csrk;
-	queue_work(hdev->workqueue, &smp->distribute_work);
+	smp_distribute_keys(smp);
 	hci_dev_unlock(hdev);
 
 	return 0;
@@ -1526,7 +1516,6 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 	struct smp_chan *smp = chan->data;
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
-	struct hci_dev *hdev = hcon->hdev;
 
 	BT_DBG("chan %p", chan);
 
@@ -1538,7 +1527,7 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 
 	cancel_delayed_work(&smp->security_timer);
 
-	queue_work(hdev->workqueue, &smp->distribute_work);
+	smp_distribute_keys(smp);
 }
 
 static void smp_ready_cb(struct l2cap_chan *chan)
-- 
1.9.3

