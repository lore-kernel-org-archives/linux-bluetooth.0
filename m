Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/9] Bluetooth: Call l2cap_conn_shutdown() when SMP recv callback fails
Date: Mon, 11 Aug 2014 22:06:38 +0300
Message-Id: <1407784004-12448-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
References: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To restore pre-l2cap_chan functionality we should be trying to
disconnect the connection when receviving garbage SMP data (i.e. when
the SMP command handler fails). This patch renames the command handler
back to smp_sig_channel() and adds a smp_recv_cb() wrapper function for
calling it. If smp_sig_channel() fails the code calls
l2cap_conn_shutdown().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 28014ad3d2d3..7a295d7edc44 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1375,7 +1375,7 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
-static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
+static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
@@ -1514,6 +1514,24 @@ static void smp_ready_cb(struct l2cap_chan *chan)
 	l2cap_chan_hold(chan);
 }
 
+static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	int err;
+
+	BT_DBG("chan %p", chan);
+
+	err = smp_sig_channel(chan, skb);
+	if (err) {
+		struct l2cap_conn *conn = chan->conn;
+
+		cancel_delayed_work_sync(&conn->security_timer);
+
+		l2cap_conn_shutdown(chan->conn, -err);
+	}
+
+	return err;
+}
+
 static struct sk_buff *smp_alloc_skb_cb(struct l2cap_chan *chan,
 					unsigned long hdr_len,
 					unsigned long len, int nb)
-- 
1.9.3

