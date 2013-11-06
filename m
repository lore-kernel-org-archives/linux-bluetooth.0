Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unnecessary 'send' parameter from smp_failure()
Date: Wed,  6 Nov 2013 11:24:57 +0200
Message-Id: <1383729897-28492-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The send parameter has only been used for determining whether to send a
Pairing Failed PDU or not. However, the function can equally well use
the already existing reason parameter to make this choice and send the
PDU whenever a non-zero value was passed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4b07acb8293c..f99352d1aa43 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -257,11 +257,11 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 	return 0;
 }
 
-static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
+static void smp_failure(struct l2cap_conn *conn, u8 reason)
 {
 	struct hci_conn *hcon = conn->hcon;
 
-	if (send)
+	if (reason)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 			     &reason);
 
@@ -406,7 +406,7 @@ static void confirm_work(struct work_struct *work)
 	return;
 
 error:
-	smp_failure(conn, reason, 1);
+	smp_failure(conn, reason);
 }
 
 static void random_work(struct work_struct *work)
@@ -490,7 +490,7 @@ static void random_work(struct work_struct *work)
 	return;
 
 error:
-	smp_failure(conn, reason, 1);
+	smp_failure(conn, reason);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
@@ -555,10 +555,10 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 		break;
 	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED, 1);
+		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED);
 		return 0;
 	default:
-		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED, 1);
+		smp_failure(conn, SMP_PASSKEY_ENTRY_FAILED);
 		return -EOPNOTSUPP;
 	}
 
@@ -895,7 +895,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case SMP_CMD_PAIRING_FAIL:
-		smp_failure(conn, skb->data[0], 0);
+		smp_failure(conn, 0);
 		reason = 0;
 		err = -EPERM;
 		break;
@@ -941,7 +941,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 
 done:
 	if (reason)
-		smp_failure(conn, reason, 1);
+		smp_failure(conn, reason);
 
 	kfree_skb(skb);
 	return err;
-- 
1.8.3.1

