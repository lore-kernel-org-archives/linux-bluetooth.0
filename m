Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 32/49] Bluetooth: Add dummy handler for LE SC keypress notification
Date: Wed,  3 Dec 2014 17:02:26 +0200
Message-Id: <1417618963-18010-33-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since we don not actively try to clear the keypress notification bit we
might get these PDUs. To avoid failing the pairing process add a simple
dummy handler for these for now.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 458d07d5603b..16bd15e04b85 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2346,6 +2346,16 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
+				   struct sk_buff *skb)
+{
+	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
+
+	BT_DBG("value 0x%02x", kp->value);
+
+	return 0;
+}
+
 static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -2438,6 +2448,10 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		reason = smp_cmd_dhkey_check(conn, skb);
 		break;
 
+	case SMP_CMD_KEYPRESS_NOTIFY:
+		reason = smp_cmd_keypress_notify(conn, skb);
+		break;
+
 	default:
 		BT_DBG("Unknown command code 0x%2.2x", code);
 		reason = SMP_CMD_NOTSUPP;
-- 
2.1.0

