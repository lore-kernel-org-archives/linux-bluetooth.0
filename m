Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 02/26] Bluetooth: Adds set_default function in L2CAP setup
Date: Wed, 28 Mar 2012 16:31:25 +0300
Message-Id: <1332941509-21345-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Some parameters in L2CAP chan are set to default similar way in
socket based channels and A2MP channels. Adds common function which
sets all defaults.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   11 +++++++++++
 net/bluetooth/l2cap_sock.c    |    8 ++------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f6f0500..c70e2cf 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -915,5 +915,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan);
+void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3caff27..6ce16db 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -297,6 +297,17 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
+void l2cap_chan_set_defaults(struct l2cap_chan *chan)
+{
+	chan->fcs  = L2CAP_FCS_CRC16;
+	chan->max_tx = L2CAP_DEFAULT_MAX_TX;
+	chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+	chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
+	chan->sec_level = BT_SECURITY_LOW;
+
+	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+}
+
 static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1d3e9c3..ae1d78e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1006,12 +1006,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		} else {
 			chan->mode = L2CAP_MODE_BASIC;
 		}
-		chan->max_tx = L2CAP_DEFAULT_MAX_TX;
-		chan->fcs  = L2CAP_FCS_CRC16;
-		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
-		chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
-		chan->sec_level = BT_SECURITY_LOW;
-		set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+
+		l2cap_chan_set_defaults(chan);
 	}
 
 	/* Default config options */
-- 
1.7.9.1

