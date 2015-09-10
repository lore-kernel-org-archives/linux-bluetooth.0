Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_intel: Fix warning due to unused pm functions
Date: Thu, 10 Sep 2015 11:23:47 +0200
Message-Id: <1441877027-19794-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

intel_suspend/resume depend on CONFIG_PM_SLEEP. They are unused in
other cases.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index ad45b9a..49e2540 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1207,7 +1207,9 @@ static int intel_resume_device(struct device *dev)
 
 	return 0;
 }
+#endif
 
+#ifdef CONFIG_PM_SLEEP
 static int intel_suspend(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
-- 
1.9.1
