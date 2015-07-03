Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] net: rfkill: gpio: Make BCM2E39 support optional
Date: Fri,  3 Jul 2015 15:22:30 +0200
Message-Id: <1435929751-26831-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1435929751-26831-1-git-send-email-frederic.danis@linux.intel.com>
References: <1435929751-26831-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of kernel configured to build Bluetooth BCM UART driver, do not
support BCM2E39 in rfkill-gpio.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 net/rfkill/rfkill-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index d978f2f..b573cbb 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -168,7 +168,9 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rfkill_acpi_match[] = {
 	{ "BCM2E1A", RFKILL_TYPE_BLUETOOTH },
+#ifndef CONFIG_BT_HCIUART_BCM
 	{ "BCM2E39", RFKILL_TYPE_BLUETOOTH },
+#endif
 	{ "BCM2E3D", RFKILL_TYPE_BLUETOOTH },
 	{ "BCM2E40", RFKILL_TYPE_BLUETOOTH },
 	{ "BCM2E64", RFKILL_TYPE_BLUETOOTH },
-- 
1.9.1

