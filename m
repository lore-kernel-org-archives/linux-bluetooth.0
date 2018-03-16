Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: hci_bcm: Remove duplication in gpio-mappings declaration
Date: Fri, 16 Mar 2018 21:28:10 +0100
Message-Id: <20180316202811.5678-4-hdegoede@redhat.com>
In-Reply-To: <20180316202811.5678-1-hdegoede@redhat.com>
References: <20180316202811.5678-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We declare the same set of const acpi_gpio_params twice with different
names, besides the needless duplication this naming leads to a sortof
double indirection which also makes it harder to see how the mapping is
actually setup.

This commit renames the first set to have generic names, which better
describe the contents of the mapping and drops the second set.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 18416c435b20..3c7fc5d6ef9f 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -774,25 +774,21 @@ static int bcm_resume(struct device *dev)
 }
 #endif
 
-static const struct acpi_gpio_params int_last_device_wakeup_gpios = { 0, 0, false };
-static const struct acpi_gpio_params int_last_shutdown_gpios = { 1, 0, false };
-static const struct acpi_gpio_params int_last_host_wakeup_gpios = { 2, 0, false };
+static const struct acpi_gpio_params first_gpio = { 0, 0, false };
+static const struct acpi_gpio_params second_gpio = { 1, 0, false };
+static const struct acpi_gpio_params third_gpio = { 2, 0, false };
 
 static const struct acpi_gpio_mapping acpi_bcm_int_last_gpios[] = {
-	{ "device-wakeup-gpios", &int_last_device_wakeup_gpios, 1 },
-	{ "shutdown-gpios", &int_last_shutdown_gpios, 1 },
-	{ "host-wakeup-gpios", &int_last_host_wakeup_gpios, 1 },
+	{ "device-wakeup-gpios", &first_gpio, 1 },
+	{ "shutdown-gpios", &second_gpio, 1 },
+	{ "host-wakeup-gpios", &third_gpio, 1 },
 	{ },
 };
 
-static const struct acpi_gpio_params int_first_host_wakeup_gpios = { 0, 0, false };
-static const struct acpi_gpio_params int_first_device_wakeup_gpios = { 1, 0, false };
-static const struct acpi_gpio_params int_first_shutdown_gpios = { 2, 0, false };
-
 static const struct acpi_gpio_mapping acpi_bcm_int_first_gpios[] = {
-	{ "device-wakeup-gpios", &int_first_device_wakeup_gpios, 1 },
-	{ "shutdown-gpios", &int_first_shutdown_gpios, 1 },
-	{ "host-wakeup-gpios", &int_first_host_wakeup_gpios, 1 },
+	{ "host-wakeup-gpios", &first_gpio, 1 },
+	{ "device-wakeup-gpios", &second_gpio, 1 },
+	{ "shutdown-gpios", &third_gpio, 1 },
 	{ },
 };
 
-- 
2.14.3
