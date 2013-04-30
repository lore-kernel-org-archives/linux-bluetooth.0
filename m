Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/14] Bluetooth: Refactor hci_cc_le_set_scan_enable
Date: Tue, 30 Apr 2013 15:29:36 -0300
Message-Id: <1367346580-6647-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a trivial refactoring in hci_cc_le_set_scan_enable.
Since start and stop discovery command failures are now handled in
mgmt layer, the status check became empty. So, we can move it to
outside the switch statement.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 27f66dc..76ff1af 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -949,18 +949,15 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
+	if (status)
+		return;
+
 	switch (cp->enable) {
 	case LE_SCAN_ENABLE:
-		if (status)
-			return;
-
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 		break;
 
 	case LE_SCAN_DISABLE:
-		if (status)
-			return;
-
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 		break;
 
-- 
1.8.2.1

