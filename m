Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] Bluetooth: Fix __l2cap_no_conn_pending() usage with all channels
Date: Thu,  7 Aug 2014 10:12:24 +0300
Message-Id: <1407395551-30810-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
References: <1407395551-30810-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The __l2cap_no_conn_pending() function would previously only return a
meaningful value for connection oriented channels and was therefore not
useful for anything else. As preparation of making the L2CAP code more
generic allow the function to be called for other channel types as well
by returning a meaningful value for them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a49e9646a6b9..887f030beb5b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1082,6 +1082,9 @@ static void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, bool poll)
 
 static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 {
+	if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED)
+		return true;
+
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }
 
-- 
1.9.3

