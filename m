Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E827FB2E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661306; cv=none; b=F8vdmpQeHc8PTaCPGZPhE6PZ41cJ7WEaTNwApIVNMcXES0vL3aD2Nywz7ZJ6QOZ69Qjdjv76B9kw3NLa4c9T6jDfJfBeuzYvmmJU6+RPAIrKWbppZYz+F7yhBCyp2kTvFPVYQ8y2l56yHXMNJU9HSCydrLqBfh1bloFe9jrqZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661306; c=relaxed/simple;
	bh=R5YT6nb9PgApzpeufYf7gthWk070NxoF+HtPuCCK/hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogb4P7LkFU+/Msr8YeTRCctgi4xCAJLN4z7Jx98qleR54iTWN6ZNGQSgaJDMpJMJcZV1ai/uG8pDoY7UWOpzMqp3vqpAZpDpvdGAWmlh/kC2oDUtb2lRQJBeBakhaeRytsmT50XVW106Nj3pWUAvrk+3DHs9UHJT/I+zLVwJ3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fCx6c0/g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RPXpW/un; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCx6c0/g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RPXpW/un"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nQP82943744
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 01:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5tsd5DKtNLlMZcvaCZDHlRAYCf+3uNDXyfWJlLEmAqA=; b=fCx6c0/g2WBsHU9D
	9p6IP81MxY9kSvJgZnSqN9cy5nJzlR8KohzvSq5yFpUHfOPsPdocZEN+Oq7UotJZ
	d67UGBQA1NUlfJYPn1lm3WPExfnIPhVYUYnQq/zpvuHz8R4Cafpq2mox16x2Xyft
	ClIvP+jK9WjHWlNbZgOKNlUFmRXk88HD6DSt3uWnGB4z8JzpMXiXss/cqyIt/jx8
	8R6WDHPGrWur5thjXdZ+K8orUUdpynkwQ1Ixsh846aeLpGuJ+Mb3MC+H2SOFw5L2
	r1tIQKwOpz8vB4OWfDNJbw/kcUXoqXdk3rCfYflveOQMZXU4Kep5ACnjPyn+XmTX
	P4SIvA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv01exw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 01:01:42 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f57d3a1acso1300488241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661301; x=1768266101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tsd5DKtNLlMZcvaCZDHlRAYCf+3uNDXyfWJlLEmAqA=;
        b=RPXpW/unM7l+AzK4vNjqhwN/QglSlbHR/tMm8lwYBoxUfHGShbKL/SVC2rrXeewf+/
         OEi32rOmd7aN7+miIPwOLKYUmVrAiZtmk08GnVwe5AQbrwkRxwD4bZji/rk6SFzarZ5a
         Hvrc3PN9JOCgMckmhxjgNB58Yg8NM+brJL+IzQJ9UuXXN8s1kHk3RgwYHEvC31IAlmzl
         tTKizS97bkE6jOkNG/LLdbg/jLDy4H/qiuXREFwBg6mnMcWXrRLRC8H4wGTZ626tcSqb
         bvcP+rga17cmaL8bidOhnAb0wlWNwxZlMgjtuvdweot86ApTL63WxhPVZbKbBVCkfzY+
         6qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661301; x=1768266101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5tsd5DKtNLlMZcvaCZDHlRAYCf+3uNDXyfWJlLEmAqA=;
        b=gykdIg+EU+l4aYGT29T2M2/53pJJrdHVyxfnzzqYqH6x1WZ3IjOiJClTr/pYAvZENg
         HDKaC0wH573jEe0yP7oqGIEBwi59XfiDUGUKwUoIDjKg6C1kpkQGJeUZX1zHDF3cmZOw
         pusYpEVd/L+3DlWViA+NgII+UoYu/aNALgf7/Y7GoKHsD6v7WvC7HPy7Aj+BJ6Dm2peq
         gFT1j2Y7py7feTIDZjBevveMZ73h0rhbqWY0ozZv86uwJxErASwh27iiZc5afPRcOcv9
         ITzbHWWkRmRzEjGQ8Km594JFPh9mc64RN7FZgDIsPiW3rtCiMOt651uHITmCny13wMGU
         ExmA==
X-Forwarded-Encrypted: i=1; AJvYcCU9DgY0CCd51WKgucdahGVh6ADbiwU300xiG1BLR85D5WgMEujFFW/A2yZkEhvNzu+GjYROQllKKJrmwuaDgMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgCa351BrwKUbdPQdL+Wd0WlnGvlVGBzMEsFS2NUA4lBmSrf4
	Nv4qvsIZm1thJWUipcfTeRcukBgY8lOq8zglvo7YUw7wafRBHYX7uXudrFryPFYrnm9XuQhfCtD
	ZGhah6q08oJkqC2M7GG1UKntmYTV+1hk/Gtzf0TBffC8lch2pIp+u052/2B32FUHF8u3UjiM=
