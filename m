Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Update smp_confirm to return a response code
Date: Tue, 20 May 2014 09:45:52 +0300
Message-Id: <1400568352-20454-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
References: <1400568352-20454-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that smp_confirm() is called "inline" we can have it return a
response code and have the sending of it be done in the shared place for
command handlers. One exception is when we're entering smp.c from mgmt.c
when user space responds to authentication, in which case we still need
our own code to call smp_failuer().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fa782d7b495b..4f9662d0fd81 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -467,14 +467,13 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	return ret;
 }
 
-static void smp_confirm(struct smp_chan *smp)
+static u8 smp_confirm(struct smp_chan *smp)
 {
 	struct l2cap_conn *conn = smp->conn;
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct crypto_blkcipher *tfm = hdev->tfm_aes;
 	struct smp_cmd_pairing_confirm cp;
 	int ret;
-	u8 reason;
 
 	BT_DBG("conn %p", conn);
 
@@ -488,19 +487,14 @@ static void smp_confirm(struct smp_chan *smp)
 
 	hci_dev_unlock(hdev);
 
-	if (ret) {
-		reason = SMP_UNSPECIFIED;
-		goto error;
-	}
+	if (ret)
+		return SMP_UNSPECIFIED;
 
 	clear_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
 
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
-	return;
-
-error:
-	smp_failure(conn, reason);
+	return 0;
 }
 
 static u8 smp_random(struct smp_chan *smp)
@@ -657,8 +651,11 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	}
 
 	/* If it is our turn to send Pairing Confirm, do so now */
-	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->flags))
-		smp_confirm(smp);
+	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->flags)) {
+		u8 rsp = smp_confirm(smp);
+		if (rsp)
+			smp_failure(conn, rsp);
+	}
 
 	return 0;
 }
@@ -765,7 +762,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	/* Can't compose response until we have been confirmed */
 	if (test_bit(SMP_FLAG_TK_VALID, &smp->flags))
-		smp_confirm(smp);
+		return smp_confirm(smp);
 
 	return 0;
 }
@@ -786,7 +783,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 	else if (test_bit(SMP_FLAG_TK_VALID, &smp->flags))
-		smp_confirm(smp);
+		return smp_confirm(smp);
 	else
 		set_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
 
-- 
1.9.0

