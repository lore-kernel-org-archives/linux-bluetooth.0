Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8234D4F4
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146581; cv=none; b=WaBaEc6UJlmRuEUAbkeFAt166YzYbh0mQCCUszLVDwNy3ZXTPzIyYl7SNu1OXG16omhS9WjKTaSNEal/OaW4y4AwdKHwbKpQYnpjQH188wCRKFOhSmNyXUH6CPQI3Gey1t4SCtJIUP+kWwaDlAQ4iZgVJgQPD1aRrY/2wdKRnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146581; c=relaxed/simple;
	bh=gRnwoWYVjN7GMrjsuBdpDhiMQwmfcdo/4r/Rw1j08vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrfGzII73DwUEryuTIIlHza/ISVPx78t7CcbA0qVAITs6ASeDCblsAVuFiH4Yi8H/ydnV7DTcO1LQBc908M4Z6qinjRR6S2kHQLc257Y4qSDKWi/lzY/7LgAfOEHwnOlfe1Q6+CC4paWou/RpCpfQR8IdKZpTNTtFDxSxbkCk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjWO2hTb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SXQ/uAM6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjWO2hTb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXQ/uAM6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60B5bLm41194002
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4KqA588JLPQI0i1Leq0ab3vXKKNpG6AzEKsdY8kU30=; b=IjWO2hTbXJlcYtYq
	xkmsUc7n1pP/5aeJrEa264nHHcXjuEmJYe/0IAY/AqrFRJVdVeCKRhbH35jqyMHF
	YZ0LzOvC8Rp8y1KeSPAH00j+j4ECDduYtNw7SmOVPXn5lE8WWQ9zteT1RwKxi2IZ
	8pUZIInaGCLd9E9Lh6Xf2l778bbujEsWzpjPcA2oiCzYMjAICTEhDPKwCs2dgwOB
	bZFZoBHQy9kUpg3lZeNAc96by0WeEIQ0WZB+BnQZW3jYPhhWDZr1FcaQtTWid4+v
	RqidpTD/wO1EfWb5N4e+2gfFeMyLCEIgVow6jj00Ga1ab0YWvDu+zpgVwaLteGkA
	XBa9BQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkntuhu4b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c1cffa1f2dso1281158785a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768146576; x=1768751376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4KqA588JLPQI0i1Leq0ab3vXKKNpG6AzEKsdY8kU30=;
        b=SXQ/uAM6tLzDEXc77+jFJluSLk0Eb8ZG+uRhoflFbb8swV4+++SKPRS3zaRAgrEbg0
         dwGTECIAjwTGhTWw6hsZfR6ihov7drX7HZDQ5nuuEjhtvY3U3SPsbCEKMshnuIuQTdm+
         Ticdp5PARqI+FfiNY7sFeFv01ZYZuKyxfADTsiy+tQt/sPT3MBG4Qv8xbCWs6kR3n9Cy
         /H/rR+2cTlDhluh5CMx4gyaLn+yiE47Ba+BIC9GEpGWO50PP92VkV19BxLf/70VqBZld
         W5/xY2w4GxvKc77lbU9M+BxOc9GBO7VN8hhq0JmQG2YxHDJrZ06nh9MnmTyuLLvTBjCs
         H1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768146576; x=1768751376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4KqA588JLPQI0i1Leq0ab3vXKKNpG6AzEKsdY8kU30=;
        b=uibUdbZ4w5Aa7Hs94W55bQDaYXNsdeQuom9jP+PeGZM7MV4zyNqXLVfDtzPcGupiHN
         8O8G7x6CaEazebuOyqYYsFqPrXvxGHjMeSk9/RnNU+yvlHAYsKx13GcjNmJ5TSeiK7rC
         eD2fybvKqEHLxW79T/BkdfOa6vj1wROtHE2hZpYgo+wdMZEFEtfjC8mrCmVgdSUOrmG6
         zmnwICTyWO22QKUn2doA3TeMAkxwluWltLIAG3WC4+BDv7WdLLATHbQR502txrYJauxp
         Ay+f1CS0dsdo2Fin1dolBeWCm8svbB1WUHgkVEKl8jk8+1MAG345wC7wqzKNozo9nCih
         wxUw==
