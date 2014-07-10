Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix advertising parameter update when toggling connectable
Date: Thu, 10 Jul 2014 10:51:27 +0300
Message-Id: <1404978687-7723-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we change the connectable state and have advertising enabled we
should update the advertising parameters no matter what. The code was
incorrectly only updating them if advertising was not already active.
This patch fixes the issue.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b49e6e711166..233e6c128727 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1897,8 +1897,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (cp->val || test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
 		write_fast_connectable(&req, false);
 
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) &&
-	    !test_bit(HCI_LE_ADV, &hdev->dev_flags))
+	/* Update the advertising parameters if necessary */
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		enable_advertising(&req);
 
 	err = hci_req_run(&req, set_connectable_complete);
-- 
1.9.3

