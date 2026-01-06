Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5152737FC
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661280; cv=none; b=HU/HkUO5UTQWjkZxcE+rjJi4PWe9H9DJtMw/XIpbvC4N3NWsZbtMcns9hVY6sZiDWw6ZJ6+ALtJeUPqMTbjRAKBOxKooFPYbdIXEZxJ7LjP8n8nn6PByUjXIM2YgKPAe/I5ZrvP0J7ZQPaDiYzPbSui2nbDGUp50C/JeEvnR7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661280; c=relaxed/simple;
	bh=CIG0Is9FpLut1uuuiBQ9Ij+nmpKB6QNbq141HKGdsi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s+b/XFv/DCkige/foAQhKmt19FUwNqzIVCP2rCYuxUrJzJj2iDeLG7mJImrNOGkSur76HYH7zRPf1tbkiXkzJLHcM/GGJMTjyYQkgaL8+sWJId7PVpxjgLzw8bQ1hNiDUQJuNLOpun6G5UTBSXW7sgzLpzaZsTsT7KPbFVHqVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SweYJe5X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eq+9044e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SweYJe5X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eq+9044e"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nwdo2727189
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 01:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CpE/A+RJl29TLk93kJv/na
	TvWiBqJr+zO5MsuSOsBCE=; b=SweYJe5XenberV8rWMUSd9F1lZRZF52w2E+hit
	vttKHo8Q00sCJgqPY4h/G1U3PVr1sKAIfZTpW42CAmxy9qLc6loxMLP1kD82OGXt
	xdILxzdbWjHJQIQvxDFkcHY7qfPFaOKYfiKzEtzPOPU1Rip8wFQ1aMp5ZxIbZpbh
	TONH6z++GlXv/KPm3o7gb+1LTLReQwSLN7jiP/+Vcl4FJamfVlC+RKG6zWfIVAak
	BHiVtWSSuptai+GHfEya8f8O8cJI4uQHa6c8+xAK+9dvvyB1RnEoXerw5mRpyQuv
	5+woCTgu04Qaflhn1ii35/AdtivCafHGZwlRZDQj+sOV4pGg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpn9r6uv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 01:01:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed7591799eso10190691cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661277; x=1768266077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpE/A+RJl29TLk93kJv/naTvWiBqJr+zO5MsuSOsBCE=;
        b=eq+9044eipxqy/bnD2GP8dPYtqbsbXkWTTv8ImTLc73visksULS6qgKoYq8x8z68hW
         5+31HsYU7MAYAUKlpXu9YpC1nj+BfPu1kjdRstnt6XVKOnb/s+KiuX2ls0TqA/EK9fpr
         ApqbcLMvL+5o6XLg1grJJPW2yzvuzWerSi2+gVaBAw9Rjl3FP+tCvmmlc9e7MldRtfEW
         bk7J88P01tEgFgYcOL9IfAjEqsQp/MmlWzzFqluIuWg3xhqaXvDtDJILCjj1F3XVcU8V
         0q7PYdjXxWmhTRwfgwoI943V7Y8GE2qwDOZ9bmAQUvt2Gq187/RR9ErglMNfgXLRzV0n
         LU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661277; x=1768266077;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpE/A+RJl29TLk93kJv/naTvWiBqJr+zO5MsuSOsBCE=;
        b=IxlfqpO8ciZwyvWyzS5ufAzwxPuoLxNRcJsS2/IC384vz2VoyTZAbCRUPsIV98WIV8
         a+khgon7SxLoPYFSc2BGfs2RHmqxbCJugoNi/fktCJwAQ1sFOKu59C2ZDduwdWOHC8mc
         mF5tySNhUOfWt9Oc1AjKRsOrzEAciWaK+g7BAgJ5G+GDMU0g1soRDt/9gk8K9t19mQFg
         Juz5Sp+w7HHpMw/rd0gW0GlSunts2O5S4Pmiq+umlq9icCy43fjTbWtK/XstByV1F+iW
         LTcdSvlAyQHxQo6flmPvD2jCI4DcO8iogc4PfXY1poBQGow40YiiE9yBkJGdTe0sEDQf
         DzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVryPRqvf2nccm5/YchaDSXPjzU/Bb8r/vz/8ZLkxmp2+XqhrlTZeNa921ySHBEfuyyrs8ZKcc1kdUeg/TdB3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1t7XUyOM+cP8lmjR5pkH/AKspAa/HsYic8Ud1q4jFKD7d986G
	RpqO9lmzd853HOyGLIDMLcIV125EjLddwgudeDPwNP5GboGwDnPoOSGjkOAGGR7jIAVc5TFW7Du
	HVFgBhzd2p7YeplxUAx68sPk5iVnF2oD5RZ3fSLp0ZS4f8Zaj+AaHzDOQJLdw8aNJ5B1KcPY=
