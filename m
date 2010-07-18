Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Enable L2CAP Extended features by default
Date: Sun, 18 Jul 2010 16:25:54 -0300
Message-Id: <1279481154-4354-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Change the enable_ertm param to disable_ertm and default value to 0. That
means that L2CAP Extended features are enabled by default now.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d175cc2..ddd2e5b 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -57,7 +57,7 @@
 
 #define VERSION "2.15"
 
-static int enable_ertm = 0;
+static int disable_ertm = 0;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -464,7 +464,7 @@ static void l2cap_do_start(struct sock *sk)
 static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 {
 	u32 local_feat_mask = l2cap_feat_mask;
-	if (enable_ertm)
+	if (!disable_ertm)
 		local_feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING;
 
 	switch (mode) {
@@ -903,7 +903,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
-		if (enable_ertm && sk->sk_type == SOCK_STREAM) {
+		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
 			pi->mode = L2CAP_MODE_ERTM;
 			pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
 		} else {
@@ -1160,7 +1160,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
-		if (enable_ertm)
+		if (!disable_ertm)
 			break;
 		/* fall through */
 	default:
@@ -1226,7 +1226,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
-		if (enable_ertm)
+		if (!disable_ertm)
 			break;
 		/* fall through */
 	default:
@@ -1986,7 +1986,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		case L2CAP_MODE_ERTM:
 		case L2CAP_MODE_STREAMING:
-			if (enable_ertm)
+			if (!disable_ertm)
 				break;
 			/* fall through */
 		default:
@@ -3302,7 +3302,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
 		rsp->type   = cpu_to_le16(L2CAP_IT_FEAT_MASK);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
-		if (enable_ertm)
+		if (!disable_ertm)
 			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
 							 | L2CAP_FEAT_FCS;
 		put_unaligned_le32(feat_mask, rsp->data);
@@ -4850,8 +4850,8 @@ EXPORT_SYMBOL(l2cap_load);
 module_init(l2cap_init);
 module_exit(l2cap_exit);
 
-module_param(enable_ertm, bool, 0644);
-MODULE_PARM_DESC(enable_ertm, "Enable enhanced retransmission mode");
+module_param(disable_ertm, bool, 0644);
+MODULE_PARM_DESC(disable_ertm, "Enable enhanced retransmission mode");
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth L2CAP ver " VERSION);
-- 
1.7.1.1