X-Forwarded-Encrypted: i=1; AJvYcCXIUhvmDF7U8PquaQSXwzyBSDtRfc9h8k4vwQtxeWwu3KCjFu/72gikEmzExZcmKoODOmeriDx8oZGCF4Gl1MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7nX45hYIZBBJqjrSEFJrCK0krZcv+aFpC8G2n5t6WSg4H3Qo
	TCMKHLZmk2IfEiAx+ozzO1FHvtwpBLbrW/VHTmMyPPmJNZlegilSTDpGpxgkHkoIMYgcjWiAC+O
	41dZGGMONFkLQIyFc409snbinpVhR20bufJfhjb9EiRbzYvU1MJ/fgC3Zct/C2gdZ8H0A7DA=
X-Gm-Gg: AY/fxX6DPAM11eBXY7P8CX0odzYRVxCB4S9idD7wfb0jtg6/u0NER+IW5WkVI2nq3q0
	lQ3CMtfUk3i+jQWoPiSVLcmVKFyzKq/BzfLfH0vFbWHXDWa+F3cfRZnTMAuMN+yiB8Wjuypol3N
	6R+mrltn+olfIUvge3O3Z2vLM8sfdCy779hYLKrCvPuRhpboaGulX3yiHr+jcy2oqR1e3uEnqmH
	+YMZL5EPA5hMMA9SKNHyL/qj2cvHQ6EJCXNz193LCG8h4ZT755AqUnFoymeSuJE0ocuXGRmBw64
	YiiDJGoSkEFkoTnCAE6fv94NXXROL0q3k15bTZvzQ6Y7haBkTcq3tPp5UnH/JL7id+GTfxIhutu
	/mKg4eEhWTV1k0XDAcVQbMU/7H3lbJaC0gA==
X-Received: by 2002:a05:620a:45a6:b0:8b2:3484:8e22 with SMTP id af79cd13be357-8c37f41b6ffmr2480622685a.0.1768146576216;
        Sun, 11 Jan 2026 07:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEWa0trsJvJBzxBLzNlhEFOczqLzE658VeGhg3pzzMzdTmL5qM/ocFgl9bywFefmIVvZXmoQ==
X-Received: by 2002:a05:620a:45a6:b0:8b2:3484:8e22 with SMTP id af79cd13be357-8c37f41b6ffmr2480620485a.0.1768146575802;
        Sun, 11 Jan 2026 07:49:35 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5180bdsm1637163166b.57.2026.01.11.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:49:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 11 Jan 2026 16:49:08 +0100
