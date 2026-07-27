Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514E3E00A6
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167258; cv=none; b=scILZtZi6+jbaJun3Q+AFvzP9OVPtAnauxEPt9Lw2hQYv2dX25wZIWzdNy0sajAGZrVakD1hzzFo9BNeLvxMYV9iSeh98oKHRERbfI4yrqPPPd2lugf8EXvpF4gkXdRKa6kq/Ox+K2A38HD1ri+GybOrSNTr95R3olatZb1s/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167258; c=relaxed/simple;
	bh=yMqnOQaDEEyw4WufS9r/vXZ36AgWvKFPth4a+uQU8BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSj24c5vPtIMQ3opQGvOSjN18Xqd8IpTpv669/wb8ST5jN08YaAizuogifUdiHOATgcMz728lWYpFn9IW5JFI5nBq4IaZnn4VGgjrt4ROCNzBbMmpA+Br22+6+EB3ZjeqWZrfO7LMZPRjyfQdqgSXKhBcRmgcdBIcOhPg15L1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9ryUIsz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ih6in9di; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9ryUIsz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ih6in9di"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlajk3414034
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=; b=J9ryUIsz+9lBziPT
	gMQxIPU0LWpFNuKmdmY48fh6G7nkavc4cPDli1knc7SAqnDFSX3DirXNlI9SF6os
	avDLUrSgInuHSCuwxDGf9InPVHygDtLlic4T9oBm8Gf6PPGtMz98hqq8DMAN3Vrj
	vlLrXs41Twmr3K+7OUgT6dsEz45zrpzb0yOFk4jwZSCnCAJ0QyKLIZ9ggbCeKJyD
	+W+QWaL95MMjPvzbmhwWW8UnMf+xDr5jITGSoyUfLrJgJU+DHK/8E5vr5WBTm2Xl
	QDeql2pxNcjGueyhlQzwb9kTnsYJ4A6fagqHMbTDnP++fHfBP/kIHWNzGh1Te17A
	JTjQUg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v69gdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:35 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81eddfe28b4so74564697b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167255; x=1785772055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=;
        b=ih6in9diHLSCPMo+M+8Ryl+ToUwDPLtRZvwGfZNn4bAaRIZod40zf2mBmCafWkPqVM
         GzsBMh1/YxQBW2XTt3/grM4Nsh9xD0gpJvO1bawDtTeEoVT6P05J+3c1qtMn0l5MGGgY
         qxqgwpnXjTQe48BUc9Kvsmpur8sBwPP/QLhfhf5WxWHTWvStNLUWt/1C8dbTQdl7nI5Q
         US64+Mj0f9UU6JSkKydUEzRYhjOmLDYwmzDrdkGCzucYuyjn3CkNEro+Ns/VL8ffcJS7
         y5DdN3F1mtNWN9wMcOSKv5QyZcnZyLbSARyv/A428kaO30YrwNtDLzpNEqImPfMw/1KY
         oVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167255; x=1785772055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=;
        b=nJRVApgnC9G8O/Igp5eSiDF/EHnHjO0z63qjifNE/RH+2SHiUgcxy7WoLT7/t1FBm/
         fsGOlOs+VIgBxgUCQw9oBbSoumKNvLJfXyHU252EWErpQ91cCjKl1go+r7OOTYYRpsr4
         CxY0DEBo5YDwYoLgN0bVZbHvUC8GAGs8Fydh+vLQzeeqyQu3W9/gmmZxz4JBClyW0lMG
         LSU2etPGB3ncRfe7uIX82F2mwcqAAdKOijhAkcH9CNR6sLuHe3vgOGtKAuwN4jEZcvg9
         92chkai5t3fQA+MUjUT3zbEfT94OHT7/Hf6WnGzwyOImHcb9EwtQXyQB08Gif0bLvv/w
         /FaA==
X-Forwarded-Encrypted: i=1; AHgh+RrEDAt6mm05sA0CyRkymxw52XlAbgTLRblRy8gfvIGXoJU6fakqaUX6aqKkvW9p9tdZnAUXdmSWKGHzvbOgDPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5SBXk1B0FDGgBY5kxHvzQ2mKPBJHBfPJNzdy94S7ntkEfwhDo
	9tU7rPCodyRwg3wlB3ieOHMbcjJ3B0QBtiax9a65D1VtOdF4v44E/j5maa5ihkWsffqvdPsjgFN
	XOcv4bOxuvO9lY5qZPGqYt4VzvAdnHZZiqTXaAFNYEozbjblRgh9ZF8vDSssj/4ErB+dD/pY=
