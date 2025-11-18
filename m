Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431D3376B8
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474662; cv=none; b=TpyDo4Mq8bMyxJLyCpbSXFGiXGDATNYr1XvhBbiNsbKdANWx+qbJEggyKL3AvN78z376tjlia8iu5rTasuctIVsuvIzOvD8fgGfAs/ZMV5P7lr5ips7/mlXZykxXyf1ibxD0zjwL+Iz/R6mRPpWq5pK3Q1lDDvZhC/e4+rZw0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474662; c=relaxed/simple;
	bh=58W4drVpq4sxNIxo4fhPSh45zjrOjXY8sQwqZo4rI/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vFlk8chGutaXJmYVjlOFa8RgGYZOSCq19fzqOoROMo3pw6f3xyYoPRje0H9gRNnwv3NMYzySS53EsjheqCWEbBodaSY0dDaQjQhLKN+lZqGaxo1FLlOnyXP8BRO7mEnzJtUlAE9p/FuIyao+iSjTIypfudvXD3f3wB7DPNQuizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BKiOybET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=STujOl7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BKiOybET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STujOl7r"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6ucJc385916
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9lrAM7xXdDO
	V6c49KXuyewJT40PoW+o/goEI9xR1gZs=; b=BKiOybETwFyANiPKN5iQJXtbEpU
	RtrQm/PJLAlnViG7bu8r3JtGp9J22RpezC1cm25q/m1U00+G1RJNjj19PbRzsfAd
	+odvljfHd0lwa6gV7AzPsnel4EWjjw4W/MRDb8Z6+fVjviDDk8I25teE6o3GH9wB
	TV1lUpKk8Q53XCwKhiYiFOw2H2L/k4X4DWuehIGeoayBDl3GXxtaxtozCVG9mQ5R
	xm99V7eacEnsUe2XzQ1a9LqE94t3TjyPCD47INU5u/F8seWz35eyqjNLFq/bcwOf
	OPlbSj6D+wotNzukSUbRCsHRsURZvLn1xPtn16pEqDfn4k4lKsuX9u9iPjg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agag8jny1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:04:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295ac7012acso23741015ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 06:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763474659; x=1764079459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lrAM7xXdDOV6c49KXuyewJT40PoW+o/goEI9xR1gZs=;
        b=STujOl7rq55Zvl40fah+Ymske/5bZf6hK0L3AC7DTHdPrzXggx+fsGnxkpzZJwBjyU
         0IQio2cPGcw2Ew/ei/k+Q0EWuydzKyKYf+7WBN9wi2qHdDAlrBQMYcGOkWRMmU7YWNoI
         bwbJNnAkDCWAoU4bCHwcvsFJ3ftIeTw67IhBTeOugGT1EYlrH93XGWBVA+fAQwG0+Ei4
         +Tr1BcAacYKwpT1r0ZA+/ci+DUGBpJ6JUcQaFXvSDfoHA9NSKQR5h+lof8T727xAr+QV
         vm/vZQ066YRUkSWCTRQGe6Ywct7QM9L4BIvY+3CS30iU4Zm8ss6iPX4HLhGpqSQV7wbR
         zltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474659; x=1764079459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lrAM7xXdDOV6c49KXuyewJT40PoW+o/goEI9xR1gZs=;
        b=ocyqWyF6ifvth+FjdthMePitOzwoEOiYrL6mCgTKinyV8EngLwGzXmvWhVsK63ZHt1
         4p/YZDVX4xr9eR87ytaGRKR/flr9lOOQHquMcK5bC7f+AEP/7uLihngEtpp++NHrcriS
         bzO8aoiD1iFzX4BImBcHKTSLc6JkL/f3Sqwe3BPQO58n2yqln1JM8fB6+lZDDrhS9bcG
         +k3AjnclvfiqRQi5jj6oFs1TTLTpgbmCzrG9fwc/HZvhMoh2juGRWttlcBy33cGiUiuG
         G/pL6oFs5taa/kbrPmMmlz341luua91nXG0SSJ3XEvY9/Tt4X+Fmnhsx3ldURHg29QmL
         Bj0w==
X-Forwarded-Encrypted: i=1; AJvYcCUya1uW+x3SxSuK5GglEYm7UPwMDcqgTFgke1ldnc2Cu0otiEQhcnDR+sz47FS9EYxHmfK93MIwQce0AlppkMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0ijAToNt0v+JEDAfzW6vIWHhUsXjWnR0Ay+B7sXQ2NSTjxOO
	6Xoq0wVfR3eMcXZKHxs1q5eBQbn2fPOYaL8sg3srF+/tf2Su0HwQqkf7hdybTgCDdEE5vNJhJz2
	/B2861JKDPEPOMiFvB/HY8qGhXJdEhEwmBL+AoAXg5jlQGEXJFksymKV8JrR/OXPMfpID7Nc=
