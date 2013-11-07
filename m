Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_Bluez] gitignore: Add tools/smp-tester to .gitignore
Date: Fri,  8 Nov 2013 00:25:41 +0200
Message-Id: <1383863141-30400-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 4994958..339d37b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -85,6 +85,7 @@ monitor/btmon
 emulator/btvirt
 emulator/b1ee
 client/bluetoothctl
+tools/smp-tester
 
 src/bluetoothd.8
 src/bluetooth.service
-- 
1.8.3.2

