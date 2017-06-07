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
Subject: [PATCH 3/3] arm64: dts: hikey: Add external clock to the Bluetooth node
Date: Wed,  7 Jun 2017 11:08:22 +0200
Message-Id: <1496826502-1339-4-git-send-email-ulf.hansson@linaro.org>
In-Reply-To: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
References: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

To make the TI WiLink chip work again for Bluetooth, let's add the missing
external clock to the Bluetooth node, such the driver can deal properly
with it during power on/off.

Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
Cc: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 49f6a62..5cdfe73 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -141,6 +141,8 @@
 			bluetooth {
 				compatible = "ti,wl1835-st";
 				enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+				clocks = <&pmic>;
+				clock-names = "ext_clock";
 			};
 		};
 
-- 
2.7.4
