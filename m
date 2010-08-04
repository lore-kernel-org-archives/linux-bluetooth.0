Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/9] Bluetooth:  Only enable for L2CAP FCS for ERTM or streaming.
Date: Wed,  4 Aug 2010 15:48:58 -0700
Message-Id: <1280962146-22604-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
with L2CAP modes other than ERTM or streaming.  At present, this only
affects the FCS value shown with getsockopt() for basic mode.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9ba1e8e..a2706d9 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3063,6 +3063,17 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	return 0;
 }
 
+static inline int l2cap_fcs_needed(struct l2cap_pinfo *pi)
+{
+	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
+		return 0;
+	else {
+		/* FCS is enabled if one or both sides request it. */
+		return !(pi->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
+			pi->fcs == L2CAP_FCS_CRC16;
+	}
+}
+
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
@@ -3127,8 +3138,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
-		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
-		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
+		if (l2cap_fcs_needed(l2cap_pi(sk)))
 			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
 
 		sk->sk_state = BT_CONNECTED;
@@ -3217,8 +3227,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
-		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
-		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
+		if (l2cap_fcs_needed(l2cap_pi(sk)))
 			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
 
 		sk->sk_state = BT_CONNECTED;
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
