Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 1/5] Bluetooth: hci_intel: Retrieve host-wake IRQ
Date: Thu, 27 Aug 2015 17:39:02 +0200
Message-Id: <1440689946-13576-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An IRQ can be retrieved from the pdev resources. This irq will be used
in case of LPM suspend mode to wake-up the host and resume the link.
This resource can be declared as a GPIO-Interrupt which requires to be
converted into IRQ.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 46426ff..934b5a7 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -31,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/acpi.h>
+#include <linux/interrupt.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -48,6 +49,7 @@ struct intel_device {
 	struct list_head list;
 	struct platform_device *pdev;
 	struct gpio_desc *reset;
+	int irq;
 };
 
 static LIST_HEAD(intel_device_list);
@@ -789,6 +791,15 @@ static const struct hci_uart_proto intel_proto = {
 	.dequeue	= intel_dequeue,
 };
 
+static irqreturn_t intel_irq(int irq, void *dev_id)
+{
+	struct intel_device *idev = dev_id;
+
+	dev_info(&idev->pdev->dev, "hci_intel irq\n");
+
+	return IRQ_HANDLED;
+}
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id intel_acpi_match[] = {
 	{ "INT33E1", 0 },
@@ -816,6 +827,7 @@ static int intel_acpi_probe(struct intel_device *idev)
 static int intel_probe(struct platform_device *pdev)
 {
 	struct intel_device *idev;
+	int err;
 
 	idev = devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
 	if (!idev)
@@ -838,6 +850,36 @@ static int intel_probe(struct platform_device *pdev)
 		return PTR_ERR(idev->reset);
 	}
 
+	idev->irq = platform_get_irq(pdev, 0);
+	if (idev->irq < 0) {
+		struct gpio_desc *host_wake;
+
+		dev_err(&pdev->dev, "No IRQ, falling back to gpio-irq\n");
+
+		host_wake = devm_gpiod_get_optional(&pdev->dev, "host-wake",
+						    GPIOD_IN);
+		if (IS_ERR(host_wake)) {
+			dev_err(&pdev->dev, "Unable to retrieve IRQ\n");
+			goto no_irq;
+		}
+
+		idev->irq = gpiod_to_irq(host_wake);
+		if (idev->irq < 0) {
+			dev_err(&pdev->dev, "No corresponding irq for gpio\n");
+			goto no_irq;
+		}
+	}
+
+	err = devm_request_threaded_irq(&pdev->dev, idev->irq, NULL, intel_irq,
+					IRQF_ONESHOT, "bt-host-wake", idev);
+	if (err) {
+		dev_err(&pdev->dev, "unable to allocate irq\n");
+		return err;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+no_irq:
 	platform_set_drvdata(pdev, idev);
 
 	/* Place this instance on the device list */
@@ -845,7 +887,8 @@ static int intel_probe(struct platform_device *pdev)
 	list_add_tail(&idev->list, &intel_device_list);
 	spin_unlock(&intel_device_list_lock);
 
-	dev_info(&pdev->dev, "registered.\n");
+	dev_info(&pdev->dev, "registered, gpio(%d)/irq(%d).\n",
+		 desc_to_gpio(idev->reset), idev->irq);
 
 	return 0;
 }
-- 
1.9.1

