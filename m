Return-Path: <ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Satish Patel <satish.patel@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] Bluetooth: hci_ll: Add support for the external clock
Date: Wed,  7 Jun 2017 11:08:21 +0200
Message-Id: <1496826502-1339-3-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
References: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support to manage the external clock provided to the WiLink combo chip
as it's needed for any of the transport interfaces.

To avoid breaking platforms not yet specifying the external clock, we make
it optional. In case the clock is successfully fetched during ->probe(),
let's manage it via the ->open|close() callbacks, to make sure the device
get properly powered on/off.

Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/bluetooth/hci_ll.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index adc444f..68f3d16 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -48,6 +48,7 @@
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 #include <linux/ti_wilink_st.h>
+#include <linux/clk.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -84,6 +85,7 @@ struct ll_device {
 	struct hci_uart hu;
 	struct serdev_device *serdev;
 	struct gpio_desc *enable_gpio;
+	struct clk *ext_clk;
 };
 
 struct ll_struct {
@@ -146,8 +148,12 @@ static int ll_open(struct hci_uart *hu)
 
 	hu->priv = ll;
 
-	if (hu->serdev)
+	if (hu->serdev) {
+		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
 		serdev_device_open(hu->serdev);
+		if (!IS_ERR(lldev->ext_clk))
+			clk_prepare_enable(lldev->ext_clk);
+	}
 
 	return 0;
 }
@@ -181,6 +187,8 @@ static int ll_close(struct hci_uart *hu)
 		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
 
+		clk_disable_unprepare(lldev->ext_clk);
+
 		serdev_device_close(hu->serdev);
 	}
 
@@ -720,6 +728,10 @@ static int hci_ti_probe(struct serdev_device *serdev)
 	if (IS_ERR(lldev->enable_gpio))
 		return PTR_ERR(lldev->enable_gpio);
 
+	lldev->ext_clk = devm_clk_get(&serdev->dev, "ext_clock");
+	if (IS_ERR(lldev->ext_clk) && PTR_ERR(lldev->ext_clk) != -ENOENT)
+		return PTR_ERR(lldev->ext_clk);
+
 	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
 	hci_uart_set_speeds(hu, 115200, max_speed);
 
-- 
2.7.4
