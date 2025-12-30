Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FF3081A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137790; cv=none; b=Tg8m16rbc6FukBgDzxDu2W/UrPW5KQX34QVd2zvoOzKQO2RNrTVTkDM0olfzr1VWuA1Sp3gENWp2wNQ4+ojhx8pFriqDoquDx/R2TFxPEoljSh/BBfO7xrIcNirJVn/Sgi7an8fAfWka9VHplUx8ac0mfL7Ib2GL9lZ6nvrnNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137790; c=relaxed/simple;
	bh=qL2gflnvdXT8Zbuzd5RGVdiolocJMGlxF5D7JlkGAxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WonNoamV0zw8Z2bQg0A+trFHcUyVDDA8h9Cdz9Zgm2Utb6Ut719W/IteZboSWLRsDYCYIHg2je0haWlRbCERNtoYiws5VX4s6sb72fyUX+h0hg2BH3KW/AVREF++xGN4xO5Rp1X3cSCWGXUXP8kVyPQDjS7NDJGrvaMv05/AM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OiGDmxlV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D0UOOK6T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OiGDmxlV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D0UOOK6T"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUKkKbQ2285911
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6nyMn1t1Y4sxs8foeNzDrA8wjI1gX3B3sgRPx84ReXk=; b=OiGDmxlV2tjiUDhe
	L8MxERLL3hL/yukKP5G0D3MSe4wjEPiYiShunx7uXJLkpW1cUslI7OoZMpE0O0tZ
	BRAaX4UCcy9mQCyVW3skcDhJQy187h1yY3q/X8jxC4krjeqdyNQQvb5GjzzCxt3X
	I5BwyIS+6gtProl1j9QD+agQOCpKM0PoqIIlk3PJBJgpdttAtesOo41cYBhSXOW/
	PaqEylB/9mT2/v6niPo2wsItC4PBoGCdPt8yseV5hURzOTSeito5YfZl5rDcrNvt
	rS/oJBODJaO6ImO7nsD5b+F5OkiCrHLloFFVRZGy3ypX6QWZk4UpH/jDYj6urbM1
	AFvx0Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc06gu693-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee09211413so274354011cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 15:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137780; x=1767742580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nyMn1t1Y4sxs8foeNzDrA8wjI1gX3B3sgRPx84ReXk=;
        b=D0UOOK6TISCsi0q4NaWS+VDK4OV/RvSKufb1G5A8aCZbOMYfCmE/i/Qf33mxZc1YRP
         sCOCtJdh9WSJuZolHmSkctc+/DuKiNKQHNzCSlvp2M9oCmM7zKP/jBr3y6rNOVfB7n5a
         qhukdLC7jPMgZJcOHKJ8i32+XEwWB286fE/e7VQw2JaZEUF6W1xXgmLfsCAtpK141Nho
         RnlVwc8hJ/mYI9CsYt0hFkCmWfNdhHT2ACzHxnPsaKtjP+bbYPN/UUdggRmK6rWWDbGn
         YAbgnRIZK5Q4D7dNX+C3cw2DmegOVJ2Y8fmZVgudRNaBmgnsZosUGg7G7pWLuP4fXra7
         z40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137780; x=1767742580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nyMn1t1Y4sxs8foeNzDrA8wjI1gX3B3sgRPx84ReXk=;
        b=q2hsymEaRPCTS0MdXFdHBjbZFaIgd4bkT65LeY7k6hc2TlYPYgdCG2gMbTtgqP5etu
         zRihkMiIE2n5oxS9vxpfAfoKJiOgxtg0XYdiP39i6qelx3KBkpTXzaPBM1nQ2vwUzysr
         YJN/GS6DFqvfPDvdnV1H//iHz2dWCCpzRfMFs/yzhA3/aMuJJG2H0C2c61fzXvED+M+g
         Ajt0hvlduLE2O4PBBgYhmQ1m4ck7oOub8ikgMrBV/M9GSDS+suREGPbvJcCtN1+tvIui
         sakVSe2iTJYYcZMjviQkHpBjJ9qzg8L67+VhyLTccLT/E95fh/ZpEDBfouGYbqoSfj/H
         9kqg==
X-Forwarded-Encrypted: i=1; AJvYcCXd7a8ttwK3qeWYaWoiRIYCtv+qRfnH/8mwB6fsJTA2oxCQa38spPsY5U4zPJXpV1ISfXpkB2b4qJehBlzOX0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVaBSTBfwF1OLZ3/QjlW2x4BmWT9apF1+BKH7ZPKDrSmbF9n3
	mW7NDJ+VEzEcMAfLJAZWHFUXtn9N6ylR4tXJNogIj9HQTxxpj5YXdOXqicLUIVol44RIJmqmSja
	0m9VcSJZo9A2GEMAZsGFoxpTYiKlClHft3dGFZJCU69asjmPwNxyyNSul7exp05qtoGKWsLc=
