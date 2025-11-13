Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F035293D
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039131; cv=none; b=q9f4gng/yEnJf0GXtW4gWeczgnmtvwWo3tZIeTxGDJM1O6J22BcbPBcfwqeeZQhbj08hFhe7XTAaz93QiLXgubcOBTOLFr/oMqlf4NIhcYGbVgpLXzkz8NO3WGJToDmvn8Okw5mMkRhifaK999CO0wz0kESXcMlPBAErUBjc7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039131; c=relaxed/simple;
	bh=/pmTjiQIV7lNkIY5RLjdvFSxXZR+OHwMnF2CG0g2LS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lAR6v0YZ1g1NimZWKFEcuLYCz6Zg7pxzBikiYzogaIdUIxPQKL42wdttoTc+HWaQ6W9pG14/iI/6ni4ABnV64abbYp6Tn5/NCtl3pZN+Ukd4+1o2rZ80liEf0R3xj9B4X/+0OJdOInVk031WI4if8goD4HbUAgleksxHYAFJi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iit7z+pD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hMHSmJsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iit7z+pD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMHSmJsm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD65ju13563371
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 13:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ami9/GRxxdVsR0BkYUb2Vn
	6mb39Uxml9YmPVyIIGtZo=; b=iit7z+pDgnjPt/631+fG4dc04U04y9RJRkFDM0
	9BCTy7sdkgFUoNHHTspwWseaxbwbvd2gaUMXJSzDc+uxDtMAQsTEXWTy1rZjEvZU
	IeycYngKJY3Ct2NgFZiLoFyA80tlZg2Eglpbku4Y4ywTuxrXzSrY8Vo9A+7d9itm
	PAwKY4IFK4Ima/xg5rAkbuhZY2QJ+80QosCG3LK0yXSvXCa4c9eKm42sLjjjeYuw
	unavYIGVHIgUnIvSBUWg/CCozzujnB4c73SBuM0+TaVZ0K//MntzwOpuzfI6W4qh
	Few+ZBg6m+mmM1J5uJS+WQRyKIlOQV2aYS773rZtSsyBM6/A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad9rvh76n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 13:05:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aed9ebcd67so193295b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 05:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763039127; x=1763643927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ami9/GRxxdVsR0BkYUb2Vn6mb39Uxml9YmPVyIIGtZo=;
        b=hMHSmJsmNm4LpveMixVg/T55C0MnDk+xw5FEGJMHRf43NNzhLOd8D1q67JEv7jNYgb
         FIp9LOdSe5/iF/vAG0WgsX49tRg4SSrDnIX3MFOsNuxX1P+ACadOlmFlFTvo1NzkZbnC
         TjkJkYdND+ds1M5/I+gh+jhb+zKLN6oVs0DN9PVEkQSA2koz13k2VkCTyRkMof/mmm/l
         GXmncoQXsYGf7SZ4v2GxLOHw6gGaPW/ajEej3Vg9/6E1Utj7o09I2hgxaVSUgFUuC16J
         3jtxeAMhIxaKehudOqfExlgW0hw8K89zNAl8lQiWBPnt3hkYX06TRY9B3iAaeCZT8aKP
         MXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039127; x=1763643927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ami9/GRxxdVsR0BkYUb2Vn6mb39Uxml9YmPVyIIGtZo=;
        b=ESo2y1HgnJwljex1KjRCEnYj+AozL1LV9RviyBQe3i30Fplf7SW9VFaJmar7MTq/X8
         yl6VB4YB46Go48muiQRhnltVtYnnnvoUq0ovEn9TF7UEGHu4Q5W76LjI/pt2/ZXMT5X1
         XttqEvaEp5qHzwpmmHw8FMNvg363Svlb9G6rs+5C4LveaAf79ur+2WmcmvL6hpmfCg6Z
         boOXu1MdywiiLQO/fNAj0k6h4K+numFg/5M5hfbOr5yclhPdS85WkE6AezxgIvD2Wk9O
         Ts9PzdxZwefqXALEUlKE+h0p8VZp9I5sqbO/r2HxUxdJXhQ1+hJ7LssCPoUazUpI0K7X
         HzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFfdaLFqlDVmPWdLD3GZgnerh4fgeUFaC/83vtnIXM9bkwTTwkKrlQyG9UTrrIrSSUH5PA7GC0wK9EO7WQDgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqCoHQ9Hm3emKTC6LwOG5Tkhb7ZuW9yGKGj0NvgjUcMD8dEJX
	LoCwIXEhJAGTZ4gwbsEARjVsLfUk1VyvJywWWN6F8Qm2rYdluEcn6o4//dH3fTaTCWSwHVsspyk
	qxhVNeoSUR2uqbx6CmsCHh+SxdYAeTPEEDlEZIkpZKFK8cdwCJppQ+1qSZRe5u18JNRzjMD4=
