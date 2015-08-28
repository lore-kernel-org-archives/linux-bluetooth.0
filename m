Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: hci_intel: Retrieve host-wake IRQ
Date: Fri, 28 Aug 2015 18:20:42 +0200
Message-Id: <1440778843-29860-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An IRQ can be retrieved from the pdev resources. This irq will be used
in case of LPM suspend mode to wake-up the host and resume the link.
This resource can be declared as a GPIO-Interrupt which requires to be
converted into IRQ.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 46426ff..1ec2205 100644
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
@@ -113,6 +115,15 @@ static int intel_wait_booting(struct hci_uart *hu)
 	return err;
 }
 
+static irqreturn_t intel_irq(int irq, void *dev_id)
+{
+	struct intel_device *idev = dev_id;
+
+	dev_info(&idev->pdev->dev, "hci_intel irq\n");
+
+	return IRQ_HANDLED;
+}
+
 static int intel_set_power(struct hci_uart *hu, bool powered)
 {
 	struct list_head *p;
@@ -139,6 +150,27 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 			hu, dev_name(&idev->pdev->dev), powered);
 
 		gpiod_set_value(idev->reset, powered);
+
+		if (idev->irq < 0)
+			break;
+
+		if (powered && device_can_wakeup(&idev->pdev->dev)) {
+			err = devm_request_threaded_irq(&idev->pdev->dev,
+							idev->irq, NULL,
+							intel_irq,
+							IRQF_ONESHOT,
+							"bt-host-wake", idev);
+			if (err) {
+				BT_ERR("hu %p, unable to allocate irq-%d",
+				       hu, idev->irq);
+				break;
+			}
+
+			device_wakeup_enable(&idev->pdev->dev);
+		} else if (!powered && device_may_wakeup(&idev->pdev->dev)) {
+			devm_free_irq(&idev->pdev->dev, idev->irq, idev);
+			device_wakeup_disable(&idev->pdev->dev);
+		}
 	}
 
 	spin_unlock(&intel_device_list_lock);
@@ -838,6 +870,31 @@ static int intel_probe(struct platform_device *pdev)
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
+	/* Only enable wake-up/irq when controller is powered */
+	device_set_wakeup_capable(&pdev->dev, true);
+	device_wakeup_disable(&pdev->dev);
+
+no_irq:
 	platform_set_drvdata(pdev, idev);
 
 	/* Place this instance on the device list */
@@ -845,7 +902,8 @@ static int intel_probe(struct platform_device *pdev)
 	list_add_tail(&idev->list, &intel_device_list);
 	spin_unlock(&intel_device_list_lock);
 
-	dev_info(&pdev->dev, "registered.\n");
+	dev_info(&pdev->dev, "registered, gpio(%d)/irq(%d).\n",
+		 desc_to_gpio(idev->reset), idev->irq);
 
 	return 0;
 }
@@ -854,6 +912,8 @@ static int intel_remove(struct platform_device *pdev)
 {
 	struct intel_device *idev = platform_get_drvdata(pdev);
 
+	device_wakeup_disable(&pdev->dev);
+
 	spin_lock(&intel_device_list_lock);
 	list_del(&idev->list);
 	spin_unlock(&intel_device_list_lock);
-- 
1.9.1

