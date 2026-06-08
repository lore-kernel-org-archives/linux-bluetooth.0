Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004339B949
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901988; cv=none; b=shpTGcUCzkFFYNe5PYstS0XJ+UaQSrKUeRLh4/esg90LQXe37iQMRMXJHMc5xtumOvf7ibNXGqeFwWdyXNfnUHLraTd3uQI7lkO0eP+9NpKO9m7BA8VdbmUYwa0j9f5wk68fLqKcerJ8coa6/aU2l8ce8TapEf2V7KZRFNnhKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901988; c=relaxed/simple;
	bh=ivfez+E9B3qAfRh5L70SB2bSHUzO4GoveMoTJ4pZ8Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntsZuHz+ByI0Aeq5HsfN1KPigH3Aw+rDLBXeMndTt2tYSmE+VKtpwTcuObt3NF2Mf2QzQ28Tvf5ows7Eu5tpJpMA/jGvAQ4bUKJuEvijN1b8VgNkOUdrTsbzFdcx91KZHuaDsDFr05Ou44MfKLzGKwCb6I6zZrJBKPeg2W/fm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLwKCEW2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WgjoX0pl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLwKCEW2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WgjoX0pl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PLUb2834629
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 06:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5UUGNkY7j3/4zh2rLPHPzZHPlPL1HtPoB4XrZlt6ez8=; b=gLwKCEW2PQCeQqva
	NS9QXhcWMAFJYCt3Ee6FPAJqCW5CTFsfrMtgC/znIDmEHt/IZyEm03DkAA5KGJ/1
	5/pRX7IO5XHkSXjmiOu9qYe6De/Y93LzCYg1xbo9zhYga7NksFr1SWrpm7gn1y07
	uRSPpNt6EAbmOFdnTPnou1nwDppjVJjafGEa23+o/r5Kb6goroP80DimL/E88YXD
	W0Q6Sn+PnZHootbHWjf91m2/DOs+sBrdxV40ituPeG2xBOxjY+6/VaX8Xm48w/T6
	2pollpjB1KvahgeFe+4v9aHCG7Sny//Yum1GzNiIYsgq3t4fmkROSc6ohANdv0oJ
	+sNNSQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmreec0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:59:45 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cfd2462acbso4142396137.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2026 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901985; x=1781506785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UUGNkY7j3/4zh2rLPHPzZHPlPL1HtPoB4XrZlt6ez8=;
        b=WgjoX0plvX9hDxG+KGeXkihOmxiUmHoHjT/l5RBzxHYARojYXvKMx3Iue23CZ9aj8m
         FvxZcP7BKQq7b3uGiwVfLrnXUY/7s3jm83WVMPgYiBGchLJ+NGP194oy7gS35oWRp1LI
         Av+hCJaSDI7fqGZHTamj73mWYZ8XouZPZO8Bv4TgOuWp+hgMoxNUoDPOzmIy+NJWuHwB
         wSX5qkN0lZL7+X8GPEcokP1XovCrnWxAaK69i53k28GN/rS7kMH8E2IRECCUZp69Ttbi
         /IcYmHVaec76cYjFDxAjmB57KNNX4Rlvf7cQdnKdSU0rhew5svXen+OFrDM5PtNoFejj
         6jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901985; x=1781506785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UUGNkY7j3/4zh2rLPHPzZHPlPL1HtPoB4XrZlt6ez8=;
        b=DYWjZVhg6jlC1Q6I/xu37f5T782ldxrssRIeuqG5ZCvVaDuZXd6gJBIWXgwvEPoLRl
         momu1dcBlclAq6u0P6UkSMYFpcNuKJeoNNNjtDzckGrVI9ViGYvDrdoaO+vsHWNEfjNQ
         jHmu0ElkNuWW91/YoN3D/39dwUS054aghhZp+BZDVTq/zgyUqateiHH4xe3LHnLXhDwx
         MEsP64jASin7ta9nQ2bMlp0cM1kmm0ScCu+kyu5iYkXl6TEiEk3g2CODCb1Qvlw8XG2A
         oNifX2LfShPAGp+sM5hsOF0cS+MtyCHgeHO96lIZND59tNjLVjw2BGQL9y808HnCMsmv
         O5VA==
