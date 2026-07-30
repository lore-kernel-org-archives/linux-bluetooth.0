Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B462448BBE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427255; cv=none; b=PC3cZVMiTsm3wsOqG84wrIMstki2HkvqUEaNlDWHySextb6m7ovS9ClzuaGkQnc7VLKhN4E5/f6aZ8k5/2c4Kc/oQmL6cUZfuoXch+WGqbeNNub3MOEDUBXx0777LtUK6pP4o9O0crBjreJRgABDFBzl27o0OwXP6QZi9b7IG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427255; c=relaxed/simple;
	bh=NYZrwdZQ8Unx+4+MfgqEtix1DA4oaM8IOP1pJXmdN5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbL1Zdk8tr3BGoS4VvrUL2GJw71TvjAEL9mNoPWTNGXxPE/44QxEmJOoAsV5DBxdOipV0vgdzLiKdRUeFfVH/cM5jM8Ni8jhOnVwTQa4LTTnIJK283px/5cZGh8uUWCMGmcCM4hLyrUyfJkixBof7c9l2Gua0NTljQG59Zk3wSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M/jRX1Tp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/pJ9Zsr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M/jRX1Tp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/pJ9Zsr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQppR1414230
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=; b=M/jRX1TpvMeqUO/P
	PVSImvtbdOfYbcOhO0VXezo+gXswQjqaHNvsJ3Mbp0b8x8Kyeye2BSJbUG+/C4Rt
	9KdEnjt9DqMob4WOB+dpqLM+JfKHUAxy5gSjY/BtUJQncrKHUO3/rZv5R7u03tOr
	AXHcTNZy+Q2+koiThYECm5Vu07/NgdJWrdfhJ3F7qhjr9L6LeZ5c50O+NZVOiuce
	JCPyjNPfpScmNOyxtR2uei4gtyrYng/bz0zpFaKDRapZKZNBpGa0ocmPhQ/ESFPY
	ubUJ+4lOJYsrXa2QlWRB0oI7usRTN7gqiJfSihZeCr9DbkBPMJ1bF3tPXJbYuewE
	5jcxEQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr891gjaa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52769fc3f2eso25352531cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427252; x=1786032052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=a/pJ9ZsrhOmMRU9FoPQR6x8VhHL2NXztqxJbHBClWmZCsGaifmSkgoT26DIye6jg8H
         1HPYGoBCT6ENWwfnbuKOxxvVxYLxm5ec3Lcqe7rzh8HW2Exooboc6aVKe0UKar5nvvGh
         tX52XPrCFlHlvghGPcBQknnrFJxItyqS3ezHWPePiIShcTxFYvfeHLqbfCcDehZclCuq
         +cyFkfTexoD9XRmMxD0k99NbgmBbAn38AGfYbkfnG7xBVRUN1uDXogOdYoqH7MLZOZb5
         rqbNMvcptI+grRALRNyBfLHG76sWlqbnmYyNLaAE4G7lQRNfVxy80rH2VIecGLHX98ku
         xRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427252; x=1786032052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=excQWZb4moZsAW0VfyvtyYFO/Ajk4PIz3tcKm5jfwd/Tp7zZh1QCUwQbyNZdxnhBi6
         dKT+v52/xT4+b8i1Y+Tt68h7Gd9nfg9KDY1JXQ7G71x2bhrUYe552sClbzIwA5Tz27du
         DP4t30DOLvsPnJYfEgyBT3U88cWctIT8dRj0ntS1AmEuELGUX9wza5DlMQPzx28iGVMH
         1MSw21w4+8LM3wDTcFfPDd2mUJ4023Pj2cgD6DayW2TmxD1500579jyeQJU5NKZx0nI4
         T+ZM2swvGa0OW3InK1CFzpNBlq243C2GrSDB2qe2UKZLwL6mmyMZoVAfOC0Tt+vXtPNb
         KUdw==
