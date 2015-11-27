Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND] bluetooth:Fix locking issues in the function l2cap_connect_cfm
Date: Fri, 27 Nov 2015 10:16:04 -0500
Message-Id: <1448637364-3144-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes a locking issue in the function l2cap_connect_cfm for
not locking the mutex lock for channels on the l2cap_conn structure
pointer conn before calling __l2cap_get_chan_by_dcid as all callers
need to lock and unlock this mutex before calling this function due
to issues with either concurrent users or race conditions arising
if this mutex is not locked before these calls.
v3 Fix double locking of mutex lock on goto next label to instead correctly
unlock the channel mutex
v2 Remove unneeded mutex_unlock for channels as the unlock was due early
for adding correct protection for all functions that have requirements
for this mutex lock needing to be locked before calling them.
Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/l2cap_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 45fffa4..20d3909 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7285,6 +7285,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		struct l2cap_chan *chan, *next;
 
 		/* Client fixed channels should override server ones */
+		mutex_lock(&conn->chan_lock);
 		if (__l2cap_get_chan_by_dcid(conn, pchan->scid))
 			goto next;
 
@@ -7301,6 +7302,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 		l2cap_chan_unlock(pchan);
 next:
+		mutex_unlock(&conn->chan_lock);
 		next = l2cap_global_fixed_chan(pchan, hcon);
 		l2cap_chan_put(pchan);
 		pchan = next;
-- 
2.1.4
