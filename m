Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7095932E723
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842497; cv=none; b=Wn6KI1BePBrGI6yuKgTs6yuzK69arR+qU7tpzbuVoCMf/pePHCKT9jGRSB/s/OwRS5Ofo0ITsJo++CJbb6YsDSeH1bbMtlODSP1rbhwAUQMugusYPUKCD09F7jTo8za6dPvS+5q1mdPFlNZEfqXSR7/Np533FF9WtN4V6XjX1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842497; c=relaxed/simple;
	bh=JW2e3YORx1IvzyXTcxL1ItlNpE70OGRvUy5PXPZhVzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtZOHbreQaSjXa4lsJXr+zTkkP0kT7Py2UDGYATZGkaRslKquEpoPS3R4ok13za7kUmVL3WzP18nqJjSuDOoTaYHvjWIgxQkeQY+OhBUHr84FOnRbP6QPF9V5wKEEZ2affbfwBH71iHBdBeyvrcKGZiSjBm0ViXAgDrLpmN9Kew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kph8csSJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mlr0mTvj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kph8csSJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mlr0mTvj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J9kIJk774034
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=; b=Kph8csSJPlcKZ5N3
	ooFTfL0fx/z0wo7ILoe2D+DwRZjo7AqMAMC1gXcr2GXZrycgehJmO/NyiQ6C5b3/
	BvIHH6o4zfZyHmPFnPGQr05JN7tVNdpP/B/kZEEwYwHlUQfLXvvI/Jyu2n4xlaDr
	8gVuvRa3co46R6gW2FSgQgOnKf4/tVvVsE791G7mKykgVBeew6psxewNGpTmdxbG
	QpWPJvpioVQwc7D6ufY2cUDa2nsbjWOSAHvxKCtvPt5IPVjAr12puDq6EWE2CCPX
	4zmYKLySiEBRWmfSkF3973G6wd+THbsl24sl1GFBRPmWeRG3oBtMQv8BjUNlAezJ
	88XlXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsj9a9a6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52d3be24cso568022585a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842493; x=1769447293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=;
        b=Mlr0mTvjxPtQieJ048z7l1KDCs7exLJBD80jxh+ZO0JWk2Mo/OdLiNANtqEiSQaU9B
         pf1hGqDPH1jlOK3mZqYizzYf1K3+ZbaZ0ia3ZoSR5OmNlLpyed1zrcibienabg3tzbCj
         VcVadGbsHjLY1l+admMeo1bgSlAZ8u25Wv6IAX8HBfr3fQd2tH5JrQ7u2i/q7W1iQUIe
         k9sPt3SNXlTvZAjYm9IobETN6sK7XjpyjPFPiMtzRTZrOxVDs9SqbvV0HPoRPnB1dkla
         qjpwpkl5Bm189Ci88I4rrghvhIbo8ytcCRVDO992xsDwZfPgF2NuCKJ79Qpa2kKXCBnj
         NnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842493; x=1769447293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=;
        b=cnRd1GW7CAjnCHETRDmzmSrgDszTaF2XZynKi81xg6788JIJZfIvP9nCs1TH4cyV12
         oRkdy1vRz/Gxsrxk/IfyWwdYHXBJTj2xdJEkpGGS/bkRxVkbCpy4GW4/lK0Wshc9djyz
         H8bwukdyPuwxqC8o0vuP8dN9J7siMoiXds2oM8x/oAcwO6i1/M7gqx6REwKAxS7alVRd
         KqMO/qbKmGFMatdtuvjCKHWLhWO+BCx3QY6MzNPmyVQ0xQ/VjgR7r+GOXVRY3cy0AtBw
         YmSjyPltXK1dzhRFU59O3FYXrMXU17ayHv+7xQ98kahsFObd+tbqEggjshUq8IM/V2XD
         gkvg==
X-Forwarded-Encrypted: i=1; AJvYcCVeReroZzWNcMHyU5BEPzCvxUCFXb3z3ZgrwbPwxhwyXoJFrOH5raq45IWcmB/VwoWJRNEbHJJtEMTUqycFEXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGz0jXnUM1f/ZQy7NYGmYz8WEmjQeLFNBctm/V8VnM0grJtyLR
	tkBYj2yqroTfUHbU9xf5i/Ax8iwEllZwVkb+YCC2w+OBgIqoEmLSMkccYH7bCVlbKznmNUWvLLP
	X+zNgnziHW6KX6AsAmbAjOdh4EOtR23VqOL6kuhLC+Vk55gFiVq1E7nAxLtTt63A2Eb4Wizw=
