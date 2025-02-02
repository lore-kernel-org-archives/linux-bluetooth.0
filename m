Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6B1DB121
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Feb 2025 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738498579; cv=none; b=BrKW/YJA9yl6cmFbna8q4IFSjms1HX1gppcgPcAE9EDRK2c8YLH5GK37uft7js+zR9q/TwJAJd/vLXIyzydl89mMy0QOmemtQ4q8EGAl3kWSsMT3lVN9LM7K7vxO8y2bCnYixhbVldHyn98xrhBETGwiYob1Vp8yHbh2QYN+Hp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738498579; c=relaxed/simple;
	bh=qi1V0XhBkBrxty8uIfZTcLxNTnebQC4tHcL8urIKw8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSQbt2IfFBfbJ18mJbZo515BeAhai3/IDLL2ZV+Wpdq2n20wTkRy0hNLrCvlsagRbwCp0SZa43mrcHcnGKuycXuEjudlqqsFVt7ieXr5fEeVAb4ZLetILX3X8PHDzvf6TY3jvhSOlEsAxKvXVBG34W25ay/RB+Trkib5cbNggZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TEdI+7XT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEdI+7XT"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e3c47434eso3657951e87.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Feb 2025 04:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738498575; x=1739103375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GCW5ssE11TCosEFHQR+hT7DqL2XinuXrF8Jh/KlSvs=;
        b=TEdI+7XTqTEubyvnS5zVcYGozhu0Va61rbeAYZVVEC97eyhFgM8o2F9FEo7aK2ADMT
         IYP89MxOJcSFyXssWNfXWAPv7T8m1/N846X01EH4OGrY1Rfcayy7uibbEcgqEeGEtATK
         yRTRyYWE8DJC3BicZ41XtlGscwHn3qMEBP4WCZJZHOml71DJy2oQ9Zu7GwILTpXE3t1S
         NY/HFNV6MTRwKlMOK357S56nnKx9cQdjfgVozCuet9PRVqil1jKwDdoPK3dPwqj4P67y
         aiSR8HGe7WdKMjT72+irLwGmIORRdseqMAwJSvOTYvUrdvoqElZ/tLRl9vgwCC2MzpYe
         21FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738498575; x=1739103375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GCW5ssE11TCosEFHQR+hT7DqL2XinuXrF8Jh/KlSvs=;
        b=L7v1X1fXz2hQVhLEIt525akOXA3QzWhIVXnDRDcx6WFiAvdHUtsX0eE357txBXXCtS
         89OR4sBexT2RyG4NnniqWQGvmn3OLgebUgkuU8WzyiTducfrHvtE/lJjW6Kfy+abCfEs
         R4bCc4stPn90Om14PitnqRKZM1N8TvD59B1Rrrf5qio2THfybr7UR8bOcMEk5ziJq7rl
         MvpkXCL2730W2cabAuCTGQFyg+7kHmiRCVGpjgg5d3HeMzT08bZcGf2SrY+DNd8TVEVX
         q7BkV5gJmNRUZw4amBKgLKkjkIIHfJD02r/g1exm+ZqNOLb6YWJOglSKEgDqyNqJdCpx
         Z4bw==
X-Gm-Message-State: AOJu0YyBubaUA2usyZjUM/o3/yJ1y3r9sp5hxps+JoZIi0tQyAEPJQ/x
	6EQBzC4fzAjST8OP8RF8AZ7A0i8kUjpgWDDKPE1uYMQ62cJ5oer6iySuJpbDU0M=
X-Gm-Gg: ASbGncsG4vqYVk5OeCJZ0mt/kgLXQvAqACtEiFHvrvG0UoCWeY6vrVHFOMWCCPTJCJ8
	mFSXxZHbR6ydbTVzpmu06+H3cLLSMqE4HMjLDH5Zgo1zNzMKBEOhgfZbW0M6OBR24grCWF8LPel
	zGCRZnCQZYixgcEQBHCz4zrP6gmJsgSwwclSkYohybU2wFGWbl0VvvVyikb+tX6DWthfG6yoQOb
	S2yAN6EFcPQMNY9U99ynSLRHR0H8G5zIgo+ix+tSY6m8ImSKtjUg18apBs8kG8OvRDCrOpXM4C7
	6yD2D8UD//HpCJ0i8cSiFeA=
X-Google-Smtp-Source: AGHT+IEStuw9o+gIF0rwYX/wMSf2YaSVPtLa6hRhzgOqIJakeawWoXldDD53yCCCQJw1KAq/Lvfg5w==
X-Received: by 2002:ac2:5481:0:b0:540:22bd:e25c with SMTP id 2adb3069b0e04-543e4c3e341mr5506950e87.50.1738498575292;
        Sun, 02 Feb 2025 04:16:15 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb0a4esm950663e87.114.2025.02.02.04.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:16:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 02 Feb 2025 14:16:01 +0200
Subject: [PATCH v3 5/6] arm64: dts: qcom: qcm2290: add UART3 device
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-rb1-bt-v3-5-6797a4467ced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qi1V0XhBkBrxty8uIfZTcLxNTnebQC4tHcL8urIKw8w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnn2IBpNre0AfGfgYIuxjDMYtVtRRhCxGUwpA4C
 ULnjgth8a2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ59iAQAKCRCLPIo+Aiko
 1XDrB/4lgRe6AgOcOU5otx1lEGNzlnAQIJC+2WkA/BSJEcC9D0A0urNkcZ7wB3cm2b3onQ0i/nX
 4iyXBRrCdB+Nj43n4Xhp0BGH9o9I2X4uKqI8qaKzuymWRE1yAswRN3YclV4PYDiyQIK7gkt1SOc
 xDpn+nxciNzU3zgd982gUQ7VKUZV9g68Da/8bKFc6w7Q6iwrR4WbdCa4jzCoFJQC+ZNJRL+m1fS
 wUJa6dci0Z8mz2GVZpV5Q8mYDgzz1f6UGMK6i96gB5CfabwtAbSoXiE2UPZezZSVHn0hzaJKLtt
 IK++NOU2Q33+A6j29Ras3sdtYG0jDMeiSWxNnuBo/sKbv6ME
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On QCM2290-based devices the SE3 is used for the Bluetooth chips. Add
corresponding device node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 6e3e57dd02612f3568f07f1e198028413f463c69..30e9bb6c1679aab13c3f3f7f6455f2483b2ba0c5 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1239,6 +1239,21 @@ &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 				status = "disabled";
 			};
 
+			uart3: serial@4a8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a8c000 0x0 0x4000>;
+				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+				status = "disabled";
+			};
+
 			i2c4: i2c@4a90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x0 0x04a90000 0x0 0x4000>;

-- 
2.39.5

