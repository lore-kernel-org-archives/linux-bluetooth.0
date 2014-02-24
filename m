Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable RPA resolving if mgmt_set_privacy is called
Date: Mon, 24 Feb 2014 11:10:30 +0200
Message-Id: <1393233030-5912-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

A user space that supports the Set Privacy command is also expected to
be able to handle New IRK events. Therefore, set the HCI_RPA_RESOLVING
flag whenever the Set Privacy command is received.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 53b9408af16b..9865e523df20 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4257,6 +4257,11 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	hci_dev_lock(hdev);
 
+	/* If user space supports this command it is also expected to
+	 * handle IRKs. Therefore, set the HCI_RPA_RESOLVING flag.
+	 */
+	set_bit(HCI_RPA_RESOLVING, &hdev->dev_flags);
+
 	if (cp->privacy) {
 		changed = !test_and_set_bit(HCI_PRIVACY, &hdev->dev_flags);
 		memcpy(hdev->irk, cp->irk, sizeof(hdev->irk));
-- 
1.8.5.3