X-Gm-Gg: AY/fxX42fc/xTCEA+/+2lGMBo1wdf+QlbGMDR9Nfla3Q41JStvgBgq24AkX6yWPU5+V
	ZoMI8Mb+3qgSXdHvdbxS9GawjTmQeKZXMm/0br82Zx1ctN4zvp+a7kFckLzd1Tamdn5SKSukZHy
	m89XhDqbuZ2nzgzgbGfsu0LW4Zlb2/IyiulR/iDjMlMuYZFmIanac8Ny1QE6uxJKbjgP1sIlZrM
	jYVOUPeiVBrUIsDf0It2aMrkr7HUnLlVUqwfTYRf/7iwOjuTAxxPvQnvEIFnoUpiOQIanvorpnp
	MnAZRMt8iM51NDg1P5fon5Y6PjTuAzFW5tVIx6y8lc+LpOcMUgQHbWM7rwfk/S+fbaNOQduCxtq
	Kkp/Ch+SFho/6JB01lvAYjdbTFGja1qo48QtWGAOhBwqTrx+daqD2acEl01st7bbz0VO6xcj2aT
	4oIbuQLvtKAxfnQVVCeOwAnwI=
X-Received: by 2002:a05:622a:11cf:b0:4ee:9b1:e2c with SMTP id d75a77b69052e-4ffa76de52amr22746381cf.33.1767661276606;
        Mon, 05 Jan 2026 17:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoPcIoXtZ5S3sACfb6AlbO/bvWBixeg6CDOT9VqCG7O0cs7fHG9tI8NmT9nXBGmCXl0qhHmQ==
X-Received: by 2002:a05:622a:11cf:b0:4ee:9b1:e2c with SMTP id d75a77b69052e-4ffa76de52amr22745571cf.33.1767661275935;
        Mon, 05 Jan 2026 17:01:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 00/14] power: sequencing: extend WCN driver to support
 WCN399x device
Date: Tue, 06 Jan 2026 03:01:10 +0200
Message-Id: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZeXGkC/12Oyw6DIBBFf8XMuljBR9VV/6NxQXGoJIoK+GiM/
 17UXTeTnMmdc2cDi0ahhTLYwOCsrOq1B3YLQDRcf5Co2jOwiKWUsYIsQsdFEZFhMcK1REieJbK
 oc5o9wB8NBqVaT+GrutjgOHmvu5bw5haJ6LtOuTLQuLp7x61DA0e8Udb15nu+M9MzfzXH9L95p
 iQiVMqkziKW8zp99taG48TbQx76AdW+7z+G70fn4gAAAA==
