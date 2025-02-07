Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476C1C68A6
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960896; cv=none; b=umpd9J3ixXgkz2n0DZrpONsBdZ3xGGlJTtHAKSkeFfR/G6ng7VcN+gjscM82Hk+ltIY4anKHH3DCHiXDqgcm+1632tEAgQrqwnlid3u3rX2RluTDZe0qAaq8oRq+C7aBezrkre6/LkC9dEqtqxg8o3Ga83QDp3+dzkXEemR7vBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960896; c=relaxed/simple;
	bh=qi1V0XhBkBrxty8uIfZTcLxNTnebQC4tHcL8urIKw8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJCca6sOADSpyy3DAp1LubILSXhLFdt+xuil20IWDeS3YwUVN+tPd02pDUim/5oTSrWXJJvGmqQxu9ympM+3tEGZb4lBXO2UNSYBvmEVS7ZL5ZIv8kV5uOstPvgDU/SYeX1jS4iI2QRjvQz4KYRp4e8vpkGYqMeJVscCbaeQClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRz7ZBIf; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRz7ZBIf"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3061513d353so25989751fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2025 12:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738960892; x=1739565692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GCW5ssE11TCosEFHQR+hT7DqL2XinuXrF8Jh/KlSvs=;
        b=uRz7ZBIfl13I77jO5n3qkcDJbEuxw/QvHahmWrRrre2wNUhVLsJztlA9LYKQL7P/Yh
         2WV6ILffS13z/RyiAa41Mdnk3jDgmqgKqZLVPAecLWfJdHvYiOiH60hOshTz03v6NkVY
         JuT/VlIelZOrBKX/R02AM8O6AGikqFzKw6A+rUtNH+IsXGVn9y6aJbXlZhkS3wxEJyCJ
         o8WL7kEAHRvx/qrC0n+Lcqrqj6nUZashqpgPu3YpIgeH+Wu/t95YNUvB++pZsBGk62Vw
         8E82fkJ9R5e5B77JiiVbd+R88dVezGAgmR8Q6EzStzHHrmyRlab+iYd9quM1h9jyhCPS
         xbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738960892; x=1739565692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GCW5ssE11TCosEFHQR+hT7DqL2XinuXrF8Jh/KlSvs=;
        b=Zll/OGRTsJ45nUdyftitrolwxU77pRnraNqX5B+hpr+CV2KjXfwn7vuZW1rkCgA7di
         M6EdqutBhcMHinkIoFc+BYrGGuj4gc9+kbVfle7ij27TokmKlp8GIlxiMhlhnbZvmKH+
         bOx/et43Lh38GiW9vnqpqq9J41QaJ8FDHBLSnvvtOw5maHn0d2xd44tx6oRLj07wf17A
         SSsR5ihdYAsTUXCns+sYiaX6qcQHlRUASYnAz3kFDU7m6l6NzsqJdkYRggl+0MSWnARb
         6vmp1PYdBVtvYvATjB5MvEWfdKn8iVyqtgLSrNOFftKZc4ax956hetsJZhOCRj+oQTPj
         rb1w==
X-Gm-Message-State: AOJu0YwqTrYrE23Q6Uk5IKx7xA5yDdxbDpc61ZL1d7D7/f2E0JyXPHvy
	6F4upNTrcXHCjya2mmDMdi2mSqf2m47TXnQXzOiyaEXyzZ/mps9KvtwUdpEQbEJ4KseaQX/3rj2
	pdzs=
X-Gm-Gg: ASbGnctrLobeJ8FUi350gGj2D7uowtSZ4Dn/00YL9i3ylLsNNBsTd8QvzlhhnuJkRkU
	sc4Q0RHsIhoivXC7KWkqAufClT3da4eKbwSUPZb+OXVuDcKuzELEeaV9S0nf8NB0j96F1e7PfpV
	COKVA0jCetrC71CDo/Xs+l1eH6I9PvOhV5CVRy+3pdSWM5PcqvgKnp7f1dHIVMAd4m+vcTM2wKB
	XNyTcqgYNUYgak7M4pXVgTLXQoBO6qwZc5sF645fYeR5xVR3VftekP1JfCnM/ZE3cxSSsRa4UlH
	4n3dpERrXqQ/7q/PFTeF5/Q=
X-Google-Smtp-Source: AGHT+IEBrJZCd0Xop4TqN7hbfRaUqlV9yD/Buv5vFYZSETU04EFffkRNpJDvdRhPM0QpF0NR/3WMpQ==
X-Received: by 2002:a2e:b8c3:0:b0:302:17e7:e17e with SMTP id 38308e7fff4ca-307e56249b5mr16057921fa.0.1738960892192;
        Fri, 07 Feb 2025 12:41:32 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de178628sm5343811fa.10.2025.02.07.12.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:41:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Feb 2025 22:41:19 +0200
Subject: [PATCH v4 5/6] arm64: dts: qcom: qcm2290: add UART3 device
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-rb1-bt-v4-5-d810fc8c94a9@linaro.org>
References: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>
In-Reply-To: <20250207-rb1-bt-v4-0-d810fc8c94a9@linaro.org>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnpm/ujW9HyGLt8g9r8KYeBGvBPzJCLQA6GIBM0
 F5rhO2oy9yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ6Zv7gAKCRCLPIo+Aiko
 1aInCACdLbRGZMZ1qluRxcZdmHdIo85b7zTs9sSmlNzHctqHpE1ZjdGHk8cepvMmTCoMuWZpbeu
 rnMO9+8Q0MECLgV7ImZPbDYxudbJySRSDawCTUP1kPPwVVX387tsvK0nkV1M3HOcF9jfWQOEFWL
 Q7gor3l8DABVRtFj2QJoGMSeTVLFubca0mXphiWnN4ZeTFyDBnIq4atPOpRLvKObAKc83zg+4rR
 /Q1kY+mtinwxcxcZFR77ZnjSSn+lkQPy34gayvbKpup6VQwbg8bcCTmmrBVsqM/hiKa1mVTKddu
 6/ree3ZIYjQ4GBQI14QB4ZTJmY7i7ikGs8PjPnijLOl/Nc/j
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

