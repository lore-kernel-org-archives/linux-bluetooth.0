Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/5] Bluetooth: rm680: pm constraints support
Date: Fri,  1 Oct 2010 15:47:08 +0300
Message-Id: <1285937230-547-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Add pm_limits callback

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 arch/arm/mach-omap2/board-rm680-peripherals.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rm680-peripherals.c b/arch/arm/mach-omap2/board-rm680-peripherals.c
index a8b03f0..94dde4c 100644
--- a/arch/arm/mach-omap2/board-rm680-peripherals.c
+++ b/arch/arm/mach-omap2/board-rm680-peripherals.c
@@ -50,6 +50,7 @@
 #include <plat/board-nokia.h>
 #include <plat/mmc.h>
 #include <plat/ssi.h>
+#include <plat/omap-pm.h>
 #include "hsmmc.h"
 #include "board-gpio-export.h"
 #include "board-rm680-types.h"
@@ -1323,6 +1324,12 @@ static int __init rm680_i2c_init(void)
 	return 0;
 }
 
+/* Use wakeup latency only for now */
+static void rm680_bt_set_pm_limits(struct device *dev, bool set)
+{
+	omap_pm_set_max_mpu_wakeup_lat(dev, set ? 10 : -1);
+}
+
 static struct omap_bluetooth_config rm680_bt_config = {
 	.chip_type		= BT_CHIP_TI,
 	.bt_wakeup_gpio		= 37,
@@ -1330,6 +1337,7 @@ static struct omap_bluetooth_config rm680_bt_config = {
 	.reset_gpio		= 26,
 	.bt_uart		= 2,
 	.bt_sysclk		= BT_SYSCLK_38_4,
+	.set_pm_limits		= rm680_bt_set_pm_limits,
 };
 
 static struct omap_ssi_board_config __initdata rm680_ssi_config = {
-- 
1.7.0.4

