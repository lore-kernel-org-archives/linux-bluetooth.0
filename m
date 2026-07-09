Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D9401A29;
	Thu,  9 Jul 2026 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588717; cv=none; b=Pb+M+tNrxZ6BvHXQIwyEr3SV8R0vvrh5IZuTz9zg/hZT6Frgx/Dt+KoqZOEc+Q/jjF6VnCo3gc1jncYUYiGwqGaamt2NPmOo8926iRSgOMoX/Vodm5pUENHEybtgoAtg+iHTeLo/kGyQGNKK8KasnNyKH2MZiK03WLbNaYKyf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588717; c=relaxed/simple;
	bh=JqCXiscIog4kZohcOHEPHuzfiLGUqD9PxagctliMr7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLC7GXBg/LFuTMwYon9qr/Xw9UiIcBUCcJEIoTYABbhn9mvezepEvZj1K95bSRsGwYbQyFnN8J4dMSPGpYQXmEGo3K+sooRQ90bvR+lwEy74gS/Ku+YVwxdVSfQ0bEEJX3QR8EK6zdOLsnk++cODhPMlL8wq1LNo7/wrRKQUPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfKXjrK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfKXjrK6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CC34C2BD01;
	Thu,  9 Jul 2026 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783588716;
	bh=JqCXiscIog4kZohcOHEPHuzfiLGUqD9PxagctliMr7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HfKXjrK6446RDNbM7MxPkHJR6nRyO6E4W4NP9FxsDoWnneZ9JxtoElYQFC5tqnY7V
	 J4erZFRxKb4IyqeuNrcEtHU1xwu8AU7fCGxnLmnGqgq7K00qTiJd5tKRcxNs4czQtA
	 WMuMJdFbTHLvKQld5pIA9dIX4qsH6EHDtHC4pcezkg0+L6525UQOZ8ioMxtyhLa+qH
	 U+OR5nR8OWrpfu1ctqa4+ivN21YJIOWAZAhtKlOI9HWLY3U/15z9Tq/R9GaleRUtR5
	 8Z54rhXxKjv/HZd0B/z53j9nIYUmG1ZEhvcOT8pCTHl8y1DHxDh7qeRCulQcS0xAvn
	 g+Uh7p6lQgT0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A67C44506;
	Thu,  9 Jul 2026 09:18:36 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 09 Jul 2026 13:18:31 +0400
Subject: [PATCH v5 5/6] arm64: dts: qcom: ipq5018: add node required for
 Bluetooth support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ipq5018-bluetooth-v5-5-e476c41f03b8@outlook.com>
References: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
In-Reply-To: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783588713; l=1135;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=ymJvkEJnDShOUP8UxN5TyZg3+NjK0WZUomZnujMqESc=;
 b=RYY8skanotxliOrV7roe0ikM4OLojv53aWcRD6phI/hhClq9Vonk38JCmUCOBpbH0Uwfhe3LT
 liF6nLYmr4xDMXkyIZ5aIbG3FJfkIJLm+qzVdNR8dXc4y4CmyeQtz1X
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add node to enable Bluetooth support on the IPQ5018 platform.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 6f8004a22a1f..8c252fa3ff5b 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -453,6 +453,22 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		bluetooth: bluetooth@7000000 {
+			compatible = "qcom,ipq5018-bt";
+			reg = <0x07000000 0x58000>;
+
+			firmware-name = "qca/bt_fw_patch.mbn";
+
+			clocks = <&gcc GCC_BTSS_LPO_CLK>;
+			clock-names = "lpo";
+			resets = <&gcc GCC_BTSS_BCR>;
+
+			qcom,ipc = <&apcs_glb 8 23>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
+
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq5018-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x7804000 0x1000>;

-- 
2.53.0


