Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00342E62B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137779; cv=none; b=UiOBZNMfMZOOMCwlYrbVVxw2zMlO9oQ/9+909J0+tVsS5huzTeC84nDG5VNdr+ht0/Dnw+CMZaPqVJjLuJU6tECPBNyl7j/6du5UDOW4DrG6pCUu8nCfkSfXmUe7HFuClbSFPsDN5H+p4mHZz4F4wYXa5W0FPMU65aV8Na0FgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137779; c=relaxed/simple;
	bh=FGGim44BfWQjkV94IPZI9LwB/0tKRgJ7VqsLfgE2Ze4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfXJp2SUmNm+Wpup9yX3O0kuD9JvTyDVwSXEHAi9ai9ANzIvbyjDnXqk3VeWWVQ2+MyhO4R+NNEK+yZGq/TGb5+gnJbYilIUYG7AYDWItW7pVRk8FJJ4K97spx2SE7R7w/k2TCiX93+w8b/wlSGUfTMhvSAkQ5O0p7LRyN7GVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X64159YK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ds9Pc1/D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X64159YK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ds9Pc1/D"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUDPRNF2548570
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yz0M2bONMw9l3lUPyJcEl7KC+6i7WH/5FxBRw7kdMZ0=; b=X64159YKNjQ8Yx5G
	YnPZhErsuZ6tqOaha8guF+8eyfGU2/K589czzzwfeNSvMmvXtmOmrZG1q3FGGNZT
	Uh4Q5PG7h6nB1b6rcyqMHjxa28sRzW4jZ8pVKIlF+ODehbdsd5Qo9PrKhJNPTeOA
	wx07du9EUA+UESqsQGSqA+/eqifBTZbIN3GltCXFuDNQUCdAyhG4KVfEpuPUo/hc
	3WhYt2/FnvDrcnZ9ft7V1CRSf/qNq86LnYs1G7ISaluIOwJjEsad832vBS3gm9c+
	fa7GUZvo9IBHasngo2AQtOZGLDo7utIXkk8yZosDH6TV4G41Qy3DFfKkp8ZQKANQ
	UUAaww==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc739acwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee04f4c632so201138171cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137775; x=1767742575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz0M2bONMw9l3lUPyJcEl7KC+6i7WH/5FxBRw7kdMZ0=;
        b=ds9Pc1/DfjUEG7bTanPrfI/25BCWqNJVUxGzmhaUJJ5QTp8sSZwTLD7/uRkHjnmU9Y
         KATFm50D5wmczvRP68nWcxsgUfWCCWk8ExJZU9TozD4G6XS0+QeSz4JutR6ovNPoA8mF
         NUHt4ZVUASMdOTcVVfp7lbZtxUPEe44zvpJ8mpy8knRoSJjNVx4j4k8b/NkTkMU2mATa
         IQ29dog6fBSQE/SjjGFVLGVwTB4mLkrJ5dPYUgPW4whAEtgxW0nUKk3fU6PjUea2CcCP
         zOZ0x5J4Dn27mlw3l1u27d6IOpvkoYieR2KWcoo/sM8V4R8vyt6spbO/FlQp5u016A2m
         7LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137775; x=1767742575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yz0M2bONMw9l3lUPyJcEl7KC+6i7WH/5FxBRw7kdMZ0=;
        b=HTWiPHjgg5i8XMxMQaW68qtd+/hBPQ/vo+AaqYEhyWugLjxL2Rhu0pYclxV0saRna8
         JLLYn+sOI+PV5uBS8pqY2gDPAIEkHyVOXMa42JWZWf11wr1FtTWN7+7R/eLLhaEPl/wu
         TKY7fmxbih9rX79wJBo8ixn9IElrC6ALk5TZ6Cw7jkBv16Do/3HY+ezeIYXmwtepwPfh
         lkpxL1ezDNmTAB6SS+pG6n/6WcARRUnZCeQ46x+wG+hGdCjZMScGf/cJR3Jb+BZ36r9/
         nUukIdv57PCuq18G6Vclc+mzFH4JTdm4dS9aPIS0PNagZeUOJSj4FxjRrLJo6ztf8YBq
         q7sg==
X-Forwarded-Encrypted: i=1; AJvYcCX9s4tFONSfKkGdNnTgCwHpVAKX/ER+5gmd/3gy7PubCKA2kFDaPWBaTuUQDse5iMzk/hB1fR+qW88OKEovhNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gBXllbHCwXBI2fzXCRe0u8A/YhJRuZLmbqGTDhjkOc4OjLLg
	sJx7Ch7w5LVGn/VAf6FNlaH5c5CxhrcCNDPYyXv3xxaUaRqjKtgpuvU5i3qkCxZBXUEAoVoQT53
	hE1/Ys/80xiGBdncQG5BR1IYcy4Qwrojd5Lz3acijRoryY96nVy3Lr9DMphwRQDub5xX+KZI=
