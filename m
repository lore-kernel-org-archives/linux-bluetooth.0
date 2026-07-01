Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5F4921A9
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921650; cv=none; b=RCKHXktwHJ0NHXsIzPcsDydMFSbR3tx9u+Yqt1OKrvNgX31jSm/95AG0XixYX0SrXqoHvGzvFRU0Tk0rbGtqGbD9h1MtMuLOk+ZlRD7L0P48LHOFHqsOSn+sHWaknwN2JoB7+E1nbU+2qVEyCE3EaVeXUfDLmjf31JSvTpSOIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921650; c=relaxed/simple;
	bh=zkO7UGTBhc0abSbmAA7xbPJx3KQa3FMC3+fWJRmAgxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNbM7nsgoQsQBFWurykX07nT1JHo2YJhoNDjvIlFfmi5Y1B2DDRSj6+psZLvhCkx4afOiQ8LvJd65GPf8PbbQ/avFVEgZycWhrIbIZhP7+rOLloaKufluC9JH2BE4CCNTlQCyE+u1b4LTaICiz0nAFKIGeZA/xZQv5WuZZ31Bjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nI3M/mnS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kL8aV5wZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nI3M/mnS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kL8aV5wZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FokvN1547618
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=; b=nI3M/mnSsplZXCvM
	E/yYWLSoIqVEdpGFBU5EwH/Gviv1hba+cB9tv/LWQc6yso+5yoIZl1/xERs98BVh
	sUlqRQWuUucfPwKyfl23pfghMzXqv9lYjjWJiAJlyLjAek/1pPn7EwsvDnP2KnMn
	aMGOlhKXkir+AMRgLkTzqcIl4N7QIjfUmZRiHs4qNQJZBFxExtThHLQ0YwH8Xc/8
	HseoertmTvfR5JrtSYZysP7IrkkfEcR6FYBk9RoiEfuCccjqN9ugmqnuryXBXknT
	oHIwJnvbojDg7qcYZGPfmki5GpS8DwHb7PMycCUrRljDrLi7zNo0MsCqNOVSHcH2
	K+DsXQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqshks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:00:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e52306621so81796085a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921644; x=1783526444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=kL8aV5wZQ75DbDd/KhPDeeDcNsFqRkCQKKF/7S8gT6sozYcodal/6N4+QrkwLBS/Cz
         Rl+9UBBguntxERTTfz1adO3iYQUsnafEzgevBqNEkJqhXciEjKleaaaBwu2fIq/qSRPn
         FLA2HukOvCBRJ7jhGZWEg5rH30NRHGI8MoDCtMeZ1Ru4J29I2P4DXqMZf9YrIUOi1ffP
         iy6q2Gg+Dhf1DwbLPuqoSUukEo4aS7jJRqvY2J66r3iyndIQfizE4+ZCMi77rqEib8UJ
         vUqf9YyiU9tCcyNlJZEUe6u95bCjuI2sPob8VH5NGIDkRJygT4XHStBkgiOYyiZeZ9co
         fLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921644; x=1783526444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwhIzMOLwD/T1MG78AEfie5XOqWGm9fdRJaKy1+95/o=;
        b=XjWKDttHin7TFIpj9NAxpbbPN3yejabA2nXb+1RDErxxmTnEZDdhdrRetp9H4eC1/Y
         t08bPNddXMXB7teZ8u+oMYMU7mE15aXCKEdcUIJ8sKqGacLB1T3zjilh8LX52tJlQ1tU
         uY1RM+FZ5wUFXTvY5azI4Gma/IHBfTjLX9fCUKNDaGgxSrKLCGjIt3ANT4RpPf6mOdyz
         dHfIfZyGzQGXivGmRbfdzuYXVqJjC1ayfE6RCMphO9gDFK9uBW7LCSUd+9FTTcD9NRnZ
         xo5VHHHmA9kFYtBF5AzYvhkxBNd4klzuvOMgzqHdcKueY+2NgYPkkECrb90pQBXmwc1b
         0Rcw==