Subject: [PATCH RESEND v3 11/11] dt-bindings: bluetooth: qcom,wcn7850-bt:
 Deprecate old supplies
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260111-dt-bindings-qcom-bluetooth-v3-11-95e286de1da1@oss.qualcomm.com>
References: <20260111-dt-bindings-qcom-bluetooth-v3-0-95e286de1da1@oss.qualcomm.com>
In-Reply-To: <20260111-dt-bindings-qcom-bluetooth-v3-0-95e286de1da1@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gRnwoWYVjN7GMrjsuBdpDhiMQwmfcdo/4r/Rw1j08vQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpY8Z8yyt49hmlZgBjJ1n+mMPK3BQevxhxyMGO4
 WJeS6jFk4iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWPGfAAKCRDBN2bmhouD
 10LvD/9EoIogO3hR+yarHZ+NEKKnYGOjy8NuyyTeKYjVKhHyWGB4QaBbpG+LV4b3Jt5z5D/CpiW
 B9FUh+p6yspGKZFL38f4FyI9dYbTKY6uWzxPODOYZtJVzLZZKLM4LkBlMC5v8CJc57EUhJxejIH
 tSb11X9KswXkEBA4xxOGo1qlaZEqDT/vugaMOPKJqC2QiK+LS0hBNVlciLcP2TX/2wfjr3Mn4XG
 xNZh71cFWjwlFkLLvp+/Qddu9IieD2VIgfe2tcK0/tcB4zSyyIa7mxrIHGPxuNKMCfh/8tEpSRa
 dpK1y1O4MuH09fXkCM3XX6ZGvmOo9L09xEqHfG+yQ8LfKQiokFOHSOnuxlqaEQK2IX+U4ruEmQr
 ve8o/iVdRVExU4OSBUF/gHoaanVQyrgvazpNlZkBXunNW5y8YTCsblNVEIK2J/GLIoQWYgg0o28
 u8gJJueplBIFBq7YMXccMFCFWWGAhUwnGeFNvZTRrPrjmQZFONkgz6WZgWoQdJtlIVXivxGwENv
 TQmJiPMPoDdB8HDgYLRgPfTpBr3VEztlR1jJ5Qld5m1K/Yf4QTFm33NI5yxT4nwdmuu+A4Njv7k
 QoygbGU1Urs0MSmvJNsHk8Hyn4xSrBZ7AB6hMWMA29bVvz8N2t6ShehQK5UTBg/7uRMu8Y5uKh0
 +C0LKhWV6FCGH5Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDE0NiBTYWx0ZWRfX0AzkIQ5a1M/r
 NphMlWToCaK3GwKAdF246RFiDAA/uSoAdavHZx9nxlhJ6VaB5LaX80nYaTJkvDrII3vlkc3cMYj
 9hDa9iWPVsEA0ueGd1hGH3Zn4WHrD48Hh9fGMdWG9jIqOgZ9LBfzL1/u02LfCG7z2JKocYiKrrz
 +y9P4Ntq+0Hf7FrImu6s7RtlORA4rp9t70SrlfGNJlyIDLW89r3+6WLEpd6kj3ad6TSRxMIjouF
 QRWKQx1w/E2AajZpxWmFtqKaZDPauSunpmzEkDZbo0RYbot7y0r0wEVHKZiTOp8UkqteEdF6PHM
 l8Es9Jq/1WqR/ErAU0ir75rmwHn/hsVPuEvSMqRTP+BaXDFmMXd9pbtTPKfONVRfE7VdS6T9xwJ
 pVB34SNMublGSgbi/0u5Jl/zA6RU5X89x6PBDLOEhmyLqR2Aos4gr46xB9zUqflTptAF4oPiasC
 AvLO2go3V+vCdiSEHoQ==
X-Authority-Analysis: v=2.4 cv=R6AO2NRX c=1 sm=1 tr=0 ts=6963c691 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Yne-JONsqnic5O4-CUAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gQIosc2iBvwzgLjm54WKRTdAPfC_V5h_
X-Proofpoint-GUID: gQIosc2iBvwzgLjm54WKRTdAPfC_V5h_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601110146

Commit bd3f305886ad ("dt-bindings: bluetooth: qualcomm: describe the
inputs from PMU for wcn7850") changed the binding to new description
with a Power Management Unit (PMU), thus certain power-controller
properties are considered deprecated and are part of that PMUs binding.

Deprecate them to mark clearly that new PMU-based approach is preferred.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
index bd628e48b4e1..8108ef83e99b 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
@@ -18,20 +18,24 @@ properties:
 
   enable-gpios:
     maxItems: 1
+    deprecated: true
 
   swctrl-gpios:
     maxItems: 1
     description: gpio specifier is used to find status
                  of clock supply to SoC
+    deprecated: true
 
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
   vdddig-supply:
     description: VDD_DIG supply regulator handle
+    deprecated: true
 
   vddio-supply:
     description: VDD_IO supply regulator handle
+    deprecated: true
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
@@ -44,6 +48,7 @@ properties:
 
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
+    deprecated: true
 
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle

-- 
2.51.0

