Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3037CD40
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218721; cv=none; b=M7RIJmovxGkv0AFz/rBVcvpjFmoNBWoJj+teIVgDHFw35MhA7sGfyd8zbfmmC6S6ZIOxNzdx0M46DmhHX/rNT6lOpYlXqIjXhbKnV9n40wQTfKUCLEacYGdIQDlZRsRq1loexA2eP9kpnspd9zaGeHBsZDoK+Kf4Yt1aw9S+kGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218721; c=relaxed/simple;
	bh=axJo0QsdmJg35RBqGTfo/6nxaHHL0FSyQ0xk2oeWY4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCu2EnVjTVA2Q/aUX7mB9EAtokHZtUJwV8nG0ZrUruj+lKgSPt25IIGrwY47J4DmOdW9iuNIc1QQhxlqCiF+DQB8R83jIFMd/0Rh8D6JBBWO3Udwo2NDhiIW4R0aC0bQhNQl4e4I8v9xU2BN6HlBunHyCws4uEfvL2rANKbgIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZhImFcT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TdzOILi1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZhImFcT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdzOILi1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDKRNT2857920
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=; b=YZhImFcT5m2pF49g
	syOvP3NGIYqkDogY3x5jnadc1wR06vX/bkETO3PenWTUjQ+T6WwEd2ZM+IcXWgyO
	zV1UAP2Yrn+gT4ODEp+2KZmDDaQJzmtbERrwA8trGQ2hojdEqaXMbjwsph830Qu3
	plAVXxqn7AOsHEhpPkLlrrWd0g4yx5jgw2tBaWoQmDnQypSCxP0SzK1zwiH14tR6
	nutMMBFRLxuX2ZPwLopXt6oozxhblP+pc4Dubi0IwOCXAWKs67q94CnKWHjtu5rp
	gefAZiXvinNRiqrR2yGh4pDiAc5JqOShuyEJNwWNTqZpEbamiCjWs5NJj5p0W5eb
	/6qZPg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex25xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c110a3b6aso50049181cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218712; x=1784823512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=;
        b=TdzOILi1SS5+kjWpoLo0A6SdOZ5VCR4BpHEuqyyfBTVi6SpB0o/n6Jp2MVENo7ddkF
         bA2VDq6YFjrC9mg5mmNL7bb9BK8dbCxjixlo1Da6UAS2hKRvOd8UfduqshOui3ow8rrv
         ZD1dcJlo54fX9DaKDw7E3jtbiBqSBbu9+3Q4ytl/TQUnkb7df1G5bS6heBAGAyoEmdWt
         X9Voy7gD1+mKCDIDfBKFegQCdOiL9wotJaFqPOPkfa/hj9i0TPApKIBsRx2GFh18LTOT
         5pQf9/d7n5bICzRlB7NJeMnTdW7Va1ddy/nrI3dNZZND21SLtGlLrA0R0GftQdFsDXc3
         azZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218712; x=1784823512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwGrtQXZOZLHM8CW5djIH+FZH0mzGoPJDhLtNrPv7hk=;
        b=naAll4OOOG3Y+sI5i6ImcnFwDeg9ul5LJQgj6czzNEl3tdBQsNpqQtBfFlCEQCVLoT
         Q9vdw57mAzATubS0XMDQSg0Nlmaep4yiizbDZet6QTNAebodWaCu0mU8tYTS0Wb1/piU
         a8UlkymNQzaIzme4kg2Qu1XPReYJJ9RzzfF7MwfkEHNvOJZZoeDkwHHuGl1xCzTzYkc5
         /2MBXgK8xPZcBWvqVsVuGweAreXdhuC1BJIHpFG5vXgZJxNtpYGE+CAp3dPH+rBb1Dop
         99zIkaIgBW6W9kVX1qC6te8nARyQhkBOXmf3x2kdUvhH261c8YLaEfoRlyo+8LIiNMOP
         mBCQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOL+HA/g+AQeVJEMCRGly7vIx0ubUBbYPoPw6jrJ5t6Yv4LDgB0BQV9dzpsxFxKtQH/Ow7/Chhxo8ellEisX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVVDZMo3J/sB+y55qI6d4ofcW5Qz2/Z4pRkpauDdYvn01dV9d
	f/KjVMtsTKSdoWaZa7lq+BtZaR99M3+a5HLrTVVy19880LVPE8wH3xB5ee8ejJd5pOXBmMfqcEt
	IXZPUoDVHssIenbPhli97uhWa2TfuEJIOYgu0qJowW2P8ob5CGF9iJxrdNTM2nYhdCjekx5A=
