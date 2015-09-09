Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v2] Bluetooth: hci_intel: Enable IRQ wake capability
Date: Wed,  9 Sep 2015 21:04:15 +0200
Message-Id: <1441825455-23767-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We need to explicitly enable the IRQ wakeup mode to let the controller
wake the system from sleep states (like suspend-to-ram).
PM suspend/resume callbacks now call the generic intel device PM
functions after enabling/disabling IRQ wake.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: rename generic suspend/resume functions
     remove useless function name debug

 drivers/bluetooth/hci_intel.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index b17386b..0179431 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1181,12 +1181,10 @@ static int intel_acpi_probe(struct intel_device *idev)
 #endif
 
 #ifdef CONFIG_PM
-static int intel_suspend(struct device *dev)
+static int intel_suspend_device(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "intel_suspend");
-
 	mutex_lock(&idev->hu_lock);
 	if (idev->hu)
 		intel_lpm_suspend(idev->hu);
@@ -1195,12 +1193,10 @@ static int intel_suspend(struct device *dev)
 	return 0;
 }
 
-static int intel_resume(struct device *dev)
+static int intel_resume_device(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
 
-	dev_dbg(dev, "intel_resume");
-
 	mutex_lock(&idev->hu_lock);
 	if (idev->hu)
 		intel_lpm_resume(idev->hu);
@@ -1208,11 +1204,31 @@ static int intel_resume(struct device *dev)
 
 	return 0;
 }
+
+static int intel_suspend(struct device *dev)
+{
+	struct intel_device *idev = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(idev->irq);
+
+	return intel_suspend_device(dev);
+}
+
+static int intel_resume(struct device *dev)
+{
+	struct intel_device *idev = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(idev->irq);
+
+	return intel_resume_device(dev);
+}
 #endif
 
 static const struct dev_pm_ops intel_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
-	SET_RUNTIME_PM_OPS(intel_suspend, intel_resume, NULL)
+	SET_RUNTIME_PM_OPS(intel_suspend_device, intel_resume_device, NULL)
 };
 
 static int intel_probe(struct platform_device *pdev)
-- 
1.9.1
