Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 13/13] Bluetooth: hci_h5: Add support for enable and device-wake GPIOs
Date: Sun, 27 May 2018 21:04:57 +0200
Message-Id: <20180527190457.2632-14-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the enable and device-wake GPIOs used on ACPI enumerated
RTL8723BS devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index d81f950cea27..177eabd00d49 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -23,6 +23,7 @@
 
 #include <linux/acpi.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/of_device.h>
 #include <linux/serdev.h>
@@ -104,12 +105,16 @@ struct h5 {
 	} sleep;
 
 	const struct h5_vnd *vnd;
+
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *device_wake_gpio;
 };
 
 struct h5_vnd {
 	int (*setup)(struct h5 *h5);
 	void (*open)(struct h5 *h5);
 	void (*close)(struct h5 *h5);
+	const struct acpi_gpio_mapping *acpi_gpios;
 };
 
 static void h5_reset_rx(struct h5 *h5);
@@ -801,10 +806,25 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	h5->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, h5);
 
-	if (has_acpi_companion(&serdev->dev))
+	if (has_acpi_companion(&serdev->dev)) {
 		h5->vnd = acpi_device_get_match_data(&serdev->dev);
-	else
+		if (h5->vnd && h5->vnd->acpi_gpios)
+			devm_acpi_dev_add_driver_gpios(&serdev->dev,
+						       h5->vnd->acpi_gpios);
+	} else {
 		h5->vnd = of_device_get_match_data(&serdev->dev);
+	}
+
+	h5->enable_gpio = devm_gpiod_get_optional(&serdev->dev, "enable",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(h5->enable_gpio))
+		return PTR_ERR(h5->enable_gpio);
+
+	h5->device_wake_gpio = devm_gpiod_get_optional(&serdev->dev,
+						       "device-wake",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(h5->device_wake_gpio))
+		return PTR_ERR(h5->device_wake_gpio);
 
 	return hci_uart_register_device(&h5->serdev_hu, &h5p);
 }
@@ -868,11 +888,34 @@ static void h5_btrtl_open(struct h5 *h5)
 	serdev_device_set_flow_control(h5->hu->serdev, false);
 	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
 	serdev_device_set_baudrate(h5->hu->serdev, 115200);
+
+	/* The controller needs up to 500ms to wakeup */
+	gpiod_set_value_cansleep(h5->enable_gpio, 1);
+	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
+	msleep(500);
 }
 
+static void h5_btrtl_close(struct h5 *h5)
+{
+	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+}
+
+static const struct acpi_gpio_params btrtl_device_wake_gpios = { 0, 0, false };
+static const struct acpi_gpio_params btrtl_enable_gpios = { 1, 0, false };
+static const struct acpi_gpio_params btrtl_host_wake_gpios = { 2, 0, false };
+static const struct acpi_gpio_mapping acpi_btrtl_gpios[] = {
+	{ "device-wake-gpios", &btrtl_device_wake_gpios, 1 },
+	{ "enable-gpios", &btrtl_enable_gpios, 1 },
+	{ "host-wake-gpios", &btrtl_host_wake_gpios, 1 },
+	{},
+};
+
 static struct h5_vnd rtl_vnd = {
 	.setup		= h5_btrtl_setup,
 	.open		= h5_btrtl_open,
+	.close		= h5_btrtl_close,
+	.acpi_gpios	= acpi_btrtl_gpios,
 };
 
 #ifdef CONFIG_ACPI
-- 
2.17.0
