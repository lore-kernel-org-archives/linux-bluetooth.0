Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix handling of L2CAP Command Reject over LE
Date: Tue, 10 Dec 2013 10:52:48 +0200
Message-Id: <1386665568-7801-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we receive an L2CAP command reject message over LE we should take
appropriate action on the corresponding channel. This is particularly
important when trying to interact with a remote pre-4.1 system using LE
CoC signaling messages. If we don't react to the command reject the
corresponding socket would not be notified until a connection timeout
occurs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ae0054ccee5b..b6bca64b320d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5736,6 +5736,31 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	return 0;
 }
 
+static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
+				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+				       u8 *data)
+{
+	struct l2cap_cmd_rej_unk *rej = (struct l2cap_cmd_rej_unk *) data;
+	struct l2cap_chan *chan;
+
+	if (cmd_len < sizeof(*rej))
+		return -EPROTO;
+
+	mutex_lock(&conn->chan_lock);
+
+	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+	if (!chan)
+		goto done;
+
+	l2cap_chan_lock(chan);
+	l2cap_chan_del(chan, ECONNREFUSED);
+	l2cap_chan_unlock(chan);
+
+done:
+	mutex_unlock(&conn->chan_lock);
+	return 0;
+}
+
 static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
@@ -5755,6 +5780,7 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
+		l2cap_le_command_rej(conn, cmd, cmd_len, data);
 		break;
 
 	case L2CAP_CONN_PARAM_UPDATE_REQ:
-- 
1.8.4.2

