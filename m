Return-Path: <SRS0=PdJ8=RM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F8C43381
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Mar 2019 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7173B20836
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Mar 2019 15:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCIPrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:47:10 -0500
Received: from avasout02.plus.net ([212.159.14.17]:54796 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCIPrK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Mar 2019 10:47:10 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2019 10:47:10 EST
Received: from localhost.localdomain ([87.114.146.246])
        by smtp with ESMTP
        id 2e4PhIi6Rx6b62e4YhgA0R; Sat, 09 Mar 2019 15:39:40 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=T4GiscCQ c=1 sm=1 tr=0
 a=DwUJrZpGRQ5ePevJMiNdYw==:117 a=DwUJrZpGRQ5ePevJMiNdYw==:17 a=OLL_FvSJAAAA:8
 a=ViPa0ciWmgWNDZ-_SmcA:9 a=1p1MZfBn9Gu4pFza:21 a=f5_gGt5-OF2vyWa9:21
 a=pUjmoVUizdcA:10 a=6X9rrcGS-_EA:10 a=oIrB72frpwYPwTMnlWqB:22
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     heiko@sntech.de, robh+dt@kernel.org, frowand.list@gmail.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, anarsoul@gmail.com
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] arm: dts: rk3288-tinker.dtsi: Add outline Bluetooth support
Date:   Sat,  9 Mar 2019 15:39:23 +0000
Message-Id: <20190309153923.22806-3-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190309153923.22806-1-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190309153923.22806-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGxqF2Ir1oYv4R43utEOiZ/s+q84qpG8mM1+LLELkZ885sALm4txqBypubAtDogY9ajkFI/PZsoWv5vNDS5TGyVP0nri9q6b2Ik3E5c5lvvAOIgGVsqx
 Yyc0+P8qwzteyl+mr1iV7rTbrCemaxiNkTi+IsuswB5hBu9PK4vgYnFas3MNfCXg3He7vkvipHZ+wGUU80sSLbnuQxJbST2Bf/w=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch is an outline for bluetooth on the ASUS Tinker Board (S).

Bluetooth is provided my RTL8723BS on these machine, and this is wired
into UART0.

Here this is performed as a SerDev device.

Now as presented, this does not give functioning bluetooth. The
updates needed to the device driver:

https://www.spinics.net/lists/linux-bluetooth/msg78661.html

Haven't yet been accepted. So this device tree hook doesn't yet have
"realtek,rtl8723bs-bt" compatible flag.

It is however still submitted as a patch, as it sets the UART up
correctly. And so basic communciation can be had with the device. This
has been confirmed by Tony McKahan @ Armbian, in particular that the
CTS/RTS is needed.

When Vasily patch is accepted, this will be added as a minor patch on
top of this patch; as this patch gives the pins needed.

The one oddity, is the RESET pin, it is labeled this way on the
schematic. However the hci_h5.c driver calls this ENABLE. Here we have
stuck with the schematic name.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 0ffab1b7c940..d29f5b34d7e6 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -486,6 +486,17 @@
 
 &uart0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
+
+	bluetooth {
+		clocks = <&rk808 RK808_CLKOUT1>;
+		reset-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
+		device-wake-gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		host-wake-gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
+		vcc-18-supply = <&vcc_18>;
+		vcc-io-supply = <&vcc_io>;
+	};
 };
 
 &uart1 {
-- 
beagleboard@davidjohnsummers.uk

