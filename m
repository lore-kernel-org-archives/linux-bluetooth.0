Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 3/3] Bluetooth: Update adv. parameters when conn. setting changes
Date: Sat, 28 Mar 2015 12:39:00 -0700
Message-Id: <1427571540-29166-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1427571540-29166-1-git-send-email-armansito@chromium.org>
References: <1427571540-29166-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug where the advertising parameters weren't updated
after a call to "Set Connectable" if the HCI_ADVERTISING_INSTANCE
setting was set.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2d84fc1..29cbd98 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2113,7 +2113,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 no_scan_update:
 	/* Update the advertising parameters if necessary */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
 		enable_advertising(&req);
 
 	err = hci_req_run(&req, set_connectable_complete);
-- 
2.2.0.rc0.207.ga3a616c

