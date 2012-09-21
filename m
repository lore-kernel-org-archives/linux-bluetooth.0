Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org, johan.hedberg@gmail.com
Subject: [PATCH 2/2] Bluetooth: Factor out Create Configuration Response
Date: Fri, 21 Sep 2012 12:30:05 +0300
Message-Id: <1348219805-19406-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1348219805-19406-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1348219805-19406-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use function to factor out similar code. For BR/EDR send EFS
Configuration Response immediately, for HS response will be sent
after receiving HCI Logical Link Complete event in the following
patches.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9732f03..d43128f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3557,6 +3557,22 @@ static inline void set_default_fcs(struct l2cap_chan *chan)
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
@@ -3648,16 +3664,11 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	/* Got Conf Rsp PENDING from remote side and asume we sent
 	   Conf Rsp PENDING in the code above */
 	if (test_bit(CONF_REM_CONF_PEND, &chan->conf_state) &&
-			test_bit(CONF_LOC_CONF_PEND, &chan->conf_state)) {
+	    test_bit(CONF_LOC_CONF_PEND, &chan->conf_state)) {
 
 		/* check compatibility */
 
-		clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
-		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
-
-		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-					l2cap_build_conf_rsp(chan, rsp,
-					L2CAP_CONF_SUCCESS, flags), rsp);
+		l2cap_send_efs_conf_rsp(chan, rsp, cmd->ident, flags);
 	}
 
 unlock:
@@ -3705,12 +3716,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 			/* check compatibility */
 
-			clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
-			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
-
-			l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-						l2cap_build_conf_rsp(chan, buf,
-						L2CAP_CONF_SUCCESS, 0x0000), buf);
+			l2cap_send_efs_conf_rsp(chan, buf, cmd->ident, 0);
 		}
 		goto done;
 
-- 
1.7.9.5

