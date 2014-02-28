Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Re-encrypt link after receiving an LTK
Date: Fri, 28 Feb 2014 16:37:33 +0200
Message-Id: <1393598254-9609-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's not strictly speaking required to re-encrypt a link once we receive
an LTK since the connection is already encrypted with the STK. However,
re-encrypting with the LTK allows us to verify that we've received an
LTK that actually works.

This patch updates the SMP code to request encrypting with the LTK in
case we're in master role and waits until the key refresh complete event
before notifying user space of the distributed keys.

A new flag is also added for the SMP context to ensure that we
re-encryption only once in case of multiple calls to smp_distribute_keys.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 27 ++++++++++++++++++++++-----
 net/bluetooth/smp.h |  3 ++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4f4ff36f5f34..79b6c97f8303 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1178,6 +1178,7 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 	struct smp_chan *smp = conn->smp_chan;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
+	bool ltk_encrypt;
 	__u8 *keydist;
 
 	BT_DBG("conn %p", conn);
@@ -1269,12 +1270,28 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 	if ((smp->remote_key_dist & 0x07))
 		return 0;
 
-	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
-	cancel_delayed_work_sync(&conn->security_timer);
-	set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
-	smp_notify_keys(conn);
+	/* Check if we should try to re-encrypt the link with the LTK.
+	 * SMP_FLAG_LTK_ENCRYPT flag is used to track whether we've
+	 * already tried this (in which case we shouldn't try again).
+	 */
+	if (smp->ltk)
+		ltk_encrypt = !test_and_set_bit(SMP_FLAG_LTK_ENCRYPT,
+						&smp->smp_flags);
+	else
+		ltk_encrypt = false;
 
-	smp_chan_destroy(conn);
+	/* Re-encrypt the link with LTK if possible */
+	if (ltk_encrypt && hcon->out) {
+		struct smp_ltk *ltk = smp->ltk;
+		hci_le_start_enc(hcon, ltk->ediv, ltk->rand, ltk->val);
+		hcon->enc_key_size = ltk->enc_size;
+	} else {
+		clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
+		cancel_delayed_work_sync(&conn->security_timer);
+		set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
+		smp_notify_keys(conn);
+		smp_chan_destroy(conn);
+	}
 
 	return 0;
 }
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index a11d4281542c..676395f93702 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -118,7 +118,8 @@ struct smp_cmd_security_req {
 #define SMP_FLAG_TK_VALID	1
 #define SMP_FLAG_CFM_PENDING	2
 #define SMP_FLAG_MITM_AUTH	3
-#define SMP_FLAG_COMPLETE	4
+#define SMP_FLAG_LTK_ENCRYPT	4
+#define SMP_FLAG_COMPLETE	5
 
 struct smp_chan {
 	struct l2cap_conn *conn;
-- 
1.8.5.3

