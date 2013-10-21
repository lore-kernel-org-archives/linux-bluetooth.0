Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix enabling fast connectable on LE-only controllers
Date: Mon, 21 Oct 2013 16:51:53 +0300
Message-Id: <1382363513-4083-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The current "fast connectable" feature is BR/EDR-only, so add a proper
check for BR/EDR support before proceeding with the associated HCI
commands.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bd91ee5..074d836 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1307,6 +1307,9 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 	struct hci_cp_write_page_scan_activity acp;
 	u8 type;
 
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		return;
+
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return;
 
-- 
1.8.3.1

