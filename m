Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix calling hci_conn_put too early
Date: Thu, 11 Dec 2014 21:45:44 +0200
Message-Id: <1418327146-15899-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
References: <1418327146-15899-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The pairing_complete() function relies on a hci_conn reference to be
able to access the hci_conn object. It should therefore only release
this reference once it's done accessing the object, i.e. at the end of
the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 16ac03730f4d..34da65ccc888 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3115,14 +3115,14 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	conn->disconn_cfm_cb = NULL;
 
 	hci_conn_drop(conn);
-	hci_conn_put(conn);
-
 	mgmt_pending_remove(cmd);
 
 	/* The device is paired so there is no need to remove
 	 * its connection parameters anymore.
 	 */
 	clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
+
+	hci_conn_put(conn);
 }
 
 void mgmt_smp_complete(struct hci_conn *conn, bool complete)
-- 
2.1.0