X-Gm-Gg: AfdE7cnGZ5CF4zdLDxChtz5reUhVFuYFptRd//wEE7+ZW86jWYKFTYiGk30FDUGb1sT
	QaJxG43CdRobZO5Metc0pz7W4pep08Bt/Q0KoTdQmWycSV1fR1uugq8w9Wdhmj+0XlNuya8aXZT
	dBJY3n1EfB65IlKoQ9s3n7MsGr8tQx1ysp0Uj83joh2zX+/pSI5j4z/zF226syMn80p2OnnHcb+
	2rp6ebBnvD3bwYKzPC3VV0amkrygdkvaLQ32bITtN4ULP4ku64QuVFfILyk+CoZ2A4Q2WgACxyF
	+PpKO22Lzb4EAG3FssTi8N7z8MiW1xJQd9DniIERKQF3K6CmIawcVTwaizFJjiTfaudPUlRafAC
	cmkIsVGXWHcrAv6ac/ulPxKTUZ1PgPljZb2EAyZ1KEgvIPlXPB1aYUpXIr18jJeOJqSdGQ5IGz4
	xhZYpXmQ74QBq/fYXi6ldidlQCpTv0u124z+sTsDUfaalMhp3X56I=
X-Received: by 2002:a05:622a:248:b0:51c:257c:8166 with SMTP id d75a77b69052e-520bcdf04fdmr2656701cf.33.1784218711623;
        Thu, 16 Jul 2026 09:18:31 -0700 (PDT)
X-Received: by 2002:a05:622a:248:b0:51c:257c:8166 with SMTP id d75a77b69052e-520bcdf04fdmr2655801cf.33.1784218710638;
        Thu, 16 Jul 2026 09:18:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:21 +0200
Subject: [PATCH v4 04/11] power: sequencing: pcie-m2: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-4-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a590458 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Wval_j7vKiRkorSqWqkA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: iroU-PdAdx9hq0kIZS4HhvHaUocBPjvw
X-Proofpoint-GUID: iroU-PdAdx9hq0kIZS4HhvHaUocBPjvw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXzM6ECkQobEGS
 vp5k1q1hu0iIf5LODHmC6eU7T7m63hgn9GaEG3DJwnmvv1Whv2rs4pzqFP3F0sFn0ylkJNSN5Cp
 RYrptqkQ930w/TFL/Q5hEm4ddLopHRg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXz1GjfCT/LfDG
 +kN9ans0VQhZus4KBmZClijIKI3GuU3/63QPgEHL479b483+1vB6WEpK9d6BO7mL5g7T7JwRguF
 Sy0Z46oiMjEeCiaOIuNezs6MvJRbZM8TriTDoca4tS/ccaL1gRWZY0ZV4NcksvXlHv8Kqh+PFG/
 2ypr7I0HXOvIQMDUzBq3hO0rkZAMvPI69BDA7LoUczb/mrXg/YMO00f/Qf7rVp2xLMZd/qfWDCn
 wdmzCxAutOk1J82uEsij+8us278E4fo2UISJW1mAOputG93OucJuetmbhQVCpCMn7Xpfgi7+8gR
 HpfBL5hub0GYNQ+fCDqmaQCkjCoSM4IfLCPVYaQWk54CU2Jj5604fS5ZQynScNCAxuVtHSYBAb3
 yL2i+e/k08qET4bYeQ7r6uYmxcl9VxzuJlKurSyrfhOCrFzknJLVwbbd1gO6YO2xO8TFedyqQkh
 SoGzFu8yqomvJh8h1CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

The M.2 Key E connector gates/resets its functions through the
W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
When a signal is not routed to a host GPIO, the corresponding
enable/disable callbacks are no-ops, so the consumer cannot gate
or reset that function on its own.

Implement the .is_controllable() callback on the "uart" and "pcie"
targets so that consumers can query this per instance (based on the
runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
pwrseq_is_controllable().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..8e4cb778e31f66aa171ad9831d4213e17d2e6145 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -84,6 +84,18 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The UART enable is driven through the W_DISABLE2# line. When it is not
+	 * wired up on this connector the enable/disable callbacks are no-ops, so
+	 * the host cannot gate the Bluetooth function on its own.
+	 */
+	return !!ctx->w_disable2_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
 	.name = "uart-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -105,6 +117,18 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The PCIe/WiFi enable is driven through the W_DISABLE1# line. When it
+	 * is not wired up on this connector the enable/disable callbacks are
+	 * no-ops, so the host cannot gate the PCIe/WiFi function on its own.
+	 */
+	return !!ctx->w_disable1_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -133,12 +157,14 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
 	.name = "uart",
 	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_uart_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.name = "pcie",
 	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
 	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {

-- 
2.34.1

