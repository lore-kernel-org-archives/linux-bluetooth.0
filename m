Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B33CC7FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534663; cv=none; b=oonTpoBMPvXzxvczB9uyCHJ7rhX/suYdPflGfwQFiQw6hP0mkpJbEoZ5Cw5jnIfb0RBt6v6WRCW1biJRc2/H/aKYiBHQwvi5f4n4PmrEgIedkdUATm41Rutf9LiKLzN8xCYWEBFlwUj10A5q94UNUCMKgpy5PG2dpt0APm7423w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534663; c=relaxed/simple;
	bh=+a2PwVdZXIN3LhIMygJSk6N3n7PMH7uL5OC0qbZNTaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bRo090ASYWZpzHqZ/DlENECjwbO05k0Jn9P7K7RsWwJLSSgij7mE8UBPsj9ZTAqzMWyG8CzToVj/ociVA9VEE4ukgT/qaezkWgQ9RmKY9bao0F79LD+kh3EOxD+g30FGGLQ6QrvXv05e3vXmN/67grepSvdBpgyzNjhdCZ4rW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQ7sqhGU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bX2xFmyV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQ7sqhGU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bX2xFmyV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RVa11762334
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=; b=fQ7sqhGUG4Stu72B
	RIyhrfdXdGQySBtD+iwK3oTc/ESzt40Y4Xl7fU0qkimYW1kaHa6jS3xFEAllsWXs
	tWT5FanGg788MO7OtGVhWa1hkxoX53XqWE8Wd8ZrUGhq7ZW4XR0HZ9hnOwer8GC7
	iLYOuNKFFn/kITX6LEWVJAwUfHyfWTlbGw49cQI3Ci+o/E4lHQRw84ajDE3KrVqH
	UwHyuHodFgaFrrZlEVBKCgWEUgNMHjRYKGWxebZcEJLKb4BzdNAD/Q1TB8T6vmPL
	WoSW6DGKASlpI18iU6gBvVxYdur7Py6dtoCshmhMNT4P9M28XTdSzK18Ftngojf0
	Kqxz2A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnn3mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so143591081cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534658; x=1785139458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=bX2xFmyVQbMILlBuKiLcakLR0liKvSyfnoQvDeEVAq19g5vcRcgJMPrMZiLKzmP8G9
         lf3sljDEEoCIt4oRjITMpfVEf5RqIbpca4cImwVCvZUCKa+cX3X5ilN2u1rE2WwF5Ik0
         iUuMh42ww2VaV/9edCVuUpfw5YEojaaOqdCctRS4jgzTN49w8FhiEK6JwIAJboKN5G6j
         VL6l5ZsS/lrjt7c9F+WoXM+AUJH40jXQDxcEOrsvmX6OKtxYCHVfZ2h7vOCunbLFaVK5
         kilFBrES1K4VnR3zIEU8BtuRKNtvkoFhu0kvKts/dHGdGGnoq7xKMOAiYxVrpEr3MM3N
         BcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534658; x=1785139458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bxz9ivOcsV3K3IoCDrb+Cf/SPwDvUEWG7a6NEPjdfs4=;
        b=Os+rm4h76Bejh/XgUkiOWxxJeMX2Yuehv2gFRC2fvq35eO5y5/JH/LX/j9gz6E+/RX
         lvrFYIYwBdxjnAuxAFQbEMAkgAXdByGdR64TEralQUf+r72YbdygdpNb5u1JRxZvAjHY
         +uaJAwSXsiaVqvm5QnFrS9EG8ekY8d1odLIUXts4cLwP0pJeJCc9owWOB8dv54b+bk7U
         IuOxGYBx6LABRxEelZXDLKz65bGKOZvsizd2SYgxB2Zss0No5u3xaLIP5fL33XIlTsN2
         EG3I/+Aa2jE4HVLcxQC+DfqfXcwXYM5aoQb1vFRWvsBWIDk+k0pF4JRRQEEn1iZMeI6D
         9CNA==