X-Change-ID: 20251229-wcn3990-pwrctl-cfa64f9d8167
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CIG0Is9FpLut1uuuiBQ9Ij+nmpKB6QNbq141HKGdsi4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7YalStl2pZB8CIWM7xWNVMoyMjk4VhBVVLW
 r/nqGqZmJCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2AAKCRCLPIo+Aiko
 1Z7jB/0VmTg+9TxqCA3shr2UhDZ+pWcE6JzPASajt3+q8+WTb/DbAFIE4bO0En5q0Qts4XrLyue
 5Wv9S7gcT8v8cCzMAqupR3c66Xgup9gOhlUhOc+Eg7kN8sM3PIlK/fT6MplmL4arM6HnKUAMKrZ
 UpakFjS/+uZlFbZfZR/QOkdwe3BIU280FXovJ3DDfpnNdG/CvFEMK6ykujZWhFpenT+EDRUw7Om
 E8fgRuD6g5VuSjZtMIz0mqxws954yB3UMtsL8VjB2ddORxCxHERyvaVBOXfmdNCMeOqExxd9DcG
 sY8QTJhCxpPrZhMw82Ks76WPSS4pOD1B/cyCbcn+th/MwyXx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: DsN_FeNkfvgtuVRf6PCpnEtTLb7538YY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX7cTXIDfkIJlj
 Likzoq5Jx9fMM6qq1xRPs3BAPAMYy7XbdSIWYBwOcpLeVkMkQaW2KQYRnEXEA3RpTN6xJp5pYXW
 T+ID4sPUu8/g8i7qW27xma1U9s0TSPwGw7cX8GpDnj77rafQwsy6o+ozF0X506Qefh7/9vqr/2O
 rtF2dHBcsvHkho8nQScC6j1odQLPqGbJWNtAM0RCxyU8j+fxvCpgPxNBrb7g7adxeIL/M8Zvoob
 LVdGMqjkcfAi/7slCfQ1sxv1eDLDdTYAWxfkigK+OZ3xsNVY4nMiqVLFccKWNvmCsoCwDJ8K88+
 cuskY1N/d9f7G+vPUFrl0ObJIVf1et4rIyT9tG34J+7GX4BnfMka/1k7v0umcf2vRJfnHEs3szs
 95xCHkvicp7M9937CPA54fm2DfKb/ZH3zxqsDZgd8eLgaeKKlXN+ZjGo+1AW6U5C7zpQkg+Wktx
 324iuJaLl+f89oDoRoA==
X-Proofpoint-GUID: DsN_FeNkfvgtuVRf6PCpnEtTLb7538YY
X-Authority-Analysis: v=2.4 cv=KfnfcAYD c=1 sm=1 tr=0 ts=695c5edd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OJCnd7j_un46Nmgy12kA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
the later WCN / QCA devices, but they still incorporate a very simple
PMU on die. It controls internal on-chip power networks, but, most
importantly, it also requires a certain start-up procedure (first bring
up VDD_IO, then bring up other voltages). In order to further unify code
supporting different families of QCA / WCN chips and in order to
maintain the required power up sequence, properly represent these chips
in DTs and modify drivers to use power sequencing for these chips.

Backwards compatibility with the existing DTs is retained by keeping the
regulator&clock code in the drivers as a fallback.

As a part of the series I've converted only several boards, verifying
that all known instances of WCN39xx family works (fixing the issues
meanwhile). The rest of devices might follow the pattern later.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Split the WCN39xx PMU schema from the qcom,qca6390-pmu.yaml
  (Krzysztof)
- Expanded the comment in the WiFi driver (Bartosz)
- Changed vddrfa1p3-supply to vddrf-supply.
- Link to v1: https://lore.kernel.org/r/20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com

---
Dmitry Baryshkov (14):
      regulator: dt-bindings: qcom,wcn3990-pmu: describe PMUs on WCN39xx
      Bluetooth: qca: enable pwrseq support for WCN39xx devices
      Bluetooth: qca: fix ROM version reading on WCN3998 chips
      wifi: ath10k: snoc: support powering on the device via pwrseq
      power: sequencing: qcom-wcn: add support for WCN39xx
      arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ storm
      arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
      arm64: dts: qcom: sdm845-db845c: specify power for WiFi CH1
      arm64: dts: qcom: sm8150: add uart13
      arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT properly
      arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT properly
      arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT properly
      arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
      arm64: dts: qcom: sm8150-hdk: describe WiFi/BT properly

 .../bindings/regulator/qcom,wcn3990-pmu.yaml       | 100 +++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  60 +++++++--
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |  62 +++++++--
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts |  66 ++++++++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  75 +++++++++--
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            | 141 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   9 ++
 drivers/bluetooth/btqca.c                          |   2 +
 drivers/bluetooth/hci_qca.c                        |  26 ++--
 drivers/net/wireless/ath/ath10k/snoc.c             |  54 +++++++-
 drivers/net/wireless/ath/ath10k/snoc.h             |   2 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c         | 130 ++++++++++++++++++-
 12 files changed, 671 insertions(+), 56 deletions(-)
---
base-commit: f8f97927abf7c12382dddc93a144fc9df7919b77
change-id: 20251229-wcn3990-pwrctl-cfa64f9d8167

Best regards,
-- 
With best wishes
Dmitry

