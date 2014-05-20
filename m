Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: Remove unnecessary work structs from SMP code
Date: Tue, 20 May 2014 09:45:49 +0300
Message-Id: <1400568352-20454-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
References: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the SMP code was initially created (mid-2011) parts of the
Bluetooth subsystem were still not converted to use workqueues. This
meant that the crypto calls, which could sleep, couldn't be called
directly. Because of this the "confirm" and "random" work structs were
introduced.

These days the entire Bluetooth subsystem runs through workqueues which
makes these structs unnecessary. This patch removes them and converts
the calls to queue them to use direct function calls instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 72743f87b22f..efb73fdf710d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -60,8 +60,6 @@ struct smp_chan {
 	struct smp_ltk	*slave_ltk;
 	struct smp_irk	*remote_irk;
 	unsigned long	smp_flags;
-	struct work_struct confirm;
-	struct work_struct random;
 };
 
 static inline void swap128(const u8 src[16], u8 dst[16])
@@ -470,9 +468,8 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	return ret;
 }
 
-static void confirm_work(struct work_struct *work)
+static void smp_confirm(struct smp_chan *smp)
 {
-	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
 	struct l2cap_conn *conn = smp->conn;
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct crypto_blkcipher *tfm = hdev->tfm_aes;
@@ -507,9 +504,8 @@ error:
 	smp_failure(conn, reason);
 }
 
-static void random_work(struct work_struct *work)
+static void smp_random(struct smp_chan *smp)
 {
-	struct smp_chan *smp = container_of(work, struct smp_chan, random);
 	struct l2cap_conn *conn = smp->conn;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
@@ -593,9 +589,6 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	if (!smp)
 		return NULL;
 
-	INIT_WORK(&smp->confirm, confirm_work);
-	INIT_WORK(&smp->random, random_work);
-
 	smp->conn = conn;
 	conn->smp_chan = smp;
 	conn->hcon->smp_conn = conn;
@@ -676,7 +669,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 
 	/* If it is our turn to send Pairing Confirm, do so now */
 	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags))
-		queue_work(hcon->hdev->workqueue, &smp->confirm);
+		smp_confirm(smp);
 
 	return 0;
 }
@@ -740,7 +733,6 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
 	struct smp_chan *smp = conn->smp_chan;
-	struct hci_dev *hdev = conn->hcon->hdev;
 	u8 key_size, auth = SMP_AUTH_NONE;
 	int ret;
 
@@ -784,7 +776,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	/* Can't compose response until we have been confirmed */
 	if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
-		queue_work(hdev->workqueue, &smp->confirm);
+		smp_confirm(smp);
 
 	return 0;
 }
@@ -792,7 +784,6 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_chan *smp = conn->smp_chan;
-	struct hci_dev *hdev = conn->hcon->hdev;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
@@ -806,7 +797,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 	else if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
-		queue_work(hdev->workqueue, &smp->confirm);
+		smp_confirm(smp);
 	else
 		set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
 
@@ -816,7 +807,6 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_chan *smp = conn->smp_chan;
-	struct hci_dev *hdev = conn->hcon->hdev;
 
 	BT_DBG("conn %p", conn);
 
@@ -826,7 +816,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(smp->rrnd, skb->data, sizeof(smp->rrnd));
 	skb_pull(skb, sizeof(smp->rrnd));
 
-	queue_work(hdev->workqueue, &smp->random);
+	smp_random(smp);
 
 	return 0;
 }
-- 
1.9.0

