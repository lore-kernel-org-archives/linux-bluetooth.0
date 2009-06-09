Return-Path: <cyrus@holtmann.org>
From: Alexander Beregalov <a.beregalov@gmail.com>
To: marcel@holtmann.org,
	linux-next@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] Bluetooth: depends on RFKILL
Date: Tue,  9 Jun 2009 19:07:40 +0400
Message-Id: <1244560060-28112-1-git-send-email-a.beregalov@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Since commit "Bluetooth: Add native RFKILL soft-switch support for all
devices" (611b30f74b5) bluetooth depends on RFKILL.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 net/bluetooth/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 7725da9..85ec71d 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig BT
-	depends on NET && !S390
+	depends on NET && RFKILL && !S390
 	tristate "Bluetooth subsystem support"
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
-- 
1.6.3.1
