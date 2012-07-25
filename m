Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 21/21] Bluetooth: Start channel move when socket option is changed
Date: Wed, 25 Jul 2012 16:51:13 -0700
Message-Id: <1343260274-11953-22-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 20 ++++++++++++++++++++
 net/bluetooth/l2cap_sock.c    |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7c50606..1f4e9c0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -802,5 +802,6 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
+void l2cap_move_start(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 752ff74..bb61bd0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4430,6 +4430,26 @@ static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 	}
 }
 
+void l2cap_move_start(struct l2cap_chan *chan)
+{
+	BT_DBG("chan %p", chan);
+
+	if (chan->chan_id == 0) {
+		if (chan->chan_policy != BT_CHANNEL_POLICY_AMP_PREFERRED)
+			return;
+		chan->move_role = L2CAP_MOVE_ROLE_INITIATOR;
+		chan->move_state = L2CAP_MOVE_WAIT_PREPARE;
+		/* Placeholder - start physical link setup */
+	} else {
+		chan->move_role = L2CAP_MOVE_ROLE_INITIATOR;
+		chan->move_state = L2CAP_MOVE_WAIT_RSP_SUCCESS;
+		chan->move_id = 0;
+		l2cap_move_start(chan);
+		l2cap_send_move_chan_req(chan, 0);
+		__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
+	}
+}
+
 void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_id,
 			u8 remote_id)
 {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 79350d1..8bee29d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -721,6 +721,11 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		}
 
 		chan->chan_policy = (u8) opt;
+
+		if (sk->sk_state == BT_CONNECTED &&
+		    chan->move_role == L2CAP_MOVE_ROLE_NONE)
+			l2cap_move_start(chan);
+
 		break;
 
 	default:
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
