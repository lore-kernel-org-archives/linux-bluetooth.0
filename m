Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 2/2] Bluetooth: Use *_unaligned_le{16,32}
Date: Mon, 24 Aug 2009 00:45:20 -0300
Message-Id: <1251085520-9094-2-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1251085520-9094-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Simplify the conversion to the right endian.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index efac637..e5847c5 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2924,7 +2924,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		if (enable_ertm)
 			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
 							 | L2CAP_FEAT_FCS;
-		put_unaligned(cpu_to_le32(feat_mask), (__le32 *) rsp->data);
+		put_unaligned_le32(feat_mask, rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
 	} else if (type == L2CAP_IT_FIXED_CHAN) {
@@ -3572,7 +3572,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case L2CAP_CID_CONN_LESS:
-		psm = get_unaligned((__le16 *) skb->data);
+		psm = get_unaligned_le16(skb->data);
 		skb_pull(skb, 2);
 		l2cap_conless_channel(conn, psm, skb);
 		break;
-- 
1.6.3.3