X-Forwarded-Encrypted: i=1; AFNElJ8/+M2AFgZXd9SJza+aKpMXrPqXhW6eCH3pZtQBC5BCfOM9H6RZiJ66pUzXQYB5OhZa3jOzAMy1L+AOB8+hfGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4p0f509TbpuQd7f8Kt2ds+kvIVmSxca37gj4fcS2PvuJceYwX
	E564BTb02Au7ymYTnuaIvh3p6MhtypSKGPQFVJZ4gDKqG0rx/TIYUTzhvjtdds6mU2tbxK5zS6t
	YiaZB3lSB6QVRQzLFFHXjwcNrqLQkQvb0kn0IWN/jHmfod8uLp4YHqEQTdd4FvIxZZExTX7I=
X-Gm-Gg: AfdE7clriygHC+RlX8UGS7GVqrOFyCXjh1k9mrokv73xI/JrPAfQupHOpmzzDbRPBNd
	ZfhyoUe3snF4st2tQnOYkbDzJjenn657sJXfB7ouWH81iUmCFtMIUJmrZc8xPLgeeNmRkaf6uJU
	59UYj3PAeeem6KqNU/APWhtFgSRX4PbGrO85n/biqmKvQqBiyNo7IRMTwxnKXNeVoPMHvdaVp4F
	u8bC03v+aBr2TLcTYJUG4DqJhZdg+wet7WMO532HPHD1MeEG8qdBbnUdDzKvzm21fH3GKQ9JFWg
	9fjkj66j7pfEUMA7tUz7JmNKsw+xyXNUUiitBO7onqwLoSxqmkNBAeghb6VqaX6F0BoJ33Kb/TE
	i3TBneeP+8lTyozEWgM5GoTfqq2cSMvHQRiaF+apAA3zZgpWy31nCtGQIDsNHZxBoeTLPwmZN++
	lWLGwYGCykVUclRuWI0azChgkIS1gLYISplTNrAnkVrba9U/+kKgZ+Ih3VFSDcXfE=
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323529385a.28.1782921643164;
        Wed, 01 Jul 2026 09:00:43 -0700 (PDT)
X-Received: by 2002:a05:620a:6086:b0:92b:3720:bc59 with SMTP id af79cd13be357-92e782578b7mr323511985a.28.1782921642439;
        Wed, 01 Jul 2026 09:00:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:28 +0200
Subject: [PATCH v7 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-4-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: essw_BM_q1015HFpHdtKG9XKkW821c4E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXzBpr/cVQ+5nX
 dRK9EZtSC0Pzt/P1ZEOQGIzLwWWMq/5ZnXPR+4fe39syO5W//L3ysqX769tXY9O12L0srgEvJuy
 8KeEwBwVZ+0vnzleONpIIeaV+FtioMM=
X-Proofpoint-ORIG-GUID: essw_BM_q1015HFpHdtKG9XKkW821c4E
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a4539ac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX9bFDB40sC1rh
 m9+LbBaMuG+17vlMdpKHsA+OvwswD7ZBlxZcWPMFtYKjTYewTRcJ60Vz0ubu5FVF19Pgi9iAXLg
 UXck5CPynhpY1mNnfMk7dBKyHVvcqymZDHAihNSuMqikrxXyGQ8zdV/Awx4WhLj+0KR8Vk27WZI
 /fi9UNmrbiwig0Xfj/FdZyCuBW9NK9emjADkGFPgf6ESlEp6dpn6R2Gg3JvR1MvcsTECsMlOeVe
 6jroRwbi4y8xuMmuNTEtI4AV4kOkXtEwOECUDqvJl6I5ElHO1EKwWuipQQ3piUDzVpLTGiSvjCx
 YaruoJsApwcieEAEx0sd83utlmJrHOAP3bMdIVcMvgBjfl9jAwLPCqL2XZDQgdkXg8koOetdksS
 +6J+C1kdhlGIIzs4pJw2BI5VyWzw0m1F3+6Nwd4Uls06WJ0oc9ZKAv6jVdAsH7/d3bB3ApW+dZm
 YHSiFGh6xgCzikXxxGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

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

