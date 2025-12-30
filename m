Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2F309DCB
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137789; cv=none; b=Cnn744EOgazdk91iF8a6SVhVrNaV11gUwb+OinlB5BqUMX7qH7B4UNuVhHaTWZx0bdMwy1zp2H6uQkHfKvVaPXxuAVW14Lbp0UoIF9GqUBaJFOOO7FhJBt0fswysFEPeweHDU5npxoJBugj/BHXDs6ExPPF8m4BG/VeDowCAGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137789; c=relaxed/simple;
	bh=/qWwJPKoLPnWdm1jyHlJq/kGeX4sTHfpI9Ptnv3sGkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oALSl/Gs/2Nr69/hZIQHZiY1u/acApwSPuWu/IGc4dT02y3M3njyFf/jXjYc/Xr2YQSDdVaLaNn/6Hd88tzqSxtngymJ8yhukcseLS+TbKx6B4uLwZdspIaqWiZ04n2MsYnrDOu3Ev0ewfG5zhnjgbWocgyOkTC5qm3R/D2dZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+ZrkBbE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AEHujBj9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+ZrkBbE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AEHujBj9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUD7Gsa2548850
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=; b=N+ZrkBbEP+N+sIq3
	WGZOMdQwbh7LAwEZbSKmbkplz3RIKgws0FYwb6W3bAI2+yato/I2yLzxB4V97pfM
	A3UhYZtlUW8Hz3iFJvFlf1SnEc96fuTx7EooWbkNDrdffjof0RcIHjOBtAJ/MhjD
	bhG5S+FaIJOiIf7+4fIyxkFbJIF7SW3UYOpGoZckvgJhbljGEw2r40M/3Oyw9Ot6
	hYPb8NHeBenQpJK59vFyAEo7V1aHA5ltSw323jIm6iXaYisRf9BvIVSDcjC0p8HX
	iYfEoUjBka9+AxQJZrBGHomGeAiKL+DhKbimOZK8oqWs1e3ux4SgmygGlSW0jTUV
	ZW0G+g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc739acxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed74ab4172so244242241cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 15:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137782; x=1767742582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=;
        b=AEHujBj9lfMaLIxOw8NTnlEsNSgGBGYPS6N6uK741lRR8b+eZRdS3gGfaWl+BiEEqz
         PGYFYCua090nV381gDunp2550zlqKsbUSskxW31/YwgugsV9oA43umszkDtQvli03VTs
         b+gpM3RnzJ3HWTog/LZn+4/Ab9G68nnKy/pvjgmHhGbp1ecfH4Iwqf/ap9iG8YwUg9vR
         6XDjO24oD3Zf8egyFDzGV/Cl/KnoKTgrQN+1nzbXwm7dKzJV2cDPxYfJYa4Vo9YNoNgU
         UctZrmwtxvJlanALPmydGOMcnTgH5CR+L2ixeTpNEoXc4HkDGRIJW6bm7kb8ixpGb4TD
         WRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137782; x=1767742582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=;
        b=KtFGbs22M4NwgZ4DpQf0FglkoANWp8vmK91L88f16cuyskF7UbRu+8zdRkeQ2XYOgW
         IGU/76zap+Aoejo+Bo4SJwatvTsla1peo+QJXtK8EGZ4PSvzCZHiks8Ce/mYpxyiE8T2
         93WkKhW41Yhq0BEo7MOwawCerYUk2Fz1ycPUYoMoL+Q4SvBXyB6ECcX/o0FxD/vxxzQ7
         sgyjXSN4X3tvys4UaDPpA+FTU9rUFGnsiXIzUFsb4OMYXWk0elRBW1QdT32N21UuFHbN
         8D1UYJfDMj1vC0fZLt4zqf/RXDGcV7ulYw59Dm1Ngb5uVLOlA9VmZVsIjKqjS9R2W65C
         w4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVo/BJGTU2YLIybNXziLox3DDZ3VAdqcP302e6da3omRehgeLvYKzpZz5pk5GoXT32n14gaRWK664MwMqdSHaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEuur02QlCIEEUrwZh2YouqMklR6bRE0tkguxbj8kmJ4iByHgW
	DhgkAhU1x4nOw9GgqjEvgwrEun7DZgKZPUtDOQLkaQZ9wOZXLki4LZGrEEP190iiaU7NQzw241f
	d5Jl/KLgHQeShae+VqPJY5seqarWihVvVSFdkHcBPKNHEzTdbixXRvhfp0q4tSTfn2mgnn8s=
X-Gm-Gg: AY/fxX4FN3iKgOZXJnVqfA0LsEoUfHjh+AmNjBAiRcKol/4Sjc/NwLa0u9sgRnpdCVL
	oCgV1jWQ/B667JBG4kWE4Vdf5JrmJhSxMkmOyAJxErZElCUUYBVg7dm36+0F4DO8eBfc1ndP1X2
	7GjZpSbFTVJLwzDkVfS69LzBdY9X9WfmEDsUXFAzgVWP5/2enx3ySWTyhJLMIc+jQbkOGCGXJmb
	WcIDjHWQ8vFWB0+6uDNL6c9lhJYxGW+6v+OzZ8yrwy+4BP6OhlQzcMm1ojIPsy603OkYosE3jdP
	0en2F2gI/pUTskSoXluu1Dq2cVJ1J8eVZof97g4GpvdAP6JnbsSMmbhJx+9vCtUknXSgZPx0XMU
	D6xR4NZ681B34xtTuM6A3pp5Vc8hLdw2cClADuooY3pF0FphP6y4iKTdMflmOU1dJk3bRC+TfNy
	gzB+l7dNHNQdFBN/swKXwXiXo=
