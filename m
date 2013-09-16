Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/8] Bluetooth: Fix L2CAP error return used for failed channel lookups
Date: Mon, 16 Sep 2013 13:05:14 +0300
Message-Id: <1379325919-19003-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The EFAULT error should only be used for memory address related errors
and ENOENT might be needed for other purposes than invalid CID errors.
This patch fixes the l2cap_config_req, l2cap_connect_create_rsp and
l2cap_create_channel_req handlers to use the unique EBADSLT error to
indicate failed lookups on a given CID.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0b8a270..eb60cf7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3884,13 +3884,13 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	if (scid) {
 		chan = __l2cap_get_chan_by_scid(conn, scid);
 		if (!chan) {
-			err = -EFAULT;
+			err = -EBADSLT;
 			goto unlock;
 		}
 	} else {
 		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
-			err = -EFAULT;
+			err = -EBADSLT;
 			goto unlock;
 		}
 	}
@@ -3978,7 +3978,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
-		return -ENOENT;
+		return -EBADSLT;
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		struct l2cap_cmd_rej_cid rej;
@@ -4438,7 +4438,7 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 		hs_hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, conn->dst);
 		if (!hs_hcon) {
 			hci_dev_put(hdev);
-			return -EFAULT;
+			return -EBADSLT;
 		}
 
 		BT_DBG("mgr %p bredr_chan %p hs_hcon %p", mgr, chan, hs_hcon);
-- 
1.8.4.rc3

