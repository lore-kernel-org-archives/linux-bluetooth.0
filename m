Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/8] Bluetooth: l2cap: Set more channel defaults
Date: Fri, 23 May 2014 12:27:24 +0300
Message-Id: <1400837248-12179-5-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 60433c4..3a7f560 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -471,8 +471,14 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 	chan->max_tx = L2CAP_DEFAULT_MAX_TX;
 	chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
 	chan->tx_win_max = L2CAP_DEFAULT_TX_WINDOW;
+	chan->remote_max_tx = chan->max_tx;
+	chan->remote_tx_win = chan->tx_win;
 	chan->ack_win = L2CAP_DEFAULT_TX_WINDOW;
 	chan->sec_level = BT_SECURITY_LOW;
+	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
+	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
+	chan->conf_state = 0;
 
 	set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 }
-- 
1.8.3.1

