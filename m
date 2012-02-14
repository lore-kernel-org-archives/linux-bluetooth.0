Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Drop frames without F-bit set when in WAIT_F state
Date: Tue, 14 Feb 2012 14:56:36 +0100
Message-ID: <1329227796-22609-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When transmitter is in WAIT_F state any frames received without F-bit=1
should not be processed (With-Valid-F-bit condition is not true).

This was affecting TP/ERM/BI-05-C PTS test.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8efac78..1a724c6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4190,6 +4190,11 @@ static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		goto drop;
 	}
 
+	/* drop frame without F-bit set when in WAIT_F state */
+	if (test_bit(CONN_WAIT_F, &chan->conn_state) &&
+			!__is_ctrl_final(chan, control))
+		goto drop;
+
 	if (!__is_sframe(chan, control)) {
 		if (len < 0) {
 			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
-- 
on behalf of ST-Ericsson

