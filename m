Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix possible NULL pointer derefence in l2cap code
Date: Wed, 11 May 2011 15:14:58 +0200
Message-ID: <1305119698-22888-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d0769a8..d9833d1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3292,6 +3292,11 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 		l2cap_send_sframe(chan, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
+		if (!new) {
+			BT_ERR("Memory allocation failed on tx_seq = %d",
+							chan->expected_tx_seq);
+			break;
+		}
 		new->tx_seq = chan->expected_tx_seq;
 		chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 		list_add_tail(&new->list, &chan->srej_l);
-- 
on behalf of ST-Ericsson

