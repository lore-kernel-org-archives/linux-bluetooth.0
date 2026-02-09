Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF142ECD37
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620650; cv=none; b=JU6EOCFTSISCg82mIELGYHOusyzNLtfUbgNalgp2g2s4ypgEp+2U6gfFowfTzRI6cX+CKIkDkyzcsCRpdg72Yw4McJoQrR5mmPDjzLo27cwu1LfKJquRuaYbREIo/lPDx7f13WTpeilia9rnPGwwNWy9qHTMYwUb5/CcUPiAH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620650; c=relaxed/simple;
	bh=1KQSI+lUZ6gFYveS3AEQBmlcp70wiC/e9qL1wsPmsbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kC8hInCA6jgQqNJSKu8SrHLyhwwFb29yOb53i8gNwYQSeqD/QTaNaB/+ktnJI+wriIOTF5KcIWh3Nklq488mGPNgXGwhn7s7CoWfupd+BooJOH+JlDix61qFjzs9EIeD2BXN7oec/c4q1tPVJNo2cjdU07epdPkqJz8ASOWsvr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xai7ORY3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hp975E+5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xai7ORY3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hp975E+5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618MF7bE2968270
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Feb 2026 07:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HoWg1bTn4CiOrfh0WKdbd7Qc32ZxCCqjLTw
	Dpv9W7a4=; b=Xai7ORY397RBwXkxQpt64l6HNqDNnMUoOEJnLdrzJMS86a8ntp8
	X/P7JmvKmGOPbCVQFHCjVm7kIK6QsXofah1pWCWX0ypQP2C2mkeq0Gltd9l6bxA5
	BY0EikrtOCzqxQYKS8fJVL7z40wQvxVpdA1rc0/Fsd6phXkjlOWWbUCKR/x3+tDD
	5brqC4yiJlHWmBlpqSdNziNXxY8eUE8EbfqrjF/ECKdDoENfu6jCFEqUZO2+hsoI
	fLdnnf3GUojjAEQ0LlYl0b58yeSC+mRyDjKXitfE7YyX4ufXhrhwSjHh0c97ea0n
	eGn9l/0W66y9l4eYj6/6Z9mxba7la7WR+Hg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c6g65ae97-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 07:04:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35464d7c539so2880519a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Feb 2026 23:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770620649; x=1771225449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoWg1bTn4CiOrfh0WKdbd7Qc32ZxCCqjLTwDpv9W7a4=;
        b=Hp975E+5h1pUm8q0TagY8NRbuI+6vIRC+ds/SdEVLo068h+Du59t2YrunqK1eMlB5R
         wgwXHCagYCjD22hjFfUmcGzBEYIONuFNVdzDlXVL0rXXyQuWhIlOnDvVPA660I9f4JaL
         gZjmL8rFjhfYmS/Zgq4eMDzyVfmYPhKQq/2oPmu6L12KfYpTEbSGZ3sLql8hDq9OCyXw
         4yhFHm4jvqYHCNZzgLnWu4FIzSqhezuqwt0Lwf4PzmapkcpEpyHQPK29hcX8ABaLxxfW
         itHamSqXmx8BQ7WP9DrDukH5qz8Sp62r5miuukHASYkZ9LSjWC7RR+QUgrzNIsSYu7tv
         zS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770620649; x=1771225449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoWg1bTn4CiOrfh0WKdbd7Qc32ZxCCqjLTwDpv9W7a4=;
        b=lZ+M7jni0bbeTLra+zfCb3P4XS9fTV+23GxlbW5CzN9Fi/ZYy1Hg4F4z6M5VZzknRx
         mjyH3V1d68I2nmDlBalSew/wodPT4slTTE8YOnsaIUWhc4yDVtCwx+F6RO5e78DHsFw4
         ipQ2f2K4/7dyIqp9iGJFCX2fy/EUVW0UVh/nVCtDQ+Y3j+LjJ8f3016QRd50cLT2DNiD
         i4OkTQnKZ+FJ4MCs6dwvdngeZCdpETg3s9kqE26+XdnH+kM5j9KufAei3KIigu8BRj6Z
         sC71TLr3VJq8Qa8a3gteX7abth6Npjrs9HWe37ORUem5BUosF9ldV6CG9Ik0nQ2IanNI
         vXRg==
