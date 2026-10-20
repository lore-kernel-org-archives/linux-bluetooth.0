Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.18.0.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502808;
	b=LulTNZs+mudBF7wmCT/XT4PzR+lZc9hZwf3L+1u9DhCeELrXXSPF9JQ3OjMGWndZ9RlI
	 HbWldEvGS4KWOrgL/LgDwYZIBVqKIgXulUgFewyxjr1Ac+1H8WBJ8TJa78TJT2Dva6zb+
	 LNkmKg/DA06nU5HKjztLcbPFuQfDSkOLI24UzMHTUJZk/ZFXcbEVpGiq/HGaBfIMk7dsg
	 pGX8ZOfB8Ug6/g0RnLP7J8Girgc+u9slENH7tg4Kgj4Dw2cATw1GxFeRC3zmcTxWAnZYT
	 /9zdYqVml8iyHH7W+4YfqKmBkfuVDbrn+5q89r3hHGZQ1E9nI4eCtu73ksFAEDF6i6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Virus-Scanned:Received:X-Auth-Info:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gxqjTLXP2Bdl4XJTAtgSbJ5PxXoA7v64IqgAkEOSj9w=;
	b=gU36X8J0/UYlLQzVMgtdgpaPdHNPnv5b0TlAkaCkZc9F1C+umK2nDq6/Xzay1pIlor6z
	 vFbvg7DGflZb/baYwaG3yVPrRyHMWOcna4k9DUnr0nMfQN4abhva/vsjtmmhLNxsJk6f0
	 bIhNDiStrAvAjeFoQLIMf5gceu+U2qWCmtYibIAK7whQ3l+lt5oNmQtJDlIO35bmpMZnN
	 5IxEs7ulBjMtqOprwparj551fG0rwZ5FEm34BLxtTMkwisarRKLjVM9/OAbZsJfghKrAE
	 JGKRmDihxRIxfLQWsyKxZLBC4mk6pjaIo/o27GatBTmRNMB6YYO46J2KsR7ozPpbYEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=muenchen-mail.de;
	spf=pass smtp.mailfrom=muenchen-mail.de;
	dkim=pass header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b=3w4L8FIE;
	arc=none smtp.remote-ip=212.18.0.9
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72240606A31B;
	Tue, 20 Oct 2026 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72240606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b=3w4L8FIE
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8Cqd5dZFz1rB8S;
	Tue, 20 Oct 2026 15:26:37 +0200 (CEST)
DKIM-Signature: a=rsa-sha256; bh=gxqjTLXP2Bdl4XJTAtgSbJ5PxXoA7v64IqgAkEOSj9w=;
        c=relaxed/relaxed; d=muenchen-mail.de;
        h=Date:From:To:Message-ID:Subject;
        s=r1; t=1792502797; v=1;
        b=3w4L8FIE/Ywd9uazcASiiL2vg4piD76E1+r2pBrGet6WRgBAN4pG39h73KVusL13
         AD5osIiiRJrBfeljB438B8mfA5gGUwf0ETQjXrHRAdsVIgBi2jY/GvYTXJ9elojI
         PauLK8TM+rAkyowl2O6Tk91Xa1+q29i1LcMp9IoKL6ojD89HxOhzEpMaz9oKcO8o
         pUrFnVh+Qg4sWBRAh5iAFlJ4nYmT5oXsdXR8ToUo3Frco1Lo8DDnLGJHf9QfyDRi
         SAqOHRLBIyWkI78l8lVtjst8zYjoBLJo4yOS0lU9FvYh3WmhhFnlKsbhJm7olR0C
         3hRY3+lvBWN5ylRnbNriIA==
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8Cqc2Gkgz1rB88;
	Tue, 20 Oct 2026 15:26:36 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4j8Cqc21yyz1qqlT;
	Tue, 20 Oct 2026 15:26:36 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id D802EUZcgVnU; Tue, 20 Oct 2026 15:26:34 +0200 (CEST)