X-Gm-Gg: AY/fxX5hDehU6T2+qab2Tn9BKvrTPkJcVDOaOCiBGT7UlDjOCLoBtwUzvcDe47GbCoB
	FlG5CuZKZbOAGDbIYF8fxqOYv69z4Q+7VMG0LY3fj4OjdfPm6+ZDypky1OpOdADmW/XEwGZqqKk
	6GtChEb7v2gO87sI4OB444iI4tNDGDK/0EVlPfa0cPNEoblMDJVGsxcGAl0QyHxhuCPVHkWcPWR
	QbDHyPQUU0zcO/fnDETbEdiq42pziCjUqInRTRmD18KM13FVoe7Od7vnjvS0fv02/X4OjB4MWjA
	HYoG+TZBC+G2td2YiQiLN8yfddHrl9OrGdi+UUU7+9qT0ZLAFBO9fTqaMJK5ILISAMaFTM2toKL
	jsYKO0PGoqm5FcTmhJAeT+s7lT3oTeowgWhYlujfjLA9QiJlCC9pJ5pB4UcKCIgyyruiTBtPCPD
	zRXRGFvdPsM7KvEvEFM5QuW78=
X-Received: by 2002:a05:620a:6ccc:b0:8b2:5fa9:5c with SMTP id af79cd13be357-8c6a67c6230mr1583281585a.83.1768842492663;
        Mon, 19 Jan 2026 09:08:12 -0800 (PST)
X-Received: by 2002:a05:620a:6ccc:b0:8b2:5fa9:5c with SMTP id af79cd13be357-8c6a67c6230mr1583272585a.83.1768842491943;
        Mon, 19 Jan 2026 09:08:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:07:59 +0200
Subject: [PATCH v3 5/8] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-5-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JW2e3YORx1IvzyXTcxL1ItlNpE70OGRvUy5PXPZhVzQ=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTujVPIgEjXA8JnEOGDYcJirzEksl0B9Mua1
 l1mjfNi6zCJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7gAKCRCLPIo+Aiko
 1UdOB/jyDd6V6C+z/elupzbVyBfZxyDWZuxMYSOT2VsBx2fd58Sxzk6ZO53Jte31TW/VqyR/G/E
 lQsewtI/4wZDG3xjBTHmS3FyaJdD52ySSz3gCSwTtdPmeKTvlQo6hSNfNOqAlT7r99TDYU/u9q2
 gtGXJIwVyMauamHvXspTNafx8ZMhBgExY/us5hxoE34Tlnhz5FiBUCnb9kYPhUfAmex0wH7ipYt
 LnD69aC8TOk0WW4XE85nU+ct4e5tW7hQy51yLSeoDX8fONsuenMGRgwUowVSgbqK8Lpjv9S191h
 S7O0Jm8c3gyJoiUVIDvhPwHjjRL1apRZyyORQGxGOY0Nc/8=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: pIonA5VeG7A8QYvqZCXujlbzW8IfdCzm
X-Authority-Analysis: v=2.4 cv=N40k1m9B c=1 sm=1 tr=0 ts=696e64fd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ib3hs3rZ3KeRbPluJGkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfXzTGJfq96637c
 GHkKPZFKQTUsIv4074Bu7Fwtz0FblROcMjYeiDT/T1upprV/JVat5ApJIJaSHSDtBOD9+4TESmF
 rRCo0SnFoJ/W5Q6pVC2VHnBFPgyjDsDdFPlGXDDsTwMvCW/qH7d+15OCUjK9ZkyixWTVqmFF3d/
 rD4rTJAlBUCgB7gSlO5LbQZc3Re+xpO7Vao0mB3jD5zQJdgcuokg3hAw+JcmwWh26fHDOCXaZ+l
 5sJ0qgCRag1iayUqUW+hY5/vfbtRbf0Jsk77LAXZY41hRGSXo35UJXv/ubGdUK5TN/3HMluIkX8
 9AbuYA5ogCQkvwJSK/rJdL+8WAlF5JpXV6dTaPrgMUJ5vJ45TNu+UCou+SMks3jCdeXyBjmgera
 JXaW32ni0xxiUF+M7QReCtAUpIl76kxxz3h+TVbAXPg19h6WREyVPcMoPYQIg+MS801ahu1bbS0
 6nzdVkbFhP+BwbQ5Lpg==
X-Proofpoint-GUID: pIonA5VeG7A8QYvqZCXujlbzW8IfdCzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

The onboard WiFi / BT device, WCN3988, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 5f8613150bdd..5ddf448bed8a 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -237,6 +237,42 @@ vph_pwr: regulator-vph-pwr {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_l9a_1p8>;
+		vddxo-supply = <&vreg_l16a_1p3>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l23a_3p3>;
+
+		swctrl-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &gpi_dma0 {
@@ -684,6 +720,12 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio87";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio88";
 		function = "gpio";
@@ -703,11 +745,10 @@ &uart3 {
 	bluetooth {
 		compatible = "qcom,wcn3988-bt";
 
-		vddio-supply = <&vreg_l9a_1p8>;
-		vddxo-supply = <&vreg_l16a_1p3>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l23a_3p3>;
-		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -744,10 +785,13 @@ &usb_qmpphy_out {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l8a_0p664>;
-	vdd-1.8-xo-supply = <&vreg_l16a_1p3>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l23a_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
 	qcom,calibration-variant = "Thundercomm_RB2";
 	firmware-name = "qrb4210";
 

-- 
2.47.3

