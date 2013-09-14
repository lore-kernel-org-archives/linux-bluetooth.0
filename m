Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/8] Bluetooth: Fix sending responses to identified L2CAP response packets
Date: Sat, 14 Sep 2013 20:28:29 +0300
Message-Id: <1379179711-16436-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When L2CAP packets return a non-zero error and the value is passed
onwards by l2cap_bredr_sig_cmd this will trigger a command reject packet
to be sent. However, the core specification (page 1416 in core 4.0) says
the following: "Command Reject packets should not be sent in response to
an identified Response packet.".

This patch ensures that a command reject packet is not sent for any
identified response packet by ignoring the error return value from the
response handler functions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d134501..7d36051 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5212,7 +5212,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 
 	case L2CAP_CONN_RSP:
 	case L2CAP_CREATE_CHAN_RSP:
-		err = l2cap_connect_create_rsp(conn, cmd, cmd_len, data);
+		l2cap_connect_create_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_CONF_REQ:
@@ -5220,7 +5220,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CONF_RSP:
-		err = l2cap_config_rsp(conn, cmd, cmd_len, data);
+		l2cap_config_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_DISCONN_REQ:
@@ -5228,7 +5228,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_DISCONN_RSP:
-		err = l2cap_disconnect_rsp(conn, cmd, cmd_len, data);
+		l2cap_disconnect_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_ECHO_REQ:
@@ -5243,7 +5243,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_INFO_RSP:
-		err = l2cap_information_rsp(conn, cmd, cmd_len, data);
+		l2cap_information_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_CREATE_CHAN_REQ:
@@ -5255,7 +5255,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_MOVE_CHAN_RSP:
-		err = l2cap_move_channel_rsp(conn, cmd, cmd_len, data);
+		l2cap_move_channel_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_MOVE_CHAN_CFM:
@@ -5263,7 +5263,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_MOVE_CHAN_CFM_RSP:
-		err = l2cap_move_channel_confirm_rsp(conn, cmd, cmd_len, data);
+		l2cap_move_channel_confirm_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	default:
-- 
1.8.4.rc3

