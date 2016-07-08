Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: wu.zheng@intel.com
To: linux-bluetooth@vger.kernel.org
Cc: wu.zheng@intel.com
Subject: [PATCH] Fix bluez5 capabilities for Smack setup
Date: Fri,  8 Jul 2016 16:03:07 +0800
Message-Id: <1467964987-6402-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wu Zheng <wu.zheng@intel.com>

Recent bluez5 releases started limiting the capabilities of
bluetoothd. When running on a Smack-enabled system, that change has the
effect that bluetoothd can no longer create the input device under
/sys because bluez5 running with label "System" has no write
access to that.

It works when running as normal root with unrestricted capabilities
because then CAP_MAC_OVERRIDE (a Smack-specific capability) allows
the process to ignore Smack rules.

We need to ensure that bluetoothd still has that capability.
---
 src/bluetooth.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f799f65..1b0fead 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -10,7 +10,7 @@ ExecStart=@libexecdir@/bluetoothd
 NotifyAccess=main
 #WatchdogSec=10
 #Restart=on-failure
-CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
+CapabilityBoundingSet=CAP_MAC_OVERRIDE CAP_NET_ADMIN CAP_NET_BIND_SERVICE
 LimitNPROC=1
 ProtectHome=true
 ProtectSystem=full
-- 
2.1.4

