Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] bluetooth: core: RfC - add basic LED triggers
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Message-ID: <5685741F.9070904@gmail.com>
Date: Thu, 31 Dec 2015 19:29:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the bluetooth subsystem I miss the option to use LEDs to indicate
the status. This patch is based on the LED triggers in mac80211 and
adds two basic LED triggers (powered up, device connected) plus
a config option to enable the BT LED triggers.

It works fine on my system however I don't know the bluetooth stack
in too much detail and therefore appreciate any comment.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/net/bluetooth/hci_core.h |   7 +++
 net/bluetooth/Kconfig            |   9 +++
 net/bluetooth/Makefile           |   1 +
 net/bluetooth/hci_core.c         |   8 +++
 net/bluetooth/hci_event.c        |   3 +
 net/bluetooth/led.c              | 126 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/led.h              |  32 ++++++++++
 7 files changed, 186 insertions(+)
 create mode 100644 net/bluetooth/led.c
 create mode 100644 net/bluetooth/led.h

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c95e032..e47f05c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -25,6 +25,7 @@
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
+#include <linux/leds.h>
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_sock.h>
 
@@ -395,6 +396,12 @@ struct hci_dev {
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
 
+#ifdef CONFIG_BT_LEDS
+	struct led_trigger assoc_led, radio_led;
+	atomic_t assoc_led_active, radio_led_active;
+	atomic_t assoc_led_cnt, radio_led_cnt;
+#endif
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 95d1a66..cba56c7 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -69,6 +69,15 @@ config BT_6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
 
+config BT_LEDS
+	bool "Enable LED triggers"
+	depends on BT
+	depends on LEDS_CLASS
+	select LEDS_TRIGGERS
+	help
+	 This option selects a few LED triggers for different
+	 Bluetooth events.
+
 config BT_SELFTEST
 	bool "Bluetooth self testing support"
 	depends on BT && DEBUG_KERNEL
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 2b15ae8..98d8988 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -17,6 +17,7 @@ bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
+bluetooth-$(CONFIG_BT_LEDS) += led.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 47bcef7..63a4229 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -40,6 +40,7 @@
 #include "hci_request.h"
 #include "hci_debugfs.h"
 #include "smp.h"
+#include "led.h"
 
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
@@ -1395,6 +1396,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		set_bit(HCI_UP, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_UP);
+		hci_led_radio(hdev, true);
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
 		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
@@ -1532,6 +1534,8 @@ int hci_dev_do_close(struct hci_dev *hdev)
 		return 0;
 	}
 
+	hci_led_radio(hdev, false);
+
 	/* Flush RX and TX works */
 	flush_work(&hdev->tx_work);
 	flush_work(&hdev->rx_work);
@@ -3067,6 +3071,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (error < 0)
 		goto err_wqueue;
 
+	hci_led_init(hdev);
+
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
 				    RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops,
 				    hdev);
@@ -3128,6 +3134,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	id = hdev->id;
 
+	hci_led_exit(hdev);
+
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7554da5..e5545c3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -35,6 +35,7 @@
 #include "a2mp.h"
 #include "amp.h"
 #include "smp.h"
+#include "led.h"
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
@@ -5239,6 +5240,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	case HCI_EV_CONN_COMPLETE:
 		hci_conn_complete_evt(hdev, skb);
+		hci_led_assoc(hdev, true);
 		break;
 
 	case HCI_EV_CONN_REQUEST:
@@ -5246,6 +5248,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	case HCI_EV_DISCONN_COMPLETE:
+		hci_led_assoc(hdev, false);
 		hci_disconn_complete_evt(hdev, skb);
 		break;
 
