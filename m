Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D21DB13F
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Feb 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738498581; cv=none; b=oMJO/b0QcqyYV7UO5mXjB5dDwEssc/JjqtjSIUpsIRKDkEe6aS8Y5rArNkIKCwmBoha6yzkLoYq6ljHgqVk2sEVNN08U2C0V/wnX/Nx2vJ6vN43N/PwDC+0GNIgG2NY93FmDhGBRPT8nvyRv67PEXcH4stADXBCXz+/HT1+uSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738498581; c=relaxed/simple;
	bh=JNFb6Y/XdVHYoGkQV0QeQUNrQN1lFqLu5lpLIO5kuFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQbC7mNwNoBFL1Faqh/xP6OxKy1S2jTm94Rt5XtaXKfZu7JWA3XSGKIfViz3RDVCz5oGgAGNCtJBxGKITqfNNsmPsn2d3fn0iFylS6oUzSGWFjM6kzMW6jRAgeDoV53vk56ts4CnQ3NBIDv7qMYwTYF0OV4LKulGXzAJDJ05XvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHl597bl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHl597bl"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30225b2586cso42600941fa.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Feb 2025 04:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738498577; x=1739103377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ov3UCovqBDyElf7wgQMMIsdctTosh7cq25mLIhj+V3w=;
        b=oHl597bldXrjDkLKrDwsqZBIFvlxUBjIMVBRgxwO+fb6o7eDABcNdC3HY+UQlVP90t
         CmDI2qVBPYQZAeijNunYGEZEPULJJT+8E/hJI2LEqARFHHB4OWiSjoSrexVB6xGlx1o8
         +LLA9F3bIi9Y9SxwaWuvE7qLNCbeFQGIKA1mWdVvIKxhSKW/va0rHhPHZjaSeROnjw5M
         sdKPsBUwBJrx3iKFX08QpTddetsf3UlStTu2av92uSaDg6EkQZWEcZ3Bh0iRXWk7v5Px
         XQ1XD5IUHl+HEm9weG0uvncaU0nhXXPEn/EdkQNkd5lwXYs0PlLbdIuxHP/w0P739btr
         2org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738498577; x=1739103377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov3UCovqBDyElf7wgQMMIsdctTosh7cq25mLIhj+V3w=;
        b=Ay/wCx+GU/j/s1lAAiV3XnBsqEHvPL7CO0VkENsGw+VZGfpVeP3ouHvRyhIGu6tcQ4
         3TQlSqThhfEPFWApJGjnQ40FITg85084A2K5rTSnKvgN++TYTQrKjNDBLJh6BzREWqbH
         TFPD83alAUradOYjT+PbdDmcYm397ulq0VEFLnT7o+mb8+vy4CEFnI6TQGn54Yv2/p0q
         9f0rEUAU1FNJvVp3Sfjcudkun8dcTwF3JEu35EUdS70V/BcqfGVsQPhb6iF0yaAhkYEJ
         yJ+gh47tsm9quFGaMBOV3QeeEpZzKaciRDR4vpelHu1JMbrAgtZBxCaunX6nA3PQT8iM
         EhYg==
X-Gm-Message-State: AOJu0YwqoPJTcbund8y0AcMcvYunU/y+pVb5DiaE3uiu+KZZrrqTkRwC
	CvRoyjdSQnxoJ7wi+JRGMhfmHBAsu8lAt7eqFRMbQIXNwmvkK08FZtacHsQ0g0evvBW6PaQLXbr
	u+s63pzjj
X-Gm-Gg: ASbGncsXfuhbkDAxaogUi1RUzXZqgSH3PAK2tuWyG5PLSodjwsjQgOdL+t0070Pvwl5
	jOCRXTNuPzXmO1Hp+F6NC4Er+be7p6Q716zDT91nMu4AYwJVWDohrCcqOJj60yaOmWK6qNYvaiU
	wVENLTS4k4VkgwYChPbdhAFi5GJKLeE3I/ldODp0SMdJmrnzMkyBLHP6r4D6+rlvMyd3fSmUwvY
	zTmo1dpOTdwpqoNBv5JIynCLcB3jLOzRIuXY0R/kTjhkq/5iKXDI4g0PZ11xyJVg97vVjbdR65M
	t0ipZpwCdJ07jCGqHye5F3Q=
