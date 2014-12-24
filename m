Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix accepting connections when not using mgmt
Date: Wed, 24 Dec 2014 20:38:19 +0200
Message-Id: <1419446299-21530-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When connectable mode is enabled (page scan on) through some non-mgmt
method the HCI_CONNECTABLE flag will not be set. For backwards
compatibility with user space versions not using mgmt we should not
require HCI_CONNECTABLE to be set if HCI_MGMT is not set.

Reported-and-tested-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org # 3.17+
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c03d4b09caa3..898dfd7ceeee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2197,7 +2197,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
+	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
+	    !test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
 	    !hci_bdaddr_list_lookup(&hdev->whitelist, &ev->bdaddr,
 				    BDADDR_BREDR)) {
 		    hci_reject_conn(hdev, &ev->bdaddr);
-- 
2.1.0

