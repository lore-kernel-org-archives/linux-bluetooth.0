Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/13] Bluetooth: Remove useless hci_conn disc_timeout setting
Date: Mon, 29 Apr 2013 19:35:44 +0300
Message-Id: <1367253345-12482-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no need to reset disc_timeout in l2cap_le_conn_ready since
HCI_DISCONN_TIMEOUT is the default when the hci_conn is created and
there should be no way for it to get changed between creation and
l2cap_le_conn_ready being called.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c78a510..d510550 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1363,8 +1363,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	chan->dcid = L2CAP_CID_ATT;
 
-	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
-
 	bacpy(&bt_sk(chan->sk)->src, conn->src);
 	bacpy(&bt_sk(chan->sk)->dst, conn->dst);
 
-- 
1.7.10.4

