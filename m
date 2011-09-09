Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/16] Bluetooth: Reduce critical region.
Date: Fri,  9 Sep 2011 18:56:24 -0300
Message-Id: <1315605391-2407-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
References: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reduces the critial region (protected by hdev->lock) in
hci_cc_le_set_scan_enable(). This way, only really required code is
synchronized.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 95b8a6c..d4884e3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -896,16 +896,15 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	if (!cp)
 		return;
 
-	hci_dev_lock(hdev);
-
 	if (cp->enable == 0x01) {
 		del_timer(&hdev->adv_timer);
+
+		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
+		hci_dev_unlock(hdev);
 	} else if (cp->enable == 0x00) {
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
 	}
-
-	hci_dev_unlock(hdev);
 }
 
 static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.5.2

