Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org,
	sfr@canb.auug.org.au,
	gustavo@padovan.org
Cc: linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org
Subject: [PATCH] Bluetooth: hci_bcm: Fix "implicit declaration"
Date: Wed, 12 Aug 2015 12:46:01 +0200
Message-Id: <1439376361-16647-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

The kbuild test robot reported implicit declaration of function
'acpi_dev_get_resources'.

Surround ACPI function by CONFIG_ACPI test.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index cb7fe83..2bb0940 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -388,6 +388,7 @@ static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
 	{ },
 };
 
+#ifdef CONFIG_ACPI
 static int bcm_resource(struct acpi_resource *ares, void *data)
 {
 	struct bcm_device *dev = data;
@@ -459,6 +460,12 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 	return 0;
 }
+#else
+static int bcm_acpi_probe(struct bcm_device *dev)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_ACPI */
 
 static int bcm_probe(struct platform_device *pdev)
 {
-- 
1.9.1
