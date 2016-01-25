Return-Path: <hkallweit1@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] bluetooth: core: use managed version of led_trigger_register
 in LED trigger
Message-ID: <56A67B8D.2010501@gmail.com>
Date: Mon, 25 Jan 2016 20:46:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Recently a managed version of led_trigger_register was introduced.
Using devm_led_trigger_register allows to simplify the LED trigger code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/bluetooth/hci_core.c | 2 --
 net/bluetooth/leds.c     | 8 +-------
 net/bluetooth/leds.h     | 2 --
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 06f603a..541760f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3134,8 +3134,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	id = hdev->id;
 
-	hci_leds_exit(hdev);
-
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
diff --git a/net/bluetooth/leds.c b/net/bluetooth/leds.c
index ded7c88..8319c84 100644
--- a/net/bluetooth/leds.c
+++ b/net/bluetooth/leds.c
@@ -55,7 +55,7 @@ static struct led_trigger *led_allocate_basic(struct hci_dev *hdev,
 	if (!htrig->led_trigger.name)
 		goto err_alloc;
 
-	if (led_trigger_register(&htrig->led_trigger))
+	if (devm_led_trigger_register(&hdev->dev, &htrig->led_trigger))
 		goto err_register;
 
 	return &htrig->led_trigger;
@@ -72,9 +72,3 @@ void hci_leds_init(struct hci_dev *hdev)
 	/* initialize power_led */
 	hdev->power_led = led_allocate_basic(hdev, power_activate, "power");
 }
-
-void hci_leds_exit(struct hci_dev *hdev)
-{
-	if (hdev->power_led)
-		led_trigger_unregister(hdev->power_led);
-}
diff --git a/net/bluetooth/leds.h b/net/bluetooth/leds.h
index 068261a..a9c4d6e 100644
--- a/net/bluetooth/leds.h
+++ b/net/bluetooth/leds.h
@@ -9,10 +9,8 @@
 #if IS_ENABLED(CONFIG_BT_LEDS)
 void hci_leds_update_powered(struct hci_dev *hdev, bool enabled);
 void hci_leds_init(struct hci_dev *hdev);
-void hci_leds_exit(struct hci_dev *hdev);
 #else
 static inline void hci_leds_update_powered(struct hci_dev *hdev,
 					   bool enabled) {}
 static inline void hci_leds_init(struct hci_dev *hdev) {}
-static inline void hci_leds_exit(struct hci_dev *hdev) {}
 #endif
-- 
2.7.0
