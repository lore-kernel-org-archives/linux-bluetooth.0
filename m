Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use zalloc when possible
Date: Thu, 18 Jun 2015 20:50:08 +0300
Message-Id: <1434649808-17543-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Use zallog for adv_instance allocation instead of kmalloc + memset.
This also fixes the following coccinelle warning:

>> net/bluetooth/hci_core.c:2693:17-24: WARNING: kzalloc should be
used for adv_instance, instead of kmalloc/memset

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 86ed44e39649..2f8fb33067e1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2716,11 +2716,10 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 		    instance < 1 || instance > HCI_MAX_ADV_INSTANCES)
 			return -EOVERFLOW;
 
-		adv_instance = kmalloc(sizeof(*adv_instance), GFP_KERNEL);
+		adv_instance = kzalloc(sizeof(*adv_instance), GFP_KERNEL);
 		if (!adv_instance)
 			return -ENOMEM;
 
-		memset(adv_instance, 0, sizeof(*adv_instance));
 		adv_instance->pending = true;
 		adv_instance->instance = instance;
 		list_add(&adv_instance->list, &hdev->adv_instances);
-- 
2.4.3

