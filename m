Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: trivial: Remove newline before EOF
Date: Tue, 23 Oct 2012 19:02:16 +0530
Message-id: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trivial fix.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 1c11d0d..d3f3f7b 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -48,4 +48,3 @@ source "net/bluetooth/cmtp/Kconfig"
 source "net/bluetooth/hidp/Kconfig"
 
 source "drivers/bluetooth/Kconfig"
-
-- 
1.7.9.5

