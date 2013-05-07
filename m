Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use HCI_MGMT flag for link keys management
Date: Tue,  7 May 2013 14:35:46 +0300
Message-Id: <1367926547-8279-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20130507111436.GA11154@x220>
References: <20130507111436.GA11154@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The HCI_MGMT flag should be enough to test for a user space that
expects the kernel to do link keys management. Checking for the
special HCI_LINK_KEYS flag is a bit overkill for this since we
don't strictly speaking need to receive the load_link_keys
command to know that user space talks mgmt - any mgmt command
should be enough.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index db58e72..e547cfd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2611,7 +2611,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	if (!test_bit(HCI_LINK_KEYS, &hdev->dev_flags))
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
 	hci_dev_lock(hdev);
-- 
1.8.1.2

