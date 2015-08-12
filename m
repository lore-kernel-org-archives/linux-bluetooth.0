Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Walleij <linus.walleij@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] Bluetooth: hci_bcm: improve use of gpios API
Date: Wed, 12 Aug 2015 09:20:56 +0200
Message-Id: <1439364056-8564-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20150812165949.0d66f2be@canb.auug.org.au>
References: <20150812165949.0d66f2be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

devm_gpiod_get currently has an optional parameter to set initial
direction and value for the requested gpio. Make use of this to simplify
the driver and make it not fail to build when this parameter is made
mandatory (which is scheduled for 4.3-rc1).

Moreover use the _optional variant of devm_gpiod_get to simplify error
handling (which also gets more strict for free).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is needed on top of commit 0395ffc1ee05 ("Bluetooth: hci_bcm: Add
PM for BCM devices") incombination with b17d1bf16cc7 ("gpio: make flags
mandatory for gpiod_get functions") which is currently sitting in next.

Stephen fixed it up with a simpler patch, which works fine, but doesn't
benefit from the nice things devm_gpiod_get et al offer.

Best regards
Uwe

 drivers/bluetooth/hci_bcm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index cb7fe837f7d9..6070303418d8 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -408,7 +408,6 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 {
 	struct platform_device *pdev = dev->pdev;
 	const struct acpi_device_id *id;
-	struct gpio_desc *gpio;
 	struct acpi_device *adev;
 	LIST_HEAD(resources);
 	int ret;
@@ -426,21 +425,16 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 
-	gpio = devm_gpiod_get(&pdev->dev, "device-wakeup");
-	if (!IS_ERR(gpio)) {
-		ret = gpiod_direction_output(gpio, 0);
-		if (ret)
-			return ret;
-		dev->device_wakeup = gpio;
-	}
+	dev->device_wakeup = devm_gpiod_get_optional(&pdev->dev,
+						     "device-wakeup",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(dev->device_wakeup))
+		return PTR_ERR(dev->device_wakeup);
 
-	gpio = devm_gpiod_get(&pdev->dev, "shutdown");
-	if (!IS_ERR(gpio)) {
-		ret = gpiod_direction_output(gpio, 0);
-		if (ret)
-			return ret;
-		dev->shutdown = gpio;
-	}
+	dev->shutdown = devm_gpiod_get_optional(&pdev->dev, "shutdown",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(dev->shutdown))
+		return PTR_ERR(dev->shutdown);
 
 	/* Make sure at-least one of the GPIO is defined and that
 	 * a name is specified for this instance
-- 
2.4.6
