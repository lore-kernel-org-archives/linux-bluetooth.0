Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/5] Bluetooth: Only enable L2CAP FCS for ERTM or streaming.
Date: Tue, 10 Aug 2010 12:00:46 -0700
Message-Id: <1281466850-5297-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281466850-5297-1-git-send-email-mathewm@codeaurora.org>
References: <1281466850-5297-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a bug which caused the FCS setting to show L2CAP_FCS_CRC16
with L2CAP modes other than ERTM or streaming.  At present, this only
affects the FCS value shown with getsockopt() for basic mode.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index fadf26b..c784703 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3071,6 +3071,17 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	return 0;
 }
 
+static inline void set_default_fcs(struct l2cap_pinfo *pi)
+{
+	/* FCS is enabled only in ERTM or streaming mode, if one or both
+	 * sides request it.
+	 */
+	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
+		pi->fcs = L2CAP_FCS_NONE;
+	else if (!(pi->conf_state & L2CAP_CONF_NO_FCS_RECV))
+		pi->fcs = L2CAP_FCS_CRC16;
+}
+
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
@@ -3135,9 +3146,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
-		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
-		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
-			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
+		set_default_fcs(l2cap_pi(sk));
 
 		sk->sk_state = BT_CONNECTED;
 
@@ -3225,9 +3234,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
-		if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_NO_FCS_RECV) ||
-		    l2cap_pi(sk)->fcs != L2CAP_FCS_NONE)
-			l2cap_pi(sk)->fcs = L2CAP_FCS_CRC16;
+		set_default_fcs(l2cap_pi(sk));
 
 		sk->sk_state = BT_CONNECTED;
 		l2cap_pi(sk)->next_tx_seq = 0;
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
