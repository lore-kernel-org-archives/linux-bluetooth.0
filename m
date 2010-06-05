Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 10/14] Bluetooth: Fix crash when sending frames after connection is closed
Date: Sat,  5 Jun 2010 04:50:14 -0300
Message-Id: <1275724218-29453-11-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-10-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
 <1275724218-29453-4-git-send-email-gustavo@padovan.org>
 <1275724218-29453-5-git-send-email-gustavo@padovan.org>
 <1275724218-29453-6-git-send-email-gustavo@padovan.org>
 <1275724218-29453-7-git-send-email-gustavo@padovan.org>
 <1275724218-29453-8-git-send-email-gustavo@padovan.org>
 <1275724218-29453-9-git-send-email-gustavo@padovan.org>
 <1275724218-29453-10-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

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
1.7.1
