Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791C273D75
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661298; cv=none; b=t65LAAXlVZAbBXb/+cdCW876lyrJSmrZkkSVMdsPT3JZ9w096fv40vSKFlm6xv9+vxx5h3T9p/i1USElyNqrgTZWhrNjwBXesspAJ+L1laejj/N1u0KZ/aXf3RcAmT+TE1Eo2JH0hLRrpe0cyg16kJr4FMsul2ZZgHx5x1b7BRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661298; c=relaxed/simple;
	bh=HBAxrX8iV9KJiU+UamUvJGLlnBeHexiYwRIWWSIzRDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oqpsj11n5OOqFwHjPoOsg2Qvr9dXQBVKjYG+CLFdQW/aR2Lhmw5ESUjtN8fspzbYtNt5FT7NgGQmLDDrGeX/IxpGnIWeG6VlaPVoYU60PZ+89fRy3QObMvaB6A7Ft/ncnLk+Nn6XWNp1eqZ8i+QwOMmprklBzkByhHGNQ4yrass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iq25W79Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A515JhYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iq25W79Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A515JhYm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nw5s2529181
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 01:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S8Ik7VDuVyBmarpdKkvCHwUmh0SVZadWNDXRUJ33//A=; b=Iq25W79QOFtdouNw
	ioka5oq/roDN02gFaTYy+Q+ikgRwZEV7UqDgdFZ4S5zFlPMfzVYDJ62yALrwSvMP
	Nn+2mEY9zNI6pRNpo52unhpDlH4ZJSviT8nvqCKUTZw1ZjEW0+nclIVALaAnTodY
	PDj6lkV2zM7Eipzib1Bex93VWk8H0CzzGQd95n/9ry0vdVzpsD+MSdSYynnynWn/
	QxzK4TyBuA4EvbBJh6JyO5/AMK8TT1e/3RSBN2V8tEvGLRgt1iREwqsI6ySrfu5Q
	/iHiAncTh7r8qk3xdNroCiTkfQarxc+3F5U+6aFrPvykKfIAyvM460uT0Xnd697p
	GutiPQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgaus2be8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 01:01:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0193a239so5824161cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661292; x=1768266092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8Ik7VDuVyBmarpdKkvCHwUmh0SVZadWNDXRUJ33//A=;
        b=A515JhYmEFGEO1v5jyyyh3QT/BPTjP7dn1iZ1R68B5+FRcyYwVQGtlaVkQaFJoQsT9
         oVPy1CahTP6sSrXv9uKcaqoERonyqKZRlROehCMzPE6+7O945YYuVDrqrJQEetpWuBlt
         Oz+s0Ykgyq4Lyl+5Q5IXw4s7A1U1pTZQhdCnjfmxqWDNgY7fZTl1Qiqhm69O7WrXDgjh
         F7yz8NqtlKo9c9l+ee+TbuMTqODZqFGFQFjd8heahliNVYWSpW3MF/HnEYPYA2FfPyLn
         jVuetsc+5H4whhUKcOkwq2gaFvoq3dBQR8RXPoKuNx6PtKW/2NZcbwGA8iRiG4GUOC79
         EeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661292; x=1768266092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S8Ik7VDuVyBmarpdKkvCHwUmh0SVZadWNDXRUJ33//A=;
        b=SpRkkX9Yb7y7hj+ZX7kauFaBb3qkLzOvDgdNDNUHsZvodS7UwgKaNnPgBeyZCi/JFb
         RRb5zsFASX9aKvJY2gOzJEW4HsMAk58YD+i+lxef/7aqjWK9ZxqtAbGV2exGvcdI3pJT
         QhSwBuj4MvUNmjUQ8R9OFireA+BKgK+9GznDPi9M7ptDwq9w9ggzolNc7qEvx7vA72Xb
         UibsKsfPGzE8F663AXwbsg/xI6nc5OBIrLinUGajP8TpNt1FeJ/98R5vNwmh0byz10kW
         uwl8627CAaTFw6graPLu91r5OtGm/Cj5JvqJelghVQUkhL/3tBgYd6UvUImg4UbHrHiZ
         hOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGZc+eNKH0SqF4UtkP9IrIUF8u0h7JtupGeEGT7/BQDyFnZHD+kN/gYMRod5OtaIQge4EOuOi4/Mb+FD6qwpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcb2ogAUqsZB98CF5jp0vMV4XmjhXVMBnYnX7ytUq1sktYtjn
	tmPPkjowQS0Cp/FFQA6XegdBV4Vju5ZNKC5Ab1bCz3Qtx3RmQ2GjTJCkEyrgN9R7qtn8qDh7peL
	G4uKi2oEuwdz1rLL7NmfZdbdRCjlvkhRe+qx6jbUrHfQnV2ldn2TmpqUl11yoAm1S7XpMVXM=