diff --git a/net/bluetooth/led.c b/net/bluetooth/led.c
new file mode 100644
index 0000000..420633c
--- /dev/null
+++ b/net/bluetooth/led.c
@@ -0,0 +1,126 @@
+/*
+ * Copyright 2015, Heiner Kallweit <hkallweit1@gmail.com>
+ * This code is based on the MAC80211 LED code.
+ * Original author: Johannes Berg <johannes.berg@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "led.h"
+
+#define cdev_to_hdev(cdev, name) container_of(cdev->trigger, \
+					      struct hci_dev, \
+					      name)
+
+void hci_led_assoc(struct hci_dev *hdev, bool associated)
+{
+	int cnt;
+
+	if (associated)
+		cnt = atomic_inc_return(&hdev->assoc_led_cnt);
+	else
+		cnt = atomic_dec_return(&hdev->assoc_led_cnt);
+
+	WARN_ON(cnt < 0);
+
+	if (!atomic_read(&hdev->assoc_led_active))
+		return;
+
+	led_trigger_event(&hdev->assoc_led,
+			  cnt ? LED_FULL : LED_OFF);
+}
+
+void hci_led_radio(struct hci_dev *hdev, bool enabled)
+{
+	int cnt;
+
+	if (enabled)
+		cnt = atomic_inc_return(&hdev->radio_led_cnt);
+	else
+		cnt = atomic_dec_return(&hdev->radio_led_cnt);
+
+	WARN_ON(cnt < 0);
+
+	if (!atomic_read(&hdev->radio_led_active))
+		return;
+
+	led_trigger_event(&hdev->radio_led,
+			  cnt ? LED_FULL : LED_OFF);
+}
+
+static void hci_assoc_led_activate(struct led_classdev *led_cdev)
+{
+	struct hci_dev *hdev = cdev_to_hdev(led_cdev, assoc_led);
+	int cnt = atomic_read(&hdev->assoc_led_cnt);
+
+	atomic_inc(&hdev->assoc_led_active);
+
+	led_trigger_event(&hdev->assoc_led, cnt ? LED_FULL : LED_OFF);
+}
+
+static void hci_assoc_led_deactivate(struct led_classdev *led_cdev)
+{
+	struct hci_dev *hdev = cdev_to_hdev(led_cdev, assoc_led);
+
+	atomic_dec(&hdev->assoc_led_active);
+}
+
+static void hci_radio_led_activate(struct led_classdev *led_cdev)
+{
+	struct hci_dev *hdev = cdev_to_hdev(led_cdev, radio_led);
+	int cnt = atomic_read(&hdev->radio_led_cnt);
+
+	atomic_inc(&hdev->radio_led_active);
+
+	led_trigger_event(&hdev->radio_led, cnt ? LED_FULL : LED_OFF);
+}
+
+static void hci_radio_led_deactivate(struct led_classdev *led_cdev)
+{
+	struct hci_dev *hdev = cdev_to_hdev(led_cdev, radio_led);
+
+	atomic_dec(&hdev->radio_led_active);
+}
+
+void hci_led_init(struct hci_dev *hdev)
+{
+	/* initialize assoc_led */
+	atomic_set(&hdev->assoc_led_cnt, 0);
+	atomic_set(&hdev->assoc_led_active, 0);
+	hdev->assoc_led.activate = hci_assoc_led_activate;
+	hdev->assoc_led.deactivate = hci_assoc_led_deactivate;
+	hdev->assoc_led.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+					      "%s-assoc", hdev->name);
+	if (hdev->assoc_led.name &&
+	    led_trigger_register(&hdev->assoc_led)) {
+		devm_kfree(&hdev->dev, (void *)hdev->assoc_led.name);
+		hdev->assoc_led.name = NULL;
+	}
+
+	/* initialize radio_led */
+	atomic_set(&hdev->radio_led_cnt, 0);
+	atomic_set(&hdev->radio_led_active, 0);
+	hdev->radio_led.activate = hci_radio_led_activate;
+	hdev->radio_led.deactivate = hci_radio_led_deactivate;
+	hdev->radio_led.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+					      "%s-radio", hdev->name);
+	if (hdev->radio_led.name &&
+	    led_trigger_register(&hdev->radio_led)) {
+		devm_kfree(&hdev->dev, (void *)hdev->radio_led.name);
+		hdev->radio_led.name = NULL;
+	}
+}
+
+void hci_led_exit(struct hci_dev *hdev)
+{
+	if (hdev->assoc_led.name)
+		led_trigger_unregister(&hdev->assoc_led);
+	if (hdev->radio_led.name)
+		led_trigger_unregister(&hdev->radio_led);
+}
+
diff --git a/net/bluetooth/led.h b/net/bluetooth/led.h
new file mode 100644
index 0000000..a607292
--- /dev/null
+++ b/net/bluetooth/led.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2015, Heiner Kallweit <hkallweit1@gmail.com>
+ * This code is based on the MAC80211 LED code.
+ * Original author: Johannes Berg <johannes.berg@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifdef CONFIG_BT_LEDS
+void hci_led_assoc(struct hci_dev *hdev, bool associated);
+void hci_led_radio(struct hci_dev *hdev, bool enabled);
+void hci_led_init(struct hci_dev *hdev);
+void hci_led_exit(struct hci_dev *hdev);
+#else
+static inline void hci_led_assoc(struct hci_dev *hdev, bool associated)
+{
+}
+
+static inline void hci_led_radio(struct hci_dev *hdev, bool enabled)
+{
+}
+
+static inline void hci_led_init(struct hci_dev *hdev)
+{
+}
+
+static inline void hci_led_exit(struct hci_dev *hdev)
+{
+}
+#endif
-- 
2.6.4