X-Gm-Gg: AY/fxX5Yjoal45Nu6Y4ZoYUeKapaFfJQZ1+E7fwHBRsnpr6GA55+C43fyy9/yClBxLj
	8frmsj2PHMf/D/kn26QLaZlnQMfXK6zT5645R+GYNSoRN4p74SBbLgZkZcT0mrRmhKKFiIgHdFw
	6Qbgm9KbBeLv9rb64ZJtHH1T6jlVfUUz3qUKr7kudGE/Dq5BG+UtmwbZklfWn5bjARMnLLappxx
	6j78CnGR+Dsw3i8JYFqx8ah7+ud/NfB15IG1TNDFsKxmwsJGf6vJd14nycHzNdT8fowDWUHEqGI
	D1rPnB8526M425TbD6Y03ud0BCRr+PZOmqgAumbKPbIO72azduTVHi3QTnPVtGXXIC4WExqE8hQ
	Iu0zNk5q5Cd7VG+/1oz02O9HxjsGKSkSFVvSfxQyEoxrEXP7B9l3VaoKP2g3qHdrCPyo1Dwdo2o
	FHzJioLz1YzbO7kyVuup2QzxM=
X-Received: by 2002:ac8:5a95:0:b0:4ee:43b0:b053 with SMTP id d75a77b69052e-4f4abcd0726mr473645371cf.9.1767137774635;
        Tue, 30 Dec 2025 15:36:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMGGQVJr5nFU32BS3rqlRNKcmT4nwQuRPso4jlVyupuyImgGYdCOcdntUN7XRhnoHEMgqIww==
X-Received: by 2002:ac8:5a95:0:b0:4ee:43b0:b053 with SMTP id d75a77b69052e-4f4abcd0726mr473645051cf.9.1767137774178;
        Tue, 30 Dec 2025 15:36:14 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:56 +0200
Subject: [PATCH 06/14] arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ
 storm
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-6-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FGGim44BfWQjkV94IPZI9LwB/0tKRgJ7VqsLfgE2Ze4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHkABOQMZr6Am7DyYFRXRSIogfZu+iSeRz6J
 dZ6Bzp6kY+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5AAKCRCLPIo+Aiko
 1SMPB/9s6ve61Q1pA4PXAtBPD6/eg5LblpoBoY8MSqB1GYg0vr2VcRReBaI5UcN3j8+jf4XpfgB
 ipggYWe6Ll8hagzxVF86Oi0EMXPh/wMppwJPc5U3oQ6t/4QDozewFUp+uXkzHRoAu6l1b5rUiE7
 FnmlvBBDUiwJelnTQJDhNbem1sofjFQn3X3ToHeFOc0fWtdWkXMG43vqCQHKrv/FIWXG0CuAq7p
 mxoBrUC8z3iqv9fHWgOOnZr0efRh3h/V3D6w1F18vahSHPEKzn5kbXGa7loKJCdZeooj0S0qbcN
 /ZHQVn/+B1PDekoMnUbHdqWQ1bB75eCm98IJFmOQZh1rxPuW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: FjLV01dZfXPRTPPpEKS9YnIrJyVnYHY5
X-Authority-Analysis: v=2.4 cv=HrV72kTS c=1 sm=1 tr=0 ts=695461ef cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4EO7c5U0FNLfYlZKXmMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX8/exMOtob9uz
 gCIR2NGIy2mH7hmi4UW1uFnEqZ4P0PWU8rCGPLVJVQO2g8dH3jPdtz0YfRdPjtJwKyUwSJfO4XN
 ak6GPJU2yB5jTJ4JzlRCvuJkeZQbY+xdkcNZv9WDSaJVOBD+UN7PeU1+1lip1Uhpw67mcWlr8l+
 vQgh8kpCTClCgHRBBH4NgAx/w8Zzo+sV3WmK7rmvXuat/6LokxyD5n1ztQDroNAaNz5DYgVQq+L
 FYdtcnT35R2nvXjQck13firzFU4ASGDDItE9nPEkIDG9ncO+J2p7cknUYS8PDdcDn/8kBg+E7PK
 aIdjl97A5q1OI5ARg8vdfZHCMyoy2BvKJjCOpm3IxMaEt/8oj7n06Y8ZAOLPf/niet5H/e3ATTf
 B6FfbojBbWOn2Ef/iRbmda6Y6dMroA4LvdiiZ3PPwwMQarKjmCs5EKpQIkIe9lEMaDe0+mbxAEC
 Fic4ADr1Bcm0zoXc/YA==
X-Proofpoint-ORIG-GUID: FjLV01dZfXPRTPPpEKS9YnIrJyVnYHY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

Follow commit 9c92d36b0b1e ("arm64: dts: qcom: qrb2210-rb1: Fix UART3
wakeup IRQ storm") and apply the similar fix to the RB2 platform.

Having RX / TX pins as pull up and wakup interrupt as high-level
triggered generates an interrupt storm when trying to suspend the
device. Avoid the storm by using the falling edge trigger (as all other
platforms do).

Fixes: cab60b166575 ("arm64: dts: qcom: qrb4210-rb2: Enable bluetooth")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 0cd36c54632f..5f8613150bdd 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -694,7 +694,7 @@ sdc2_card_det_n: sd-card-det-n-state {
 
 &uart3 {
 	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
+			      <&tlmm 11 IRQ_TYPE_EDGE_FALLING>;
 	pinctrl-0 = <&uart3_default>;
 	pinctrl-1 = <&uart3_sleep>;
 	pinctrl-names = "default", "sleep";

-- 
2.47.3

