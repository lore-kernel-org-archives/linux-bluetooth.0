Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <padovan@profusion.mobi>
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v4 7/9] Bluetooth: Centralize SMP pairing failure handling
Date: Wed, 16 Nov 2011 13:53:18 -0800
Message-Id: <1321480400-17397-8-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/smp.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3b3726a..af8dde4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -232,6 +232,18 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 	return 0;
 }
 
+static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
+{
+	if (send)
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
+								&reason);
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->pend);
+	mgmt_auth_failed(conn->hcon->hdev, conn->dst, reason);
+	del_timer(&conn->security_timer);
+	smp_chan_destroy(conn);
+}
+
 static void confirm_work(struct work_struct *work)
 {
 	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
@@ -270,8 +282,7 @@ static void confirm_work(struct work_struct *work)
 	return;
 
 error:
-	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
-	smp_chan_destroy(conn);
+	smp_failure(conn, reason, 1);
 }
 
 static void random_work(struct work_struct *work)
@@ -354,8 +365,7 @@ static void random_work(struct work_struct *work)
 	return;
 
 error:
-	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
-	smp_chan_destroy(conn);
+	smp_failure(conn, reason, 1);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
@@ -653,6 +663,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case SMP_CMD_PAIRING_FAIL:
+		smp_failure(conn, skb->data[0], 0);
 		reason = 0;
 		err = -EPERM;
 		break;
@@ -698,8 +709,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 
 done:
 	if (reason)
-		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
-								&reason);
+		smp_failure(conn, reason, 1);
 
 	kfree_skb(skb);
 	return err;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
