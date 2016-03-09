Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Fix adding discoverable to adv instance flags
Date: Wed,  9 Mar 2016 17:30:33 +0200
Message-Id: <1457537434-32250-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1457537434-32250-1-git-send-email-johan.hedberg@gmail.com>
References: <1457537434-32250-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When lookup up the advertising instance flags for the default
advertising instance (0) the discoverable flag should be filled in
based on the HCI_DISCOVERABLE flag.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c78ee2dc9323..77be344efd18 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -866,6 +866,9 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
 			flags |= MGMT_ADV_FLAG_CONNECTABLE;
 
+		if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
+			flags |= MGMT_ADV_FLAG_DISCOV;
+
 		return flags;
 	}
 
-- 
2.5.0