X-Gm-Gg: AY/fxX62W79wybNceqhE/UAhgSq2xuXPJ6t6u6nTUKThWguK7ihS+OzkCf7ezN8vmYc
	8MpFML3OnzB9v4lubk7MPY6l6CU3VOls3W+235Wqa3u3oDjUst7oqURk+KWowGMBjzrPrmkRzeH
	j/zJNt5wkZt9Er5+qh5UlGzEXeZ8wFkBpVtQp5mayho1+V4TLWuN51loVWp0dkjKmeJ99P1BYsB
	D98zEEZwt5XNNHOKrMgtH6ijC9conBX6Ls73x1Uva/YKXozrQUx3DDW6P0xO+Js6uWjStlrWajT
	CIBYqte+j1qkWwtx/LAl8c93KW+w0MmGqBQ1SfbgGQprf9CUHkIaqvsEAWQFsVM1/KebpVdp2ZX
	keMNH25gDCj6J52OLONTgw97h+a7osNYv7gvqI4u5qIUN/Av8fDvQQ9qu6tXin89cXOlcBjmRMz
	j1zQJEIQECJxQlrtDe1n9SiYM=
X-Received: by 2002:a05:622a:5985:b0:4ec:f791:738f with SMTP id d75a77b69052e-4f4abd753b4mr496100091cf.49.1767137779939;
        Tue, 30 Dec 2025 15:36:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnKOZyeFtAgzQwkf1IH0VQkWAyjQ3jiu/gxGz7mjyXUaQfJ69jiH+MtKxkffEKCn6Vhg4YMQ==
X-Received: by 2002:a05:622a:5985:b0:4ec:f791:738f with SMTP id d75a77b69052e-4f4abd753b4mr496099691cf.49.1767137779523;
        Tue, 30 Dec 2025 15:36:19 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:00 +0200
Subject: [PATCH 10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qL2gflnvdXT8Zbuzd5RGVdiolocJMGlxF5D7JlkGAxs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHl1eArCTGYcdLB/w99f7QscISxVzq61zkxb
 TDUbk1iPmKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1ajxB/9mlVj65pIRt3vIVHArpezX02P5FeMTN2z9Q/aE0QAW7jBIc2fPMZO4rTFc1MEG2f7ziHv
 CbIlbTiEXQugG2FXreSW0nCtkTYM4YlMp9FDTIGeAodRYOo3ljK3Scb3961fEvRhkdGIVFIvDOT
 7GpzzfyjWOv6WQ40TLbZIQj7IlT3b9zXGU+N5+4tH0Sn9V0U+ZKxqBQKnyPpOfZD+csJ+XkMOfw
 PLXkZTGE5WcGZHFM5LDry9IWU3uJSgjTuRPUGdSg53rMMnptXcuA+Ih8mrUyAHcBzZv6vMJh+MI
 ep6tyvA4bXNcK1zJ+bXzDrXxwthkK+kt2OlokoJ9Yjyk1oWd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Ca6Mg3Fe6HksfsrUXeUuz_PfM__dnHG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfXyE9oyzF4+NXs
 /cGg7kWAfcVo/zeEr0t05o2+IG7x1BnWBkgl9QNqa2tp1Tl4XR1VrfAHv+GXn8ju0qsFIGhPPV3
 LJPTj47DC3AtMu0lRoY9o8s+ZkvVys3wR8T946D5sncoEH2jS0D9VvRwY6/smoKHITeNurFNRAR
 mVIUZAWZFXVqkH5eStvlguESw6obaaWyRzlhmeNlOLUj9T2Zr+s8Y/tkQdqQvotfirqPLYYukEs
 30o0++74AnNPbGqyzPANskhwlzFs5Jg08Vp+aGFi2BKS4ELLAHYsi2HqJs1T8frumR5roRod8aY
 HKZqxqX+cT9Ohg12KI1CFRMX5R8tGqQJ43vJnipSTBucp2QHNUSa/u7R04tT5PT43ssbdCJl3jA
 LDlVwhvIGpnuiL9F74KUjG3CjVoLu1eYcKNeH6UTwHABMeZSi9+XWzLX4islIdWVhxfH37OMhqE
 H2Kq6/y9Null4Dmrycg==
X-Authority-Analysis: v=2.4 cv=A45h/qWG c=1 sm=1 tr=0 ts=695461f4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=e0lpCu-zAayEtEefm0IA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Ca6Mg3Fe6HksfsrUXeUuz_PfM__dnHG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 1b9ca957a94b..4501bc34357b 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -235,6 +235,42 @@ platform {
 			};
 		};
 	};
+
+	wcn3950-pmu {
+		compatible = "qcom,wcn3950-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm4125_l15>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrfa1p3-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
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
 
 &cpu_pd0 {
@@ -679,6 +715,12 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio87";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	sd_det_in_on: sd-det-in-on-state {
 		pins = "gpio88";
 		function = "gpio";
@@ -714,11 +756,10 @@ &uart3 {
 	bluetooth {
 		compatible = "qcom,wcn3950-bt";
 
-		vddio-supply = <&pm4125_l15>;
-		vddxo-supply = <&pm4125_l13>;
-		vddrf-supply = <&pm4125_l10>;
-		vddch0-supply = <&pm4125_l22>;
-		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -759,10 +800,13 @@ &venus {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
-	vdd-1.8-xo-supply = <&pm4125_l13>;
-	vdd-1.3-rfa-supply = <&pm4125_l10>;
-	vdd-3.3-ch0-supply = <&pm4125_l22>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
 	qcom,calibration-variant = "Thundercomm_RB1";
 	firmware-name = "qcm2290";
 	status = "okay";

-- 
2.47.3

