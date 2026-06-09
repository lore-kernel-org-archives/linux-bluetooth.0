Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F713ED5B8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991601; cv=none; b=MEW6UOfOVxr2au0HXxlOQPt4HL+mB3GU0ABNPzJkwnmzG6j8z3Sr3Scn15N/BZmYAgtZanVQabe26snYXP38ncq4qZNAhFCfW7sY+8lTLZYA56eyYksdDBh2z88zldyKD9OudE+fjkN1aDDJhyEV8SXu5PLgGYoZsw1aPaDljxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991601; c=relaxed/simple;
	bh=yYJ5VBN7wBwAYsQ0zlbRkE0xdiTrAcSbG/QNNToAmpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2ijMydaEQvyg/lZF4PAG7ILZ+kbm/actTRHetXWospmVCC0RToU8VxDUHDu2BCAJpT4bjGfS6T/X4I6a7JuAgt2Aro7rbbFa1ie8PB5xuoneBBx55yr0dYJtWdw75FoBl82kKw3VfRJ1K+O3nMJoawGdNibSGUhoS0F1FUtr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGK78Hh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1L3oOhH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGK78Hh2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1L3oOhH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wrKt945089
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 07:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=; b=oGK78Hh2GvSSk3nx
	gRnEthzbKV089nIAjT+pSAu6UIWXHONVitXv+kCiYNajab87B+rFJbZw9tkGCq5B
	j1v0xQtK8QFmGL4AiAHzvO3DrS1j7d0IIx35SbMpvtzTsRXJqzsPsFplwmJ/7Uik
	xha+82hUokTCipYZ1DCkQE+tum05qEMgwTeSbTBu7/e0n4Qky/Kv7swLuSX18C0g
	g6uS3XehElds/iQla4W4q4foq9qDeMYFes1lTTi5O9+qZi7jVPiUZhNLFx1xcdtm
	WR4lK1+q0aM/KbvRlQQeCaaUEpY4u+rq/tDaV0fQr19uQbHeaLK8b943DzeCPHc8
	vbkc3A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx45g6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 07:53:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ce9df49c6bso82808916d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991598; x=1781596398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=V1L3oOhH+pqUN12byo5Nmtn4RJwdRG+59ehbHvN/X2dVdIEWt0SYBuNCeC/25nmRPW
         8MKbaJrfgXeWi7saPTOq8hHRGHRQQDW2pjiMgH1zswy190UleM0Y14+/bUVS/UZ5OYAF
         QbT45Xwmbf88kbYKq3zUTPKtFlFj4x/tQiRSrM5tIqnsUEh2/N4qT09wphEIaY1safcD
         ++voo/p3XpsQPjxpFAfvofRZI7HKZq6JijICU0ICHRYHg7sVNPAoSjqMTSNwN/qHjbqo
         4FIlWfCTCK0xfWuh3mP1mJIdl3+rIRPYBGPqGRc8b5htK6cga6TaG/sGFMwXPVEBbPi0
         uYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991598; x=1781596398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaVv9Eurf6ixxwY7bJNLCZAXbfQRk7/8Rh3U8IOXpwA=;
        b=TdevJtHEeC/UOzYaOr6KghyO+ZmlmqvyDGjBnWCvfCd1k38Ub5ZQv0gHByOrvRiQen
         V8Xgh1xBeNeucJb2VGa9CdVgs85Nto/ZFEwZaxZWpgD0YKAjU8asL8gbX2UKly11Nzns
         +e3ZaN8GnAYqhaL6BcLuV7eLAtk0/8ayNJ7NRkYdtzhetW3dJpnFXJgtOSFi5rVbke0/
         4Vs0Ej3GcNmgSqIKU3+dmg8DS9rPYC2y1JiN+Umf+MZfMsziPJTdQ//OalZB8ZzK7+Iv
         qGgUmlTpjsc5EKXr/qUnxaHfhUi5nUHqJUz9BWdynV/blL/JrJHa1ndPlQnb82eGeG6b
         EhKw==
X-Forwarded-Encrypted: i=1; AFNElJ/GD5XdiDx+cUuB+PZY0FfQlboTwG9HDriMksZWgZ7MGzxXDDSMmWLPA69Osd9CgJ0AfTRxb3hVEYpXN0jJPoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqyzz7WrfU3AsrDQo91RAB4p80ASvhBwLVVE1n8bBaZT+MOcuY
	LIKK9L3KtJnzKTfQZe69TvFBNCnuqcjR3ontfFf141Az9AZHZVjuz+6rb6wOGd8WwwPE7i7emiN
	pjhB+zP7afmN+unSXHpB2wbJwF+oocoa2oAAZg1FNnQ5U7ARHv2N2vZ5cH0G+schFjNZEnGM=
X-Gm-Gg: Acq92OHH8Bom5NYvK/6uqotJ/fzkV5bSTek7d69gFzQf/UBRJwIZ2jsxeO4zbna/Q/P
	SiSuZlJFTekK3epZhQHEiPmsDTC+tJ2xiO+R71+iC3lC6F8J3woPUgTY/aENdQJhYXOVJWkUqiy
	gLxY/xoXGVLJNIBj2N9zAq83KqMFbhhL1PpR7EB25xgMU8WaKzNxW7CfUuaYZWX2Qx9xqaMtrK2
	WY/0E5fPjF4iu/IUlvpRcBRNhjCB7RlU5+T2glhAsXlxBjq+HUoELxSG8ByA8w6eEuzqoMgvwmH
	MG9nw9g/b/09Q5kg3J6lQLNfC3Z0efMGzKL+0AYClT3Rh7rvtCd7zlP7mAWLISX/XNr3z1iMwi+
	PMeAO6/jz1Kj1TGjIJbYrPAPQc7YPX/VvPE+++xK4J3SMzGfGRqTQcrQVjknMm09RF9jZcNXoDT
	1aQaX7sDkXO/tDYSJqtcuUB/x7l29mFEk/PcORkfvWZkdjOyJ9auTQSEhZ7WWJth4xaMmMW0CXC
	T9RfMsMroZ/
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186043591cf.24.1780991598509;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
X-Received: by 2002:a05:622a:1a98:b0:517:a9ef:ce3c with SMTP id d75a77b69052e-517a9efd0bemr186042831cf.24.1780991598097;
        Tue, 09 Jun 2026 00:53:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:17 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:27 +0200
Subject: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a27c66f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 1xItApGnLpu3EJv7mZ8pn9qW5pcWWi9O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX17QSwQqEa/Mg
 3dvdM6DhzXHrzUXwDJxki2xvQ5E9edZ4tK5kBinD3bJKe6o5v2vPkNMurbuKUWw9sQZr6abbenb
 0C6AdJKkbve8wNyvuw/3zMKAtnm4W/ybZCjanO3X9SIjn1osC2YyRG1vKqxc6OHwR5prR+FvtBB
 aZDXJqF6cbgARjRGLAP++2PV6/MAFfBV9Nd2DWldb8/NSunc0W/POXeBTRr2Ile8ATSzeV/FC6z
 i2U+qhpYFcwChFFLLLwXNtXkiqgqzAUafIHw7658HB0FtOBpLa8VfiN5AGQU70EV5LvoEO3LHnc
 UFQVHwJdENJufysUggg5MT3huT7F6fzrFscn+6Plh1oaFM/+ZggRGxjU3dzvZOOkILNSFHm5kfM
 gIBdSoms1hsI70WGuk8mjdo7fJb1bw==
X-Proofpoint-GUID: 1xItApGnLpu3EJv7mZ8pn9qW5pcWWi9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606090074

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b9919d48c41ac09f1e 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description: |
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1

