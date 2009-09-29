Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 7/7] Bluetooth: Send ReqSeq on 'SendRRorRNR' function
Date: Tue, 29 Sep 2009 01:42:29 -0300
Message-Id: <1254199349-19713-7-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254199349-19713-6-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-5-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-6-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

SendRRorRNR need to acknowledge received I-frames so ReqSeq is set
to BufferSeq on the the outgoing S-frame.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ddf70d6..76a7a19 100644
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
1.6.3.3
