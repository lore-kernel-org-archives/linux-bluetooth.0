Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCHv5 18/18] Bluetooth: Start channel move when socket option is changed
Date: Tue, 23 Oct 2012 15:24:23 -0700
Message-Id: <1351031063-11791-19-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1351031063-11791-1-git-send-email-mathewm@codeaurora.org>
References: <1351031063-11791-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Channel moves are triggered by changes to the BT_CHANNEL_POLICY
sockopt when an ERTM or streaming-mode channel is connected.

Moves are only started if enable_hs is true.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 19 +++++++++++++++++++
 net/bluetooth/l2cap_sock.c    |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b4c3c65..49783e9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -809,5 +809,6 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
 void l2cap_send_conn_req(struct l2cap_chan *chan);
+void l2cap_move_start(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 93f1ebb..fae0c70 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4453,6 +4453,25 @@ static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 	}
 }
 
+void l2cap_move_start(struct l2cap_chan *chan)
+{
+	BT_DBG("chan %p", chan);
+
+	if (chan->local_amp_id == HCI_BREDR_ID) {
+		if (chan->chan_policy != BT_CHANNEL_POLICY_AMP_PREFERRED)
+			return;
+		chan->move_role = L2CAP_MOVE_ROLE_INITIATOR;
+		chan->move_state = L2CAP_MOVE_WAIT_PREPARE;
+		/* Placeholder - start physical link setup */
+	} else {
+		chan->move_role = L2CAP_MOVE_ROLE_INITIATOR;
+		chan->move_state = L2CAP_MOVE_WAIT_RSP_SUCCESS;
+		chan->move_id = 0;
+		l2cap_move_setup(chan);
+		l2cap_send_move_chan_req(chan, 0);
+	}
+}
+
 static void l2cap_do_create(struct l2cap_chan *chan, int result,
 			    u8 local_amp_id, u8 remote_amp_id)
 {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 89f1472..1bcfb84 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -736,6 +736,11 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
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
1.8.0

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
