Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34C37DE83
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218722; cv=none; b=nivsdVQDun5qyh48WVDm0VhA+O4i7jMBDdLhHBEoa6hGdvRp41p/ZcaglPPIApmJCRttzLZ5B0oytrvApFOOsxvFwGWmlW3J4PTvl9PiVKIkYhPUEPCwNGzO2ldIiTALkfa9W+STlwHXsa2W2unjErQMnLptL4x2a5oktVUlDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218722; c=relaxed/simple;
	bh=+a2PwVdZXIN3LhIMygJSk6N3n7PMH7uL5OC0qbZNTaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGUjtEkCRjgBONcnu4nNGZnczgnUzNQM4c4lkeaIgR94jlshTKq6qcv7rU8XaIRIbqEhtT3dl7j5Jw+6Arbqm0llMbLkbjmoFGJD50MjIQXFLKhOqn58qfP/J0/JBijDrKk91jIAg7kv+tceNSXLsJWFXYQlHCX9X0ksmemPhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GYgQrQs5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XhaOaOVi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GYgQrQs5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XhaOaOVi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GF497w2811335
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=; b=GYgQrQs5ChdhQ7ok
	ReS1TaxAQ007HtFnLTqhwEoCVtxQ379eB+DhXh9+EyB3WcpPU8tjWydTQzd+WbsY
	oiOz6wf9BlGenF6QpKTBp8JUVF9NoDGQqQuTd9c0WQtE7aytueC2hYjZ0TSxsMfp
	Ozzxle9TRnByuUSVxKviwTCqzC5K7FDVPlYrgiBBroOrgoyzJSTp+ap8dP39G3TU
	1NXC+PRyxXiNTIHaT4LNz6d0jqJEx+ls3OwkWOlfWekpRFvkJDXWnT0BgQp5AcFC
	Jy4dP07WLACoVYkYxhQXOHrsm/d7UTtWSYKzoVrsdCwFil2gdAEukVqJpbl477qr
	6UfDZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9gab3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bec738909so58677391cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218714; x=1784823514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=XhaOaOVirVTmHSvtqz1CtenSVKzu9MKFKJOlak7pC1aQuBWiY8JEzSNFz2I6pdZRMA
         BicfDiZOQrPhRjuP4qQgjvCMT9hji/FFUAUJDIGf7pebbtZk2/2lLkoAI7++cWDabl54
         EPkSd9aNGVVQjHjeITWQJSDHFGinJBoDMu43IakV35rHclbNOQWGKBKXDm+++TKNnHdE
         iEciAzKMi2CbV7dtZ8SX9ptwJVztoZxrbhEJcDuwRWxVCHK5mZCKsyO7AYf4gGkjohgU
         gPtd1bYH+48PncyWGUWluMUNNxIxl/WeNgfkT3v9oTj+1ncXmRzfwtBa26+1//JVO81U
         biTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218714; x=1784823514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=eRY5pA4NirsVE+fJlq0PuwxgyMts9Fx1I9oxFWUXbCI/IVH9xyEICZK7elmPMY71Hv
         2sxolZk+Iqo3D54TzpREKJbzQ89vkDfB/w8QH9+LkYjIoaKFKsQdKTVutkD5gQgMLAIv
         pciwysGTFYxuvR+HB7NonYo0j/v4dore9XZI+D0xGk1cV5cqbWzspm8S3CDY/ssG6McI
         +ZZhSFiuoHx2mIWz9gMoFTB09p+wj8xQgxWTzpNNQFxdaBWLxc468m1WKVq+s22SwXEQ
         QKbVkjQ8MInOAiwnrj5yG+yb5uMBL5uNoueA+/1COEUc3dI5uomW8gSygcbplbDe77I0
         uhxg==
X-Forwarded-Encrypted: i=1; AHgh+RoCKJpDm1INI1/n4LnlOHb7WZNdnebG51qkm2wHD/7gecfa+tYq+tfvoiu0+GXsKUPZ2jC72V5TxAJlpWBGzlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EtNEpCOTepxyGR4ews9Iumc1q0OJuVK235d4uuoqSNx19cK/
	nAlCsiv4lYdKd+xoXt2LPo3y8/jLzydJUcnlH9ffR0MD9ysg3e6LsoqS6DDZCHWhn8yzBF+rSMi
	LwlmHWnxNs9vB3+8SqlcBn+PEUkrDnjJlRuTzweokWSYs7kQUUR0ov7n2/UTmlftKdkQe5jw=
X-Gm-Gg: AfdE7cmptyrEUTDB4bUrblqqkmPFJjsVDczy7R1z0DqrNPCcrwk3r3cEclGuMg4ZmGS
	hugtzgi+yJ/cutzMpClUORKxjOE4ONRGC2hHQLzMYIcJmMhwGCSX6lZF8cLFpSMeQGMPNddcGbO
	Z3iIFWAb6l87xVgnnJz9sMldfcyeYlPbv2MqZ7JWvdwRHF9RtqGYo6NhvxZPNq5jlSl+Xn5XWQH
	kA3q0lkg0XhQ6h97JejmaRvBrCTbw706thgjO4UHtrnD/3oTm9ooi8zz3ULbqJ3YRCL2R1S0Jyo
	ZMxS9zkqUsDaP6oF8pKuzdk1G7lxzzoU6BD0pRV5z5juf7FgYAGY31wUjPmFdFLWQOoDqVXQYXP
	w1JgzcV+s4AoT3dQeXveVmwAC/69e8YTRMUzWBokC8JFdQ/mrPRGvsyJxQ86bRJoeyGBR+fzElY
	TOvMyH4xLOw84TD40oI71q958ti7McKLDi/pv22hJDCsAg++iz790=
