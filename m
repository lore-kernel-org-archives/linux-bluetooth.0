Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v3 2/4] Bluetooth: hci_intel: Add PM support
Date: Wed,  2 Sep 2015 12:04:12 +0200
Message-Id: <1441188254-15507-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1441188254-15507-1-git-send-email-loic.poulain@intel.com>
References: <1441188254-15507-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add PM suspend/resume callbacks which call lpm_suspend/resume.
Add LPM ack in threaded IRQ handler to notify the controller that
resume is complete.
Protect hci_uart against concurrent removing during suspend/resume.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: Rebase on lpm functions reorder.
     Add idev->hu comment.
 v3: no change

 drivers/bluetooth/hci_intel.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 2e15ca5..3897e75 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -68,6 +68,8 @@ struct intel_device {
 	struct list_head list;
 	struct platform_device *pdev;
 	struct gpio_desc *reset;
+	struct hci_uart *hu;
+	struct mutex hu_lock;
 	int irq;
 };
 
@@ -277,6 +279,11 @@ static irqreturn_t intel_irq(int irq, void *dev_id)
 
 	dev_info(&idev->pdev->dev, "hci_intel irq\n");
 
+	mutex_lock(&idev->hu_lock);
+	if (idev->hu)
+		intel_lpm_host_wake(idev->hu);
+	mutex_unlock(&idev->hu_lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -307,6 +314,15 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 
 		gpiod_set_value(idev->reset, powered);
 
+		/* Provide to idev a hu reference which is used to run LPM
+		 * transactions (lpm suspend/resume) from PM callbacks.
+		 * hu needs to be protected against concurrent removing during
+		 * these PM ops.
+		 */
+		mutex_lock(&idev->hu_lock);
+		idev->hu = powered ? hu : NULL;
+		mutex_unlock(&idev->hu_lock);
+
 		if (idev->irq < 0)
 			break;
 
@@ -1087,6 +1103,40 @@ static int intel_acpi_probe(struct intel_device *idev)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int intel_suspend(struct device *dev)
+{
+	struct intel_device *idev = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "intel_suspend");
+
+	mutex_lock(&idev->hu_lock);
+	if (idev->hu)
+		intel_lpm_suspend(idev->hu);
+	mutex_unlock(&idev->hu_lock);
+
+	return 0;
+}
+
+static int intel_resume(struct device *dev)
+{
+	struct intel_device *idev = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "intel_resume");
+
+	mutex_lock(&idev->hu_lock);
+	if (idev->hu)
+		intel_lpm_resume(idev->hu);
+	mutex_unlock(&idev->hu_lock);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops intel_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
+};
+
 static int intel_probe(struct platform_device *pdev)
 {
 	struct intel_device *idev;
@@ -1095,6 +1145,8 @@ static int intel_probe(struct platform_device *pdev)
 	if (!idev)
 		return -ENOMEM;
 
+	mutex_init(&idev->hu_lock);
+
 	idev->pdev = pdev;
 
 	if (ACPI_HANDLE(&pdev->dev)) {
@@ -1171,6 +1223,7 @@ static struct platform_driver intel_driver = {
 	.driver = {
 		.name = "hci_intel",
 		.acpi_match_table = ACPI_PTR(intel_acpi_match),
+		.pm = &intel_pm_ops,
 	},
 };
 
-- 
1.9.1
