Return-Path: <lukas@wunner.de>
Message-Id: <900a99d8d85b9a3c3edd5308c4b3d6909b29449d.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 08/10] Bluetooth: hci_bcm: Document struct bcm_device
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index dbf9d10dadf1..30ac688dc2c7 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -52,7 +52,30 @@
 
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
-/* device driver resources */
+/**
+ * struct bcm_device - device driver resources
+ * @serdev_hu: HCI UART controller struct
+ * @list: bcm_device_list node
+ * @dev: physical UART slave
+ * @name: device name logged by bt_dev_*() functions
+ * @device_wakeup: BT_WAKE pin,
+ *	assert = Bluetooth device must wake up or remain awake,
+ *	deassert = Bluetooth device may sleep when sleep criteria are met
+ * @shutdown: BT_REG_ON pin,
+ *	power up or power down Bluetooth device internal regulators
+ * @clk: clock used by Bluetooth device
+ * @clk_enabled: whether @clk is prepared and enabled
+ * @init_speed: default baudrate of Bluetooth device;
+ *	the host UART is initially set to this baudrate so that
+ *	it can configure the Bluetooth device for @oper_speed
+ * @oper_speed: preferred baudrate of Bluetooth device;
+ *	set to 0 if @init_speed is already the preferred baudrate
+ * @irq: interrupt triggered by HOST_WAKE_BT pin
+ * @irq_active_low: whether @irq is active low
+ * @hu: pointer to HCI UART controller struct,
+ *	used to enable flow control during runtime suspend and system sleep
+ * @is_suspended: whether flow control is currently enabled
+ */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
 	struct hci_uart		serdev_hu;
@@ -74,7 +97,7 @@ struct bcm_device {
 
 #ifdef CONFIG_PM
 	struct hci_uart		*hu;
-	bool			is_suspended; /* suspend/resume flag */
+	bool			is_suspended;
 #endif
 };
 
-- 
2.15.1
