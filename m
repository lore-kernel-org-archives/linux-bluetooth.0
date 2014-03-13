Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-bluetooth@vger.kernel.org, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] Bluetooth: make sure 6LOWPAN_IPHC is built-in if needed
Date: Thu, 13 Mar 2014 11:31:41 +0100
Message-ID: <23264195.jQigvx9V9i@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

>From 5c094e2f8e556b27a73607fc39d33944c1ec3384 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 13 Mar 2014 11:27:21 +0100
Subject: [PATCH] Bluetooth: make sure 6LOWPAN_IPHC is built-in if needed

Commit 975508879 "Bluetooth: make bluetooth 6lowpan as an option"
ensures that 6LOWPAN_IPHC is turned on when we have BT_6LOWPAN
enabled in Kconfig, but it allows building the IPHC code as
a loadable module even if the entire Bluetooth stack is built-in,
and that causes a link error.

We can solve that by moving the 'select' statement into CONFIG_BT,
which is a "tristate" option to enforce that 6LOWPAN_IPHC can
only be a module if BT also is a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 10c752f..06ec144 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -6,6 +6,7 @@ menuconfig BT
 	tristate "Bluetooth subsystem support"
 	depends on NET && !S390
 	depends on RFKILL || !RFKILL
+	select 6LOWPAN_IPHC if BT_6LOWPAN
 	select CRC16
 	select CRYPTO
 	select CRYPTO_BLKCIPHER
@@ -42,7 +43,6 @@ menuconfig BT
 config BT_6LOWPAN
 	bool "Bluetooth 6LoWPAN support"
 	depends on BT && IPV6
-	select 6LOWPAN_IPHC
 	help
 	  IPv6 compression over Bluetooth.
 
