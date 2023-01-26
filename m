Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B42FC54E94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 07:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjAZHqJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 02:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjAZHpv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 02:45:51 -0500
Received: from smtp-out-06.comm2000.it (smtp-out-06.comm2000.it [212.97.32.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529169B1B;
        Wed, 25 Jan 2023 23:45:26 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-06.comm2000.it (Postfix) with ESMTPSA id D51BC561372;
        Thu, 26 Jan 2023 08:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1674719110;
        bh=Y9XCnAPij17MA+QoBNd8FvPcBvFaxXeiz+vHwwOCDWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=I2CYUxZwZ+wcSRyagmyhnstP4jB889U8C2lqZHpElTSvXWVR1/M7WQiK0ZxYc0UKq
         0LMoyg4QPXsFwbl4KGpeTUvIguB6XcOlKh/hMUzofuiaMrmsxmuQZnNJXaMIoKd/XM
         oI4pq0Qa6uQI24787uklIx/aJQ5uwuyYfM5YejbEBGFD2NKqOYJobBaBYLPNIXTZXu
         4d4pVwWCZNAewoeChn75KpnBz32Lu2jtDQ3zieRArOSZOEmBR/ie3E7MbDgN04jfdc
         xh/RqctVwlWC+hcSFFKwoH40lFg8psglNFENlygH5e3aTDy7+Ars85MMWm2vy460W/
         Y11hPaXaXkH9A==
From:   Francesco Dolcini <francesco@dolcini.it>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 5/5] arm64: dts: imx8mp-verdin: add 88W8997 serdev to uart4
Date:   Thu, 26 Jan 2023 08:43:56 +0100
Message-Id: <20230126074356.431306-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126074356.431306-1-francesco@dolcini.it>
References: <20230126074356.431306-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Use the serdev feature to load the driver for the 88W8997 bluetooth
driver.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
index 36289c175e6e..ef94f9a57e20 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
@@ -65,6 +65,11 @@ &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_bt_uart>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "mrvl,88w8997";
+		max-speed = <921600>;
+	};
 };
 
 /* On-module Wi-Fi */
-- 
2.25.1

