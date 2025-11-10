Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99D2D738A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762754244; cv=none; b=GTE8p4VrjjeLaNC/r82Km/b3Vwq4YHRFn2ZKXBTwk5KTuw7ynFPKXfdaopPv4uwg8NLXSiOtqow//4FaKpwgHvpBJYRaSjDv6xvrC5nHThE962MMNwhKu4C5W7w3+e/7UbcHcEHVba4tbV9YseZo9x18Znggt8p3n61D0HtKrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762754244; c=relaxed/simple;
	bh=QzmDOJKkFKSKQC0iazd75tmvhu41zincARzHlNr7Hzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sVUwY38XJS+EnIMm6ArotjFK2Yvy/eQjcJT+0px5esyvu4IQrOXsftva043qQQ563uI8JHHgEbxidbmqQP2Ik7wTqH/+MOVvMANnivURFSYyHcz5jrYA0CJAB34C1tFBAnWGvBzp2ncf9TOyWY6Qu4BOldq+f2l82qvZcQhUx8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GnBzXyBb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dO0VyXV4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GnBzXyBb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dO0VyXV4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9LX6IE1587509
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 05:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NZ5xkV0JLXjFw/zvyfnoZiVXRA0mAMPDAU9
	IbeP6+Yo=; b=GnBzXyBbipZRI33Et88pryS7N5B28j3qxC6yUxUCMfQwNkBJkcj
	XlBfNHjwJxhUN54RPSOAz4rqf91/aFV4Aq9iR0yQlmg82Qbs2QXs9J95JCZlS6tn
	Fgyk9wLUQsCb6UZwmngQL4tNKPbID40UOVmlLZpWw9zQpC+dqwmRKEDl1Yf9xeZK
	N42K/oYMwZ4cbnqbEpfAKVIhAp7Hd0elYXwAzqWX/Ba4HPngNNqAoruvVMBqtzD0
	mT4JCDNorv/1uSvMKFPcx4E/hkH6btZDvvwwqVtutMBywRvRBETWqJUMqw/wSw1l
	T00NCPNewm2qE2RF2dBHoRES0BEzcmkBjqQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aad2a2c26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 05:57:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295ac7012acso15271995ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 21:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762754240; x=1763359040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ5xkV0JLXjFw/zvyfnoZiVXRA0mAMPDAU9IbeP6+Yo=;
        b=dO0VyXV4uelFtQJj4gpwmsvOv3VNsuRMnvnfFtHr33n4FwUy1z9VTnRGRKCgEFVNV0
         4ZKYv9FGkNF6JJGq5Z5rB5mHErXNBJ1Z67GoSaY0CFhHIkbXnwK8J5ilhfk92ssKRWS6
         fWUJLQADuPjX5eywVhCtKijEYxldnpbQT9/dIjwdo1pRLtB5/gFenE2tLEYUJeeinAU3
         AqzNTjLLCPbXp28tI0vFvyY6Zlh7i5AFLb30/kMQhBhExH2zJTucYbk46YbG/Q605E2n
         E5G1pepHBDaeoejtCNgLjUAN+dhdPdBS0W6pXUWo+8HXc+5+7Im19H1JkLOcfi7kgSBK
         mjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762754240; x=1763359040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ5xkV0JLXjFw/zvyfnoZiVXRA0mAMPDAU9IbeP6+Yo=;
        b=s+t7sxGMWBrtrFspfDeS8ykbhVK6Andd0YqGQ/iNGUBvKX8TEJWTx/+Nwvun4P01pN
         uU3/OxJUlWe1TihfoWCQ7qk0GvdED3m9w0Gy/aSUTWPSALqD4r+niPTQn6cFkp/u+LgQ
         BwC8RGFThXEKul4ieGJx/QZJMnNjeGsCNL4QBRgJ9NYYgM6q0+/x/kp+3Rn7uin4Fb8t
         hC+lWDT0McGSfSeXtumG7xc+PWCPb165/JeOhvimVuDjwqQjx5dEGWt8hi5UwaA2hzm2
         t6bvk2iNTyXhPjC4LLBX8CLKdaS5UX8gYB40P2SgKIfhVDdFNq1dJ6dmKsUom+vpEJZT
         dInA==
X-Forwarded-Encrypted: i=1; AJvYcCXgiqpPaMLR58ROrj0w8LzRSBK5nfeMcb2PIjazby9kScLYX/b56tMFwbaqJ4Ll4dAyj9vl07mxsXue2a81BKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhelmUzW31N2bOUaHrr2MNiGy87b1RPQ2nYdAbNWPDy9uCcn3
	FbB46pa1ADmQWRL6T56aMftk9ElAbfNOlOtMxbFOSRyPjMsQ/Kc/2B8IMZcD2K8O3Gm9S7FM/I9
	RYOrHQaarxU08KSyzrAyXlnrRts8zx2dFSS4QeyHuIACz95HyciePXuDZmESSBU+BoJ19iqk=
