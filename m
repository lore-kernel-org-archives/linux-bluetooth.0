Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: trivial: Remove empty line
Date: Thu,  6 Sep 2012 15:05:44 +0300
Message-Id: <1346933147-11789-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8dbbc01..f305e44 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -268,7 +268,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 		BT_ERR("Unknown device type %d", hdev->dev_type);
 		break;
 	}
-
 }
 
 static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
-- 
1.7.9.5

