Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 04/19] Bluetooth: Check the minimum {I,S}-frame size into L2CAP
Date: Tue, 23 Mar 2010 16:48:31 -0300
Message-Id: <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

All packets with size fewer than the minimum specified is dropped.
Note that the size of the l2cap basic header, FCS and SAR fields are
already subtracted of len at the moment of the size check.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index a020b9f..e78fc16 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3619,10 +3619,17 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (l2cap_check_fcs(pi, skb))
 			goto drop;
 
-		if (__is_iframe(control))
+		if (__is_iframe(control)) {
+			if (len < 4)
+				goto drop;
+
 			l2cap_data_channel_iframe(sk, control, skb);
-		else
+		} else {
+			if (len != 0)
+				goto drop;
+
 			l2cap_data_channel_sframe(sk, control, skb);
+		}
 
 		goto done;
 
@@ -3637,7 +3644,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (pi->fcs == L2CAP_FCS_CRC16)
 			len -= 2;
 
-		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE || __is_sframe(control))
+		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE || len < 4
+				|| __is_sframe(control))
 			goto drop;
 
 		if (l2cap_check_fcs(pi, skb))
-- 
1.6.4.4
