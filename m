Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/6] Bluetooth: l2cap: Set more channel defaults
Date: Wed, 28 May 2014 14:43:04 +0300
Message-Id: <1401277388-4611-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1401277388-4611-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1401277388-4611-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Default values for various channel settings were missing. This
way channel users do not need to set default values themselves.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bb41d9b..d080581 100644
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

