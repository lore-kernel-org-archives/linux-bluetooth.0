Return-Path: <SRS0=Kz1L=YT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D712FC47E49
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04AA21655
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 20:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="XWt470oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfJZUsj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:48:39 -0400
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:39562 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfJZUsj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Oct 2019 16:48:39 -0400
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id 1A923BFE83;
        Sat, 26 Oct 2019 20:41:48 +0000 (UTC)
Received: from bonstra.fr.eu.org (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id 2A6AA60873;
        Sat, 26 Oct 2019 22:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1572122507; x=1573332107;
        bh=VhKkxkWcTbCjrWeKegoiffMLEInoYHE0UkHYo8HkL10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XWt470oIb0+H5KUndkc4KgevXnc31VGP7RacGTgi4Me6h0cxIdsebstCCEU4tbPRs
         uirV6/kgxCUItw3V4e2RrOXO3s368QAIlDw+T1TNjM75Fy6h4G82DaByyVunSShyhc
         w7ljbeEQznjqGZJveqSZiHdfHBv1faGDYFCqLb8vslSUD1i3V7jJDkUtauCc+z4Xcr
         nwJjiSr7PB9E7T8sn4lgN1ymyfGckhk5gvuzRhK3JIxD9oXZTkdLg47FbexB2xWT2e
         o0Y6vwNdarMY0jNrcnHVt7Gg90+ZKHqDLPKCVw2i79TzDt4GfktEuHU/Vq829cQp0k
         FWs67w3PYGdfg==
From:   Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: allwinner: a64: Enable Bluetooth on Teres-I
Date:   Sat, 26 Oct 2019 22:41:16 +0200
Message-Id: <20191026204116.95119-4-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
References: <20191026204116.95119-1-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The UART1 on the Teres-A64-I is connected to a rtl8723bs combo
WLAN/Bluetooth controller, with three GPIOs used for device reset,
host wake up and device wake up.

Currently, the host wake up feature is not supported by the HCI H5
driver.

Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 1069e7012c9c..c7db2f1650d4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -325,6 +325,19 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		enable-gpio = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		device-wake-gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		realtek,config-name = "teres_a64_i";
+	};
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
-- 
2.23.0

