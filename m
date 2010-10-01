Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 5/5] Bluetooth: pm constraints in bt transfer mode
Date: Fri,  1 Oct 2010 15:47:10 +0300
Message-Id: <1285937230-547-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

When entering BT transfer mode set up pm limits using constraints
to achive maximum BT throughput.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 drivers/bluetooth/hci_h4p/core.c    |   92 ++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/hci_h4p/hci_h4p.h |    1 +
 2 files changed, 92 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_h4p/core.c b/drivers/bluetooth/hci_h4p/core.c
index 74e6cfe..10cf8a4 100644
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/timer.h>
+#include <linux/kthread.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -45,6 +46,10 @@
 
 #include "hci_h4p.h"
 
+#define H4P_SCHED_TRANSFER_MODE	1
+
+static struct task_struct *h4p_thread;
+
 /* This should be used in function that cannot release clocks */
 static void hci_h4p_set_clk(struct hci_h4p_info *info, int *clock, int enable)
 {
@@ -105,6 +110,17 @@ void hci_h4p_smart_idle(struct hci_h4p_info *info, bool enable)
 	hci_h4p_outb(info, UART_OMAP_SYSC, v);
 }
 
+static inline void h4p_schedule(struct hci_h4p_info *info, uint event)
+{
+	if (unlikely(!h4p_thread))
+		return;
+
+	if (unlikely(!test_bit(event, &info->event))) {
+		set_bit(event, &info->event);
+		wake_up_process(h4p_thread);
+	}
+}
+
 static void hci_h4p_disable_tx(struct hci_h4p_info *info)
 {
 	NBT_DBG_POWER("\n");
@@ -128,6 +144,8 @@ void hci_h4p_enable_tx(struct hci_h4p_info *info)
 	if (!info->pm_enabled)
 		return;
 
+	h4p_schedule(info, H4P_SCHED_TRANSFER_MODE);
+
 	spin_lock_irqsave(&info->lock, flags);
 	del_timer(&info->lazy_release);
 	hci_h4p_set_clk(info, &info->tx_clocks_en, 1);
@@ -167,6 +185,8 @@ static void hci_h4p_enable_rx(struct hci_h4p_info *info)
 	if (!info->pm_enabled)
 		return;
 
+	h4p_schedule(info, H4P_SCHED_TRANSFER_MODE);
+
 	hci_h4p_set_clk(info, &info->rx_clocks_en, 1);
 	info->rx_enabled = 1;
 
@@ -613,6 +633,68 @@ static irqreturn_t hci_h4p_wakeup_interrupt(int irq, void *dev_inst)
 	return IRQ_HANDLED;
 }
 
+static inline void __hci_h4p_change_pm_constraints(struct hci_h4p_info *info,
+		bool set)
+{
+	struct omap_bluetooth_config *bt_config = info->dev->platform_data;
+
+	if (likely(bt_config && bt_config->set_pm_limits)) {
+		BT_DBG("Change pm constraints to: %s", set ? "set" : "clear");
+		bt_config->set_pm_limits(info->dev, set);
+	}
+}
+
+static int h4p_run(void *data)
+{
+#define TIMEOUT_MIN msecs_to_jiffies(100)
+#define TIMEOUT_MAX msecs_to_jiffies(2000)
+	struct hci_h4p_info *info = data;
+	unsigned long last_jiffies = jiffies;
+	unsigned long timeout = TIMEOUT_MIN;
+	BT_DBG("");
+	set_user_nice(current, -10);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!test_bit(H4P_SCHED_TRANSFER_MODE, &info->event)) {
+			/* No pending events. Let's sleep.
+			 * Incoming connections and data will wake us up. */
+			BT_DBG("Nothing to do... sleeping.");
+			schedule();
+		}
+
+		BT_DBG("Wake up. %u msec expired since last BT activity.",
+				jiffies_to_msecs(jiffies - last_jiffies));
+
+		/* Empiric analyzer  :-) */
+		if (jiffies - last_jiffies < TIMEOUT_MIN) {
+			timeout <<= 1;
+			timeout = (timeout > TIMEOUT_MAX) ?
+				TIMEOUT_MAX : timeout;
+		} else {
+			timeout >>= 1;
+			timeout = (timeout < TIMEOUT_MIN) ?
+				TIMEOUT_MIN : timeout;
+		}
+
+		__hci_h4p_change_pm_constraints(info, true);
+
+		BT_DBG("Set active mode for %u msec.",
+				jiffies_to_msecs(timeout));
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(timeout);
+
+		__hci_h4p_change_pm_constraints(info, false);
+
+		clear_bit(H4P_SCHED_TRANSFER_MODE, &info->event);
+		last_jiffies = jiffies;
+		BT_DBG("Return from active mode. Restore constraints.");
+	}
+
+	return 0;
+}
+
 static int hci_h4p_reset(struct hci_h4p_info *info)
 {
 	int err;
@@ -835,6 +917,8 @@ static int hci_h4p_hci_close(struct hci_dev *hdev)
 	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
 		return 0;
 
+	__hci_h4p_change_pm_constraints(info, false);
+
 	hci_h4p_hci_flush(hdev);
 	hci_h4p_set_clk(info, &info->tx_clocks_en, 1);
 	hci_h4p_set_clk(info, &info->rx_clocks_en, 1);
@@ -942,7 +1026,7 @@ static int hci_h4p_register_hdev(struct hci_h4p_info *info)
 	return 0;
 }
 
-static int hci_h4p_probe(struct platform_device *pdev)
+static int __init hci_h4p_probe(struct platform_device *pdev)
 {
 	struct omap_bluetooth_config *bt_config;
 	struct hci_h4p_info *info;
@@ -1104,6 +1188,12 @@ static int hci_h4p_probe(struct platform_device *pdev)
 		goto cleanup_irq;
 	}
 
+	h4p_thread = kthread_run(h4p_run, info, "h4p_pm");
+	if (IS_ERR(h4p_thread)) {
+		err = PTR_ERR(h4p_thread);
+		goto cleanup_irq;
+	}
+
 	return 0;
 
 cleanup_irq:
diff --git a/drivers/bluetooth/hci_h4p/hci_h4p.h b/drivers/bluetooth/hci_h4p/hci_h4p.h
index cd72bba..7d7a0fa 100644
--- a/drivers/bluetooth/hci_h4p/hci_h4p.h
+++ b/drivers/bluetooth/hci_h4p/hci_h4p.h
@@ -98,6 +98,7 @@ struct hci_h4p_info {
 	int tx_enabled;
 	int autorts;
 	int rx_enabled;
+	unsigned long event;
 
 	int tx_clocks_en;
 	int rx_clocks_en;
-- 
1.7.0.4

