Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/8] Bluetooth:  Make sure the L2CAP FCS is only enabled for ERTM or streaming.
Date: Mon,  2 Aug 2010 12:20:03 -0700
Message-Id: <1280776810-18213-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9ba1e8e..aed72f2 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3127,8 +3127,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
-		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
-		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
+		if ((l2cap_pi(sk)->mode == L2CAP_MODE_ERTM ||
+			l2cap_pi(sk)->mode == L2CAP_MODE_STREAMING) &&
+			(!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
+			l2cap_pi(sk)->fcs != L2CAP_FCS_NONE))
 			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
 
 		sk->sk_state = BT_CONNECTED;
@@ -3217,8 +3219,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
-		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
-		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
+		if ((l2cap_pi(sk)->mode == L2CAP_MODE_ERTM ||
+			l2cap_pi(sk)->mode == L2CAP_MODE_STREAMING) &&
+			(!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
+			l2cap_pi(sk)->fcs != L2CAP_FCS_NONE))
 			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
 
 		sk->sk_state = BT_CONNECTED;
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
