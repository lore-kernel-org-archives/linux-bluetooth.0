Return-Path: <guodong.xu@linaro.org>
From: Guodong Xu <guodong.xu@linaro.org>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	catalin.marinas@arm.com,
	will.deacon@arm.com,
	haojian.zhuang@linaro.org,
	linus.walleij@linaro.org,
	tony@atomide.com
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH 2/2] arm64: dts: hikey: set bluetooth led trigger
Date: Thu, 23 Jun 2016 12:58:43 +0800
Message-Id: <1466657923-5776-2-git-send-email-guodong.xu@linaro.org>
In-Reply-To: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
References: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Set bluetooth led trigger to hci0-rx, and so LED blinks on hci
frame receiving.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e92a30c..5032792 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -132,7 +132,7 @@
 		bt_active_led {
 			label = "bt_active";
 			gpios = <&gpio4 7 0>; /* <&gpio_bt_active_led>; */
-			linux,default-trigger = "hci0rx";
+			linux,default-trigger = "hci0-rx";
 			default-state = "off";
 		};
 	};
-- 
1.9.1
