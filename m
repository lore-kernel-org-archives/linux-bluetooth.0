Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 09/15] Bluetooth: Send mgmt_discovering events
Date: Wed,  5 Oct 2011 20:20:41 -0300
Message-Id: <1317856847-28167-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 08f7712..0bbd8fe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -897,12 +897,16 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		return;
 
 	if (cp->enable == 0x01) {
+		mgmt_discovering(hdev->id, 1);
+
 		del_timer(&hdev->adv_timer);
 
 		hci_dev_lock(hdev);
 		hci_adv_entries_clear(hdev);
 		hci_dev_unlock(hdev);
 	} else if (cp->enable == 0x00) {
+		mgmt_discovering(hdev->id, 0);
+
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
 	}
 }
-- 
1.7.5.2

