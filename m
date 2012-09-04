Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 07/15] Bluetooth: L2CAP: Create Conf Response function
Date: Tue,  4 Sep 2012 16:44:26 +0300
Message-Id: <1346766274-21612-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use function to factor out similar code. For BR/EDR send EFS
Configuration Response immediately, for HS response will be sent
after receiving Logical Link Complete event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9a21a31..609a4cd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3631,6 +3631,22 @@ static inline void set_default_fcs(struct l2cap_chan *chan)
 		chan->fcs = L2CAP_FCS_CRC16;
 }
 
+static void l2cap_send_efs_conf_rsp(struct l2cap_chan *chan, void *data,
+				    u8 ident, u16 flags)
+{
+	struct l2cap_conn *conn = chan->conn;
+
+	BT_DBG("conn %p chan %p ident %d flags 0x%4.4x", conn, chan, ident,
+	       flags);
+
+	clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
+	set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+
+	l2cap_send_cmd(conn, ident, L2CAP_CONF_RSP,
+		       l2cap_build_conf_rsp(chan, data,
+					    L2CAP_CONF_SUCCESS, flags), data);
+}
+
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
@@ -3726,12 +3742,11 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 		/* check compatibility */
 
-		clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
-		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
-
-		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-					l2cap_build_conf_rsp(chan, rsp,
-					L2CAP_CONF_SUCCESS, flags), rsp);
+		/* Send rsp for BR/EDR channel */
+		if (!chan->ctrl_id)
+			l2cap_send_efs_conf_rsp(chan, rsp, cmd->ident, flags);
+		else
+			chan->ident = cmd->ident;
 	}
 
 unlock:
@@ -3781,12 +3796,11 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 			if (l2cap_check_efs(chan))
 				amp_create_logical_link(chan);
 
-			clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
-			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
-
-			l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-						l2cap_build_conf_rsp(chan, buf,
-						L2CAP_CONF_SUCCESS, 0x0000), buf);
+			if (!chan->ctrl_id)
+				l2cap_send_efs_conf_rsp(chan, buf, cmd->ident,
+							0);
+			else
+				chan->ident = cmd->ident;
 		}
 		goto done;
 
-- 
1.7.9.5