X-Forwarded-Encrypted: i=1; AHgh+RrXBUNDSACKZns8MMb/Z4cBvjzLUSYL2GhOIO0VLFUid4YXoc2ZlxMZipKsJfwtLNT4GjFzLcVnmbwqPZal9nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xpXr4mM3EsrFXg2/hfmjDGngJbCA9FEu9Nt8Qjr+nB2ohCU/
	iXl/BosjcPaBoNfpze1Sa409+c5OAZhfw9HLVbbjI+A+MfwmD04HYgHpW6H0BILSuFYnJ3RJ3Dv
	Rr+XQqVkmdXTX1JSkUNVT8wOpGHPMgqB2pOnpFu6qPuv6kpt+5eNYPuM2duhX8TXbRIxoFv8=
X-Gm-Gg: AfdE7ckDBX5J9CeGStm2tzEdRLXdgrtsHINk4IM+A8FCxOjR9GGLpqD1docmvWhK5D3
	bOa8mimRAl8sX+1wtu3ZurBdvVynI/b7ppHhgvoEPvSK5W/Y8jUdPfnmrDr7Kk7kzVuqSpbGgL1
	JUsKj/4IFzHGIgVjmnnV3NPejhRi14A+c8dc4h6GU++hHegMSMTBm/Wn2aoQmTEr18Vl57fhW6W
	E+DEpKiX8y4tLZWyVDYVczzfpvN+mSKIpqP3PJiCd9ThknY0GbSphlu9pQyINp9ariE7rhhr7ea
	MDTWQsd6u99Zp99/ZgTdB6D4+tU3MZTNfeo2KEAEp013b2U1C1/fRvuu2JjoYWPCrZYjaLT158i
	FvHlVjeMX8/r/+a2RKOVxP/eQehPag5SX342n/XbDK9aFvVCeSK7gUjIDYXWUjI2XSWC/rKzbEJ
	uk6i9iZ+gDYmacijnGIFOGJe+BWPIqlVQHqUTQwhsvNiCnjzvQ4G4=
X-Received: by 2002:a05:622a:43:b0:51c:6d7:215e with SMTP id d75a77b69052e-5213dc9828dmr122931601cf.32.1784534657770;
        Mon, 20 Jul 2026 01:04:17 -0700 (PDT)
X-Received: by 2002:a05:622a:43:b0:51c:6d7:215e with SMTP id d75a77b69052e-5213dc9828dmr122931301cf.32.1784534657277;
        Mon, 20 Jul 2026 01:04:17 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:16 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:07 +0200
Subject: [PATCH v5 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX6mZ9/GmWOyE4
 PArXqxVmnk07R0cuUZa9co/kEnWZagltuEidw/j2cweSgZfNWHRXizjQiCTbqw/0yjaq5GH+2C2
 AHuEgn7WqNeH/8Q1guKgV4J/qzUEzbtBi3QeILeXsy+LtEiJOD6dIEmJhyja1XsXYrjPb1YrWps
 PwtIwO9ejCy48n+FLN2YOBP9TTcnnVarNmjsKqcluNOd/DttGil5wTPGatE6MfEigFrxkRxlOlp
 jRRag6Grn9KYWKwgm6Meofcuqi8XL9ty4hYfQRUj23rB7CIcKDufDDXgNRcwI+BYdS2lWhOeVNk
 nAWnhf4rBKCQulQTAHhvOFkEP1W/O16lj9nwgiE2wZ8jUs987oruZswdHVfwZwofJl/2raQqtB/
 neoHlh5eOVUERejIi6rKeyWxSZ5YNDfffrl1uFJM7fE/g3hi9cm7WuqlQKYN/oxrzku3nXYpo/Y
 tncUz3L4q7MtfxihwBg==
X-Proofpoint-ORIG-GUID: oMX02gRrFPBI4aNvjgZqw7Pjrhhzui7e
X-Proofpoint-GUID: oMX02gRrFPBI4aNvjgZqw7Pjrhhzui7e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX60RZZuAPBUeq
 EjayCIbHimD25005ybAtsQfWkjqJIqDu+9a5KfLnqs7bi1u26tpZfT/0GZOPUGdK0bdqrX7GjEv
 Jtt3hQN0pxDrrzJ2hlPfJ8Gzf9BTrnU=
X-Authority-Analysis: v=2.4 cv=deOwG3Xe c=1 sm=1 tr=0 ts=6a5dd682 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QWuo0IUDA92h_ITipQ8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

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

