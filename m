Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Don't let background scanning interfering with discovery
Date: Mon,  7 Jul 2014 13:24:59 +0300
Message-Id: <1404728699-11268-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404728699-11268-1-git-send-email-johan.hedberg@gmail.com>
References: <1404728699-11268-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have an active discovery going on we shouldn't do any changes to
LE scanning when hci_update_background_scan() is called (a call which
can happen for many different reasons). This patch fixes the issue by
returning from the function if the discovery state is anything else
except DISCOVERY_STOPPED.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6a0e39f69e03..4f8ba49ac49d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5403,6 +5403,10 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
 		return;
 
+	/* If discovery is active don't interfere with it */
+	if (hdev->discovery.state != DISCOVERY_STOPPED)
+		return;
+
 	hci_req_init(&req, hdev);
 
 	if (list_empty(&hdev->pend_le_conns) &&
-- 
1.9.3

