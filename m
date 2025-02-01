Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC51D049D
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738430963; cv=none; b=SPFBT0L43ikXGctiHzfCNOGBdPGlu+4c2WUcA2l/+1v0Sj2mRZuMkLOHCT2SuIgovlkUa41DRXZM31dcvl7ETM3VKLYdEoak2yb7lQJgfkVfeD/CI68dCmCCBJ0lJSg0AuI8BWP8G3+guleSp7Ib5tcNIj/Vi6W5Pi0oWlzWfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738430963; c=relaxed/simple;
	bh=bnFY74SBqBhj50zQ7HIO+wjy7JugjwXGjrF/pgpBgeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPFMCGMMVDTHMoPGvo4y4ehvBpnbKO4gd9qfYrRzoRVRMTRQb41BNjsxTpMbkSh+FE0LywXV6goA/pCdI1wbKJ3EYzNUjH4Ev8wC5Ce1PExKc8UGxG2qV7Y5i/6vVqtGP2lMaLT8AGGxjzVXQVvhhW7SN4n4KKvjvN++QKGNhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L8BfN8gv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8BfN8gv"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-540218726d5so2862720e87.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738430960; x=1739035760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl2JKZ1IRhnp1wS++WB7EWKXLLWje8GjFlU5tMr+N/Y=;
        b=L8BfN8gvRIXlMwSq3H3Hq7bOvyPtT1CEaXiq7Pt5UrEeerDfxnaAoIWsXbSK0JRnEC
         47N6MMKNK8biL2TYlA3ZavhW2CAzkRSlqg1UKjbuMpEceyvBLDeGJSaKqkzUeenrgqpP
         0AK1EqPRGgGKD2zQRtJ6VK9PKTYabNmw8lMUdMSHk8UqY1Zcc+bFUIePKk6bjO5HFJbz
         CPuuTr7lKatxPqG81j3Zc9KkkYlHNqjMNKci3LWNhdA3TKVtDjoIavF/8qpofKeKq82h
         pS+iBaNXq5CqfUxgsNmH9PvGZ7xqszg9FVhMdR++2WPGE8WQBxVCw8/jJBAvP4Ojolt5
         aMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738430960; x=1739035760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl2JKZ1IRhnp1wS++WB7EWKXLLWje8GjFlU5tMr+N/Y=;
        b=rOYCdatOWVYKTEYjfj/KiruVpf0jRClg5VZnag3ujzaLdTe1M/ADuHt4LWhg8Rs7lK
         y0uwe7z/aAaB+Z3KVzoqmbSLzfliskaJPJcKD5wkX4QRelU35PbdHusZ8VlOEYwVTyGs
         tedVprk3GkGnmQriIV6IknFGkReUmeR948PYXmOaBx3Xlh7U9QdoGAt/8dwircX+KImy
         6j5W3SCNmGQvO8WQWcJyMcAsL3OWmQ0tX36h0mu5vmtfY3iZ1sDqcD6HfQjblJoZzw4T
         LH6fSmP9SLdABKK1iCXUYj4U6jCyhqDxD5Y6PmH0O0wLhy3LywbNTPFwagrhFzTbGtDW
         o/Fg==
X-Gm-Message-State: AOJu0YwPR9LSBzPxFg7Dlv3MPIZtYniTpcT+49ZUZnuDpDQpUyHH3PNd
	Vi5YA4S+gKhy/avisqtvQic8QR0IaYO2JlSymvt8ZJrCI9RnhnDgVPCjNy4Qfx8=
X-Gm-Gg: ASbGnct8a55rdn2YMUMjA5ekR7whfQfeXtuPPDi/mFgubczGuiIcjWJczBIIGms3FnD
	+UHQcLyLTeaTkSJ+NHaRzFn9EWBxFjqrCCFybVwFeXCLBt15bcJMBtSpQxY/aRbnssxSiFrHv3l
	c6A6Q2U1GzbaUgS1dHb4tUt8eyyHF4EVg+ER56w9/jiJ1FrBB/lMuWclyg95tsuW9NibejiHV8i
	GiroQOwHFEL/74ltYomfKPoPENvFx8YrlZv8pxFct5RJozJTDb5J1+nDDmjFGr1bklwBAWll3PV
	5ForRmJcMyVbn3Iilzw+tvk=
X-Google-Smtp-Source: AGHT+IHMuKtjT5ZbuqY6KVm0e4CJvXi02Mis2Ir5adR5x1LTVk8zoitQukV4i3Qns0xfnUx56Acygg==
X-Received: by 2002:a2e:bc24:0:b0:302:1861:6de7 with SMTP id 38308e7fff4ca-307968e0bc1mr48166981fa.24.1738430959669;
        Sat, 01 Feb 2025 09:29:19 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3099ec4sm8852161fa.48.2025.02.01.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 09:29:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Feb 2025 19:29:10 +0200
Subject: [PATCH v2 4/6] arm64: dts: qcom: qcm2290: fix (some) of QUP
 interconnects
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250201-rb1-bt-v2-4-fd44011749bb@linaro.org>
References: <20250201-rb1-bt-v2-0-fd44011749bb@linaro.org>
In-Reply-To: <20250201-rb1-bt-v2-0-fd44011749bb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4082;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bnFY74SBqBhj50zQ7HIO+wjy7JugjwXGjrF/pgpBgeg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnnlnlE8rC8lkPbmRRukx6muSKaSPXb735xm6PZ
 vw0rHkAGCCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ55Z5QAKCRCLPIo+Aiko
 1bYPB/46tLJQKeUtmL0j3FPsYuCbrPRdXbsTbX6gxtGZJkCLdx8vNvu8r52iwUrE0GqXtoeYNW7
 jR1I+CyfCkmNSGemwtXg5xZJ2P1eM/q5lXQ2O+fucXANn5oFg3tm7/4cFjuaiUDSk3S2FMHmiE0
 5VEtD/UCNMmdHS5JLhNaTJRVQR7l3/cn/zTDNhv25U6tNTktlFpywnPbeIMkhpEwWygEJpMMnD8
 UpJo0L1Do0Y+hrH1cWKy8Un0DXoWFARg8kJP7rJHKfFjGxWsEzAqJlH4qIArA2x9k8fjEacalUT
 gIhu6zsNj7/9e21dkrvFtXIJu7NiO4OFH6PK/oB/6WzBCyMO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While adding interconnect support for the QCM2290 platform some of them
got the c&p error, rogue MASTER_APPSS_PROC for the config_noc
interconnect. Turn that into SLAVE_QUP_0 as expected.

Fixes: 5b970ff0193d ("arm64: dts: qcom: qcm2290: Hook up interconnects")
Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index f0746123e594d5ce5cc314c956eaca11556a9211..6e3e57dd02612f3568f07f1e198028413f463c69 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1073,7 +1073,7 @@ spi0: spi@4a80000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1092,7 +1092,7 @@ uart0: serial@4a80000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				status = "disabled";
@@ -1137,7 +1137,7 @@ spi1: spi@4a84000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1184,7 +1184,7 @@ spi2: spi@4a88000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1231,7 +1231,7 @@ spi3: spi@4a8c000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1278,7 +1278,7 @@ spi4: spi@4a90000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;
@@ -1297,7 +1297,7 @@ uart4: serial@4a90000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				status = "disabled";
@@ -1342,7 +1342,7 @@ spi5: spi@4a94000 {
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
 						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
-						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
 				interconnect-names = "qup-core",
 						     "qup-config";
 				#address-cells = <1>;

-- 
2.39.5