X-Gm-Gg: ASbGncsKrllcqJndOJ3dmQcRokfgFQb+zdeAjBufXO9nnVhsYg0KPL95n8rIFVZIieD
	pvNRNqd/0fCCmsmBH10wu2vBgFDc1WLSpO1DzaCtNn0N0RopOaO5iLihff7QgDOY2UsZt8EoUdU
	dkuY5hLrpULz046weGzFAIGxAeBXDM9fDPaQdN6uSwb0ut4va/yD7njTaCj1G/R0bO3SeWtmThJ
	fe5CMnZVF6pOxSOlfTt4wrX2hkmFmE/oeO5T7tiZ5M3eO46+evsE3nYCwQbDPg5+evv085G+WQ8
	gJIK8VJkXo19nIOgcdBjV9oMTmGgcjQfoj9u1RcQpeUKHz9JtAnTDS1gRH676Lj+koRmXdmRXoE
	vurTxJcIBR3RfPg20+OA09QLuG3QYJO6S
X-Received: by 2002:a17:903:2350:b0:297:df7c:ed32 with SMTP id d9443c01a7336-299f641a54fmr21484805ad.0.1763474658645;
        Tue, 18 Nov 2025 06:04:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOP7F7VRre0B4GU4GD1NcI89R7ec3DLibcn7RiLGcPvNDRnFETmmrhYAeGOnSNnTVMBj5I/g==
X-Received: by 2002:a17:903:2350:b0:297:df7c:ed32 with SMTP id d9443c01a7336-299f641a54fmr21484375ad.0.1763474657928;
        Tue, 18 Nov 2025 06:04:17 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986a60b116sm142957695ad.79.2025.11.18.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:04:17 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH V2 1/1] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
Date: Tue, 18 Nov 2025 19:34:06 +0530
Message-Id: <20251118140406.1551669-2-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118140406.1551669-1-wei.deng@oss.qualcomm.com>
References: <20251118140406.1551669-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lcf7DVSsqMZICiA_O916tLyqJ0AGJNT9
X-Proofpoint-ORIG-GUID: lcf7DVSsqMZICiA_O916tLyqJ0AGJNT9
X-Authority-Analysis: v=2.4 cv=G6sR0tk5 c=1 sm=1 tr=0 ts=691c7ce3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vfj0strxkez5rotHyDAA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDExMyBTYWx0ZWRfX7tyDltXr/NWV
 k7H9J/QoBrAL5f5PGM4E1objtarffwtY2vBYIQgigP0hgN9sW2wssEjMN500qMoDuDSKqmeNoIe
 VaIQrUPAjJTra+d4CA4CgzfIuC9IwS9YdkwSPowiJmN542opSr493A3ci3baTz9mgaumaIv0sWF
 dyXzYqUjWADRAiliaXIZrTI9NQOoxE86/TeL5fXv6j3aB1BdPTj+wCL1HRUA7I5XG3eb/H9M92q
 fF9o6fQImZsUmQNb2W1lQsOWCtGYRbGBW2Fu+i9xrRTNOBqrPhcaiQxglcEDWujKgT3d0qi562/
 nIr+UeGfbIQ2zb5PK+sZA+HC+EnmUh4NU73nH2HaQ3ds1QloCeThNlQj8KrM23EeZQA+54TTzIR
 rznzabLtSF1QFblG/p/l+HQ8WvvMxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511180113

Enable BT on qcs8300-ride by adding a BT device tree node.

Since the platform uses the QCA6698 Bluetooth chip. While
the QCA6698 shares the same IP core as the WCN6855, it has
different RF components and RAM sizes, requiring new firmware
files. Use the firmware-name property to specify the NVM and
rampatch firmware to load.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index cd8800a59700..08b705fe4eea 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -18,6 +18,7 @@ / {
 	aliases {
 		serial0 = &uart7;
 		mmc0 = &sdhc_1;
+		serial1 = &uart2;
 	};
 
 	chosen {
@@ -71,6 +72,7 @@ wcn6855-pmu {
 		vddpcie1p3-supply = <&vreg_conn_pa>;
 		vddpcie1p9-supply = <&vreg_conn_1p8>;
 
+		bt-enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
 		wlan-enable-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
 
 		regulators {
@@ -501,6 +503,13 @@ &sdhc_1 {
 };
 
 &tlmm {
+	bt_en_state: bt-en-state {
+		pins = "gpio55";
+		function = "gpio";
+		bias-pull-down;
+		output-low;
+	};
+
 	ethernet0_default: ethernet0-default-state {
 		ethernet0_mdc: ethernet0-mdc-pins {
 			pins = "gpio5";
@@ -571,6 +580,25 @@ wlan_en_state: wlan-en-state {
 	};
 };
 
+&uart2 {
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6855-bt";
+		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
+		max-speed = <3200000>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &uart7 {
 	status = "okay";
 };
-- 
2.25.1

