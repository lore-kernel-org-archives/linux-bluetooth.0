Return-Path: <SRS0=v5pE=ZW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE11C33CB9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88C52084D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 20:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="UjacfKcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK3UXj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:23:39 -0500
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:41476 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfK3UXj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Nov 2019 15:23:39 -0500
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id 90334BFBCC;
        Sat, 30 Nov 2019 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id BB4D864C1B;
        Sat, 30 Nov 2019 21:23:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1575145416; x=1576355016;
        bh=KTDx3GIAk0BBY7Hm5xNIopsl0EDTIeBIgAhSNWOJzzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UjacfKcEmbQNnDInHocp5tbE+wr0WT/estqa6bJNtRbZSfUdnGXRTWfpwC21fXuqc
         Q4VdN5W0fl5w8+pkpodLt696Bt8TzqwKvV7WrmcYaTCEOme4SpRMuX4sC55ypAyDSt
         3Qiu1RmJrOKHWlrI53/4QbH27j8BRJDVyVA/F7p9yDn85tGZOidoMAaNob2nAMptIu
         TL5Yrf6JiBrnbNMX9KhjKJRGnZlVYRgQHD19KwBpwHxUdwrP/SkZSBrai7hH/VS+A8
         BxADUTpyz8uB/67wH8brJ8SMVT9BfYqDOBjRLxsni9xb722ojAZGmc2clZ0QR2BLqX
         QaBiIl7Zj8JWA==
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
Subject: [PATCH v4 3/3] arm64: dts: allwinner: a64: Enable Bluetooth on Teres-I
Date:   Sat, 30 Nov 2019 21:23:14 +0100
Message-Id: <20191130202314.142096-4-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130202314.142096-1-bonstra@bonstra.fr.eu.org>
References: <20191130202314.142096-1-bonstra@bonstra.fr.eu.org>
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
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 1069e7012c9c..b28e6d7cb227 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -325,6 +325,20 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		powerdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+		host-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		device-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		firmware-name = "rtl8723bs_config-teres_a64_i.bin";
+	};
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
-- 
2.24.0

