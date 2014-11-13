Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: Trigger SMP for the appropriate LE CoC errors
Date: Thu, 13 Nov 2014 10:55:19 +0200
Message-Id: <1415868919-12040-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415868919-12040-1-git-send-email-johan.hedberg@gmail.com>
References: <1415868919-12040-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The insufficient authentication/encryption errors indicate to the L2CAP
client that it should try to elevate the security level. Since there
really isn't any exception to this rule it makes sense to fully handle
it on the kernel side instead of pushing the responsibility to user
space.

This patch adds special handling of these two error codes and calls
smp_conn_security() with the elevated security level if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a37f809591ad..15784d32108d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5218,9 +5218,10 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 				u8 *data)
 {
 	struct l2cap_le_conn_rsp *rsp = (struct l2cap_le_conn_rsp *) data;
+	struct hci_conn *hcon = conn->hcon;
 	u16 dcid, mtu, mps, credits, result;
 	struct l2cap_chan *chan;
-	int err;
+	int err, sec_level;
 
 	if (cmd_len < sizeof(*rsp))
 		return -EPROTO;
@@ -5259,6 +5260,26 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		l2cap_chan_ready(chan);
 		break;
 
+	case L2CAP_CR_AUTHENTICATION:
+	case L2CAP_CR_ENCRYPTION:
+		/* If we already have MITM protection we can't do
+		 * anything.
+		 */
+		if (hcon->sec_level > BT_SECURITY_MEDIUM) {
+			l2cap_chan_del(chan, ECONNREFUSED);
+			break;
+		}
+
+		sec_level = hcon->sec_level + 1;
+		if (chan->sec_level < sec_level)
+			chan->sec_level = sec_level;
+
+		/* We'll need to send a new Connect Request */
+		clear_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags);
+
+		smp_conn_security(hcon, chan->sec_level);
+		break;
+
 	default:
 		l2cap_chan_del(chan, ECONNREFUSED);
 		break;
-- 
2.1.0

