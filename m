Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: Do not set HCI_RAW when HS enabled
Date: Fri, 11 Nov 2011 16:14:27 +0200
Message-Id: <1321020867-8938-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1321020867-8938-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321020867-8938-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 net/bluetooth/hci_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 189bada..1b08e4b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -51,6 +51,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
 
 #define AUTO_OFF_TIMEOUT 2000
 
@@ -570,8 +571,9 @@ int hci_dev_open(__u16 dev)
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

