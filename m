Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Delay LTK encryption to let remote receive all keys
Date: Fri, 28 Feb 2014 16:37:34 +0200
Message-Id: <1393598254-9609-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393598254-9609-1-git-send-email-johan.hedberg@gmail.com>
References: <1393598254-9609-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Some devices may refuse to re-encrypt with the LTK if they haven't
received all our keys yet. This patch adds a 200ms delay before
attempting re-encryption with the LTK.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 22 +++++++++++++++++++---
 net/bluetooth/smp.h |  3 +++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 79b6c97f8303..cba0e0ddf332 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -549,6 +549,20 @@ error:
 	smp_failure(conn, reason);
 }
 
+static void smp_reencrypt(struct work_struct *work)
+{
+	struct smp_chan *smp = container_of(work, struct smp_chan,
+					    reencrypt.work);
+	struct l2cap_conn *conn = smp->conn;
+	struct hci_conn *hcon = conn->hcon;
+	struct smp_ltk *ltk = smp->ltk;
+
+	BT_DBG("");
+
+	hci_le_start_enc(hcon, ltk->ediv, ltk->rand, ltk->val);
+	hcon->enc_key_size = ltk->enc_size;
+}
+
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
 	struct smp_chan *smp;
@@ -559,6 +573,7 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	INIT_WORK(&smp->confirm, confirm_work);
 	INIT_WORK(&smp->random, random_work);
+	INIT_DELAYED_WORK(&smp->reencrypt, smp_reencrypt);
 
 	smp->conn = conn;
 	conn->smp_chan = smp;
@@ -576,6 +591,8 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 
 	BUG_ON(!smp);
 
+	cancel_delayed_work_sync(&smp->reencrypt);
+
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
@@ -1282,9 +1299,8 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 
 	/* Re-encrypt the link with LTK if possible */
 	if (ltk_encrypt && hcon->out) {
-		struct smp_ltk *ltk = smp->ltk;
-		hci_le_start_enc(hcon, ltk->ediv, ltk->rand, ltk->val);
-		hcon->enc_key_size = ltk->enc_size;
+		queue_delayed_work(hdev->req_workqueue, &smp->reencrypt,
+				   SMP_REENCRYPT_TIMEOUT);
 	} else {
 		clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
 		cancel_delayed_work_sync(&conn->security_timer);
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 676395f93702..f95bf887a9f3 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -121,6 +121,8 @@ struct smp_cmd_security_req {
 #define SMP_FLAG_LTK_ENCRYPT	4
 #define SMP_FLAG_COMPLETE	5
 
+#define SMP_REENCRYPT_TIMEOUT	msecs_to_jiffies(200)
+
 struct smp_chan {
 	struct l2cap_conn *conn;
 	u8		preq[7]; /* SMP Pairing Request */
@@ -140,6 +142,7 @@ struct smp_chan {
 	unsigned long	smp_flags;
 	struct work_struct confirm;
 	struct work_struct random;
+	struct delayed_work reencrypt;
 };
 
 /* SMP Commands */
-- 
1.8.5.3

