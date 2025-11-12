Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1BE285C96
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931528; cv=none; b=D7u/okFX1BlEMTUxXonxiHNMsYmBYoTMy23ceMNDzpf8OyJQvQZUc9QOvrNTdLRgOCInwtWcWKqLOZLi4Cwef0cVFe/LEFFKVypngHoZeYE2STIm2f5Ip1+19L9DrZCPfA7esRJOyeNWc8tsAFdo+yAEnvvgXu1/IEOclSv/wRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931528; c=relaxed/simple;
	bh=t6/dnpKeijBWspn2y7sLCQ1hIJte3iDvGgv7cHKKY14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYcRTkecjaxT3flxIwLLHzwHWakyDiNqL9LEWApjA8Shq9vZWfVrKyE+lrvtIqxM4yT/aZAntmLABe5vUdjAxTRCs00dTzddc1+sQFUIJ4gCe90SdUmbM/Xiv3+6gFUJsOsYZIaUvIV4lWbe8m0QCIX+J79Qi26u0LibxhoIlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eH5LvamG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ejRvq+r+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eH5LvamG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ejRvq+r+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC0w4eG4008081
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 07:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9fxPxZxcQt6S8UXjieAvc43H1MpqDUf2xI5qng2G0vQ=; b=eH5LvamG8iATuNvP
	UmwPQL7u3r8sg3PdA+oZjS2ZLtLsqavOzSjF4phxI6hT2up+ydX+GUzWT8ienj0Y
	siQ2CCkPNEub0PqONjoEkQxrgKsCZrRdZYdISlmauDx4e39fZuF/CbgZF55JD/sF
	W2HJrXdZF+Kvj8oD3wvOjeQViKYVBIBWvpHRX9wo9fezbE/uNwksNz2zGREO4jdX
	anQNMaUlWpj+zk21K+iumnp1S2c29lyMa154XRHx77IcC7/bYLf1Mmu3aSDKV+ek
	6+howMQh4TXY06gn/sNQ0uyr0SJVCaxOxCjltGPWhZfDKl1HGVuFe2pM/ekrwrvN
	TdiwPw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acg5bgwrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 07:12:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34180bae854so209975a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 23:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762931522; x=1763536322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fxPxZxcQt6S8UXjieAvc43H1MpqDUf2xI5qng2G0vQ=;
        b=ejRvq+r+1q4/CrQANP7X3CwYlvEnOIykGI3YuaZiHTUwQJY3HojqSx5DV8vbX2vAER
         n4ZWxp7+8FU0qDcO3xPf1m0Nj/43ONZbFQsA1KbXY4neUz1pycZmkwUM7YbXqh7TOS/X
         FR0qzoOjLogY3cWtUTjX2LT9yPzTh/UneSN+qUkJPLjzDZEN95TXYsehEL+laMSXOBCZ
         y9h1RWPPniFDIfDtLBU57mcphPBr8lM1DcUVJTirOKkUDY8Yw9uIOS5aIEhZXMqb76ti
         SMRPf6WBcWIqAoj6mTX7st0YZua5uM4OM1be6mtizmBEoFIdDM3pBpS5BEfnZtJZIHQu
         lgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931522; x=1763536322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fxPxZxcQt6S8UXjieAvc43H1MpqDUf2xI5qng2G0vQ=;
        b=I86jF4xsTQHnt4htbYChARLoOOYQuVVSCskAXhiKkHy0PuN9SDpZyEOv247RD/wUv7
         zM3DL6kCDUZFkBNmb5IwT8VgLrv/893LEyJxOqzWcKx4EggkLYBWK2kelqfisZMgd6eL
         dFU/44entxy3Pa6UQh4VIOHWWSZqfUFiBekWySXf9qGhmi8A007YbZjs8UqQv083+cM/
         rsWpmeYbviAhMyyoj1EMf5lnb8tR13HmdnNtwzlosnhgVR2QfXGlUCbGys1wZo52hhD1
         dEBZf261koXgZdnY4JM4hPctQ26vibmDQE7XoifupjV+0hC18sD5+cauD259c6+6iRps
         BVjw==
X-Forwarded-Encrypted: i=1; AJvYcCXbsdg6sbTHkrdEgooFTeBvdyEPgRu3bY/hOeCDROYsBxYw5pipXiHOcDXZuADmKJY1G4EanbtPu7q/6R1yOu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6fyyNF0YM2Z+sXlhMlTLMCLRnNcZpuSjXM6HdwEyA/eAAYtz
	nvmR7oP2KCt+iqSlg0EbhLK9BgZQinNcewuooXdfLM9WQ+mGRk5YFOOAjedXqgRSMdt2aWndT6A
	C8YwcUEofGQ+yEPoHAsTTKx3vzwRqG+hd0bCdGxDjYlCwrIsYyd1cJY4cFzTQDDCOB4k2NhU=
