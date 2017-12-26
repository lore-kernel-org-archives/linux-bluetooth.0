Return-Path: <lukas@wunner.de>
Message-Id: <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
In-Reply-To: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
References: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 26 Dec 2017 17:07:34 +0200
Subject: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Loading hci_bcm with CONFIG_GPIOLIB=n results in the following splat
when calling gpiod_to_irq() from bcm_get_resources():

    WARNING: CPU: 0 PID: 1006 at ./include/linux/gpio/consumer.h:450 bcm_get_resources+0x50/0x80
    CPU: 0 PID: 1006 Comm: kworker/u8:4 Tainted: G       A         4.15.0-rc4custom+ #4
    Hardware name: Apple Inc. MacBook8,1/Mac-BE0E8AC46FE800CC, BIOS MB81.88Z.0168.B00.1708080033 08/08/2017
    Call Trace:
    bcm_serdev_probe+0x8b/0xc0
    driver_probe_device+0x202/0x310
    __driver_attach+0x85/0x90
    ? driver_probe_device+0x310/0x310
    bus_for_each_dev+0x57/0x80
    async_run_entry_fn+0x2c/0xd0
    process_one_work+0x1d2/0x3d0
    worker_thread+0x26/0x3c0
    ? process_one_work+0x3d0/0x3d0
    kthread+0x10c/0x130
    ? kthread_create_on_node+0x40/0x40
    ret_from_fork+0x1f/0x30

We could call gpiod_to_irq() only if IS_ENABLED(CONFIG_GPIOLIB) but
without GPIOLIB, the driver's power saving features can't be used,
so selecting GPIOLIB seems more appropriate.

The same issue is present in hci_intel.c and hci_nokia.c, fix those up
as well.

Reported-by: Max Shavrick <mxms@me.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 45a2f59cd935..41932f0e68d0 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -110,6 +110,7 @@ config BT_HCIUART_NOKIA
 	depends on PM
 	select BT_HCIUART_H4
 	select BT_BCM
+	select GPIOLIB
 	help
 	  Nokia H4+ is serial protocol for communication between Bluetooth
 	  device and host. This protocol is required for Bluetooth devices
@@ -170,6 +171,7 @@ config BT_HCIUART_INTEL
 	depends on BT_HCIUART
 	select BT_HCIUART_H4
 	select BT_INTEL
+	select GPIOLIB
 	help
 	  The Intel protocol support enables Bluetooth HCI over serial
 	  port interface for Intel Bluetooth controllers.
@@ -183,6 +185,7 @@ config BT_HCIUART_BCM
 	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)
 	select BT_HCIUART_H4
 	select BT_BCM
+	select GPIOLIB
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
 	  port interface for Broadcom Bluetooth controllers.
-- 
2.15.1
