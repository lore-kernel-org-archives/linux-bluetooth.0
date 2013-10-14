Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix updating scan mode in set_bredr()
Date: Mon, 14 Oct 2013 21:15:26 +0300
Message-Id: <1381774527-13746-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
References: <1381774527-13746-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the connectable setting is also applicable for the LE side it's
possible that the HCI_CONNECTABLE flag is already set when changing the
BR/EDR setting from false to true while the controller is powered. In
this situation we need to update the BR/EDR scan mode to reflect the
setting. Additionally, since HCI_CONNECTABLE also applies to LE we must
not clear the HCI_CONNECTABLE flag when disabling bredr.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 48aa239..0bad451 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3640,7 +3640,6 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	if (!hdev_is_powered(hdev)) {
 		if (!cp->val) {
-			clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
 			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 			clear_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
@@ -3683,7 +3682,12 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 
 	hci_req_init(&req, hdev);
+
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+		set_bredr_scan(&req);
+
 	hci_update_ad(&req);
+
 	err = hci_req_run(&req, set_bredr_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.8.3.1