X-Gm-Gg: AY/fxX67GZY3OXsPdPEwP/FIFDqDAJtOBsgnDoqvtAncr89CxXJ1VO3t26wbb/RVnYV
	tQPefmO+cAwNisNtHtdgdBYMMnhtYwKUWjmMB+f6+Mi3nVNvLR1hJ4vaOwpB3xX3EO3tGiptpG3
	krH7CjY3lwNXCzS9iSbdLRq0vsV4qUUrs5wplVxMlwaCQjn0bVxJ+TizDAdN9iQnpZie+fIaIcz
	qVgVwqPmaSr2BK9ATdbEjgEHUgRFXRQiF1Y4I+Bf5r/uYj06l/vdo8ZQ7UmhbGl48bPJUD6Wb65
	5+dSHDlBqoKZTnOdiGh2dl7UWmmv9lhJPvk3XC4D/9C15oTLW22jtj9TpqOh2BWUnuJ5xDn+/B5
	uqDfVKKsmbV7vwICoubKbRHa38xQrhQbcNQJx8TTDNTN+qomKGNwKG2oUZKtURPC2VsqyvsUH5j
	gKETXgFZC61L5SG60iCQn5bSw=
X-Received: by 2002:a05:6102:448d:b0:5db:d2b7:9511 with SMTP id ada2fe7eead31-5ec74574d2dmr443421137.40.1767661299574;
        Mon, 05 Jan 2026 17:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIchMWx6h9LQgm2INjt7jZLpa0baSCgZJT92LF35vomyPAvbZ7Z2gmXZvJx10AwyD/MmXxzw==
X-Received: by 2002:a05:6102:448d:b0:5db:d2b7:9511 with SMTP id ada2fe7eead31-5ec74574d2dmr443361137.40.1767661297733;
        Mon, 05 Jan 2026 17:01:37 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:19 +0200
Subject: [PATCH v2 09/14] arm64: dts: qcom: sm8150: add uart13
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-9-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=R5YT6nb9PgApzpeufYf7gthWk070NxoF+HtPuCCK/hI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7ZeuJ4H5kQTiKN0SZPAWoEkpvXEwqkfstAM
 oFfkcFhRy+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1YNJB/91Nexwnv0JCxYQ3fcm0Z58dhtpTmhbVp0CaGAKg7i8jIX1Id9ZsqWTms+2sxzJTQIH4QS
 N4J1ZnxBkCFvfGrdqPu7j1ZDCg+CDX8nTrhqbE2z9s9XMR76wucz66SU2ATTHyWLWQYds/CXlBS
 +UaRxS2wXRfA6g7p6JPFctX4oSTLZlzIWsSBBsghkm+83cuPqUfDsJNR4QVwakCDavScMOrhzei
 fVb+vuo1cE7Rek/+SDQHIH54zHKd7Sak6FZDYkKgKz/Enl+bMGwZ2d/VUZIvv0CtviWxuCCNMSe
 JIdsWh/wdazrpirurs3xLBof1CtdRTNVlPkYUj9447wgGBQD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c5ef6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tD0gfWrjhV-l0aOYTiAA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: IMIA0q4Xrf2tjYHFVQFR2sq6SkyF_zX_
X-Proofpoint-ORIG-GUID: IMIA0q4Xrf2tjYHFVQFR2sq6SkyF_zX_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX6vzXn1K2wQ4X
 z3+yLeUgv76ieEFrCRTVdAY2yehNDdl+uWPxZJ+5Y6xjdkfbzueGCdSS6Xk6qUvzJ5mRpYXss2y
 8saDFshhH3LkCuR5PW4FG1VL5tt+aZKFoo66LQi7Go1d2BX6iukwRil6w2zqR3RZBIXQezP5jBj
 jDm2ceChPlO/izqhANyXHlIflwsnUXoe+y21yQg15B9JJTOtvprXYQTmFv+5uCe7XckkJ9iiLXH
 XYBUgcGYvViCgcYm6mhtY8mlIAR8tUOp012cx64paL2hhfUyrELnAOqsvnIIbqfsi1OVx6s6pYH
 //+xtcDMd6wUWJ/8T0/h5t55C2ScCQ7aG8BuIgLCFUh3PBX5aPE/UrQPYN5oFvjs4AKI3Ta9pBa
 Slj3JJw5e40NOON//SOABCDebbBY0r1Q+PEl0rQDRL7Xw7ZkLATrtok+3Jj9iYnFvqlelILNImI
 lxQogo0uirPR3ncCGPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

Add UART13, typically used for Bluetooth connection on SM8150.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d36a3d214db4..97ca5275d740 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1693,6 +1693,15 @@ spi13: spi@c8c000 {
 				status = "disabled";
 			};
 
+			uart13: serial@c8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@c90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c90000 0 0x4000>;

-- 
2.47.3

