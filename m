Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Update smp_random to return a response code
Date: Tue, 20 May 2014 09:45:51 +0300
Message-Id: <1400568352-20454-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
References: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since we're now calling smp_random() "inline" we can have it directly
return a response code and have the shared command handler send the
response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8d1a1903e458..fa782d7b495b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -503,19 +503,17 @@ error:
 	smp_failure(conn, reason);
 }
 
-static void smp_random(struct smp_chan *smp)
+static u8 smp_random(struct smp_chan *smp)
 {
 	struct l2cap_conn *conn = smp->conn;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct crypto_blkcipher *tfm = hdev->tfm_aes;
-	u8 reason, confirm[16];
+	u8 confirm[16];
 	int ret;
 
-	if (IS_ERR_OR_NULL(tfm)) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
-	}
+	if (IS_ERR_OR_NULL(tfm))
+		return SMP_UNSPECIFIED;
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
@@ -528,15 +526,12 @@ static void smp_random(struct smp_chan *smp)
 
 	hci_dev_unlock(hdev);
 
-	if (ret) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
-	}
+	if (ret)
+		return SMP_UNSPECIFIED;
 
 	if (memcmp(smp->pcnf, confirm, sizeof(smp->pcnf)) != 0) {
 		BT_ERR("Pairing failed (confirmation values mismatch)");
-		reason = SMP_CONFIRM_FAILED;
-		goto error;
+		return SMP_CONFIRM_FAILED;
 	}
 
 	if (hcon->out) {
@@ -549,10 +544,8 @@ static void smp_random(struct smp_chan *smp)
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
-		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags)) {
-			reason = SMP_UNSPECIFIED;
-			goto error;
-		}
+		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
+			return SMP_UNSPECIFIED;
 
 		hci_le_start_enc(hcon, ediv, rand, stk);
 		hcon->enc_key_size = smp->enc_key_size;
@@ -574,10 +567,7 @@ static void smp_random(struct smp_chan *smp)
 			    ediv, rand);
 	}
 
-	return;
-
-error:
-	smp_failure(conn, reason);
+	return 0;
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
@@ -815,9 +805,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(smp->rrnd, skb->data, sizeof(smp->rrnd));
 	skb_pull(skb, sizeof(smp->rrnd));
 
-	smp_random(smp);
-
-	return 0;
+	return smp_random(smp);
 }
 
 static u8 smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
-- 
1.9.0

