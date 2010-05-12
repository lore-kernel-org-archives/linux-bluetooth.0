Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [l2cap 6/6] Bluetooth: Only check SAR bits if frame is I-frame
Date: Wed, 12 May 2010 00:05:58 -0300
Message-Id: <1273633558-10576-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1273633558-10576-5-git-send-email-padovan@profusion.mobi>
References: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
 <1273633558-10576-1-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-2-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-3-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-4-git-send-email-padovan@profusion.mobi>
 <1273633558-10576-5-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index dbd43d1..2192b9c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4123,7 +4123,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (l2cap_check_fcs(pi, skb))
 			goto drop;
 
-		if (__is_sar_start(control))
+		if (__is_sar_start(control) && __is_iframe(control))
 			len -= 2;
 
 		if (pi->fcs == L2CAP_FCS_CRC16)
-- 
1.6.4.4