X-Gm-Gg: AR+sD13HmwPkev4H5PG7FDXwKVPLdulC/8DDuJ4hl1JxuDnLbl9TICp+dYOL65YnO4/
	7GwTycmLoDBAl9mSrJevhZFVGscQDNYq29aBuVR89q2KzE+Kx27cZJO+8yNV3JyYIGMB3Wkz8iw
	brKxF0AkKYibPRQAjEiSLfaFKCwRropVZ8sPujV6k+1ji91p7TpTricJETd0lyxknI6IDbdDCRX
	1oSKpKjXpXEPH2+qT/OEiJ3ECJZicgUXjLOf8CvjNeDR4I8pDL6F8TQP24uvlSuczeNVLmwNupJ
	4fuRt3wXr/k0KmmWEum6q921Uayw29d1F8N0IuGk5ogkSN+ZgTN+Z3Wm3F5MYkZ2aGoGOsBIgXf
	F2Fjl9rLj70ae0piaUvDWOfW2rEGADQ==
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr490117b3.1.1785167254714;
        Mon, 27 Jul 2026 08:47:34 -0700 (PDT)
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr489677b3.1.1785167253763;
        Mon, 27 Jul 2026 08:47:33 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:33 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:04 +0530
Subject: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU and
 M.2 PCI node
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX3BioJVa6e/Vf
 e4f+WG3hfSxlbDE77nJG8xbsJsz9NR32RAEuA0YdOMbosF51Fs4EQC7qEHgzrXlL6TuqA+V5BUF
 RaB7b4S5EXsNVAs5YDeOJqlHb7EJpPo=
X-Proofpoint-GUID: jDDFkApWHy2Qtk_7FND5oq6-GQLi47eh
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a677d97 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=5vclj9FtNX7zLWCMXg0A:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: jDDFkApWHy2Qtk_7FND5oq6-GQLi47eh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX/kVQmLcoLLWt
 hnjJE7GjEzc/80Xspwe6DM2DaxCXHP5nfGidtdfvYXOKk43YLk1AHWNHjqiC3HQfy1No8wc+xrx
 RfXoVowgON8Nb9dSM8sDAJBarW6Pl2W8myE85Ak07pWuS/o/NKplVHwxRBx+a7yL1m928XDtLpE
 6WZmsa4r2Yjcri/QnOxz2LO+jXAFsSrZQPGgWrzCtQ/MmVefW2Ko+v8CFKECzXmKUymqyn180/L
 CrcPSTICtrLgJZoBqtKz5FJU/EWYzgCgxtnHWOeDPsciXgbGt7HEv+XMpyPQImf52Sb9butLJZY
 jHlXGvZhA92+VCsVfGRUQaJ/23FxEZ9V2muVsOduFEw5sbQjKSefuXWON+EF2IKUEgx6nZZRHk6
 3H8yvTjnND84Aid5W2EQ63lBTu8Z2Qvd8Dgul/ge0/lSZCSoXw2ohXIFVxzy3iPJyjgYo3CTzHh
 nVuamFvW4M2dM3XvItQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270148

The reworked RB3 Gen 2 Industrial BT UART overlay needs to disable the
on-board WCN6750 PMU and add a graph endpoint to the M.2 PCI node.

Label the exact WCN6750 PMU node and PCI child node connected to the M.2
E-key slot so the overlay can patch them directly instead of using a full
path or reconstructing the nested PCI hierarchy.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 37a3b51323ce..b2b6fd29880f 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -325,7 +325,7 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
 		regulator-enable-ramp-delay = <10000>;
 	};
 
-	wcn6750-pmu {
+	wcn6750_pmu: wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
 		pinctrl-names = "default";
@@ -901,7 +901,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
 			bus-range = <0x3 0xff>;
 		};
 
-		pcie@2,0 {
+		pcie0_m2_e: pcie@2,0 {
 			reg = <0x21000 0x0 0x0 0x0 0x0>;
 			#address-cells = <3>;
 			#size-cells = <2>;

-- 
2.34.1

