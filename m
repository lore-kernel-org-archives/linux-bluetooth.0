Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Fix responding to invalid L2CAP signaling commands
Date: Fri, 13 Sep 2013 14:29:26 +0300
Message-Id: <1379071767-16604-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379071767-16604-1-git-send-email-johan.hedberg@gmail.com>
References: <1379071767-16604-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we have an LE link we should not respond to any data on the BR/EDR
L2CAP signaling channel (0x0001) and vice-versa when we have a BR/EDR
link we should not respond to LE L2CAP (CID 0x0005) signaling commands.
This patch fixes this issue by checking for a valid link type and
ignores data if it is wrong.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: no changes

 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ea3792f..1d03644 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5297,6 +5297,7 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 					struct sk_buff *skb)
 {
+	struct hci_conn *hcon = conn->hcon;
 	u8 *data = skb->data;
 	int len = skb->len;
 	struct l2cap_cmd_hdr cmd;
@@ -5304,6 +5305,9 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 
 	l2cap_raw_recv(conn, skb);
 
+	if (hcon->type != LE_LINK)
+		return;
+
 	while (len >= L2CAP_CMD_HDR_SIZE) {
 		u16 cmd_len;
 		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
@@ -5342,6 +5346,7 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
+	struct hci_conn *hcon = conn->hcon;
 	u8 *data = skb->data;
 	int len = skb->len;
 	struct l2cap_cmd_hdr cmd;
@@ -5349,6 +5354,9 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 
 	l2cap_raw_recv(conn, skb);
 
+	if (hcon->type != ACL_LINK)
+		return;
+
 	while (len >= L2CAP_CMD_HDR_SIZE) {
 		u16 cmd_len;
 		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
-- 
1.8.4.rc3

