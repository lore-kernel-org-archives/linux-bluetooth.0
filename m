Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122138F93B
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901984; cv=none; b=PeMevXAfGn76HjpOafncbwZoHrr0ZLcAb0OvzjXBz19cwl7XZK2fcsk/rDYVJiy1O+7/nxuy+kkFAS5lwdHZgoTFroSqFewxbjvb+0Uxqqf6rFG5ix36TWc/Y79EEXqDBmXo825iDx/8JTm1/gB2qS4IAShxOnCfHnFukC4AsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901984; c=relaxed/simple;
	bh=n8BAXFAj+oDCn4RhQ8z2NOQ90wTtinkzV4SU1c/SY4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Je6XOK2Zlg2p+UFyZOTx7ziZMr86NnkG4iWRxySzbKW920mEW1VvJgmG3iZgmxVdPUAoh83AiU6sl+mS+twafv+RxU0HQyh6XhoX+5V4XEs9D9kkTuq1CZx6WbN32jTCrJZid5QOjkLCCg0I47XDBsXqOkTddEB2inFlla1Nm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MsePBlZ+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AVU+re16; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MsePBlZ+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AVU+re16"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586RWFu2833503
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 06:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/7UWcSa7sch199uUm0ihpHSXkTOLrOrU2Q3K/tjsND8=; b=MsePBlZ+U1N9lgCF
	NLYP92U844vUD1wYtSyuAsPUHaJfSR0oRRVeFxzRzhEUt7JpEkblaAj9xyG2n2th
	wCjSB/RcL0cZlKR9o0D6MwJsJ0L1uP4wHUo6TYjfVAEPlxKwR4uIboDS7VyBaGjk
	mLTcXMKsYDmNAkPjg1CR1E/MP3y86PETbOao+3zXWzlqxxkgwwsLC0QGWZR+enEH
	I0mAVS9BL00B51ZNv03jyj1vQ74kp4qbFVKbbvU03RGqp9kfp/VVju3leLhQ4Qo3
	ML6rl/erWJO8/4iIRnRWkPRh3bAOW2pwcqXnTPgS3O8c7L89WhgNUQVbJYzaW80H
	jlITsg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4xp7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:59:42 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfd2462acbso4142361137.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2026 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901981; x=1781506781; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7UWcSa7sch199uUm0ihpHSXkTOLrOrU2Q3K/tjsND8=;
        b=AVU+re16EWAF0Oa4PfiOA06tUaphi69TeDWtn2AAJRwEnrUlBrFYO6RFyn3CnxeWIU
         EMhJ2kfElAH60+r5+YcAuxCPnsnSJL9c2RilBr4fl319uwkE1wZk71+fYzdvxxj2/Kr1
         AVA9MGZlAQcPGrkLS22Plb0W9slxaelqLWC3se0U2f4Zu8sQH8n0xD7bfXho5a30wQ5N
         gKWjHnR4+wyMAFrnfAjem2G4ahzYdidVHjDxOlfhI/TkIwW9gkRRkPimerFY24KACnJO
         6JDol/4W+2+WrjBmgQ+gkRLftjy4Z1rfTH9u9kdmWbMfkzEC/PwI+zy5eIW7V/BlNng0
         0Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901981; x=1781506781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/7UWcSa7sch199uUm0ihpHSXkTOLrOrU2Q3K/tjsND8=;
        b=ZhWtt+k8FL00uXIA7yV/iR0gnzokrKP/I0IrbCEhaNhMOkLBJV5M/ldVvr4LpEQ1ZO
         g9eG3N2TUkCzDTf3qmqeFh+TWqoOWPoLu4OlAU3MQy3a4cEt4rfhtQgQOB4ENR0Dc1Uk
         yfuSnohaBHNwEnqWIT943ex82+DuzNiIYc9oVjP3ygD4EQfSMcFMgmpJ1KOh7mUuIB78
         qpJJXpseFHDrgRRzqySqzVOptEd1NCfwNbLfDpedR21oU775BqyJ7DzskoSpc4P0rt3c
         BNToTSJPfvxbT9VmhcqXxmKGY+cbfmMmXW+StVNuTw9P4OwIJciMFpaV9Oaa4mFRvqQ7
         vS/g==
X-Forwarded-Encrypted: i=1; AFNElJ8ZHfubGU16fwpGdS/WWkLo3Npn1rW1l4+x/prqbLEY+ob2wauHdjfbunFys3KeKfti40+yR/Od3q0/1hGBM5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQf5+RsYBlmDQXb1h8iNBY6/i2WkVxSzYEy7M3LYANPQd4V+Jx
	sCKn8vv82EVofQr1+0eVgRWwIPo7Flw+SccvrUEyJEP2IAQFsDlNootYknTfPD03I+NDZw6jR97
	W/PSQ98cCxveRyo6OaikrhgcR8AO2Cl31DGiOEvqn3MovujE7W9/cPJlB2D/DZVOaYyrXbHM=
