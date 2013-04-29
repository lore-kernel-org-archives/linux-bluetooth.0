Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/13] Bluetooth: Fix EBUSY condition test in l2cap_chan_connect
Date: Mon, 29 Apr 2013 19:35:37 +0300
Message-Id: <1367253345-12482-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The current test in l2cap_chan_connect is intended to protect against
multiple conflicting connect attempts. However, it assumes that there
will ever only be a single CID that is connected to, which is not true.
We do need to check for conflicts with connect attempts to the same
destination CID but this check is not in anyway specific to LE but can
be applied to BR/EDR as well.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95d46cd..fd8d3059 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1811,16 +1811,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		goto done;
 	}
 
-	if (hcon->type == LE_LINK) {
-		err = 0;
-
-		if (!list_empty(&conn->chan_l)) {
-			err = -EBUSY;
-			hci_conn_drop(hcon);
-		}
-
-		if (err)
-			goto done;
+	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
+		hci_conn_drop(hcon);
+		err = -EBUSY;
+		goto done;
 	}
 
 	/* Update source addr of the socket */
-- 
1.7.10.4

