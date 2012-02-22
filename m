Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix read_name updating when HCI_SETUP is not set
Date: Wed, 22 Feb 2012 21:06:54 +0200
Message-Id: <1329937615-29893-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
References: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The local name should only be updated as a consequence of a
hci_read_local_name if we are in the HCI_SETUP state. In all other
scenarios it should only be updated through hci_write_local_name.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c79ffb9..9917fe3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -227,7 +227,8 @@ static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 	if (rp->status)
 		return;
 
-	memcpy(hdev->dev_name, rp->name, HCI_MAX_NAME_LENGTH);
+	if (test_bit(HCI_SETUP, &hdev->dev_flags))
+		memcpy(hdev->dev_name, rp->name, HCI_MAX_NAME_LENGTH);
 }
 
 static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.9

