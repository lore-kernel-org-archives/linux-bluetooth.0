Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix changing advertising setting while LE is connected
Date: Tue,  8 Oct 2013 15:52:18 +0200
Message-Id: <1381240338-13436-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We only (re)enable advertising when LE is disconnected. Trying to enable
advertising using mgmt_set_advertising while connected should simply
change the flag but not do anything else (until the connection gets
dropped). This patch fixes this by making an LE connection lookup to
determine whether there are any connected devices or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4070bb0..a9d7506 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3264,7 +3264,13 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data, u1
 	val = !!cp->val;
 	enabled = test_bit(HCI_ADVERTISING, &hdev->dev_flags);
 
-	if (!hdev_is_powered(hdev) || val == enabled) {
+	/* The following conditions are ones which mean that we should
+	 * not do any HCI communication but directly send a mgmt
+	 * response to user space (after toggling the flag if
+	 * necessary).
+	 */
+	if (!hdev_is_powered(hdev) || val == enabled ||
+	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECTED)) {
 		bool changed = false;
 
 		if (val != test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
-- 
1.8.3.1

