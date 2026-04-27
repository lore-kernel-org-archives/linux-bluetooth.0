Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7830B533
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289763; cv=none; b=Vpatl4nxg4WOMHj3bSrWETn5fXYF6rth9UJlJOG/bfJ17/NtDN9zYrtIfgjM4N3/Rkpau8wKcF5HwtbQSbXmeJYbmFLQdIy1fEgt1+aocaheJ4M9MLWf73EvvY1NWf5/UCnNQ0rEp4v1RaKXAFgKlo0I/oSbS3gF58qciGVss68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289763; c=relaxed/simple;
	bh=C2MupbCihLMMxdAqiULKdFQISREaqVY6L2PVda6Xn/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nljgbgt+uWJlvT1VLedpMQpiBQcZVuNjZ7ru1tposPWsJc7L6JhXrEIYze8pHFZeA3wPc/Xn8PFz3Iga8ntmJteFZs2jQSdjYKCgpFPIbsR4LAXHVgANCAYZX+WQIJqGYIXhX87vLLHp42//NJ48gGaRHPZioRWKz2/4a3EqaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=olRyWC+s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eBkLqgEr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="olRyWC+s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBkLqgEr"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8T7d42913800
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UrPYU8jpATx
	6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=; b=olRyWC+sfceJtQcYJk3f87wsUSC
	UWBFpTr+inXI/5j/b5DarworhGP5FP/YMpUw/Cx1zdfr+YvnvZVY3bO7PzPMBhub
	X29pfG8lCZ/nGAPkegxDoLTbQGKNiiJxivm+w4CQxkr7eN2A3/6dr14vs7npmiMk
	iAr/ClK+wwbF+sQTxkqq4HseM1EI0NHPh/wKPpsixhKSMCUrrk8n8j+ZvP0Ks9jV
	PeXPPeJhSkJ59hVqd5q1gmuy9MouIEEeIHEE28SqUiHvaxVsegvzfuco35fEjHdM
	MhYsr33JJ2vF/CXmZHc8OgbmsjQ4O+oAbJsnKU57o8U+IBj9FZSFwWOOq8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xh8jf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2ed279eedso69287495ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777289757; x=1777894557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=eBkLqgErbu5XsLLx+hqj/pgnTmGo8wdlYW7LAjYIv3J24Ho4VXm0b2MoF9NM/VkYRj
         ZGrWJxU+GBTbq9XlV9SGguMAQw5CwsQoRH3mfdnu7TqjzXB6M1Ws46D7lBfR5KMPuuGd
         fXhJJGAFuv6tnO2dYyOWsKa/PMgTlCdxp3YHpUKjUCOczGBwxImtxRVBdb6zLm9RKzsa
         ZGhyRAUU/fYB4P2aSmw7MmEpJ19KGkwa7DVksPwY3qz9MLy1C6MkSq9ho4UgQUUZXUo8
         6kXW4ZxaM99fEW7A3xtjGKw3uk1tCbzu16Vz9lnuh//0JWclJYN6hIOkW1J51UfmY+rD
         BlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289757; x=1777894557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=bLVc4s7IeqtxkD0k2wraPaGblapZTmi62EphUGt+vWo1623TIXqODwFJqFMeoxTixq
         HRXdH8NN3BBViinej9ZScPIx3dsGrWDRcnFcVu+7B14kHt6aPePf+ZudrHYMqewQbuem
         iqnxwG2pnC/eZ2I/GalDpVpzyMRhSRvZlr5WmNAmDjnCMXJCMvNy8bBwrA/mKsoIF7vE
         JpFHzsVIZhqx2tKAtBxgXrc8lu/G8Yf0L4/J/5zpH41xu8MLjjJ0mPwrn5EwZzN2hY+W
         lozqOPkVfeO70FuOJbut934ZU5PZBPVmyr9Hc9Bg5ODxl2kfsFefNtxhfiFwaiEylcv4
         rPSA==
X-Gm-Message-State: AOJu0YyNS9sOoCd0hOON9eHA+xgVS3JuiKzjtFnW0Fv0R9TK1XdeDOig
	TtUig1vNkD4PObOvYHwQLZvD+Y/Zc2jwmWokLQVCus7OfuJVUSACuONKkg5mpW9Q5l3gc6qfJ0y
	WNi2p2u7tHkks9RbVxTWHeh3hWpFYWqb926q8iXHPPeeWyZL/QhYbs55T6rtos+rmVlUIIMCPWY
	YHTFM=
