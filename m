Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for SMP Invalid Parameters error code
Date: Thu,  8 May 2014 14:19:11 +0300
Message-Id: <1399547951-26259-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Invalid Parameters error code is used to indicate that the command
length is invalid or that a parameter is outside of the specified range.
This error code wasn't clearly specified in the Bluetooth 4.0
specification but since 4.1 this has been fixed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 20 ++++++++++----------
 net/bluetooth/smp.h |  1 +
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index dfb4e1161c10..b5b926399e76 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -663,7 +663,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (skb->len < sizeof(*req))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	if (conn->hcon->link_mode & HCI_LM_MASTER)
 		return SMP_CMD_NOTSUPP;
@@ -720,7 +720,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (skb->len < sizeof(*rsp))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
 		return SMP_CMD_NOTSUPP;
@@ -770,7 +770,7 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
 	if (skb->len < sizeof(smp->pcnf))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
 	skb_pull(skb, sizeof(smp->pcnf));
@@ -794,7 +794,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (skb->len < sizeof(smp->rrnd))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	memcpy(smp->rrnd, skb->data, sizeof(smp->rrnd));
 	skb_pull(skb, sizeof(smp->rrnd));
@@ -836,7 +836,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
 		return SMP_CMD_NOTSUPP;
@@ -944,7 +944,7 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	/* Ignore this PDU if it wasn't requested */
 	if (!(smp->remote_key_dist & SMP_DIST_ENC_KEY))
@@ -969,7 +969,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	/* Ignore this PDU if it wasn't requested */
 	if (!(smp->remote_key_dist & SMP_DIST_ENC_KEY))
@@ -1001,7 +1001,7 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("");
 
 	if (skb->len < sizeof(*info))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	/* Ignore this PDU if it wasn't requested */
 	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
@@ -1025,7 +1025,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	BT_DBG("");
 
 	if (skb->len < sizeof(*info))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	/* Ignore this PDU if it wasn't requested */
 	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
@@ -1075,7 +1075,7 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	BT_DBG("conn %p", conn);
 
 	if (skb->len < sizeof(*rp))
-		return SMP_UNSPECIFIED;
+		return SMP_INVALID_PARAMS;
 
 	/* Ignore this PDU if it wasn't requested */
 	if (!(smp->remote_key_dist & SMP_DIST_SIGN))
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 1277147a9150..afd16231db13 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -111,6 +111,7 @@ struct smp_cmd_security_req {
 #define SMP_CMD_NOTSUPP			0x07
 #define SMP_UNSPECIFIED			0x08
 #define SMP_REPEATED_ATTEMPTS		0x09
+#define SMP_INVALID_PARAMS		0x0a
 
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
-- 
1.9.0

