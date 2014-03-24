Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Remove LTK re-encryption procedure
Date: Mon, 24 Mar 2014 14:39:08 +0200
Message-Id: <1395664748-13494-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
References: <1395664748-13494-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Due to several devices being unable to handle this procedure reliably
(resulting in forced disconnections before pairing completes) it's
better to remove it altogether.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 48 +++++-------------------------------------------
 net/bluetooth/smp.h |  8 ++------
 2 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2ab1b3eb2bb7..98488be6dafa 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -556,20 +556,6 @@ error:
 	smp_failure(conn, reason);
 }
 
-static void smp_reencrypt(struct work_struct *work)
-{
-	struct smp_chan *smp = container_of(work, struct smp_chan,
-					    reencrypt.work);
-	struct l2cap_conn *conn = smp->conn;
-	struct hci_conn *hcon = conn->hcon;
-	struct smp_ltk *ltk = smp->ltk;
-
-	BT_DBG("");
-
-	hci_le_start_enc(hcon, ltk->ediv, ltk->rand, ltk->val);
-	hcon->enc_key_size = ltk->enc_size;
-}
-
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
 	struct smp_chan *smp;
@@ -580,7 +566,6 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 	INIT_WORK(&smp->confirm, confirm_work);
 	INIT_WORK(&smp->random, random_work);
-	INIT_DELAYED_WORK(&smp->reencrypt, smp_reencrypt);
 
 	smp->conn = conn;
 	conn->smp_chan = smp;
@@ -598,8 +583,6 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 
 	BUG_ON(!smp);
 
-	cancel_delayed_work_sync(&smp->reencrypt);
-
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
@@ -1276,7 +1259,6 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 	struct smp_chan *smp = conn->smp_chan;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
-	bool ltk_encrypt;
 	__u8 *keydist;
 
 	BT_DBG("conn %p", conn);
@@ -1376,32 +1358,12 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 	if ((smp->remote_key_dist & 0x07))
 		return 0;
 
-	/* Check if we should try to re-encrypt the link with the LTK.
-	 * SMP_FLAG_LTK_ENCRYPT flag is used to track whether we've
-	 * already tried this (in which case we shouldn't try again).
-	 *
-	 * The request will trigger an encryption key refresh event
-	 * which will cause a call to auth_cfm and eventually lead to
-	 * l2cap_core.c calling this smp_distribute_keys function again
-	 * and thereby completing the process.
-	 */
-	if (smp->ltk)
-		ltk_encrypt = !test_and_set_bit(SMP_FLAG_LTK_ENCRYPT,
-						&smp->smp_flags);
-	else
-		ltk_encrypt = false;
+	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
+	cancel_delayed_work_sync(&conn->security_timer);
+	set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
+	smp_notify_keys(conn);
 
-	/* Re-encrypt the link with LTK if possible */
-	if (ltk_encrypt && hcon->out) {
-		queue_delayed_work(hdev->req_workqueue, &smp->reencrypt,
-				   SMP_REENCRYPT_TIMEOUT);
-	} else {
-		clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
-		cancel_delayed_work_sync(&conn->security_timer);
-		set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
-		smp_notify_keys(conn);
-		smp_chan_destroy(conn);
-	}
+	smp_chan_destroy(conn);
 
 	return 0;
 }
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 0d536b8b3f9a..1277147a9150 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -118,11 +118,8 @@ struct smp_cmd_security_req {
 #define SMP_FLAG_TK_VALID	1
 #define SMP_FLAG_CFM_PENDING	2
 #define SMP_FLAG_MITM_AUTH	3
-#define SMP_FLAG_LTK_ENCRYPT	4
-#define SMP_FLAG_COMPLETE	5
-#define SMP_FLAG_INITIATOR	6
-
-#define SMP_REENCRYPT_TIMEOUT	msecs_to_jiffies(500)
+#define SMP_FLAG_COMPLETE	4
+#define SMP_FLAG_INITIATOR	5
 
 struct smp_chan {
 	struct l2cap_conn *conn;
@@ -145,7 +142,6 @@ struct smp_chan {
 	unsigned long	smp_flags;
 	struct work_struct confirm;
 	struct work_struct random;
-	struct delayed_work reencrypt;
 };
 
 /* SMP Commands */
-- 
1.8.5.3

