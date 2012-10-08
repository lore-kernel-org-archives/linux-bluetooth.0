Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow to set flush timeout
Date: Mon,  8 Oct 2012 12:09:16 +0300
Message-Id: <1349687357-11829-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <506B3010.6060606@globaledgesoft.com>
References: <506B3010.6060606@globaledgesoft.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_sock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0c05d7d..70578d8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -536,6 +536,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		chan->fcs  = opts.fcs;
 		chan->max_tx = opts.max_tx;
 		chan->tx_win = opts.txwin_size;
+		chan->flush_to = opts.flush_to;
 		break;
 
 	case L2CAP_LM:
-- 
1.7.9.5

