Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix variable assignment for internal function returns in the function l2cap_bredr_sig_cmd
Date: Fri, 18 Dec 2015 23:12:27 -0500
Message-Id: <1450498347-20994-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This makes all internal functions that can return a error code to
properly signal this to the caller of the function l2cap_bredr_sig_cmd
by making their return value equal to the variable err before returning
to the caller of the function l2cap_bredr_sig_cmd with this value
as to allow us to correctly signal when a failure has occurred when
this particular function is called.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c65ee2..488eebe 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5319,7 +5319,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
-		l2cap_command_rej(conn, cmd, cmd_len, data);
+		err = l2cap_command_rej(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_CONN_REQ:
@@ -5328,7 +5328,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 
 	case L2CAP_CONN_RSP:
 	case L2CAP_CREATE_CHAN_RSP:
-		l2cap_connect_create_rsp(conn, cmd, cmd_len, data);
+		err = l2cap_connect_create_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_CONF_REQ:
@@ -5336,7 +5336,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_CONF_RSP:
-		l2cap_config_rsp(conn, cmd, cmd_len, data);
+		err = l2cap_config_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_DISCONN_REQ:
@@ -5344,7 +5344,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 		break;
 
 	case L2CAP_DISCONN_RSP:
-		l2cap_disconnect_rsp(conn, cmd, cmd_len, data);
+		err = l2cap_disconnect_rsp(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_ECHO_REQ:
-- 
2.1.4
