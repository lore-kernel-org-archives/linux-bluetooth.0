Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/8] Bluetooth: Fix L2CAP Disconnect response for unknown CID
Date: Mon, 16 Sep 2013 13:05:15 +0300
Message-Id: <1379325919-19003-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we receive an L2CAP Disconnect Request for an unknown CID we should
not just silently drop it but reply with a proper Command Reject
response. This patch fixes this by ensuring that the disconnect handler
returns a proper error instead of 0 and will cause the function caller
to send the right response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eb60cf7..31bf812 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4206,7 +4206,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 	chan = __l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan) {
 		mutex_unlock(&conn->chan_lock);
-		return 0;
+		return -EBADSLT;
 	}
 
 	l2cap_chan_lock(chan);
-- 
1.8.4.rc3

