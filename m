Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 9/9] Bluetooth: Make smp_chan_destroy() private to smp.c
Date: Mon, 11 Aug 2014 22:06:44 +0300
Message-Id: <1407784004-12448-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
References: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are no external users of smp_chan_destroy() so make it private to
smp.c. The patch also moves the function higher up in the c-file in
order to avoid forward declarations.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 100 ++++++++++++++++++++++++++--------------------------
 net/bluetooth/smp.h |   2 --
 2 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 312ea5ec2d7d..07ca4ce0943b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -366,6 +366,56 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 	return 0;
 }
 
+static void smp_chan_destroy(struct l2cap_conn *conn)
+{
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp = chan->data;
+	bool complete;
+
+	BUG_ON(!smp);
+
+	cancel_delayed_work_sync(&smp->security_timer);
+	/* In case the timeout freed the SMP context */
+	if (!chan->data)
+		return;
+
+	if (work_pending(&smp->distribute_work)) {
+		cancel_work_sync(&smp->distribute_work);
+		if (!chan->data)
+			return;
+	}
+
+	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
+	mgmt_smp_complete(conn->hcon, complete);
+
+	kfree(smp->csrk);
+	kfree(smp->slave_csrk);
+
+	crypto_free_blkcipher(smp->tfm_aes);
+
+	/* If pairing failed clean up any keys we might have */
+	if (!complete) {
+		if (smp->ltk) {
+			list_del(&smp->ltk->list);
+			kfree(smp->ltk);
+		}
+
+		if (smp->slave_ltk) {
+			list_del(&smp->slave_ltk->list);
+			kfree(smp->slave_ltk);
+		}
+
+		if (smp->remote_irk) {
+			list_del(&smp->remote_irk->list);
+			kfree(smp->remote_irk);
+		}
+	}
+
+	chan->data = NULL;
+	kfree(smp);
+	hci_conn_drop(conn->hcon);
+}
+
 static void smp_failure(struct l2cap_conn *conn, u8 reason)
 {
 	struct hci_conn *hcon = conn->hcon;
@@ -812,56 +862,6 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	return smp;
 }
 
-void smp_chan_destroy(struct l2cap_conn *conn)
-{
-	struct l2cap_chan *chan = conn->smp;
-	struct smp_chan *smp = chan->data;
-	bool complete;
-
-	BUG_ON(!smp);
-
-	cancel_delayed_work_sync(&smp->security_timer);
-	/* In case the timeout freed the SMP context */
-	if (!chan->data)
-		return;
-
-	if (work_pending(&smp->distribute_work)) {
-		cancel_work_sync(&smp->distribute_work);
-		if (!chan->data)
-			return;
-	}
-
-	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
-	mgmt_smp_complete(conn->hcon, complete);
-
-	kfree(smp->csrk);
-	kfree(smp->slave_csrk);
-
-	crypto_free_blkcipher(smp->tfm_aes);
-
-	/* If pairing failed clean up any keys we might have */
-	if (!complete) {
-		if (smp->ltk) {
-			list_del(&smp->ltk->list);
-			kfree(smp->ltk);
-		}
-
-		if (smp->slave_ltk) {
-			list_del(&smp->slave_ltk->list);
-			kfree(smp->slave_ltk);
-		}
-
-		if (smp->remote_irk) {
-			list_del(&smp->remote_irk->list);
-			kfree(smp->remote_irk);
-		}
-	}
-
-	chan->data = NULL;
-	kfree(smp);
-	hci_conn_drop(conn->hcon);
-}
-
 int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 59a594278a85..cf1094617c69 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -128,8 +128,6 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
-void smp_chan_destroy(struct l2cap_conn *conn);
-
 bool smp_irk_matches(struct hci_dev *hdev, u8 irk[16], bdaddr_t *bdaddr);
 int smp_generate_rpa(struct hci_dev *hdev, u8 irk[16], bdaddr_t *rpa);
 
-- 
1.9.3