X-Forwarded-Encrypted: i=1; AFNElJ9liTfgUMi0ITc4MesVjH/5LZVusleROwNL2vf5GfgocjVqkzGhMcpIGlvPOCsRCetVKQeEfh5O255UKkaW720=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwMKRJusq2sAMqGl6hg2NGKyzFEdf6ZOe/sNGvYjiK8GJGvEL
	Z+sW2Ykz7O6HxCS6KbvXayola7THmd0B6/PH1HVUHIWFgGpz8pNh+X/KpdhkPjpcuvz5irVTGLy
	4ou3RH+ctbuQeIfvqr+JJV2QHC9iLk+K1uhmWV9a4QHjNPo6KwWrzCeRx1FZLsgpPROGQuc8=
X-Gm-Gg: Acq92OFpYui4jrlv0fKF+9a7hV5J/C2klXLLEi1Gr75Ql5nqnvPC5Wzno9ZUmsyMLBm
	Amxme8t2uXr/lkgL/lNokyZwYEW8VACWpFkevTLWSeEpjzs+9OmdBTsT+on3LKNZyBVoc+LGCXY
	KSP5Y1dGModclX88DH4KiAxKqbYyK9lfw//4rs7eONB/EvAp1OhwcIFLueocTx1ucqV3gYUHW12
	Gj9zUtchd8J/dl2Hxu3zFKQ+RA6BYOELsC3MDsCxNAIShfkqAj0oOvi7USlvLvPRWMXVIsbPmh4
	ubZaV+2XRdBkyA3rz4Ta+hhgjSNLLXjNLem2zRJecI8FVBv0bmwgKc1WqOWXP9Nh/9SR78lS0dc
	rKsUakFWhH5+qhv4CPoK1Tkdw2HANnwzEdRA8w/mQXW7VdL2AygMObRGL11wyTF88S9B+kPyHzZ
	yEGX88rDeg6M/v7trtOH9F7IULYE9ISFfDpRBuPDMB3hykrg==
X-Received: by 2002:a05:6102:3e0b:b0:6ef:d9b8:88d with SMTP id ada2fe7eead31-6fefc8b6fd2mr7182297137.8.1780901985341;
        Sun, 07 Jun 2026 23:59:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3e0b:b0:6ef:d9b8:88d with SMTP id ada2fe7eead31-6fefc8b6fd2mr7182278137.8.1780901984873;
        Sun, 07 Jun 2026 23:59:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:25 +0300
Subject: [PATCH v2 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-7-efb68f1ff04c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6193;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ivfez+E9B3qAfRh5L70SB2bSHUzO4GoveMoTJ4pZ8Vc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhMuqGfQoyOCl1z0/vW5dE+0jogozA0K9B7r
 kku4lpySs+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoTAAKCRCLPIo+Aiko
 1XabCACw2Bp0Gz+PrGS7tDbpoA4CbJky6pod9M426pAO+JrCgMofF5yNPYfSbJdixO6vvT3t004
 XRNGoysRpBKyIrZCROWXoj8W66wckYFcKMntiwBCl3OZmZgoulp9sfIA4Rj8S+96k77801TNZNn
 K+BpDr+GcMfk3eH46QBM3/5wO5zmglfFTWmIwiQ5l5kb+Lq7f79XetrIglxNYnEPp/NzBLFToJg
 cXIfLqhtff6pRJtjSGY370yRkPgjeW+zV7D43PVBb7q6Z0SAtdtlkIUfLAgDAGGJ/IHUbKsMxb7
 sq1NwizoyGv4tyXrnlNYcGR8MH9VmN0DFZ92s8nFLlGbKCl7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX+sR7301LKXWg
 ZPDZx9rdKhw6cGev3uX/9LBK7csImunvlw+hEWsidAlFITIjQmS7pk0i/00roKuPeOs7LnsBvJk
 gxvywHtdfqUhrkQF6lCNP46ZklRy5E5/kF6rHiP/TK5+RBzGVRfpbYAjn0jdn5HfzNLMIQaTdMj
 sAhQKd7I0mSD8VmxDv7SLJVTrYGRkWsnrQd1O9LpDtFy7WV9pxPFmpKcqhwZrUZk0+B1rMNVU1d
 mdPsdKU736wZhwkmP/84jKTjW6IqiccpcQLQvDAmFMTDcIf7eBNwldwylxzBb2FxldEkAPL8Awy
 L3oPxJ2PwjrzU6GtASA2uvMLsJw+bKW6uGBUPWAZRzcYl5Tj+EcpOzI3rXaGmb6kOcix3ingw3c
 sjuYjb2fvwjZMOX0YhGrf6YEwVosi0Q9QvNGumh5lNo6mQ4mkXdAmNIL8vRR1sfue3GUb2ypj0u
 rXDaHjo8A7HVwHKFnJg==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a266861 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=o9ryCBrv46mMSQ48XGcA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: kUcoBrRbu6W5_ICuyCOWbj5Ee4nv4iaZ
X-Proofpoint-ORIG-GUID: kUcoBrRbu6W5_ICuyCOWbj5Ee4nv4iaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
parts of the device.

The firmware isn't (yet) available as a part of linux-firmware, so it
was verified with the firmware files from the vendor-supplied package
(wcn prefix was applied to Bluetooth firmware files to make them follow
upstream driver changes, vendor provided hpbtfw10.tlv and hpnv10.b06).

Bluetooth: hci0: QCA Product ID   :0x00000013
Bluetooth: hci0: QCA SOC Version  :0x400c0110
Bluetooth: hci0: QCA ROM Version  :0x00000100
Bluetooth: hci0: QCA Patch Version:0x00001017
Bluetooth: hci0: QCA controller version 0x01100100
Bluetooth: hci0: QCA Downloading qca/wcnhpbtfw10.tlv
Bluetooth: hci0: QCA Downloading qca/wcnhpnv10.b06
Bluetooth: hci0: QCA setup on UART is completed
Bluetooth: hci0: HFP non-HCI data transport is supported

ath11k_pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x605fffff 64bit]: assigned
ath11k_pci 0000:01:00.0: MSI vectors: 32
ath11k_pci 0000:01:00.0: wcn6855 hw1.1
mhi mhi0: Requested to power ON
mhi mhi0: Power on setup success
mhi mhi0: Wait for device to enter SBL or Mission mode
ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x6 soc_id 0x400c0110
ath11k_pci 0000:01:00.0: fw_version 0x110c80c8 fw_build_timestamp 2021-05-25 21:43 fw_build_id WLAN.HSP.1.1.c3-00200-QCAHSPSWPL_V1_V2_SILICONZ-1
ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0

