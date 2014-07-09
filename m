Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/7] Bluetooth: Fix incorrectly setting HCI_CONNECTABLE
Date: Wed,  9 Jul 2014 11:43:09 +0300
Message-Id: <1404895392-12588-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
References: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since page scan might be enabled by Add Device we should not implicitly
set connectable whenever something else than Set Connectable changes it.
This patch makes sure that we don't set HCI_CONNECTABLE for these cases
if there are any entries in the white list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f5f0763266e0..83435a08b0c0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6075,6 +6075,14 @@ void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 	if (!connectable && mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
 		return;
 
+	/* If something else than mgmt changed the page scan state we
+	 * can't differentiate this from a change triggered by adding
+	 * the first element to the whitelist. Therefore, avoid
+	 * incorrectly setting HCI_CONNECTABLE.
+	 */
+	if (connectable && !list_empty(&hdev->whitelist))
+		return;
+
 	if (connectable)
 		changed = !test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 	else
-- 
1.9.3