X-Gm-Gg: AY/fxX4ohIWArX0PhVZL0RyYb6YzpymxNXaAjaUnuetf2norWmfhQRcWiKGbXelP4my
	RthKmCj5i+fqhMmJvX46YpjKwaVnyhtLyBR4nuNwROwA6B/uxhgxcQoQhBwoiAwU4SxcOJciXIx
	OqAPQ3OJNJRVGQUBqdOJYr0ntunf7HryX2mKGFp+7sKwT4TEwRdNIFZ5cQKTeGqWkQDOTnUvP4b
	+VP+V6mY0r40ZOOij9JnIXKbxr4HmP53+t9FZPxfpd3cmqvfUuEhfR5Kq+z+ExUZgingUwJXtjL
	hF9s+9TB54cirZSC6jG92jGuu4B044G9fcWRxAfi6vwdADQZFP97svFZFTgQjhc2AMGNbdSFdng
	GqUuG6uy3dsfsGlD2/qc/Qe5cIH5g4h6BaFfyzzTpw8i7tN/shzWpfZoFMANRxXLxnb8p+P2ywB
	M3pPtbB892YVTD8eAAgZijiec=
X-Received: by 2002:a05:622a:2597:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-4ffa76a1fa9mr22531021cf.13.1767661292300;
        Mon, 05 Jan 2026 17:01:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt7DDj2OmAqAuyn4uADPuy2ZgBfefpU7ocoBOHTN5kE9DO+gdCGToaNV+v3jan8nMFTXwpow==
X-Received: by 2002:a05:622a:2597:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-4ffa76a1fa9mr22530081cf.13.1767661291701;
        Mon, 05 Jan 2026 17:01:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:29 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:16 +0200
Subject: [PATCH v2 06/14] arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup
 IRQ storm
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-6-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HBAxrX8iV9KJiU+UamUvJGLlnBeHexiYwRIWWSIzRDA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7ZuvUFKSSgxoY07jR5chyzPO9tSWZCnONwQ
 6EwB+Xb5t+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1TydCACKh+wp+fnm51csTFbwKAJL8ROyCe8q4mEdQ/VZh9vvL7LRhZg+i3LZH71A2YSF+0LzM12
 yLu2lIAGKrToPnigiBC+sER+qaLwgOD0c5RxIFrzQaItAoqNrhNW0JbvO0omP/jMNCxyaTJoPGC
 5b2UPXPBhDld7/r/LhIDrQyaNi4qB2awdhal1aXTGyTQ++ia3rMGUSliuG1bzlMIYASVuhH6Wwq
 WMTPaoYL7nBQvsx0ZzJuF/9HxGvRo/661EPfI+vrBrqWNSQtJybjYqVwgOIbDXlRUfYkxij2coz
 9wN980qyF2BdAWgtZWiq4E5vid5H5iLcjounuT/EysQubVO0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: rU1JLUNxt6cz24RZgH1luqlrdEiaD9gG
X-Authority-Analysis: v=2.4 cv=DP6CIiNb c=1 sm=1 tr=0 ts=695c5eed cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4EO7c5U0FNLfYlZKXmMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: rU1JLUNxt6cz24RZgH1luqlrdEiaD9gG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX236QfNcc5cp6
 AYhvhAH+57yL3XIhPaasTaf9pPeMOttcK6ND0rJFC+iiWuh53kYvf9BRpfP3BlBf+FhLlpLZ4Zh
 Bhji0HrOge2Jq+cPX+SS+vGB2yUwn+e0lDBLnNk9Hjtnxxuc+MQfGiyghJ5X31uvBJn2ilb4e+V
 DCDu1KWmYh+fHoJrsRbi5YXZR4mrStwL1hve85yCKFBU/b8UUtRKYSudU3IYEIJwDxzeMeB68W+
 S7QPqWRydl3vHPYI5wwDuKEsmVk7enPvoUnqjIHHw/7FXFtWGTtA8Fhi0BSJ9sVWTE7rUf8xPSr
 RcYZPmGShIdZ+LQlq7+pQpU2We9smDSn41c8Aqu6pcHRabInaq56KBhwIiKJFU2XHDTleQdirwE
 XlRm/QYZXElcRDtMLoU+BZKko4YtYIlSvPk3oHHTGWl5Uu3I2w//kmrszM+KqeStGTFhGbv7yuo
 bfI8Kj1Y35xWbuU8WWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060007

Follow commit 9c92d36b0b1e ("arm64: dts: qcom: qrb2210-rb1: Fix UART3
wakeup IRQ storm") and apply the similar fix to the RB2 platform.

Having RX / TX pins as pull up and wakup interrupt as high-level
triggered generates an interrupt storm when trying to suspend the
device. Avoid the storm by using the falling edge trigger (as all other
platforms do).

Fixes: cab60b166575 ("arm64: dts: qcom: qrb4210-rb2: Enable bluetooth")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

