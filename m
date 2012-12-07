Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5] Bluetooth: Fix using locked state_change for A2MP chan
Date: Fri,  7 Dec 2012 14:59:04 +0200
Message-Id: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

A2MP channel do not have sk associated so use unlocked version
of state_change. chan is already locked.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2c78208..d4a44dc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1196,7 +1196,7 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 	}
 
 	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
-		l2cap_state_change(chan, BT_DISCONN);
+		__l2cap_state_change(chan, BT_DISCONN);
 		return;
 	}
 
-- 
1.7.10.4

