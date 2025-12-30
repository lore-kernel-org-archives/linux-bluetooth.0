Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69E2E8E07
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137785; cv=none; b=ciIa19WBl2R/giKvSa+mtkce1Eho/u0Ji6ADYxT0sY56gxuKnETegmdn3St8iM7rk8XFlaujLWo895o7+LoD6SIBmBxnRgJI1dFZyRgBdD7louLHW1cFfyFMyUf1TnCTSfhM1pqxfLyVOEu2176v0FkeM1XuEithZYkd02v+E5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137785; c=relaxed/simple;
	bh=Pz4bYuDWOk27q8/d1KeCQS7z4vWcU9y3prNSQvbuMuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BehIbcLuPdeiyJqNgM0LocYwEVWx1lrS7vrqKvjAW2MYGb1PFBtLDgGPzep5dw500/ICSmvNiKFwr7lnmfgBhuq3bSipgofS3+3uc0LYk4v8vN75eusIU3suxL5c9mqyWR6IbdPej+c9bDcmsC4bo1srkgaOYkKZwg5wARhlNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hGIXLqce; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dG3brML9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGIXLqce";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dG3brML9"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMfUNo734201
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N+FVwNRLikQP8LSojRQtHGdUV511zX9zkUOVCzM0yiQ=; b=hGIXLqcexQ1Pj2UR
	Bkjfa/MMgfSquAig0IZEtKMMN97R8FB+VMXuAes8LaJToSI2uqfbcBaUsXfVY8a7
	movLC0e4Gh755YBmiIynBdBmrdWkGvYCrg2+3acmNu2ihATJNZ20eCIVVTz3wQ+/
	rgPxlg7voc5hQunfKHr9g+SBwUcBK2MxI+E3DIYNx91EpmQJUGYyWkn1SNzmj1/c
	ntfVIEa5tJHMbqpJJrHEQCyJWiFLzOtJnNIVAFSogUZQVa1/8dNzEItstQ/nQrcI
	RwI6Mu1Fsyin7Z+0s0eO8bu5JpDDOYyTJNK3RydUMG6IgFMdrVXN/ibwWz4RrOWy
	59UCUg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0sgu2c6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 23:36:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edaf9e48ecso285352841cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 15:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137778; x=1767742578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+FVwNRLikQP8LSojRQtHGdUV511zX9zkUOVCzM0yiQ=;
        b=dG3brML9y/nDhUukny8LhHqTvni5WHam1JgC8xl6rWvT40GOoeLBuFiqn2Iv3i29qN
         aH6mvNHiXUZTKqYI0jFG7IUjpp06edMazNJQoCC7NyD+3tdeCOjcYoFTIHhTnxKC8mvf
         2RzOItBkkrsFE6hgVnN484tmDnzjvhhx7sht2Oy/132HNfgFA2UAZ3tVzaWOcZv0taAv
         MWwGsw5vo5qvl9Zz1lKG9UCqrC4hjB0TpdeegZeSKkNDKW4G6lZ/GYz/iB+JKsWW41Tc
         nF6MnGBghGNnNmy+A4OqFjQ2KrKuBwYej4jVHpBL5r2nGC7wwmKgmIoZW28YMfrf/6WL
         3riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137778; x=1767742578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N+FVwNRLikQP8LSojRQtHGdUV511zX9zkUOVCzM0yiQ=;
        b=RppuXSH9Z94FOBBRRd2tMGcatNqNe4NXxXONEZhS1rTJxokp9N/NN+i7lZGhYAO/sr
         2qq+AXDi8xKtAA9b1by7BgId2eQgJaPQQZC9ci/WQD0Yz661r6fOf4N2KLwfBhbwige9
         K2RpCZLo786RXB6otzAhLgSaC4sb4F6F5tIxDcpzHBajrnFkSnx42yGKkY3ojaY7g+3g
         i0j0I2G5SLTZIvbpbtAzUBTCVC1OFmmQJjyi6+s68cgtGeBFQhn2wrgvVDSo7txK23qd
         TTTteB09hJXQFMhEMUhXyzcqe2sfbo80ghfstEowalBhk50uz2uBL5kzuDs5mJhg9GI3
         PAKw==
X-Forwarded-Encrypted: i=1; AJvYcCVWExAIdvR8IkmWHDMMlAliAqA+a0c8bnLVqGRVXzIbHlK3ioqGfamnVejf7gnI6jVLDcv5MnLBssrp/XqpKbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwELnj0BPyxQPcTkXX4w/JlMkTDvVVqqlFFSxZ5gCAEvQFEH22a
	vSvmgWwjYn6ymq4mb/0wPGDNbecs/CjztGyFZeMiQnedMzcbt/R7rCb2omEBnQTZVtUy9Edn4Gs
	9XSDmW5Imx07t8XXeCn/o7zDUczjes4xj18yy5SLuhWjrprqr4oYoxt/rZZ1gw4fVEueAGD8=
