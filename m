Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Delay check for conn->smp in smp_conn_security()
Date: Fri,  4 Sep 2015 12:22:46 +0300
Message-Id: <1441358566-24428-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several actions that smp_conn_security() might make that do
not require a valid SMP context (conn->smp pointer). One of these
actions is to encrypt the link with an existing LTK. If the SMP
context wasn't initialized properly we should still allow the
independent actions to be done, i.e. the check for the context should
only be done at the last possible moment.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ad82324f710f..0510a577a7b5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2311,12 +2311,6 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (!conn)
 		return 1;
 
-	chan = conn->smp;
-	if (!chan) {
-		BT_ERR("SMP security requested but not available");
-		return 1;
-	}
-
 	if (!hci_dev_test_flag(hcon->hdev, HCI_LE_ENABLED))
 		return 1;
 
@@ -2330,6 +2324,12 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 			return 0;
 
+	chan = conn->smp;
+	if (!chan) {
+		BT_ERR("SMP security requested but not available");
+		return 1;
+	}
+
 	l2cap_chan_lock(chan);
 
 	/* If SMP is already in progress ignore this request */
-- 
2.4.3

