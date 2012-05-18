Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] Bluetooth: Do not purge queue in Basic Mode
Date: Fri, 18 May 2012 19:03:02 -0300
Message-Id: <1337378582-29271-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

chan->tx_q is only initialized if we use ERTM or Streaming mode.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b70dca4..ccd2d85 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -549,6 +549,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
 
+	if (chan->mode == L2CAP_MODE_BASIC)
+		return;
+
 	skb_queue_purge(&chan->tx_q);
 
 	if (chan->mode == L2CAP_MODE_ERTM) {
-- 
1.7.10.1