X-Forwarded-Encrypted: i=1; AHgh+RpAc8ND+8U/D3+GEhs0dryNd5cfdqrhe5Kk1L7PnNPO3H+RJqRbSNQkulXUY4AOVIpw2hjhrO5BuckIbp2WXyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZGBQD+HmmqWPadjFVhzbZJ+6ANlTOUXPDiNN9doC60ztzU3Z
	qp3aLTME4AC057665TcKL8VnKeeyF8wYnIK/7favLLipUUWHeyD6MVlUOMs4vzWqZdhiGOGT+dx
	WOikSwwsBB82U9l0qExe+pjakTW1RM+ZQlcvZ07tHI/NWaO0W0/M6aGZvQ2bfxfIS3l9ickE=
X-Gm-Gg: AR+sD12DFdmi6q1xSe9579b3Ek2amAREoJiEl0SS6UVK8eniuD5rpfCvY/pm4IR2ltd
	qdqtMsXjXLx5A7G9WP1vhxevxoX7hJic5tLj3FF60EDTkS2NHUlbRWIqEYq7+cneEDz6b/fdwOg
	rnRcqcRRQWwQYzsVUjduBIobtOOseQ/u2HmR5NHn2qFuYobKBSjep6eyzHymR2+CVqF7G+1PKZ5
	tIYZwiuRvW8hXI0kGaJewWc8y65UKRJpMUCWhneXhte3q2hj8cs0xW8f0eccSKBZ6LH69OfO9cj
	xVc0xP/wEaV1DGqoefcIdwX9vblioedVhIQ/+U3CtAKeQuZDGGZZMN7u4/Mq3tKG2i3A9T5DBQw
	7Jg33Fds61GUrKQfRsFi+kZqYY5upp7q0FYffcXK3Da9SJ4nS/vBliZWV5KUmo7KWgg0cLjcraS
	ja6tBJ+y7cHsqFrt/uOIVB2J4fFkJyxsMgs+WnW4YcaplNyp9ViZ/L
X-Received: by 2002:a05:622a:4d8a:b0:527:73a7:ee21 with SMTP id d75a77b69052e-52b3871bcddmr35046721cf.86.1785427252082;
        Thu, 30 Jul 2026 09:00:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8a:b0:527:73a7:ee21 with SMTP id d75a77b69052e-52b3871bcddmr35046061cf.86.1785427251550;
        Thu, 30 Jul 2026 09:00:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:34 +0200
Subject: [PATCH v9 04/10] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-4-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXwI4/xuhHk1N+
 AKGXYYrDqoxibFOdiMriKvYyjJl0HRB6Frqhy1XNK6JcayNYsHZtTyA3EgsKnXZI3+Qm+a+v6kR
 RM4BkCAP8hKEFfRvPJtYakSWJafDKEdsmQNdre7uoOwKfJQWKht8jt09gpZx2sQ+zQcCvyvDTAn
 N0q5B0myQIK5v0ffvsqY/ar5+9p51xgtv9fYmHjYhawqsQSvagzOOgKeWMeEOkLUQRs4woaKvU8
 xrnE+BnQ7GAQUVnD8a/iOdEbhIi3cELxk+b7CmvNcu6Zdj807tRCaQF6qRwNOs3hqsL5HKld5km
 cFRU8QaITBgJosWGRWn6NlBxGFNimA07GO5ih7fB5pQTy2qfEHtq6NYjh6VeKaMRMR4stNU9HpA
 xtsJP1eSI0nbgruy1YDGraKDgDM2nUAJBqBSsXZzLNPtTK29EmJI/Bjz+e6dfRmiNp34vU6a+BT
 QjP9LjwLoNAjbj88yFg==
X-Proofpoint-ORIG-GUID: NpntkdzaooJsW1kkr60E_BUqSVKo07Cz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXyLVeAQaVcehv
 8fkcQJ+CqXYQJOgc8J3uV69dhuQPKB9dW+c+9uD4syZS/YKe4b9xTosAZp9ljso6QTRFk9SVFyo
 jh3iLjBbjGeQsGbeZNMoOOZLbOHqphc=
X-Authority-Analysis: v=2.4 cv=PdzPQChd c=1 sm=1 tr=0 ts=6a6b7535 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: NpntkdzaooJsW1kkr60E_BUqSVKo07Cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1

