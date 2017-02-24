Return-Path: <jeffy.chen@rock-chips.com>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Rajat Jain <rajatja@google.com>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] btusb: wake system up when receives a wake irq
Date: Fri, 24 Feb 2017 14:24:29 +0800
Message-Id: <1487917471-5501-1-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Currrently we are disabling this wake irq after receiving it. If this
happens before we finish suspend and the pm event check is disabled,
the system will continue suspending, and this irq would not work again.

We may need to abort system suspend to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1c8094e..81a2f02 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -26,6 +26,7 @@
 #include <linux/firmware.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/suspend.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -2792,6 +2793,7 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
 	struct btusb_data *data = priv;
 
 	pm_wakeup_event(&data->udev->dev, 0);
+	pm_system_wakeup();
 
 	/* Disable only if not already disabled (keep it balanced) */
 	if (test_and_clear_bit(BTUSB_OOB_WAKE_ENABLED, &data->flags)) {
-- 
2.1.4
