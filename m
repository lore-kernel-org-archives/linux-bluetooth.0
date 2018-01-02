Return-Path: <lukas@wunner.de>
Message-Id: <e8378e2d12066f6bf34b0505e3973b633e6073eb.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 04/10] Bluetooth: hci_bcm: Validate IRQ before using it
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ronald Tschalär <ronald@innovation.ch>

The ->close, ->suspend and ->resume hooks assume presence of a valid IRQ
if the device is wakeup capable.  However it's entirely possible that
wakeup was enabled by some other entity besides this driver and in this
case the user will get a WARN splat if no valid IRQ was found.  Avoid by
checking if the IRQ is valid, i.e. > 0.

Case in point:  On recent MacBook Pros, the Bluetooth device lacks an
IRQ (because host wakeup is handled by the SMC, independently of the
operating system), but it does possess a _PRW method (which specifies
the SMC's GPE as wake event).  The ACPI core therefore automatically
marks the physical Bluetooth device wakeup capable upon binding it to
its ACPI companion:

device_set_wakeup_capable+0x96/0xb0
acpi_bind_one+0x28a/0x310
acpi_platform_notify+0x20/0xa0
device_add+0x215/0x690
serdev_device_add+0x57/0xf0
acpi_serdev_add_device+0xc9/0x110
acpi_ns_walk_namespace+0x131/0x280
acpi_walk_namespace+0xf5/0x13d
serdev_controller_add+0x6f/0x110
serdev_tty_port_register+0x98/0xf0
tty_port_register_device_attr_serdev+0x3a/0x70
uart_add_one_port+0x268/0x500
serial8250_register_8250_port+0x32e/0x490
dw8250_probe+0x46c/0x720
platform_drv_probe+0x35/0x90
driver_probe_device+0x300/0x450
bus_for_each_drv+0x67/0xb0
__device_attach+0xde/0x160
bus_probe_device+0x9c/0xb0
device_add+0x448/0x690
platform_device_add+0x10e/0x260
mfd_add_device+0x392/0x4c0
mfd_add_devices+0xb1/0x110
intel_lpss_probe+0x2a9/0x610 [intel_lpss]
intel_lpss_pci_probe+0x7a/0xa8 [intel_lpss_pci]

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
[lukas: fix up ->suspend and ->resume as well, add commit message]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index d9ca27d3209a..dbba08fd05a3 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -371,7 +371,7 @@ static int bcm_close(struct hci_uart *hu)
 		pm_runtime_disable(bdev->dev);
 		pm_runtime_set_suspended(bdev->dev);
 
-		if (device_can_wakeup(bdev->dev)) {
+		if (bdev->irq > 0) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 		}
@@ -622,7 +622,7 @@ static int bcm_suspend(struct device *dev)
 	if (pm_runtime_active(dev))
 		bcm_suspend_device(dev);
 
-	if (device_may_wakeup(dev)) {
+	if (device_may_wakeup(dev) && bdev->irq > 0) {
 		error = enable_irq_wake(bdev->irq);
 		if (!error)
 			bt_dev_dbg(bdev, "BCM irq: enabled");
@@ -652,7 +652,7 @@ static int bcm_resume(struct device *dev)
 	if (!bdev->hu)
 		goto unlock;
 
-	if (device_may_wakeup(dev)) {
+	if (device_may_wakeup(dev) && bdev->irq > 0) {
 		disable_irq_wake(bdev->irq);
 		bt_dev_dbg(bdev, "BCM irq: disabled");
 	}
-- 
2.15.1
