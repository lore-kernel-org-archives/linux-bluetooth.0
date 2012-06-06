Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix deadlock and crash when SMP pairing times out
Date: Wed,  6 Jun 2012 18:44:11 +0800
Message-Id: <1338979451-15851-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
References: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The l2cap_conn_del function tries to cancel_sync the security timer, but
when it's called from the timeout function itself a deadlock occurs.
Subsequently the "hcon->l2cap_data = NULL" that's supposed to protect
multiple calls to l2cap_conn_del never gets cleared and when the
connection finally drops we double free's etc which will crash the
kernel.

This patch fixes the issue by using the HCI_CONN_LE_SMP_PEND for
protecting against this. The same flag is also used for the same purpose
in other places in the SMP code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f9bffe3..4ca8824 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1314,7 +1314,12 @@ static void security_timeout(struct work_struct *work)
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
 						security_timer.work);
 
-	l2cap_conn_del(conn->hcon, ETIMEDOUT);
+	BT_DBG("conn %p", conn);
+
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
+		smp_chan_destroy(conn);
+		l2cap_conn_del(conn->hcon, ETIMEDOUT);
+	}
 }
 
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
-- 
1.7.10

