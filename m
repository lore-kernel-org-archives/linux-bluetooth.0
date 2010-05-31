Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 10/11] Bluetooth: Fix crash when sending frames after connection is closed
Date: Mon, 31 May 2010 16:05:26 -0300
Message-Id: <1275332727-16263-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275332727-16263-9-git-send-email-padovan@profusion.mobi>
References: <1275332727-16263-1-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-2-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-3-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-4-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-5-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-6-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-7-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-8-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-9-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

At the time the channel is closed we can't really know if the timer
was really deleted, since we used del_timer(). We can't call
del_timer_sync() in interrupt context! So sometimes the acktimeout
expires and try to send a acknowledgement, but we don't have any
connection anymore.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 3db0078..e5b766d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -345,8 +345,12 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
 	struct l2cap_conn *conn = pi->conn;
+	struct sock *sk = (struct sock *)pi;
 	int count, hlen = L2CAP_HDR_SIZE + 2;
 
+	if (sk->sk_state != BT_CONNECTED)
+		return;
+
 	if (pi->fcs == L2CAP_FCS_CRC16)
 		hlen += 2;
 
-- 
1.6.4.4
