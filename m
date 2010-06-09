Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Bluetooth: remove ERTM minimum packet length
From: Nathan Holstein <nathan@lampreynetworks.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 09 Jun 2010 15:46:25 -0400
Message-Id: <1276112785.3546.560.camel@strawberry>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ERTM and streaming mode L2CAP sockets have no minimum packet length.
Instead, validate the the packet contained all necessary control, FCS,
and SAR fields.

Signed-off-by: Nathan Holstein <ngh@isomerica.net>
---
 net/bluetooth/l2cap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 411b1ec..9099e6d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4131,9 +4131,9 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 {
 	struct sock *sk;
 	struct l2cap_pinfo *pi;
-	u16 control, len;
+	u16 control;
 	u8 tx_seq, req_seq;
-	int next_tx_seq_offset, req_seq_offset;
+	int len, next_tx_seq_offset, req_seq_offset;
 
 	sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
 	if (!sk) {
@@ -4203,7 +4203,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		}
 
 		if (__is_iframe(control)) {
-			if (len < 4) {
+			if (len < 0) {
 				l2cap_send_disconn_req(pi->conn, sk);
 				goto drop;
 			}
@@ -4234,7 +4234,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (pi->fcs == L2CAP_FCS_CRC16)
 			len -= 2;
 
-		if (len > pi->mps || len < 4 || __is_sframe(control))
+		if (len > pi->mps || len < 0 || __is_sframe(control))
 			goto drop;
 
 		tx_seq = __get_txseq(control);
-- 
1.6.0.4



