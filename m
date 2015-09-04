Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Sep 2015 04:56:26 -0400
From: Chuck Ebbert <cebbert.lkml@gmail.com>
To: Oon-Ee Ng <ngoonee.talk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH - untested] bluetooth: Don't check for SMP security too
 early
Message-ID: <20150904045626.4881d34b@as>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 25ba26539 ("Bluetooth: Fix NULL pointer dereference in
smp_conn_security") added a check for NULL SMP, but it was checked
too early. It is possible for this function to return success even
when that is NULL. Move the check down to just before the variable
gets used.

Fixes: 25ba26539 ("Bluetooth: Fix NULL pointer dereference in smp_conn_security")

---

NOTE: UNTESTED, no signoff

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ad82324..0510a57 100644
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
