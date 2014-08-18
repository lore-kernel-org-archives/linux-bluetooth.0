Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Use hci_disconnect for immediate disconnection from SMP
Date: Mon, 18 Aug 2014 20:33:29 +0300
Message-Id: <1408383214-16366-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
References: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Relying on the l2cap_conn_del procedure (triggered through the
l2cap_conn_shutdown API) to get the connection disconnected is not
reliable as it depends on all users releasing (through hci_conn_drop)
and that there's at least one user (so hci_conn_drop is called at least
one time).

A much simpler and more reliable solution is to call hci_disconnect()
directly from the SMP code when we want to disconnect. One side-effect
this has is that it prevents any SMP Failure PDU from being sent before
the disconnection, however neither one of the scenarios where
l2cap_conn_shutdown was used really requires this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 07ca4ce0943b..496584921fdc 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -829,7 +829,7 @@ static void smp_timeout(struct work_struct *work)
 
 	BT_DBG("conn %p", conn);
 
-	l2cap_conn_shutdown(conn, ETIMEDOUT);
+	hci_disconnect(conn->hcon, HCI_ERROR_REMOTE_USER_TERM);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
@@ -1569,7 +1569,7 @@ static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		if (smp)
 			cancel_delayed_work_sync(&smp->security_timer);
 
-		l2cap_conn_shutdown(chan->conn, -err);
+		hci_disconnect(chan->conn->hcon, HCI_ERROR_AUTH_FAILURE);
 	}
 
 	return err;
-- 
1.9.3