X-Gm-Gg: ASbGncs63qqVo0RC2BeARDKYf2Bk5IQJ6D0/ISmQSEb+iEuQoi4obiOCTivE4C5iFJM
	CjtziN8s6P9UDuRtH/oF7Ib2B1Kz2ESlkAkE8kj7BW4RPRW7RYv7EmwIE+2KBiOAM/1DcZ8zgiB
	M0KSLJ4PE036M2jQy2LqyUWUrzo9pAoHPOSEbkiAXA27c9NuRZC1gX+qosDdP9KBQMDaE0kCu+0
	LeUvAMSO3CTeZx4fDLFfwkessRmS4eJiW4fKh9eYEesXMZ67MybbEI1ZSOpmPntntP5fiIfpNuF
	1O5wNUjhMZ20bnU2++kxcZcjX30ynSxvkM3URaYvYI7FvRhCxH/oAtQZSq4wlyvvkJN46h5Z4a5
	aBk9nlZYe0sOVTmQAk2R/4Q==
X-Received: by 2002:a17:90b:3ec8:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-343ddef65a5mr1336595a91.6.1762931521729;
        Tue, 11 Nov 2025 23:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjYDY1JLEsZVVzJaPhfcfNidP7Rb9JXHS6DfFNv0Q2YteiyP7RZu1nSeRRUCw8ztCuRHYQjg==
X-Received: by 2002:a17:90b:3ec8:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-343ddef65a5mr1336582a91.6.1762931521246;
        Tue, 11 Nov 2025 23:12:01 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18968e1dsm1748045a12.33.2025.11.11.23.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:12:00 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH v2 1/1] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Date: Wed, 12 Nov 2025 12:41:47 +0530
Message-Id: <20251112071147.1450258-2-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112071147.1450258-1-wei.deng@oss.qualcomm.com>
References: <20251112071147.1450258-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _80b6R3phs9f4ecU-uPv6wGzwN2lWfiR
X-Proofpoint-GUID: _80b6R3phs9f4ecU-uPv6wGzwN2lWfiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA1NiBTYWx0ZWRfX1cSNAHaFixcw
 RHkhCRhwm+9qB6WgWa+RNx+hO2aROOsrMYGdgyF4lRqIHFk6TAmctvWdSmD82FbaYNiMw4Tkz5s
 ybKgaWTUNEnz+hYcqeX5VXYHS0miM9r36kk4SIFZK89hiOLfAkpjdBtbrz9DDkkz54D0VrXixRg
 /SmY7S2gWB2OSwyrhGmy2IC2+gitXXoCiOp9qEFwCIgDUGMar8N0SZqn2NOmXEDDCkHmJSNcwWN
 YUxAI/vqeFRwaFMwm4PTzNwIKwjsvdsdst4aOdYllh6upfrME6Z7OBMQSD9BtBcNtrtgvSqU5tW
 yUPSBjuqFosLFXeu+L7rEHZVD39C+Ba3a+To+hmup3O7cMWnq6/d4PNyOonISyCtlc3oSzkhtc8
 vf5EIVuFnXASphY29Uzc6MAdzmDKLA==
X-Authority-Analysis: v=2.4 cv=YYawJgRf c=1 sm=1 tr=0 ts=69143342 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jAN5yIkcfwfeL4kR2mIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120056

There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
Bluetooth work, we need to define the necessary device tree nodes,
including UART configuration and power supplies.

Since there is no standard M.2 binding in the device tree at present,
the PMU is described using dedicated PMU nodes to represent the
internal regulators required by the module.

The module provides a 3.3V supply, which originates from the
main board’s 12V rail. To represent this power hierarchy in the device
tree, add a fixed 12V regulator node as the DC-IN source and link it
to the 3.3V regulator node.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 99 +++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index b40fa203e4a2..89f3f001fdcf 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -21,6 +21,7 @@ aliases {
 		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
+		serial1 = &uart17;
 	};
 
 	dmic: audio-codec-0 {
@@ -110,6 +111,17 @@ vmmc_sdc: regulator-vmmc-sdc {
 		regulator-max-microvolt = <2950000>;
 	};
 
+	vreg_dcin_12v: regulator-dcin-12v {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_DCIN_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vreg_sdc: regulator-vreg-sdc {
 		compatible = "regulator-gpio";
 
@@ -123,6 +135,75 @@ vreg_sdc: regulator-vreg-sdc {
 
 		startup-delay-us = <100>;
 	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vreg_dcin_12v>;
+
+		regulator-boot-on;
+	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		vddio-supply = <&vreg_wcn_3p3>;
+		vddaon-supply = <&vreg_wcn_3p3>;
+		vddpmu-supply = <&vreg_wcn_3p3>;
+		vddpmumx-supply = <&vreg_wcn_3p3>;
+		vddpmucx-supply = <&vreg_wcn_3p3>;
+		vddrfa0p95-supply = <&vreg_wcn_3p3>;
+		vddrfa1p3-supply = <&vreg_wcn_3p3>;
+		vddrfa1p9-supply = <&vreg_wcn_3p3>;
+		vddpcielp3-supply = <&vreg_wcn_3p3>;
+		vddpcielp9-supply = <&vreg_wcn_3p3>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -761,6 +842,24 @@ &uart10 {
 	status = "okay";
 };
 
+&uart17 {
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6855-bt";
+		max-speed = <3200000>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+	};
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
 	vcc-supply = <&vreg_l8a>;
-- 
2.25.1

