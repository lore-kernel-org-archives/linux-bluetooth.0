Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 3/3] Bluetooth: Add support to 'Send RRorRNR' action
Date: Wed, 26 Aug 2009 04:04:03 -0300
Message-Id: <1251270243-28832-3-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1251270243-28832-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1251270243-28832-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1251270243-28832-2-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When called, 'Send RRorRNR' should send a RNR frame if local device is
busy or a RR frame otherwise.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 40fbf5c..b030125 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -366,6 +366,16 @@ static inline int l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
 	return hci_send_acl(pi->conn->hcon, skb, 0);
 }
 
+static inline int l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
+{
+	if (pi->conn_state & L2CAP_CONN_LOCAL_BUSY)
+		control |= L2CAP_SUPER_RCV_NOT_READY;
+	else
+		control |= L2CAP_SUPER_RCV_READY;
+
+	return l2cap_send_sframe(pi, control);
+}
+
 static void l2cap_do_start(struct sock *sk)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
@@ -1202,8 +1212,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	__mod_monitor_timer();
 
 	control = L2CAP_CTRL_POLL;
-	control |= L2CAP_SUPER_RCV_READY;
-	l2cap_send_sframe(l2cap_pi(sk), control);
+	l2cap_send_rr_or_rnr(l2cap_pi(sk), control);
 	bh_unlock_sock(sk);
 }
 
@@ -1219,8 +1228,7 @@ static void l2cap_retrans_timeout(unsigned long arg)
 	l2cap_pi(sk)->conn_state |= L2CAP_CONN_WAIT_F;
 
 	control = L2CAP_CTRL_POLL;
-	control |= L2CAP_SUPER_RCV_READY;
-	l2cap_send_sframe(l2cap_pi(sk), control);
+	l2cap_send_rr_or_rnr(l2cap_pi(sk), control);
 	bh_unlock_sock(sk);
 }
 
@@ -3428,8 +3436,8 @@ static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, str
 
 		del_timer(&l2cap_pi(sk)->retrans_timer);
 		if (rx_control & L2CAP_CTRL_POLL) {
-			u16 control = L2CAP_CTRL_FINAL | L2CAP_SUPER_RCV_READY;
-			l2cap_send_sframe(l2cap_pi(sk), control);
+			u16 control = L2CAP_CTRL_FINAL;
+			l2cap_send_rr_or_rnr(l2cap_pi(sk), control);
 		}
 		break;
 	}
-- 
1.6.3.3