X-Auth-Info: X//PJFB5cKJHMaFeE+OqOQNjOzV+MxMHlhQBdCjykIl9w5Vw+uMptPISYU/ALOh0
Received: from wiesel.intern (aftr-62-216-206-189.dynamic.mnet-online.de [62.216.206.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 15:26:34 +0200 (CEST)
Received: from murmel.intern (unknown [IPv6:fdea:9b79:8984:1:7b8d:a039:76a5:1596])
	by wiesel.intern (Postfix) with ESMTP id DB9AB79A0932;
	Tue, 20 Oct 2026 15:26:33 +0200 (CEST)
From: Thomas Gerner <thomas.gerner@muenchen-mail.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Thomas Gerner <thomas.gerner@muenchen-mail.de>
Subject: [PATCH v2 2/2] riscv: dts: thead: Enable bluetooth on BeagleV-Ahead
Date: Tue, 20 Oct 2026 15:26:04 +0200
Message-ID: <20261020132604.90708-3-thomas.gerner@muenchen-mail.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
References: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the BeagleV-Ahead the bluetooth module of the Ampak AP6203BM is
identified by the btbcm driver as BCM4362A2. The module is connected by
UART4, several gpio pins and an I2S interface. The I2S is currently not
used as there is currently no driver.

Signed-off-by: Thomas Gerner <thomas.gerner@muenchen-mail.de>
---
Changes in v2:
	- use default pinctrl definition for bluetooth in and out pins
	
 .../boot/dts/thead/th1520-beaglev-ahead.dts   | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index e16484a47653..7161a9d4c61f 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -76,6 +76,23 @@ led-5 {
 		};
 	};
 
+	reg_vbat_1v8: regulator-vbat-1v8 {
+		compatible = "regulator-fixed";
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vbat-1v8";
+	};
+
+	reg_vbat_3v3: regulator-vbat-3v3 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vbat-3v3";
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "d";
@@ -152,6 +169,28 @@ led-pins {
 };
 
 &padctrl0_apsys {
+	bluetooth_pins: bluetooth-0 {
+		in-pins {
+			bias-disable;
+			drive-strength = <1>;
+			function = "gpio";
+			input-enable;
+			input-schmitt-enable;
+			pins = "GPIO2_30";
+			slew-rate = <0>;
+		};
+
+		out-pins {
+			bias-disable;
+			drive-strength = <3>;
+			input-disable;
+			input-schmitt-disable;
+			pins = "SDIO1_DETN",	/* GPIO2_29 */
+			       "SDIO1_WPRTN";	/* GPIO2_28 */
+			slew-rate = <0>;
+		};
+	};
+
 	gmac0_pins: gmac0-0 {
 		tx-pins {
 			pins = "GMAC0_TX_CLK",
@@ -268,6 +307,30 @@ reg-on-pins {
 	};
 };
 
+&padctrl1_apsys {
+	uart4_pins: uart4-0 {
+		rx-pins {
+			bias-disable;
+			drive-strength = <1>;
+			function = "uart";
+			input-enable;
+			pins = "UART4_RXD", "UART4_CTSN";
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+
+		tx-pins {
+			bias-disable;
+			drive-strength = <3>;
+			function = "uart";
+			input-disable;
+			pins = "UART4_TXD", "UART4_RTSN";
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
 &sdio0 {
 	bus-width = <4>;
 	max-frequency = <198000000>;
@@ -314,3 +377,25 @@ &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&uart4 {
+	pinctrl-0 = <&uart4_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4329-bt";
+		device-wakeup-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <30 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "host-wakeup";
+		max-speed = <921600>;
+		pinctrl-0 = <&bluetooth_pins>;
+		pinctrl-names = "default";
+		shutdown-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>; 	/* BT-REG-ON */
+		vbat-supply = <&reg_vbat_3v3>;
+		vddio-supply = <&reg_vbat_1v8>;
+	};
+};
-- 
2.53.0

