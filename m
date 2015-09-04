Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_intel: Fix warnings due to unused lpm functions
Date: Fri,  4 Sep 2015 17:39:25 +0200
Message-Id: <1441381165-13510-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

intel_lpm_suspend/resume are only used in case of CONFIG_PM.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 8c9c2b6..70e9e47 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -163,6 +163,7 @@ static int intel_wait_lpm_transaction(struct hci_uart *hu)
 	return err;
 }
 
+#ifdef CONFIG_PM
 static int intel_lpm_suspend(struct hci_uart *hu)
 {
 	static const u8 suspend[] = { 0x01, 0x01, 0x01 };
@@ -249,6 +250,7 @@ static int intel_lpm_resume(struct hci_uart *hu)
 
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 static int intel_lpm_host_wake(struct hci_uart *hu)
 {
-- 
1.9.1

