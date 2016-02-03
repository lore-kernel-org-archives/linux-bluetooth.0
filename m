Return-Path: <root@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <wnhuang@chromium.org>, <marcel@holtmann.org>,
        Cathy Luo <cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v2 2/2] bluetooth: btmrvl: parse host wakeup configuration from device tree
Date: Tue, 2 Feb 2016 21:34:21 -0800
Message-ID: <1454477661-26734-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1454477661-26734-1-git-send-email-akarwar@marvell.com>
References: <1454477661-26734-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

This patch implements a framework for board specific wakeup.
driver parse irq/gpio number from device tree, corresponding
resources will be allocated, and used for host suspend/resume.
Device tree binding file is also updated in the patch.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
v2: Fixed build error reported by kbuild test robot
drivers/bluetooth/btmrvl_platform.c:141:22: error:
'btmrvl_plt_pm_ops' undeclared here (not in a function)
---
 Documentation/devicetree/bindings/btmrvl.txt | 17 ++++-
 drivers/bluetooth/btmrvl_platform.c          | 95 ++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/btmrvl.txt b/Documentation/devicetree/bindings/btmrvl.txt
index 25b804b..887c7ff 100644
--- a/Documentation/devicetree/bindings/btmrvl.txt
+++ b/Documentation/devicetree/bindings/btmrvl.txt
@@ -12,11 +12,19 @@ Optional properties:
 
   - btmrvl,gpio-gap : gpio and gap (in msecs) combination to be
 		      configured.
+  - interrupt-parent: phandle of the parent interrupt controller
+  - interrupts : interrupt number to the cpu
+  - gpios: specify GPIO respectively. gpio here is board specific pin.
+	   while above gpio-gap represents the device side pin used to
+	   wakeup host.
+  - pinctrl-names : a pinctrl state named "default" must be defined
+  - pinctrl-0 : pin control group to be used for this controller
 
 Example:
 
-GPIO pin 13 and gap 100ms are configured for host wakeup, calibration
-data is also available in below example.
+GPIO pin 119 and gap 100ms are configured for host wakeup,
+pin 13 is configured so that firmware can wakeup host using this device side
+pin, calibration data is also available in below example.
 
 btmrvl {
 	compatible = "marvell,btmrvl";
@@ -26,4 +34,9 @@ btmrvl {
 		0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
 		0x00 0x00 0xf0 0x00>;
 	btmrvl,gpio-gap = <0x0d64>;
+	interrupt-parent = <&pio>;
+	interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
+	gpios = <&pio 119 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&wake_pins>;
 };
diff --git a/drivers/bluetooth/btmrvl_platform.c b/drivers/bluetooth/btmrvl_platform.c
index 4e91d27..6f64922 100644
--- a/drivers/bluetooth/btmrvl_platform.c
+++ b/drivers/bluetooth/btmrvl_platform.c
@@ -19,9 +19,63 @@
 
 struct platform_device *btmrvl_plt_dev;
 
+struct btmrvl_wake_dev {
+	struct device	*dev;
+	int		irq_bt;
+	bool		wake_by_bt;
+};
+
+static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
+{
+	struct btmrvl_wake_dev *ctx = priv;
+
+	if (ctx->irq_bt >= 0) {
+		ctx->wake_by_bt = true;
+		disable_irq_nosync(ctx->irq_bt);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int btmrvl_plt_probe(struct platform_device *pdev)
 {
+	int ret;
+	struct btmrvl_wake_dev *ctx;
+	int gpio;
+
 	btmrvl_plt_dev = pdev;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->dev = &pdev->dev;
+	ctx->irq_bt = platform_get_irq(pdev, 0);
+	if (ctx->irq_bt < 0)
+		dev_err(&pdev->dev, "Failed to get irq_bt\n");
+
+	gpio = of_get_gpio(pdev->dev.of_node, 0);
+	if (gpio_is_valid(gpio))
+		gpio_direction_input(gpio);
+	else
+		dev_err(&pdev->dev, "gpio bt is invalid\n");
+
+	if (ctx->irq_bt >= 0) {
+		ret = devm_request_irq(&pdev->dev, ctx->irq_bt,
+				       btmrvl_wake_irq_bt,
+				       IRQF_TRIGGER_LOW,
+				       "bt_wake", ctx);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to request irq_bt %d (%d)\n",
+				ctx->irq_bt, ret);
+			return -EINVAL;
+		}
+		disable_irq(ctx->irq_bt);
+	}
+
+	platform_set_drvdata(pdev, ctx);
+
 	return 0;
 }
 
@@ -31,6 +85,44 @@ static int btmrvl_plt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int btmrvl_plt_suspend(struct device *dev)
+{
+	struct btmrvl_wake_dev *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	if (ctx->irq_bt >= 0) {
+		ctx->wake_by_bt = false;
+		enable_irq(ctx->irq_bt);
+		ret = enable_irq_wake(ctx->irq_bt);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int btmrvl_plt_resume(struct device *dev)
+{
+	struct btmrvl_wake_dev *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	if (ctx->irq_bt >= 0) {
+		ret = disable_irq_wake(ctx->irq_bt);
+		if (!ctx->wake_by_bt)
+			disable_irq(ctx->irq_bt);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops btmrvl_plt_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(btmrvl_plt_suspend, btmrvl_plt_resume)
+};
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct of_device_id btmrvl_dt_match[] = {
 	{
 		.compatible = "marvell,btmrvl",
@@ -46,6 +138,9 @@ static struct platform_driver btmrvl_platform_driver = {
 	.driver = {
 		.name	= "btmrvl_plt",
 		.of_match_table = btmrvl_dt_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm             = &btmrvl_plt_pm_ops,
+#endif
 	}
 };
 
-- 
1.8.1.4
