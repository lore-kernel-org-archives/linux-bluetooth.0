Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/12] Bluetooth: Fix missing return statement in process_adv_report
Date: Fri,  4 Jul 2014 12:37:16 +0300
Message-Id: <1404466647-16352-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we're doing passive scanning we shouldn't proceed with any of the
code that deals with active scanning (pending reports, etc.). This patch
fixes a missing return statement for the passive scanning section in the
process_adv_report() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 20317e516e74..e0407e674061 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4256,6 +4256,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			flags = 0;
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
 				  rssi, flags, data, len, NULL, 0);
+		return;
 	}
 
 	/* When receiving non-connectable or scannable undirected
-- 
1.9.3

