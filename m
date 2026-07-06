Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8A3B2FD6;
	Mon,  6 Jul 2026 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358846; cv=none; b=MLkS1CrhSMZIBgCBPrSx6iMV2f4ljovzSw1DUg3Bn48VSh7FzFd7BYN0NpUkbrVoBuQ6Qaj2+nmL7v8Ln/f/0qeIlayv76syJcevS5OleACZZym+mZ7Ucc3sUZUnkGHQR2nXb07CJ+fJAjsvu8lZHL2jCXA0OU+76ptRDn0QfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358846; c=relaxed/simple;
	bh=RQmgSBFH2cx0khuHTu1iDslzO288ZJKeX8oEXA1WCJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1pIlVzWCXvaoJ8RyWJVfD9aUMeByInmhUKrw6IwWZ9gG75O5GJBLJDPbPxjjXCu6BrynstWdA09aPmc/HkKUYTbIbnWlXLkGHlG3Vze5U1QT8H8i4474WUHbY3RC7iS83ZMymy+nhr4e2FlPpDoYW8VAhkqvk54meh8S4kNDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxPbQ2O7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxPbQ2O7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C9CFC32781;
	Mon,  6 Jul 2026 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783358846;
	bh=RQmgSBFH2cx0khuHTu1iDslzO288ZJKeX8oEXA1WCJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OxPbQ2O7jRPVAmJbX8CpJiwUEhSWhJY3TXiFdmRbtSZCdp0rn1xp9BIs1YIt+xVLA
	 0SoaPAx9gCI2LXvdfpKyFPS7xihiRUUBLpy2jMdZQxbL5YKEyDdizS5Lha1b6fEvbx
	 LtRdyNhIXJhuOL1Jhp2kebDVA8CUry6snqM38Yxorh94cFoFE1IlokLgkBOu7a4pEc
	 JLrZiaeL6wy/PNmHGrj99aZPCt4bE4YVqdzxaHN84ShdBr+ZcOAmilNVzJcEw4co67
	 3jW+cxPseXbbF1hUTfPthtBopnGROA98M937bSdGnjdFEqzJcnmex3+UFoXTfGRZMQ
	 9bHaNjyy+3CUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA0C43602;
	Mon,  6 Jul 2026 17:27:25 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 06 Jul 2026 21:26:21 +0400
Subject: [PATCH v4 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ipq5018-bluetooth-v4-5-350262a30959@outlook.com>
References: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com>
In-Reply-To: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783358843; l=1331;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=2Ya/NV2YIxD6DUZ6yWlk6db33MZmQHxQGiRcdIWTPzo=;
 b=Xkkix3izQsqjZ9k1RW6cTzpFyRRVFVBg4ebx+pzaiiwPeVUzdPyj4FLIkm6jcoGdIlHO7O3Qf
 DZLYfBa6J0SC5Y05kno+CSeZuRfP5yZ97KQjuKTZZH0YJZHleiMPVYL
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add nodes for the reserved memory carveout and Bluetooth.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 6f8004a22a1f..c97c20d4428c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -17,6 +17,23 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	bluetooth: bluetooth {
+		compatible = "qcom,ipq5018-bt";
+
+		firmware-name = "qca/bt_fw_patch.mbn";
+
+		clocks = <&gcc GCC_BTSS_LPO_CLK>;
+		clock-names = "lpo";
+		resets = <&gcc GCC_BTSS_BCR>;
+
+		qcom,ipc = <&apcs_glb 8 23>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
+
+		memory-region = <&btss_region>;
+
+		status = "disabled";
+	};
+
 	clocks {
 		gephy_rx_clk: gephy-rx-clk {
 			compatible = "fixed-clock";
@@ -136,6 +153,11 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
+		btss_region: bluetooth@7000000 {
+			reg = <0x0 0x07000000 0x0 0x58000>;
+			no-map;
+		};
+
 		bootloader@4a800000 {
 			reg = <0x0 0x4a800000 0x0 0x200000>;
 			no-map;

-- 
2.53.0


