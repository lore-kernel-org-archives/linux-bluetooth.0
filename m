Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded timer clear
Date: Wed, 21 Mar 2012 10:34:32 +0200
Message-Id: <1332318872-15225-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

set_chan_timer clears timer itself

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8598489..9c86d73 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -454,7 +454,6 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	case BT_CONFIG:
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 					conn->hcon->type == ACL_LINK) {
-			__clear_chan_timer(chan);
 			__set_chan_timer(chan, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, chan, reason);
 		} else
@@ -4538,7 +4537,6 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 
 	if (encrypt == 0x00) {
 		if (chan->sec_level == BT_SECURITY_MEDIUM) {
-			__clear_chan_timer(chan);
 			__set_chan_timer(chan, L2CAP_ENC_TIMEOUT);
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
 			l2cap_chan_close(chan, ECONNREFUSED);
@@ -4596,7 +4594,6 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			if (!status) {
 				l2cap_send_conn_req(chan);
 			} else {
-				__clear_chan_timer(chan);
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
 		} else if (chan->state == BT_CONNECT2) {
-- 
1.7.9.1

