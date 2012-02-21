Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: mgmt: Fix Removing discoverable timeout in set_connectable
Date: Tue, 21 Feb 2012 19:43:45 +0200
Message-Id: <1329846229-7919-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
References: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When switching connectable mode off any pending discoverable timeout
must also be disabled to avoid duplicate write_scan_enable commands.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6311be7..eec70a4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -935,9 +935,14 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 
 	if (cp->val)
 		scan = SCAN_PAGE;
-	else
+	else {
 		scan = 0;
 
+		if (test_bit(HCI_ISCAN, &hdev->flags) &&
+						hdev->discov_timeout > 0)
+			cancel_delayed_work(&hdev->discov_off);
+	}
+
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.9

