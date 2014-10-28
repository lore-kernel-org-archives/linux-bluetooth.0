Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix LE connection timeout deadlock
Date: Tue, 28 Oct 2014 22:23:26 +0100
Message-Id: <1414531407-9785-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1414531407-9785-1-git-send-email-johan.hedberg@gmail.com>
References: <1414531407-9785-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The le_conn_timeout() may call hci_le_conn_failed() which in turn may
call hci_conn_del(). Trying to use the _sync variant for cancelling the
conn timeout from hci_conn_del() could therefore result in a deadlock.
This patch converts hci_conn_del() to use the non-sync variant so the
deadlock is not possible.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6a3225bf7bac..74b8e2421e96 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -518,7 +518,7 @@ int hci_conn_del(struct hci_conn *conn)
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
 	} else if (conn->type == LE_LINK) {
-		cancel_delayed_work_sync(&conn->le_conn_timeout);
+		cancel_delayed_work(&conn->le_conn_timeout);
 
 		if (hdev->le_pkts)
 			hdev->le_cnt += conn->sent;
-- 
1.9.3

