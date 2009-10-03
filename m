Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 5/5] Bluetooth: Fix 'SendRRorRNR' to send the ReqSeq value
Date: Sat,  3 Oct 2009 02:34:40 -0300
Message-Id: <1254548080-13478-5-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254548080-13478-4-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254548080-13478-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1254548080-13478-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1254548080-13478-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1254548080-13478-4-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SendRRorRNR needs to acknowledge received I-frames (actually every packet
needs to acknowledge received I-frames by sending the proper packet
sequence number), so ReqSeq is set to the next I-frame number sequence to
be pulled by the reassembly function.
SendRRorRNR tells the remote side about local busy conditions, it sends
a Receiver Ready frame if local busy is false or a Receiver Not Ready
if local busy is true.
ReqSeq is the packet's field to send the number of the acknowledged
packets.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 0c4fdea..2f29e40 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -373,6 +373,8 @@ static inline int l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
 	else
 		control |= L2CAP_SUPER_RCV_READY;
 
+	control |= pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+
 	return l2cap_send_sframe(pi, control);
 }
 
-- 
1.6.4.4

