Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/8] Bluetooth: Fix L2CAP error return used for failed channel lookups
Date: Sun, 15 Sep 2013 21:16:38 +0300
Message-Id: <1379269001-6313-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com>
References: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The EFAULT error should only be used for memory address related errors
whereas ENOENT should be used for failed lookups for the given CID. This
patch fixes the l2cap_connect_create_rsp and l2cap_create_channel_req
handlers to use the correct ENOENT error return.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0b1a656..3b0633f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3884,13 +3884,13 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	if (scid) {
 		chan = __l2cap_get_chan_by_scid(conn, scid);
 		if (!chan) {
-			err = -EFAULT;
+			err = -ENOENT;
 			goto unlock;
 		}
 	} else {
 		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
-			err = -EFAULT;
+			err = -ENOENT;
 			goto unlock;
 		}
 	}
@@ -4438,7 +4438,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 		hs_hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, conn->dst);
 		if (!hs_hcon) {
 			hci_dev_put(hdev);
-			return -EFAULT;
+			return -ENOENT;
 		}
 
 		BT_DBG("mgr %p bredr_chan %p hs_hcon %p", mgr, chan, hs_hcon);
-- 
1.8.4.rc3

