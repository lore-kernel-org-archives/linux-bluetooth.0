Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Put led_trigger field behind CONFIG_BT_LEDS
Date: Thu, 21 Jul 2016 14:12:40 +0200
Message-Id: <1469103161-39260-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The led_trigger field in hci_dev should be conditional based on if
CONFIG_BT_LEDS is set or not.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ee7fc47680a1..b8d43bd9c71b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -399,7 +399,9 @@ struct hci_dev {
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
 
+#if IS_ENABLED(CONFIG_BT_LEDS)
 	struct led_trigger	*power_led;
+#endif
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
-- 
2.7.4

