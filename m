Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: Fix redundant scan mode updates
Date: Mon, 28 Jul 2014 15:10:15 +0300
Message-Id: <1406549416-9229-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406549416-9229-1-git-send-email-johan.hedberg@gmail.com>
References: <1406549416-9229-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that whitelist information is temporarily held in hci_conn objects
the calls leading to update_page_scan() will occasionally happen even
though page scanning is already in the state we want it to be. To avoid
redundant changes to it simply check the HCI_PSCAN flag before sending
any HCI command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4f56855c1fbb..4d96913484cd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5258,6 +5258,10 @@ static void update_page_scan(struct hci_dev *hdev, u8 scan)
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		return;
 
+	/* Don't bother updating page scan if it's already what we want */
+	if (test_bit(HCI_PSCAN, &hdev->flags) == !!(scan & SCAN_PAGE))
+		return;
+
 	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
 		scan |= SCAN_INQUIRY;
 
-- 
1.9.3