X-Forwarded-Encrypted: i=1; AJvYcCXeBvmRrljgF8z/soLqM6IcdZBg9qKcdggt/jCNuPaXf1J3miKNbbUhbIhBfDQhqCMSX/2xTvRK0yR5vy32fQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJKqYdGKAb7Y27pWTVJ1/ld+dbTHpaWQT9KqeS8l7n7My5IEi
	H2VUK0u9yF/z+vnd6/559dR2Biw7mDLZDm+IxSQSa0c/SbtfikASVB3m239KThB2u5ycNEnQlWT
	sSFLp36jQd4q/nbxCklgze8mrglJ2htF4ily+ep7vAAOpeXFzlP68sRAM5Dq7+6c/5jxdC4Ftde
	s0ztU=
X-Gm-Gg: AZuq6aLanvX7X9VDSK/uN2gWSHgNYR8wGCQ+tN4GMInzdajOzt15IoGAhPxeenVJnpl
	5e80l0vNK9xphutOWIetSJMRzQ4PqHQMYRBAVQgUnIe+rOoBnen5zskAKNWMlxB5hYn1hgLjuHQ
	yraSSazaRCt2mi4wHKNfOl6dxRndYqbjJpu0a3m6myWdvjBLLO/XYuxlpb6mw1Q2ADyWZShx4Yb
	2//6KDvk4X3Oy4zPn/LoAxdtm5+RbEs++e5HbodYnigBgh7vaMQ/o5ss2h1KwIy1uUaLAH9bJpy
	TFNqqX+An1XTUxk4EkJRgG34rwZD5NNRD9W7HCOkerS4wUfO/QuamdjkThbAndXdinkmWKg4Cx+
	y7RqdmURJ8DQrM0peioQoO39HVbs4WqT8H0O2IH0=
X-Received: by 2002:a17:90b:4ec3:b0:356:2fee:92c4 with SMTP id 98e67ed59e1d1-3562fee9606mr2890765a91.24.1770620648629;
        Sun, 08 Feb 2026 23:04:08 -0800 (PST)
X-Received: by 2002:a17:90b:4ec3:b0:356:2fee:92c4 with SMTP id 98e67ed59e1d1-3562fee9606mr2890734a91.24.1770620648133;
        Sun, 08 Feb 2026 23:04:08 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244169804bsm9176950b3a.27.2026.02.08.23.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 23:04:07 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: qualcomm: add bindings for QCC2072
Date: Mon,  9 Feb 2026 12:33:55 +0530
Message-Id: <20260209070356.187301-1-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GqNPO01C c=1 sm=1 tr=0 ts=698986e9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=FGpUFwgwi8_8IHRhZgYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: bGHfo5o2MglZ0Yp0UgajotOWA-b9rEyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA1NyBTYWx0ZWRfXx0PIJDhNgekA
 M2yBZlcMy1Vzx6DxORB543vsNZql52exE8LG5VUfiGKQBShY5GnFon3wpniSfzUpcBrY42WvLfN
 Y40EFubOzITKK3L3i9WbSkpy5NhSPKGQRI2ib9vpTc0ZiCUWs+Ig4HAOnkCXfiu5Tpu1oDEupxK
 iJz/IbiyVW1CVF/qiwmbv7haMup8+5nRuqiyRZ8WGLAkrDH6xqfnn815Cpe+0BJkcqXVpj3wMsY
 HlHpPvG6X4PvDc4kT2om69aLQJUultO7aCZQTGA5cJqI++vhrqTswYzUYdN+pedCLbRYYJDZfOU
 /kKvbijNbTCY0I37O0ac3dA+iv8o4TVwjqIU6MZbZY33j85lfs62IOgEejdvUrQL9JGCnyQg3/w
 bXkISuI6WogcmCUkh06yxkAypRhotCeduaFghdW8ZdFein5ztpg/E4c4qdlwTchbpbMykvCm/ye
 zUHomGT3sjmgDiY+s4w==
X-Proofpoint-GUID: bGHfo5o2MglZ0Yp0UgajotOWA-b9rEyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090057

QCC2072 is a WiFi/BT connectivity chip.
It requires different firmware, so document it as a new compat string.

Correct the sorting of other chipsets for better readability.

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 6353a336f382..1f47ad36aa61 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -18,13 +18,13 @@ properties:
     enum:
       - qcom,qca2066-bt
       - qcom,qca6174-bt
+      - qcom,qca6390-bt
       - qcom,qca9377-bt
-      - qcom,wcn3950-bt
+      - qcom,qcc2072-bt
       - qcom,wcn3988-bt
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
       - qcom,wcn3998-bt
-      - qcom,qca6390-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
-- 
2.34.1

