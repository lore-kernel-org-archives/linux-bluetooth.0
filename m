Return-Path: <bastienphilbert@gmail.com>
From: Bastien Philbert <bastienphilbert@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: Fix locking issues in the function l2cap_connect_cfm
Date: Mon,  4 Apr 2016 16:32:40 -0400
Message-Id: <1459801960-8886-1-git-send-email-bastienphilbert@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a locking issue in the function l2cap_connect_cfm for
not locking the mutex lock for channels on the l2cap_conn structure
pointer conn before calling __l2cap_get_chan_by_dcid as all callers
need to lock and unlock this mutex before calling this function due
to issues with either concurrent users or race conditions arising

Signed-off-by: Bastien Philbert <bastienphilbert@gmail.com>
---
 net/bluetooth/l2cap_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eb4f5f2..2ab103e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7308,6 +7308,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		struct l2cap_chan *chan, *next;
 
 		/* Client fixed channels should override server ones */
+		mutex_lock(&conn->chan_lock);
 		if (__l2cap_get_chan_by_dcid(conn, pchan->scid))
 			goto next;
 
@@ -7324,6 +7325,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 		l2cap_chan_unlock(pchan);
 next:
+		mutex_unlock(&conn->chan_lock);
 		next = l2cap_global_fixed_chan(pchan, hcon);
 		l2cap_chan_put(pchan);
 		pchan = next;
-- 
2.5.0
