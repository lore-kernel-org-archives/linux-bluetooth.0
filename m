Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 9/9] Bluetooth: hci_h5: Add support for enable and device-wake GPIOs
Date: Tue, 10 Jul 2018 10:11:17 +0200
Message-Id: <20180710081117.25078-10-hdegoede@redhat.com>
In-Reply-To: <20180710081117.25078-1-hdegoede@redhat.com>
References: <20180710081117.25078-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the enable and device-wake GPIOs used on ACPI enumerated
RTL8723BS devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_h5.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fd5f50e30a79..8417d745a593 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -23,6 +23,7 @@
 
 #include <linux/acpi.h>
 #include <linux/errno.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
@@ -104,12 +105,16 @@ struct h5 {
 
 	const struct h5_vnd *vnd;
 	const char *id;
+
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *device_wake_gpio;
 };
 
 struct h5_vnd {
 	int (*setup)(struct h5 *h5);
 	void (*open)(struct h5 *h5);
 	void (*close)(struct h5 *h5);
+	const struct acpi_gpio_mapping *acpi_gpio_map;
 };
 
 static void h5_reset_rx(struct h5 *h5);
@@ -810,8 +815,21 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 
 		h5->vnd = (const struct h5_vnd *)match->driver_data;
 		h5->id  = (char *)match->id;
+
+		if (h5->vnd->acpi_gpio_map)
+			devm_acpi_dev_add_driver_gpios(dev,
+						       h5->vnd->acpi_gpio_map);
 	}
 
+	h5->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(h5->enable_gpio))
+		return PTR_ERR(h5->enable_gpio);
+
+	h5->device_wake_gpio = devm_gpiod_get_optional(dev, "device-wake",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(h5->device_wake_gpio))
+		return PTR_ERR(h5->device_wake_gpio);
+
 	return hci_uart_register_device(&h5->serdev_hu, &h5p);
 }
 
@@ -874,11 +892,34 @@ static void h5_btrtl_open(struct h5 *h5)
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
+	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
 
 #ifdef CONFIG_ACPI
-- 
2.17.1
