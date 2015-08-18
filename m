Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix locking issues in the function l2cap_connect_cfm
Date: Tue, 18 Aug 2015 15:08:22 -0400
Message-Id: <1439924902-13408-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a locking issue in the function l2cap_connect_cfm for
not locking the mutex lock for channels on the l2cap_conn structure
pointer conn before calling __l2cap_get_chan_by_dcid as all callers
need to lock and unlock this mutex before calling this function due
to issues with either concurrent users or race conditions arising
if this mutex is not locked before these calls.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/l2cap_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 45fffa4..fcee783 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7285,9 +7285,11 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		struct l2cap_chan *chan, *next;
 
 		/* Client fixed channels should override server ones */
+		mutex_lock(&conn->chan_lock);
 		if (__l2cap_get_chan_by_dcid(conn, pchan->scid))
 			goto next;
-
+
+		mutex_unlock(&conn->chan_lock);
 		l2cap_chan_lock(pchan);
 		chan = pchan->ops->new_connection(pchan);
 		if (chan) {
@@ -7301,6 +7303,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 		l2cap_chan_unlock(pchan);
 next:
+		mutex_unlock(&conn->chan_lock);
 		next = l2cap_global_fixed_chan(pchan, hcon);
 		l2cap_chan_put(pchan);
 		pchan = next;
-- 
2.1.4
