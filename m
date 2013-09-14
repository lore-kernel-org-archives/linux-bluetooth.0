Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/8] Bluetooth: Fix error code for invalid CID in l2cap_config_req
Date: Sat, 14 Sep 2013 20:28:28 +0300
Message-Id: <1379179711-16436-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
References: <1379179711-16436-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The convention of the L2CAP code is to return EFAULT when a CID in the
request packet is invalid. This patch fixes the l2cap_config_req to use
that error code instead of ENOENT.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9ec1561f..d134501 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3978,7 +3978,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 
 	chan = l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
-		return -ENOENT;
+		return -EFAULT;
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		struct l2cap_cmd_rej_cid rej;
-- 
1.8.4.rc3

