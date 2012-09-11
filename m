Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 20/20] Bluetooth: Start channel move when socket option is changed
Date: Tue, 11 Sep 2012 11:21:31 -0700
Message-Id: <1347387691-5285-21-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Channel moves are triggered by changes to the BT_CHANNEL_POLICY
sockopt when an ERTM or streaming-mode channel is connected.

Moves are only started if enable_hs is true.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 20 ++++++++++++++++++++
 net/bluetooth/l2cap_sock.c    |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cfbde8f..b6a57c8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -799,5 +799,6 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
+void l2cap_move_start(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 35baa27..06942a8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4435,6 +4435,26 @@ static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 	}
 }
 
+void l2cap_move_start(struct l2cap_chan *chan)
+{
+	BT_DBG("chan %p", chan);
+
+	if (chan->local_amp_id == 0) {
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
 static void l2cap_do_create(struct l2cap_chan *chan, int result,
 			    u8 local_amp_id, u8 remote_amp_id)
 {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 13f6a98..f77f5a3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -725,6 +725,11 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
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
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