X-Received: by 2002:a05:622a:1144:b0:4ee:49c9:a923 with SMTP id d75a77b69052e-4f4abdb66b6mr477095801cf.56.1767137782323;
        Tue, 30 Dec 2025 15:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkPqMdqJk/XCzk1e8ZyvUBpUaurMVX1soNXULfyOp66jtSt+yb9md0PSgAOZm8YQ0qjDZn3g==
X-Received: by 2002:a05:622a:1144:b0:4ee:49c9:a923 with SMTP id d75a77b69052e-4f4abdb66b6mr477095691cf.56.1767137781889;
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:02 +0200
Subject: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/qWwJPKoLPnWdm1jyHlJq/kGeX4sTHfpI9Ptnv3sGkQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHlCjUGMHlkqkJafwLhwLJykGktOCOjkpAY9
 wWwhzlyFAqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1ZqOB/9GU2/Bf/2GNGunBAoAKZe+gB1ID8NoQrA09/9ZRauuaoMy+dCCtYIDBM3vRl2CFb28OcA
 pgDJEoOPyMzCEfV1gSMyuD7P7rD/eHJ2v5lclrEGHrFBeR0ki/EalU6nNTUWWN5ygcKYM//UJXd
 v8QqOiqJ8Ztktem3BId5LhT4sVp6BsXNVwpJmGyqjjRbqL23k5ccCrYi27el/uzDpcWDkUscilk
 vt2LS8i70uf65bXCvZdd8rCTUojWi/nIwwpAxYRYUcDUb6bRbNO5co2pu3jppvt0AQtvI3mzjsR
 bNWBuTR3ETPU/KTXh3R5hBqGJsBQnFzb/Jz3Mspfy7Z6S74E
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: kizjv0gZ7KG45cgN234TITm_jq0FWVM7
X-Authority-Analysis: v=2.4 cv=HrV72kTS c=1 sm=1 tr=0 ts=695461f7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AhE6NyMZFPWiW_N_LacA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX7V8IIleJMZ78
 gtMHkXUG+zUXmOcTj2fRBKLWhKvU4D/I+TqCDeJE8HAl5V+hx3Et/6txYuMsAlr6WWFuWrDguH+
 KvmdUQLv+LsbG7JcY41Ethe08jr1OLtuRVr0yEF0+VLxlPzfX3Gxyl+Knb1zBqkFkSiOsyCVl2B
 aVgPbtfU5g3u9U3a3UXRQQDMS3HsMI44VA249jdPRFDafZLyiCvWaaCHYeKLSz11OYLjcXMat5e
 XDr6aVedZETVLP4KKQj0bP7c0Bwhc3MvoK72OfJ7pvC7XBdt32h1dpOnNTx/c44iXciCCYKiylI
 E6TftIprxKzxMn6C4TonsKsk5yTC4aUX/GwMf/cLneU3E8oG85LERTMuiO8M4sE13N/nOMBXcEC
 eCz2fzph1t9n9wZVojykmOjkbJapuXB8nLJTW47WrZsxz/IbfPeUj2uDUWujeUrxxFlmOuP+Vww
 i/1CfEXb1TJpFQrmZRg==
X-Proofpoint-ORIG-GUID: kizjv0gZ7KG45cgN234TITm_jq0FWVM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 66 +++++++++++++++++++---
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 74cb29cb7f1a..b4ea79cbcb3f 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -108,6 +108,43 @@ vreg_l10a_1p8: vreg-l10a-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	wcn3990-pmu {
+		compatible = "qcom,wcn3990-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_l13a_1p8>;
+		vddxo-supply = <&vreg_l9a_1p8>;
+		vddrfa1p3-supply = <&vreg_l6a_1p3>;
+		vddch0-supply = <&vreg_l19a_3p3>;
+		vddch1-supply = <&vreg_l8b_3p3>;
+
+		swctrl-gpios = <&pm660_gpios 5 GPIO_ACTIVE_HIGH>;
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
 
 &adreno_gpu {
@@ -197,10 +234,10 @@ &blsp2_uart1 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_l13a_1p8>;
-		vddxo-supply = <&vreg_l9a_1p8>;
-		vddrf-supply = <&vreg_l6a_1p3>;
-		vddch0-supply = <&vreg_l19a_3p3>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -238,6 +275,16 @@ &pon_resin {
 	linux,code = <KEY_VOLUMEUP>;
 };
 
+&pm660_gpios {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio5";
+		function = "normal";
+
+		input-enable;
+		bias-pull-down;
+	};
+};
+
 &qusb2phy0 {
 	status = "okay";
 
@@ -503,11 +550,14 @@ &usb3_qmpphy {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l9a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l6a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l19a_3p3>;
-	vdd-3.3-ch1-supply = <&vreg_l8b_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	vdd-3.3-ch1-supply = <&vreg_pmu_ch1>;
 
 	qcom,calibration-variant = "Inforce_IFC6560";
 

-- 
2.47.3

