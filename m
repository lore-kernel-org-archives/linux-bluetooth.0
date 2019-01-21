Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BDC37120
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 20:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685752089F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfAUUj4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:39:56 -0500
Received: from avasout04.plus.net ([212.159.14.19]:56403 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUUjz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 15:39:55 -0500
Received: from localhost.localdomain ([87.112.42.170])
        by smtp with ESMTP
        id lgMBgPXkRAOoylgMMgBlmF; Mon, 21 Jan 2019 20:39:54 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=mWDk6ZswF0UwtwIMZFE8gw==:117 a=mWDk6ZswF0UwtwIMZFE8gw==:17
 a=WaJYZbQPnuN-YhsSyc4A:9 a=u-giGDfNQ2kGiz5w:21 a=tviL4In-nHg2R7vb:21
From:   David Summers <beagleboard@davidjohnsummers.uk>
To:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     David Summers <beagleboard@davidjohnsummers.uk>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: Create the file for Realtek Bluetooth serial devices
Date:   Mon, 21 Jan 2019 20:39:28 +0000
Message-Id: <20190121203928.32723-2-beagleboard@davidjohnsummers.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
References: <20190121203928.32723-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFubGDHLUmLoAlwIfINJT5uDay8rcjv8Hv6DwIg435/jaaIxMKoeKgLXk97fASTFspFML2rdOkSs60uB+GFHg8IQLvYVWkDX8gywmyEpInKN9gZZSMrz
 IgwZKu6Oyjqrm1X1RbOCXSXOvqWQLQYjAgSpGLb3dQTRsPDxWzj49pTW65+bl8xEMvY73ImKypedkEZhut1YaKgGLAOj2gzP158=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With the changes requested by Marcel Holtmann and Rob Herring.

Capitalisation as requested.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
---
 .../bindings/net/realtek-bluetooth-serial.txt | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
new file mode 100644
index 000000000000..2eddde1a0cf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
@@ -0,0 +1,32 @@
+Realtek Bluetooth devices connected via a UART.
+These devices typically also have a WI-FI connected via SDIO - the
+compatible described here is used just for referencing the Bluetooth.
+
+- compatible: should be "realtek,<name>-bt"
+  except for "realtek,trl8761atv" - which only has a serial Bluetooth connection
+       "realtek,rtl8723as-bt"
+       "realtek,rtl8723bs-bt"
+       "realtek,rtl8723ds-bt"
+       "realtek,rtl8761atv"
+       "realtek,rtl8821as-bt"
+       "realtek,rtl8821cs-bt"
+       "realtek,rtl8822bs-bt"
+
+Example:
+
+&uart0 {
+	status = "okay";
+	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		uart_rts_gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default","rts_gpio";
+		pinctrl-0 = <&uart0_rts>;
+		pinctrl-1 = <&uart0_gpios>;
+		BT,reset_gpio    = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		BT,wake_gpio     = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+		BT,wake_host_irq = <&gpio4 31 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+this ensures that the Bluetooth device is tied to the correct uart.
-- 
beagleboard@davidjohnsummers.uk

