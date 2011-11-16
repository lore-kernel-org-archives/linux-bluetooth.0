Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 3/3] Bluetooth: Do not set HCI_RAW when HS enabled
Date: Wed, 16 Nov 2011 17:27:39 +0200
Message-Id: <1321457259-31485-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1321457259-31485-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321457259-31485-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb3feeb..cf18f6d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -521,8 +521,9 @@ int hci_dev_open(__u16 dev)
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		set_bit(HCI_RAW, &hdev->flags);
 
-	/* Treat all non BR/EDR controllers as raw devices for now */
-	if (hdev->dev_type != HCI_BREDR)
+	/* Treat all non BR/EDR controllers as raw devices if
+	   enable_hs is not set */
+	if (hdev->dev_type != HCI_BREDR && !enable_hs)
 		set_bit(HCI_RAW, &hdev->flags);
 
 	if (hdev->open(hdev)) {
-- 
1.7.4.1