X-Gm-Gg: AY/fxX7SBcVlN5LbqneChuyfWA0lXlTeh3+YUGLacQImKO8/HepoMpvZvlpMZBzzviG
	XmEGzu6A5poQazixGjk5GmKqdDr+zOOBkS4ETuXVpNygylN7XKqjPAbjtpPUNpLtgbgda7BpiVz
	znmNzsuZ1UgXjhlrNVovUX4/RR8zInSDptEUxKOyP9aaxFRfDEFk/elmC7KVFTb1wyv9WYTeE4k
	DiiloOGqhfhReZHsSkCHVHWPj+/6fjKebaZtDOPL2s3E1Rcok+81FhE01ZALKc3VzAkFoMrPhA9
	Qk8I1pQyOKrL2JHLcpsBF2CCBFD7uYWUEELosESO0ZsaaxKRWp8GmVXOQxdo+OsBBgTvb0mLS7a
	5iu/RQC9gqaAjmUeK6lQN5FB7ryk0I4l67wuYs2kWNqZ86CVQLVj/+/WSv1XCuIFkrb8AtEXC30
	XqK4Tqj3dCX9sscrYWSpKJpiE=
X-Received: by 2002:a05:622a:2b46:b0:4d0:ac40:fab8 with SMTP id d75a77b69052e-4f4abcb609amr511678261cf.7.1767137778420;
        Tue, 30 Dec 2025 15:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH59lx+ZCDpow83PB4eH/5T/X29RNR0aVJbnqhYno60nbct3hC5Y5OsKlGMVfNCgjJmFDZvoQ==
X-Received: by 2002:a05:622a:2b46:b0:4d0:ac40:fab8 with SMTP id d75a77b69052e-4f4abcb609amr511677921cf.7.1767137778035;
        Tue, 30 Dec 2025 15:36:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:17 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:59 +0200
Subject: [PATCH 09/14] arm64: dts: qcom: sm8150: add uart13
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Pz4bYuDWOk27q8/d1KeCQS7z4vWcU9y3prNSQvbuMuE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHluW6qebycSnrD5SNFOD5335n2RZeHUhSEk
 te7vraHp9eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1XA+B/9Ku9Oec16ayWeVxl+sQOev59kRkI4jvd53Bo4+j993wCSjdYNaBIcMOjHpBtdsyi/DDeh
 FCqhwnxfxwR/cTOJeCd3hsWAoEPp4WsLb4HwvE5IIHlu4zQhsE7Q6D2qfsiqMUE7Fn52T4GEAwT
 5cCemYj0GzUO0yeFyn7bnsYk0FsfenLfPLViJXvkAT6CoqZCRM6Zd70UDRgNzeDLnlsyGYEIJ0M
 ZkLNxrAqNvJQiA6/WsXXq6tIRKw2+yRXdZ6k60oc7W7vAQU2lpYSfCGPED8gbKF6EsSAajYTlW4
 VMy3sEhDdO9MoAeR+LxRsuVtx3ficRB/NdBrAh7X+qu98d3V
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX9NlJaUrVp+bL
 0c7KG1kYOpi0RY3jMVrEqvhWC2L5lvc26cEfrvoTNvU2BVzgIcwKX0eN3m9Dfu8bZ0yfRzplQ55
 ZeFS1JyICrdXAXUhdwPGAsO78ll71EIUaj4CBR1D8GOIU/whMhA6W5gzuI1Te6uyDhuFTIQUs5h
 vWR48Q2fal77gfZ657Se+V2EE/EhKXxLvC9ZtvebviXd5PmvMYOCeSP9/z5/zU/Ss8Mb56gmEro
 nt7wzElNxtnZK7M5RzacGWu3mW5Kl/BwiHb54qx1/gT7eNRxy2mNuOESob5gt30tveC5HhUGehT
 U8xOEIY9Ioyzy2WfFGXemcZRYkzLb5fS01RQLWJwYA8Cf0AN1uVhiTEpd4urLEuDXn+RwEh3xau
 7LsCrWBZpd1cBUHaB1dyK2tqKJAt0KRoCVEkphP9ALoojBNLDaMNyQGhKpgzt17ozhGrx4P2QI0
 osyzKtv3UpARUIikjQw==
X-Proofpoint-GUID: JognSUqWwAtJqCbil5_LBQFNg8Vac_mr
X-Proofpoint-ORIG-GUID: JognSUqWwAtJqCbil5_LBQFNg8Vac_mr
X-Authority-Analysis: v=2.4 cv=foHRpV4f c=1 sm=1 tr=0 ts=695461f2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3uNi7MZmT9RZencDy0AA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

Add UART13, typically used for Bluetooth connection on SM8150.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index e3ec99972a28..24c1691642c8 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1693,6 +1693,15 @@ spi13: spi@c8c000 {
 				status = "disabled";
 			};
 
+			uart13: serial@c8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@c90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c90000 0 0x4000>;

-- 
2.47.3