X-Gm-Gg: ASbGnctohunoNHImh7Yn4p7u3+iWwWe6eYpIn80T06y6HbPn0UNMyuwC2+cLc8Uusb0
	3jkJncwkHh2nNNiyac983itWnb+ddW6ZvPq0enDILX0fXchu0cx+ThIJON4KoBuTkq7jF6AWu39
	FqeyRkBxKqc/NJ7yzyW73ApD7HQMZvkLu95sbhKuU/XS7FTINQjmS4kHhhBPyWTaMZx+oZk45wr
	KirU7fB1JN4ebjBHa5y0d8xrUJ/cnGN+p6bXS24r3ftJB1Fzc3hVID0ckoMHLgqke4C4RbG6zoZ
	nvDgJy/O2TY9FJh63B0Ue13ECVaZVsfxuXiWGpoFAppx//ILX1lvvfoo6NRmNdZ2LP3RJtGdEmZ
	/MKWEjbGYiZ7MSPz2RqbdRA==
X-Received: by 2002:a05:6a20:3943:b0:334:a531:a51a with SMTP id adf61e73a8af0-353a2908c00mr4784522637.4.1762754240375;
        Sun, 09 Nov 2025 21:57:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/4tfvH+MRQiVSi6nbedH8c4nEAywNsbUsJHnIDQs6p/nXqjlrt4RAFVGtaO/i8XjzbKH5sg==
X-Received: by 2002:a05:6a20:3943:b0:334:a531:a51a with SMTP id adf61e73a8af0-353a2908c00mr4784501637.4.1762754239794;
        Sun, 09 Nov 2025 21:57:19 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bb57baf9905sm2156589a12.17.2025.11.09.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 21:57:19 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com, Wei Deng <wei.deng@oss.qualcomm.com>
Subject: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Date: Mon, 10 Nov 2025 11:27:09 +0530
Message-Id: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aedsXBot c=1 sm=1 tr=0 ts=69117ec1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2pNZeJXcaPdVUEHXAskA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1MCBTYWx0ZWRfXzjynay3F2N7w
 tBJ+0zeoDKonPXBIKeW1SQhMJ2VAuNjyz8ZIECUMX1tPLKDYk5xY7lU0NhMI7CEL44PKKnZRboi
 cpkFC90dzDdvWIWhtkKPpm0Ainj84vRu5ZByIJCbLldy2/JUEon1sxoV7IVxSh6HCpvXZhg3PFK
 bsyrn1dMztkV8yLdSyNtDYgtZ38vOxL8jPse2CT3PWLDFfvdge1iN6d64Duj9JTSwHaOjIIgkKK
 ionoMc8zoVbgs5+d71U+z1avLaO81+Z66XBAHMADBplFnZ42jiqty+ys/2WUzdmmvKvh5CeD9Dd
 u+VNCAtdYhNKcnD+c/Ga1Fw5DotCjiKlub3IbXG6pZO06D6wwF6RXwYTRIdoBPJM7dewICeYpIB
 fbLN2atfGPvGEPkN1kmmK9EZZRu8TA==
X-Proofpoint-ORIG-GUID: G7YCV2QculZn4NPKZtQ5UHE37Rrhj5yR
X-Proofpoint-GUID: G7YCV2QculZn4NPKZtQ5UHE37Rrhj5yR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100050

There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
Bluetooth work, we need to define the necessary device tree nodes,
including UART configuration and power supplies.

Since there is no standard M.2 binding in the device tree at present,
the PMU is described using dedicated PMU nodes to represent the
internal regulators required by the module.

The 3.3V supply for the module is assumed to come directly from the
main board supply, which is 12V. To model this in the device tree, we
add a fixed 12V regulator node as the DC-IN source and connect it to
the 3.3V regulator node.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index b40fa203e4a2..c87291e3c6ac 100644
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
@@ -627,6 +708,22 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&qup_uart17_cts {
+	bias-disable;
+};
+
+&qup_uart17_rts {
+	bias-pull-down;
+};
+
+&qup_uart17_tx {
+	bias-pull-up;
+};
+
+&qup_uart17_rx {
+	bias-pull-down;
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sa8775p/adsp.mbn";
 
@@ -761,6 +858,24 @@ &uart10 {
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

