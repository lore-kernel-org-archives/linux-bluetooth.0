Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 7/8] Bluetooth: Fix responding to invalid L2CAP signaling commands
Date: Sat, 14 Sep 2013 20:28:30 +0300
Message-Id: <1379179711-16436-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we have an LE link we should not respond to any data on the BR/EDR
L2CAP signaling channel (0x0001) and vice-versa when we have a BR/EDR
link we should not respond to LE L2CAP (CID 0x0005) signaling commands.
This patch fixes this issue by checking for a valid link type and
ignores data if it is wrong.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7d36051..247a955 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5311,6 +5311,7 @@ static u16 l2cap_err_to_reason(int err)
 static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 					struct sk_buff *skb)
 {
+	struct hci_conn *hcon = conn->hcon;
 	u8 *data = skb->data;
 	int len = skb->len;
 	struct l2cap_cmd_hdr cmd;
@@ -5318,6 +5319,9 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 
 	l2cap_raw_recv(conn, skb);
 
+	if (hcon->type != LE_LINK)
+		return;
+
 	while (len >= L2CAP_CMD_HDR_SIZE) {
 		u16 cmd_len;
 		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
@@ -5356,6 +5360,7 @@ static inline void l2cap_le_sig_channel(struct l2cap_conn *conn,
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
+	struct hci_conn *hcon = conn->hcon;
 	u8 *data = skb->data;
 	int len = skb->len;
 	struct l2cap_cmd_hdr cmd;
@@ -5363,6 +5368,9 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 
 	l2cap_raw_recv(conn, skb);
 
+	if (hcon->type != ACL_LINK)
+		return;
+
 	while (len >= L2CAP_CMD_HDR_SIZE) {
 		u16 cmd_len;
 		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
-- 
1.8.4.rc3