X-Received: by 2002:ac8:7f13:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51e42497dc8mr115017671cf.74.1784218713313;
        Thu, 16 Jul 2026 09:18:33 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:51c:7b12:5fde with SMTP id d75a77b69052e-51e42497dc8mr115016901cf.74.1784218712393;
        Thu, 16 Jul 2026 09:18:32 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:31 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:22 +0200
Subject: [PATCH v4 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-5-9b02e6f549d7@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a59045a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX8tX2VYEgitPo
 q/kuq6+X7n0f0hMiDr29gTvDNTAZtKYKreTcUs5VNGLWVm/9etFI+nGc247+rJ5/bjvyhkYtOei
 A7u7hy7gg3AnSgvh+F6vOV+t76sXIHWS1106BdhyiXqq+fDdgnWRAIqFsj2CDtDRgULE3K6Osp1
 jXyOUEEXx0lndJJTJl69vCWZU3clur39PgiFpfGbQ/hqJGWlHuB4TG+9H7yb02DA9Gkz2hGHxNb
 /kEeCBPJDxPfaSTBufI1nxeZ9d+PHqRVWQbTNe0qVKpnOPN1X6kN3pYMVPIbXRhO18/M984d5Mt
 1Lty8Nux2OcShIJ+WAUokMfwvZtTyRO4y1/TrAZdCmRQVd8yO2KBfb2RD93L1n+5wCElsx6WkG1
 NrSF9xAzKazdqWodVQHYtrQ7fS5ZHJzEKGH6T5FCk45J+J0IoWbeNrlFpwxlKw3Y3j6/5Pp2DHw
 Xf4//2x4UbGwkTrXBUA==
X-Proofpoint-GUID: nbUNgXwaNlg88Y47ZegFPV2K0fiUo71A
X-Proofpoint-ORIG-GUID: nbUNgXwaNlg88Y47ZegFPV2K0fiUo71A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX2oH3GcG67YrF
 VlGjodbq3oY2PzXTi+Jny8F18Ty54r/3oymgnZlXeHebMNX14BIbPOgfbO42WXcMz+5FiOxojO5
 2ty6YVpoMUGHCCeAU806rNaJqErzB74=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
gate the respective functions. These GPIOs are optional, on some boards
they are hardwired to an always-on pull-up and not routed to a host GPIO.
In that case the corresponding enable/disable callbacks are no-ops, so the
consumer cannot gate or reset that function on its own.

Implement the .is_controllable() callback on the "bluetooth" and "wlan"
targets so that consumers can query this via the pwrseq API.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index b55b4317e21b626e050e022648147770ca7f386e..19b51c94653b7f8e7e1f5a2fe906c0cc1cd46aa8 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -184,6 +184,19 @@ static int pwrseq_qcom_wcn_bt_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_bt_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The Bluetooth enable is driven through the BT_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the Bluetooth function
+	 * on its own.
+	 */
+	return !!ctx->bt_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
 	.name = "bluetooth-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
@@ -218,6 +231,19 @@ static int pwrseq_qcom_wcn_wlan_disable(struct pwrseq_device *pwrseq)
 	return 0;
 }
 
+static bool pwrseq_qcom_wcn_wlan_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The WLAN enable is driven through the WLAN_EN GPIO. When it is not
+	 * wired up (e.g. hardwired to an always-on pull-up), the enable/disable
+	 * callbacks are no-ops, so the host cannot gate the WLAN function on
+	 * its own.
+	 */
+	return !!ctx->wlan_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_qcom_wcn_wlan_unit_data = {
 	.name = "wlan-enable",
 	.deps = pwrseq_qcom_wcn_unit_deps,
@@ -258,12 +284,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn_bt_unit_data,
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_qcom_wcn_wlan_target_data = {
 	.name = "wlan",
 	.unit = &pwrseq_qcom_wcn_wlan_unit_data,
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 /* There are no separate BT and WLAN enablement pins */
@@ -281,12 +309,14 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn6855_bt_unit_data,
 	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+	.is_controllable = pwrseq_qcom_wcn_bt_is_controllable,
 };
 
 static const struct pwrseq_target_data pwrseq_qcom_wcn6855_wlan_target_data = {
 	.name = "wlan",
 	.unit = &pwrseq_qcom_wcn6855_wlan_unit_data,
 	.post_enable = pwrseq_qcom_wcn6855_xo_clk_deassert,
+	.is_controllable = pwrseq_qcom_wcn_wlan_is_controllable,
 };
 
 static const struct pwrseq_target_data *pwrseq_qcom_wcn_targets[] = {

-- 
2.34.1

