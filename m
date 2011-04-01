Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/15] Bluetooth: Fix lockdep warning with skb list lock
Date: Fri,  1 Apr 2011 19:33:20 -0300
Message-Id: <1301697200-2446-16-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-15-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-10-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-11-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-12-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-13-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-14-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-15-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a regression acctually, caused by the first patch series for
creating a formal strcut l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0cf3a55..0dd8d5b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -236,6 +236,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	} else
 		sk->sk_state_change(sk);
 
+	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE &&
+			l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE))
+		goto free;
+
 	skb_queue_purge(TX_QUEUE(sk));
 
 	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
@@ -254,6 +258,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		}
 	}
 
+free:
 	kfree(chan);
 }
 
-- 
1.7.4.1