X-Gm-Gg: Acq92OHwqfSebzD9FJs3A2JGAZH2Gpen6th9VTlqjscq+npxT7g+rHVeQmT13PncmhG
	k2PEtyHKoTCCMhdxax0aM6LJzpcM6eiYtcfgddhzX+8rr0uLwyspyM8/gWR28WFr0OsDIc4bir0
	YoEmlf06uCTcwYD/iU9h1FcUYIOvHJwEnsc6nzgCGiW5v9UmXTjMbyNGQg1JGp/dM6U2uIk0qL4
	wp5IivVvTYGqFGwzkUtbLybJ0LCtRqboxBN/DTNi3yEuk+6IPQ2TKQ3g4+3qiAaBBrSspvaey2a
	YRK3Z04HVbugZcBKYg48Jt0vLxsYA5GbESk4ItrPNNX0BO85peG4CgiBRssmmxfZUB/NbKCviyV
	S1oZmbFbV3HqoYoMyEHLo3FNQ2Ugs7XDIYk44TLywOPshAv6+jmXm1hUJhvQdTOJNyVYsK3OJdl
	bx2IecmfNouYEsnMO0iESkKvJuQHrWSOYA89T2EKp4yo0Olg==
X-Received: by 2002:a05:6102:5490:b0:6d9:a889:13b2 with SMTP id ada2fe7eead31-6fefdee84d9mr6614177137.11.1780901981548;
        Sun, 07 Jun 2026 23:59:41 -0700 (PDT)
X-Received: by 2002:a05:6102:5490:b0:6d9:a889:13b2 with SMTP id ada2fe7eead31-6fefdee84d9mr6614147137.11.1780901981146;
        Sun, 07 Jun 2026 23:59:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:24 +0300
Subject: [PATCH v2 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-6-efb68f1ff04c@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
In-Reply-To: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2866;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=n8BAXFAj+oDCn4RhQ8z2NOQ90wTtinkzV4SU1c/SY4o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhLpooe78rWUM+pR4BQH6xXBSOcSM/trlgR8
 7p27ucqN/eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSwAKCRCLPIo+Aiko
 1Wi2B/wL9YzaoY4qmodagukhZOgdXJIhA6Y1QNMMx/Va60ooRz8YLt4QW9aOMDXUsOFPoLa+U94
 XGMmnat45/qKU/rD95roVjE/BrtRvsA83alds5Pw92qaatXP5HGdcyZshtqD9v9dYyp5tVnmLkB
 jrWSC8j3g1Omxut44iWRiy6laIkRAR5O+JZoEVYqksajmAMmaPGxK6iuwV7INO439eRXeKu+9lp
 FRg5VGJff6rHF94spYK4CBnlSV+CKQJA2Ow+iMkJpMN9oOKFjNSPu23rynyScf4FwdMmcCI8ey1
 Q5Im/Iway9vmYQRKRL/dS3vObRmxszVEGx5OzDrTZ10Ztks8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: rDLST4042U775gWCJWSWObft25KIqa7x
X-Proofpoint-GUID: rDLST4042U775gWCJWSWObft25KIqa7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXxuj9Un0zqPpn
 GMdpfTdDINp5uUk8GMsm8Dn1iv4dSCXJR5ygFFe1rxGKj55F+jrfDbYSQnTyXOKZikXMPK2NxEJ
 9GPJIzyXPr06H8Be/D3LC4dU+Zk0CMKAF6/y/3dOAiHq85bVqEVflekU21AshQMbqamJf8mvXUp
 gD9b9rweV9Hz6XUlJgR3yJRteV5HQj8psO7oRNL+Mdf3FdmCvUaa9BfWouJJysOQ7pratxio49S
 EAlUc6Lfidk0QCAPzXjFc209zHvtiNUFxUHgaPS4Qja9ZGTuPQqMct8vgc9M5kBalZSb6Nq5DX9
 /HvaJ6Sgt8P8N6b1AfWTMsjiOQFLlx9SewyHoOamq9EaTZQD75q/5B9AkdDx3DYrbog+TQTswbV
 toWAgmRpMUeEp4M+xVP5cKTO1KG9w6M1Cf2a6GxY2OZ+ieAHO1SkaUR36+5QA4UgRwmnTrTi2Wl
 Ynv1H8PKnMXUgTEYa2w==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a26685e cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=a-LFHBoeUMMLBGfzAX8A:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

The recent suggestion is to have PERST# / WAKE pins and PHYs in the PCIe
port rather than RC device. The kernel recently started warning about
the older style of DT. Modernize DT for SM8350 platform by moving the
entries under the root port device node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 18 +++++++++++-------
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 12 ++++--------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 5f975d009465..4973a3eb11b5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -493,12 +493,14 @@ &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_default_state>;
 
-	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
-
 	status = "okay";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l5b_0p88>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
@@ -507,15 +509,17 @@ &pcie0_phy {
 };
 
 &pcie1 {
-	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-
-	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
 
 	status = "okay";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+};
+
 &pcie1_phy {
 	status = "okay";
 	vdda-phy-supply = <&vreg_l5b_0p88>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index eb2a795d8edb..136daa444865 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1583,12 +1583,9 @@ pcie0: pcie@1c00000 {
 
 			power-domains = <&gcc PCIE_0_GDSC>;
 
-			phys = <&pcie0_phy>;
-			phy-names = "pciephy";
-
 			status = "disabled";
 
-			pcie@0 {
+			pcie0_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
@@ -1596,6 +1593,7 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+				phys = <&pcie0_phy>;
 			};
 		};
 
@@ -1692,12 +1690,9 @@ pcie1: pcie@1c08000 {
 
 			power-domains = <&gcc PCIE_1_GDSC>;
 
-			phys = <&pcie1_phy>;
-			phy-names = "pciephy";
-
 			status = "disabled";
 
-			pcie@0 {
+			pcie1_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
@@ -1705,6 +1700,7 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+				phys = <&pcie1_phy>;
 			};
 		};
 

-- 
2.47.3

