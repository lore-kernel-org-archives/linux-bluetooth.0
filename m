Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix NULL pointer dereference in smp_conn_security
Date: Mon, 20 Jul 2015 20:31:25 +0300
Message-Id: <1437413485-1180-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The l2cap_conn->smp pointer may be NULL for various valid reasons where SMP has
failed to initialize properly. One such scenario is when crypto support is
missing, another when the adapter has been powered on through a legacy method.
The smp_conn_security() function should have the appropriate check for this
situation to avoid NULL pointer dereferences.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org # 4.0+
---
 net/bluetooth/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3d0f7d2a0616..ad82324f710f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2312,6 +2312,10 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		return 1;
 
 	chan = conn->smp;
+	if (!chan) {
+		BT_ERR("SMP security requested but not available");
+		return 1;
+	}
 
 	if (!hci_dev_test_flag(hcon->hdev, HCI_LE_ENABLED))
 		return 1;
-- 
2.4.3

