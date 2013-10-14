Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check that scan window is smaller or equal than scan interval
Date: Mon, 14 Oct 2013 09:55:32 -0700
Message-Id: <1381769732-19707-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The scan window parameter for connection establishment and passive
scanning needs to be smaller or equal than the scan interval.

Instead of waiting for a controller to reject these values later on,
just reject them right away.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index caa552c..40c85ed 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3423,6 +3423,10 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
 				  MGMT_STATUS_INVALID_PARAMS);
 
+	if (window > interval)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	hdev->le_scan_interval = interval;
-- 
1.8.3.1

