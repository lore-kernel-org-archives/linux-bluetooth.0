Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add combined LED trigger for controller power
Date: Thu, 21 Jul 2016 14:12:41 +0200
Message-Id: <1469103161-39260-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of just having a LED trigger for power on a specific controller,
this adds the LED trigger "bluetooth-power" that combines the power
states of all controllers into a single trigger. This simplifies the
trigger selection and also supports multiple controllers per host
system via a single LED.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c |  5 +++++
 net/bluetooth/leds.c         | 27 +++++++++++++++++++++++++++
 net/bluetooth/leds.h         | 10 ++++++++++
 3 files changed, 42 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index ece45e0683fd..b8a5caf2bf52 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -31,6 +31,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <linux/proc_fs.h>
 
+#include "leds.h"
 #include "selftest.h"
 
 /* Bluetooth sockets */
@@ -726,6 +727,8 @@ static int __init bt_init(void)
 
 	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
 
+	bt_leds_init();
+
 	err = bt_sysfs_init();
 	if (err < 0)
 		return err;
@@ -785,6 +788,8 @@ static void __exit bt_exit(void)
 
 	bt_sysfs_cleanup();
 
+	bt_leds_cleanup();
+
 	debugfs_remove_recursive(bt_debugfs);
 }
 
diff --git a/net/bluetooth/leds.c b/net/bluetooth/leds.c
index 8319c8440c89..cb670b5594eb 100644
--- a/net/bluetooth/leds.c
+++ b/net/bluetooth/leds.c
@@ -11,6 +11,8 @@
 
 #include "leds.h"
 
+DEFINE_LED_TRIGGER(bt_power_led_trigger);
+
 struct hci_basic_led_trigger {
 	struct led_trigger	led_trigger;
 	struct hci_dev		*hdev;
@@ -24,6 +26,21 @@ void hci_leds_update_powered(struct hci_dev *hdev, bool enabled)
 	if (hdev->power_led)
 		led_trigger_event(hdev->power_led,
 				  enabled ? LED_FULL : LED_OFF);
+
+	if (!enabled) {
+		struct hci_dev *d;
+
+		read_lock(&hci_dev_list_lock);
+
+		list_for_each_entry(d, &hci_dev_list, list) {
+			if (test_bit(HCI_UP, &d->flags))
+				enabled = true;
+		}
+
+		read_unlock(&hci_dev_list_lock);
+	}
+
+	led_trigger_event(bt_power_led_trigger, enabled ? LED_FULL : LED_OFF);
 }
 
 static void power_activate(struct led_classdev *led_cdev)
@@ -72,3 +89,13 @@ void hci_leds_init(struct hci_dev *hdev)
 	/* initialize power_led */
 	hdev->power_led = led_allocate_basic(hdev, power_activate, "power");
 }
+
+void bt_leds_init(void)
+{
+	led_trigger_register_simple("bluetooth-power", &bt_power_led_trigger);
+}
+
+void bt_leds_cleanup(void)
+{
+	led_trigger_unregister_simple(bt_power_led_trigger);
+}
diff --git a/net/bluetooth/leds.h b/net/bluetooth/leds.h
index a9c4d6ea01cf..08725a2fbd9b 100644
--- a/net/bluetooth/leds.h
+++ b/net/bluetooth/leds.h
@@ -7,10 +7,20 @@
  */
 
 #if IS_ENABLED(CONFIG_BT_LEDS)
+
 void hci_leds_update_powered(struct hci_dev *hdev, bool enabled);
 void hci_leds_init(struct hci_dev *hdev);
+
+void bt_leds_init(void);
+void bt_leds_cleanup(void);
+
 #else
+
 static inline void hci_leds_update_powered(struct hci_dev *hdev,
 					   bool enabled) {}
 static inline void hci_leds_init(struct hci_dev *hdev) {}
+
+static inline void bt_leds_init(void) {}
+static inline void bt_leds_cleanup(void) {}
+
 #endif
-- 
2.7.4