X-Gm-Gg: AeBDiet50nFWK99KxMs4WJq7LSsdWmInnsdW7eQMIq6nI9ZmpALwSMTWDSSynNRqReX
	vJz0mEkI76X1RD2F5dNkKwHsH61ytQQwJfl2CDJcTEVJZF+dz2NfOd3hp0rtOtDhava6lY7Iwc3
	p8TI1fhszCCEIVylpjP6KFq4ptuox4q77KkDpyrXA6zCGHBk0qRHJ9683GDxzrRRFo35dR8oH0l
	Xzk9w0p95PkBpMIoIx+bVNUfWZx9kIp6KPOAQZUMG9OMpF5/9ztBY1E52lOq4TMpvLsZvqmmKff
	L4s+qk1xTHIbHgtB/8cUWb/5G63IkCU2RZJuLY1+0Zp7dQpbmideZNJIDvk2odSfA/G1MQApEDG
	yenxTu74ylWI1GiyKUfDHvMibZXfZivWvY47ucYUNGmR01EWO6deoVQ==
X-Received: by 2002:a17:903:38c4:b0:2b0:6d56:8d29 with SMTP id d9443c01a7336-2b5f9f3b3edmr509082235ad.32.1777289757084;
        Mon, 27 Apr 2026 04:35:57 -0700 (PDT)
X-Received: by 2002:a17:903:38c4:b0:2b0:6d56:8d29 with SMTP id d9443c01a7336-2b5f9f3b3edmr509081815ad.32.1777289756490;
        Mon, 27 Apr 2026 04:35:56 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm282921055ad.23.2026.04.27.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:35:56 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v3 3/3] profiles/ranging: Read cs_mode_one_data members as per spec
Date: Mon, 27 Apr 2026 17:05:44 +0530
Message-Id: <20260427113544.1063560-4-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427113544.1063560-1-prathm@qti.qualcomm.com>
References: <20260427113544.1063560-1-prathm@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fawe6VIf2fPnipfiWk1mmHOkYm8o8Kr_
X-Proofpoint-ORIG-GUID: Fawe6VIf2fPnipfiWk1mmHOkYm8o8Kr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyMyBTYWx0ZWRfX8DUOguKKp7H6
 asgfkI8NrRy8tW6Zl7S6ZfCXFQ7xflVu7FOlyh1t8OJyflLxX88x28sl9b2OO3K0RHiAbPQgvoA
 hYjZxoRQz6KPkApntrO+vVy7CgcM0KCGdIjkqpKAr5NKnrZY9vLXn7W0zd2n+oiZlF1xkAXgEzj
 /eEQ8+jVtAAkbQ3x7CwWj/1mPfX5rg2mmVDAQrH5/yJsbzdFZKsbNiYBSFfSjCXIVo5C9xqs+KO
 TTm+hhZ8zthDdXH6hl4CR1kb4jBuI7yFjBWnKVnuVkr4HbDog5XJ8l5ajbPRyf3qEPxH7lyZ/4F
 YEw5NPphi0JFOMPbzuHp5AqEyivvxY5pXUbZAoAWNPiYM054U3su33fbd71MNBlQlRKntf/PB7p
 u0ana2JlOuUPA7KU5RIoL9AsINW5yynoZ9JbWF3ucDZdP7zPLp+3G3+SpO/D+GlEAn2lAIbAtML
 Qo5cInKsPGbnMHbmqNg==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef4a1e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VE_zAK7Kjm7KZJZHiogA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270123

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Rearrage reading of cs_mode_one_data struct members as per spec.
---
 profiles/ranging/rap_hci.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index a3d2df608..08ddc077c 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -632,19 +632,22 @@ static void parse_mode_one_data(struct iovec *iov,
 	}
 
 	DBG("CS Step mode 1");
-	util_iov_pull_u8(iov, &mode_data->packet_quality);
-	util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
-	util_iov_pull_u8(iov, &mode_data->packet_ant);
-	util_iov_pull_u8(iov, &mode_data->packet_nadm);
-
-	if (iov->iov_len >= 2) {
-		util_iov_pull_le16(iov, &time_val);
-		if (cs_role == CS_REFLECTOR)
-			mode_data->tod_toa_refl = time_val;
-		else
-			mode_data->toa_tod_init = time_val;
+	/* Parse fixed fields in specification order */
+	if (!util_iov_pull_u8(iov, &mode_data->packet_quality) ||
+		!util_iov_pull_u8(iov, &mode_data->packet_nadm) ||
+		!util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm) ||
+		!util_iov_pull_le16(iov, &time_val) ||
+		!util_iov_pull_u8(iov, &mode_data->packet_ant)) {
+		DBG("Mode 1: failed to parse basic fields");
+		memset(mode_data, 0, sizeof(*mode_data));
+		return;
 	}
 
+	if (cs_role == CS_REFLECTOR)
+		mode_data->tod_toa_refl = time_val;
+	else
+		mode_data->toa_tod_init = time_val;
+
 	if ((cs_rtt_type == 0x01 || cs_rtt_type == 0x02) &&
 		iov->iov_len >= 6) {
 		int16_t i_val, q_val;
-- 
2.34.1

