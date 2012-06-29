Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Do not auto off AMP controller
Date: Fri, 29 Jun 2012 15:07:00 +0300
Message-Id: <1340971622-16318-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340971622-16318-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340971622-16318-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since AMP controller is not managed by user space do not shut it down.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8b93491..37712d3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1743,8 +1743,11 @@ int hci_register_dev(struct hci_dev *hdev)
 		}
 	}
 
-	set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 	set_bit(HCI_SETUP, &hdev->dev_flags);
+
+	if (hdev->dev_type != HCI_AMP)
+		set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+
 	schedule_work(&hdev->power_on);
 
 	hci_notify(hdev, HCI_DEV_REG);
-- 
1.7.9.5

