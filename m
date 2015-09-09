Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: Bluetooth: hci_intel: Enable IRQ wake capability
Date: Wed,  9 Sep 2015 19:04:15 +0200
Message-Id: <1441818255-16128-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to explicitly enable the IRQ wakeup mode to let the controller
wake the system from sleep states (like suspend-to-ram).

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index b17386b..3314823 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1181,11 +1181,11 @@ static int intel_acpi_probe(struct intel_device *idev)
 #endif
 
 #ifdef CONFIG_PM
-static int intel_suspend(struct device *dev)
+static int intel_rt_suspend(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "intel_suspend");
+	dev_dbg(dev, "intel_rt_suspend");
 
 	mutex_lock(&idev->hu_lock);
 	if (idev->hu)
@@ -1195,11 +1195,11 @@ static int intel_suspend(struct device *dev)
 	return 0;
 }
 
-static int intel_resume(struct device *dev)
+static int intel_rt_resume(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "intel_resume");
+	dev_dbg(dev, "intel_rt_resume");
 
 	mutex_lock(&idev->hu_lock);
 	if (idev->hu)
@@ -1208,11 +1208,35 @@ static int intel_resume(struct device *dev)
 
 	return 0;
 }
+
+static int intel_suspend(struct device *dev)
+{
+	struct intel_device *idev = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "intel_suspend");
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(idev->irq);
+
+	return intel_rt_suspend(dev);
+}
+
+static int intel_resume(struct device *dev)
+{
+	struct intel_device *idev = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "intel_resume");
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(idev->irq);
+
+	return intel_rt_resume(dev);
+}
 #endif
 
 static const struct dev_pm_ops intel_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
-	SET_RUNTIME_PM_OPS(intel_suspend, intel_resume, NULL)
+	SET_RUNTIME_PM_OPS(intel_rt_suspend, intel_rt_resume, NULL)
 };
 
 static int intel_probe(struct platform_device *pdev)
-- 
1.9.1

