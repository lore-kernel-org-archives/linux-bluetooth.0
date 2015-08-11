Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] net: rfkill: gpio: Remove BCM2E39 support
Date: Tue, 11 Aug 2015 12:12:11 +0200
Message-Id: <1439287933-21069-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1439287933-21069-1-git-send-email-frederic.danis@linux.intel.com>
References: <1439287933-21069-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Power management support for BCM2E39 is now performed in Bluetooth
BCM UART driver.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 net/rfkill/rfkill-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index d5d58d9..9312722 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -164,7 +164,6 @@ static int rfkill_gpio_remove(struct platform_device *pdev)
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rfkill_acpi_match[] = {
 	{ "BCM2E1A", RFKILL_TYPE_BLUETOOTH },
-	{ "BCM2E39", RFKILL_TYPE_BLUETOOTH },
 	{ "BCM2E3D", RFKILL_TYPE_BLUETOOTH },
 	{ "BCM2E40", RFKILL_TYPE_BLUETOOTH },
 	{ "BCM2E64", RFKILL_TYPE_BLUETOOTH },
-- 
1.9.1

