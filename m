Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
To: Pavan Savoy <pavan_savoy@sify.com>,
	Vitaly Wool <vitalywool@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>,
	Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Par-Gunnar Hjalmdahl <pghatwork@gmail.com>,
	Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
Subject: [PATCH 11/11] Bluetooth and mach-ux500: Fix of minor issues
Date: Fri, 17 Dec 2010 12:26:08 +0100
Message-ID: <1292585168-28688-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes some minor issues discovered late before
patch creation.

Signed-off-by: Par-Gunnar Hjalmdahl <par-gunnar.p.hjalmdahl@stericsson.com>
---
 arch/arm/mach-ux500/devices-cg2900.c |    6 ++++--
 drivers/bluetooth/hci_uart.h         |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-cg2900.c b/arch/arm/mach-ux500/devices-cg2900.c
index 4dcef97..f0248e3 100644
--- a/arch/arm/mach-ux500/devices-cg2900.c
+++ b/arch/arm/mach-ux500/devices-cg2900.c
@@ -70,14 +70,16 @@ static void dcg2900_enable_chip(struct cg2900_chip_dev *dev)
 {
 	struct dcg2900_info *info = dev->b_data;
 
-	gpio_set_value(info->gbf_gpio, 1);
+	if (info->gbf_gpio != -1)
+		gpio_set_value(info->gbf_gpio, 1);
 }
 
 static void dcg2900_disable_chip(struct cg2900_chip_dev *dev)
 {
 	struct dcg2900_info *info = dev->b_data;
 
-	gpio_set_value(info->gbf_gpio, 0);
+	if (info->gbf_gpio != -1)
+		gpio_set_value(info->gbf_gpio, 0);
 }
 
 static struct sk_buff *dcg2900_get_power_switch_off_cmd
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index ab195fb..4c99222 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	6
+#define HCI_UART_MAX_PROTO	7
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
-- 
1.7.3.2
