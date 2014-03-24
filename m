Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unnecessary assignment in SMP
Date: Mon, 24 Mar 2014 16:59:14 +0200
Message-Id: <1395673154-32409-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The smp variable in smp_conn_security is not used anywhere before the
smp = smp_chan_create() call in the smp_conn_security function so it
makes no sense to assign any other value to it before that.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 10a8e622ab2b..2c7370844731 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -889,8 +889,6 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (!conn)
 		return 1;
 
-	smp = conn->smp_chan;
-
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
 		return 1;
 
-- 
1.8.5.3