X-Gm-Gg: ASbGncug0oA0bh7i6qFAmDO1lnJ7h1slx6Eys9p04TOD+MsQ9g1L2YKFQ4LshXrhrXa
	s3UYk1+ezSBQghNBiC/kDiitV9ZtLJgeiDnU413lTIvKXwdAMTuMXe6g2JPrxmsXoBz/j0+wpkE
	PrfFqSKS5AR+zMEtKGrk/03r4Up/Mst+rqYX8K1kNsF1tTO6c1uQkj1XFfwzU88QeM+5muoc+ju
	Py1pnqe87165XfJaYoOCFbdbWAOLeETfu1pHK6YnKVvKG1YN6WDS3ZbSFz/a4unYTiWMCic77a3
	V3/GVqOwlYa8qDVTwR7cDCBuBO4fQMCKBlP9Hm9ueU8BhdjnlAbuDuDWBOVtvKrRn7POMhg/Ilt
	CX6255aiT6k6xmjSHxXmrhw==
X-Received: by 2002:a17:90b:384c:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-343ddef4dd8mr4473958a91.5.1763039127178;
        Thu, 13 Nov 2025 05:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENEs8usVLQVclfCfoQ11ktHzHwnn3YtQfKRKLH1gqmzn5G8Re1Uz7UaIJvtTSzWnAEDf7Ulw==
X-Received: by 2002:a17:90b:384c:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-343ddef4dd8mr4473871a91.5.1763039125335;
        Thu, 13 Nov 2025 05:05:25 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4adf45sm2564093a91.4.2025.11.13.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:05:24 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH] arm64: dts: qcom: monaco-evk: Enable Bluetooth support
Date: Thu, 13 Nov 2025 18:35:19 +0530
Message-Id: <20251113130519.2647081-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XrX3+FF9 c=1 sm=1 tr=0 ts=6915d798 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jAN5yIkcfwfeL4kR2mIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 7SaMvO0tLlYsJbfm_g-WxTd306VR10js
X-Proofpoint-GUID: 7SaMvO0tLlYsJbfm_g-WxTd306VR10js
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5OSBTYWx0ZWRfX+0ETzHMJvNnu
 Npd0CVQGSw2cfoyQqVA59xZ3krVf3T2bOGN0pMnTcGPUxfa5j+XeEVkNHYkzRGs4v3f4NdDsVi3
 d1Xe5Un47V9S/3ic0c/dDTxo3ZyjZtw/GqKr/DAvM84xKeGkI4efv+avQuaQ86vqGWJF0HqGo+2
 UESwYIXvbLQlgE9WSKRZ/pDVWwGCFQy4hzLUM8/KWv/Pz5XRp793qtlnSJf8QsQ1RKTDf8WEvt1
 gUFFTvuh8LvI654V9hq8OQxzLC9PcplNnPRdRuZ59B3rHT1PkHQvVTilTY8JS7FvwG6nDWIk7HM
 UhpwA2EOkQEajldOUXhk3dOYm8XHSk7OY67kcsPk6ZGBY7YASJ5/5A2JwRR0TyiNBAwy1Djs8sP
 K3aQIOGLlg3sr8k46dkFKYhvujWgnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130099

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
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 99 +++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index bb35893da73d..a8d1dd04fcd3 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -20,6 +20,7 @@ aliases {
 		ethernet0 = &ethernet0;
 		i2c1 = &i2c1;
 		serial0 = &uart7;
+		serial1 = &uart2;
 	};
 
 	chosen {
@@ -76,6 +77,86 @@ platform {
 			};
 		};
 	};
+
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
@@ -466,6 +547,24 @@ qup_i2c15_default: qup-i2c15-state {
 	};
 };
 
+&uart2 {
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
 &uart7 {
 	status = "okay";
 };
-- 
2.25.1

