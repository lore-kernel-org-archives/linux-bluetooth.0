Return-Path: <ianwmorrison@gmail.com>
Subject: [RESEND PATCH] Bluetooth: BCM: Add support for MINIX Z83-4 based
 devices
References: <22c4b179-d181-bfc3-8da3-ccba215abbf7@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org
Cc: hdegoede@redhat.com, frederic.danis.oss@gmail.com, greg@kroah.com
From: Ian W MORRISON <ianwmorrison@gmail.com>
Message-ID: <9e4fb525-49fd-d118-d9d7-9bd08ece87d4@gmail.com>
Date: Fri, 6 Oct 2017 18:33:56 +1100
MIME-Version: 1.0
In-Reply-To: <22c4b179-d181-bfc3-8da3-ccba215abbf7@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices use an AP6255 chip
for wifi and bluetooth. Bluetooth requires an ACPI device id of BCM2EA4
with BCM4345 rev C0 firmware.

Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
---
 drivers/bluetooth/btbcm.c   | 1 +
 drivers/bluetooth/hci_bcm.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index cc4bdef..7de75f1 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -327,6 +327,7 @@ static int btbcm_read_info(struct hci_dev *hdev)
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
+	{ 0x6119, "BCM4345C0"  },	/* 003.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index e254011..8a97810 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -704,6 +704,14 @@ static int bcm_resume(struct device *dev)
 		.driver_data = &acpi_active_low,
 	},
 	{
+		.ident = "MINIX Z83-4",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
+		},
+		.driver_data = &acpi_active_low,
+	},
+	{
 		.ident = "Asus T100CHI",
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR,
@@ -926,6 +934,7 @@ static int bcm_remove(struct platform_device *pdev)
 	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
+	{ "BCM2EA4", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ },
-- 
1.9.1
