Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/2] Bluetooth: Release chan lock upon sleeping
Date: Thu, 31 May 2012 16:25:43 -0300
Message-Id: <1338492344-1474-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The lock must be released otherwise we block any other piece of the code
trying to lock the chan lock.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9750204..1cb3ca0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1569,7 +1569,9 @@ int __l2cap_wait_ack(struct sock *sk)
 		}
 
 		release_sock(sk);
+		l2cap_chan_unlock(chan);
 		timeo = schedule_timeout(timeo);
+		l2cap_chan_lock(chan);
 		lock_sock(sk);
 		set_current_state(TASK_INTERRUPTIBLE);
 
-- 
1.7.10.2