For the reference, the driver looks for the board data for
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=0,qmi-board-id=6,variant=QC_8350_HDK

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 126 ++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 4973a3eb11b5..8e35216e4272 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -115,6 +115,70 @@ lt9611_3v3: lt9611-3v3-regulator {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b_1p8>;
+		vddaon-supply = <&vreg_s11b_0p95>;
+		vddpmu-supply = <&vreg_s11b_0p95>;
+		vddpmumx-supply = <&vreg_s2e_0p85>;
+		vddpmucx-supply = <&vreg_s11b_0p95>;
+		vddrfa0p95-supply = <&vreg_s11b_0p95>;
+		vddrfa1p3-supply = <&vreg_s12b_1p25>;
+		vddrfa1p9-supply = <&vreg_s1c_1p86>;
+		vddpcie1p3-supply = <&vreg_s12b_1p25>;
+		vddpcie1p9-supply = <&vreg_s1c_1p86>;
+
+		regulators {
+			vreg_pmu_rfa_cmn_0p8: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn_0p8";
+			};
+
+			vreg_pmu_aon_0p8: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p8";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p8: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p8";
+			};
+
+			vreg_pmu_btcmx_0p8: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p8";
+			};
+
+			vreg_pmu_pcie_1p8: ldo5 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo6 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_rfa_0p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo8 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo9 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+		};
+	};
 };
 
 &adsp {
@@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
 			regulator-name = "vreg_l7e_2p8";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
+
+			/*
+			 * This is used by the RF front-end for which there is
+			 * no way to represent it in DT (yet?).
+			 */
+			regulator-boot-on;
+			regulator-always-on;
 		};
 	};
 };
@@ -499,6 +570,23 @@ &pcie0 {
 &pcie0_port0 {
 	reset-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+
+		qcom,calibration-variant = "QC_8350_HDK";
+	};
 };
 
 &pcie0_phy {
@@ -763,6 +851,20 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
+	wlan_en: wlan-en-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	bt_en: bt-en-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		perst-pins {
 			pins = "gpio94";
@@ -815,12 +917,36 @@ sdc2_card_det_n: sd-card-det-n-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	swctrl: swctrl-state {
+		pins = "gpio153";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
 };
 
 &uart2 {
 	status = "okay";
 };
 
+&uart18 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6851-bt", "qcom,wcn6855-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &ufs_mem_hc {
 	status = "okay";
 

-- 
2.47.3