X-Google-Smtp-Source: AGHT+IHU+cY7Sd2FJwu/fK+FejNxlwvrPxT3OOghYyb0HQvwwOLYe3yknR5BZu/qRImPl6zTGSjVfg==
X-Received: by 2002:a05:6512:3d2a:b0:540:16b3:3699 with SMTP id 2adb3069b0e04-543f0ef2da1mr2889703e87.9.1738498576871;
        Sun, 02 Feb 2025 04:16:16 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb0a4esm950663e87.114.2025.02.02.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:16:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 02 Feb 2025 14:16:02 +0200
Subject: [PATCH v3 6/6] arm64: dts: qcom: qrb2210-rb1: add Bluetooth
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-rb1-bt-v3-6-6797a4467ced@linaro.org>
References: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org>
In-Reply-To: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3096;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JNFb6Y/XdVHYoGkQV0QeQUNrQN1lFqLu5lpLIO5kuFE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnn2IBlxn0ajqkpQJUmshzRsvUxqdik1OzGVj7t
 fB8L11OJ6uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ59iAQAKCRCLPIo+Aiko
 1UjUB/0XgJhzc/BM7b4PFzB0HBDUYi2cf0F8MCk7zDlSJF2i5R7Y9caEeQDxOtJLsLwumoRLsHk
 agl+SbPPMD1Ko63Ke//UhzKdl3q+0CSY841s1KHQaXSMTBnA3rb15CxX9c76QhEStY1pKeMpIIp
 LQOjfnEMjl+ZptAlrSK7lrcLtJeISceoQK0NVWvkEv3S1p9M5F200noLOF0mjxht2cp+JNvJioo
 sCCO0nObmvH1ncL0QIVmR5PLmHkq9AdgSUbgY3J69PMNsu9Gb/ViXkZwziVsLYVNfB51JDs6B+g
 MO81NMCey11gEa1Q5SB+2me34bViqTFIUjHaNJhFg/W65eFC
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add support for the onboard WCN3950 BT/WiFi chip. Corresponding firmware
has been merged to linux-firmware and should be available in the next
release.

Bluetooth: hci0: setting up wcn399x
Bluetooth: hci0: QCA Product ID   :0x0000000f
Bluetooth: hci0: QCA SOC Version  :0x40070120
Bluetooth: hci0: QCA ROM Version  :0x00000102
Bluetooth: hci0: QCA Patch Version:0x00000001
Bluetooth: hci0: QCA controller version 0x01200102
Bluetooth: hci0: QCA Downloading qca/cmbtfw12.tlv
Bluetooth: hci0: QCA Downloading qca/cmnv12.bin
Bluetooth: hci0: QCA setup on UART is completed

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 7a789b41c2f1887f0c41ae24da2e2fe8915ab13c..b9248505fadd3b986e188976435b786f43975dc3 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		serial0 = &uart4;
+		serial1 = &uart3;
 		sdhc1 = &sdhc_1;
 		sdhc2 = &sdhc_2;
 	};
@@ -549,6 +550,66 @@ can@0 {
 };
 
 &tlmm {
+	uart3_default: uart3-default-state {
+		cts-pins {
+			pins = "gpio8";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio9";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		tx-pins {
+			pins = "gpio10";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio11";
+			function = "qup3";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	uart3_sleep: uart3-sleep-state {
+		cts-pins {
+			pins = "gpio8";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio9";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		tx-pins {
+			pins = "gpio10";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		rx-pins {
+			pins = "gpio11";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
 	lt9611_rst_pin: lt9611-rst-state {
 		pins = "gpio41";
 		function = "gpio";
@@ -584,6 +645,27 @@ key_volp_n: key-volp-n-state {
 	};
 };
 
+&uart3 {
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
+	pinctrl-0 = <&uart3_default>;
+	pinctrl-1 = <&uart3_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3950-bt";
+
+		vddio-supply = <&pm4125_l15>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		max-speed = <3200000>;
+	};
+};
+
 /* UART connected to the Micro-USB port via a FTDI chip */
 &uart4 {
 	compatible = "qcom,geni-debug-uart";

-- 
2.39.5

