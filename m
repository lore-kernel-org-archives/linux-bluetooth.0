Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 25/31] Bluetooth: Fix LE L2CAP Connect Request handling together with SMP
Date: Wed,  4 Dec 2013 16:11:21 +0200
Message-Id: <1386166287-13693-26-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Unlike BR/EDR, for LE when we're in the BT_CONNECT state we may or may
not have already have sent the Connect Request. This means that we need
some extra tracking of the request. This patch adds an extra channel
flag to prevent the request from being sent a second time.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_core.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c6c86d0e39c5..a4616eeeb8b5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -695,6 +695,7 @@ enum {
 	FLAG_EXT_CTRL,
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
+	FLAG_LE_CONN_REQ_SENT,
 };
 
 enum {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eb6edbcc3ce3..0e3a6eac289c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1223,6 +1223,9 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_conn_req req;
 
+	if (test_and_set_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags))
+		return;
+
 	req.psm     = chan->psm;
 	req.scid    = cpu_to_le16(chan->scid);
 	req.mtu     = cpu_to_le16(chan->imtu);
-- 
1.8.4.2

