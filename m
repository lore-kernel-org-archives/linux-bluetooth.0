Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 1/6] Bluetooth: Allow to set flush timeout
Date: Mon,  8 Oct 2012 17:52:07 +0300
Message-Id: <1349707932-10006-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a71c408..b0014d5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -529,6 +529,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		chan->fcs  = opts.fcs;
 		chan->max_tx = opts.max_tx;
 		chan->tx_win = opts.txwin_size;
+		chan->flush_to = opts.flush_to;
 		break;
 
 	case L2CAP_LM:
-- 
1.7.9.5

