Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/11] Bluetooth: Fix __hci_request() handling of empty requests
Date: Tue,  5 Mar 2013 20:37:42 +0200
Message-Id: <1362508671-6460-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
References: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If a request callback doesn't send any commands __hci_req_sync() should
fail imediately instead of waiting for the inevitable timeout to occur.
This is particularly important once we start creating requests with
conditional command sending which can potentially result in no commands
being sent at all.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cdece72..cd4e5cd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -122,6 +122,14 @@ static int __hci_req_sync(struct hci_dev *hdev,
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	req(hdev, opt);
+
+	/* If the request didn't send any commands return immediately */
+	if (skb_queue_empty(&hdev->cmd_q) && atomic_read(&hdev->cmd_cnt)) {
+		hdev->req_status = 0;
+		remove_wait_queue(&hdev->req_wait_q, &wait);
+		return err;
+	}
+
 	schedule_timeout(timeout);
 
 	remove_wait_queue(&hdev->req_wait_q, &wait);
-- 
1.7.10.4

