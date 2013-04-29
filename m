Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/13] Bluetooth: Fix duplicate call to l2cap_chan_ready()
Date: Mon, 29 Apr 2013 19:35:40 +0300
Message-Id: <1367253345-12482-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In l2cap_le_conn_ready() after doing l2cap_chann_add() the LE channel is
part of the list which is subsequently iterated in l2cap_conn_ready() in
this loop each channel will get l2cap_chan_ready() called which would
result in trying to set the channel two times into BT_CONNECTED state.
Instead it makes sense to just add the channel but not call chan_ready
in l2cap_le_conn_ready, which is what this patch does.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 60d13bc..881be61 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1371,8 +1371,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	l2cap_chan_add(conn, chan);
 
-	l2cap_chan_ready(chan);
-
 clean:
 	release_sock(parent);
 }
-- 
1.7.10.4

