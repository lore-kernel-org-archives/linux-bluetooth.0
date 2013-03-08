Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] Bluetooth: Check hci_req_run returning value in __hci_req_sync
Date: Fri,  8 Mar 2013 11:20:15 -0300
Message-Id: <1362752418-8688-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
References: <1362752418-8688-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since hci_req_run will be returning more than one error code, we
should check its returning value in __hci_req_sync.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5f625e0..dc76dcf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -100,13 +100,16 @@ static int __hci_req_sync(struct hci_dev *hdev,
 	err = hci_req_run(&req, hci_req_sync_complete);
 	if (err < 0) {
 		hdev->req_status = 0;
-		/* req_run will fail if the request did not add any
-		 * commands to the queue, something that can happen when
-		 * a request with conditionals doesn't trigger any
-		 * commands to be sent. This is normal behavior and
-		 * should not trigger an error return.
+
+		/* ENODATA means the HCI request command queue is empty.
+		 * This can happen when a request with conditionals doesn't
+		 * trigger any commands to be sent. This is normal behavior
+		 * and should not trigger an error return.
 		 */
-		return 0;
+		if (err == -ENODATA)
+			return 0;
+
+		return err;
 	}
 
 	add_wait_queue(&hdev->req_wait_q, &wait);
-- 
1.8.1.2

