Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD435392C2F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343486; cv=none; b=d5MHzf3ls2Tj2OPloqiHqePz4Y7EDhuJ/Nt4BsSyIXC3Et8CCMv2DD4br1uWsAaVScaZdRxY2SEG1jCDqFFXA1t+tGnO7GkEu2Hlp7a2SZKCTDDcA19i21MjO03TqSOqYYh6XYCCbJLjLBu6OrFHXh4gglOKxOdyCi2/IWiKYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343486; c=relaxed/simple;
	bh=C2MupbCihLMMxdAqiULKdFQISREaqVY6L2PVda6Xn/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsVa2aWvI1s4kCZM+LWsoSH/qvz+gbzS3rdKtENZ31xYd9VgXLEXjhaWRJoXDDhE9hNCMlWFncoEDG5gZrZHKMJ/o0ZeTUuQNLDuh8cdS/85FFzIlkdEYkbmUMGy9l2FJM05hI3feXtGitMdLDl0bLaqXiQRLeLSeN8VdnHKPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eQIqiSW/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4LotcSl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQIqiSW/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4LotcSl"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RK0rON2383098
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UrPYU8jpATx
	6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=; b=eQIqiSW/3MG8kYpGkaij6bef6hY
	Wa0adAIW8gOka00FkjxgNft2nd5cd29FqA67eAMe85eLvaguN5YmDASQYBHdVtpq
	WErfrNdRpHgwpwer+us8XxC5B83rHdlDJp5R93u1aC4T986XYXUI6FIKfysH5OBh
	sQH4CoI1MdRQCX9f8GB0bVF4NKeFEMDjsBt2quxbVRpIGnfQx92/bgaZaAX2BvuN
	pelfbFjCdXFea5zkAVaZ4+qlGUNfwqFU1mrepkXZPIZ76dERDCMeFL/is/ovgUri
	7hQThREXqXcvO6FZpAEqZ+QxX9wdUCDLksVr2lUXFmMzXbvfasHCtXYpRvw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xtu9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:31:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24308165dso154140595ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777343483; x=1777948283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=L4LotcSl6Kpidd9+awUj4/Hytp1qCrY88gZow8K2B1rv2AjKlmcYUXuzY2owTibEDk
         QOnuK0JTSMCbqM2hZfXUj0oxJnP+T1cZYK8Rraw00KUAZySLmbkQhxZmQuTxqn7mTY+T
         FERF0RhRqwA8RRlwSVSnokqUvhi6sDP7rULtM+m1Rn51tlcpaLgWV9RttruG5+vMjTFC
         H4j1Oq0Ux9wSuMZQ/T9jaufeJiAIXERSJfNT/qcTYLHDAGgIQg6eUCBSVjI3yDkdnqT7
         y+rm9IEiJoiwM2xrAv67NVeeoX/+ZNJiEZmyqY+5MDgtkqtXoTc1m+HV2V5CIlb9fbMT
         87VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343483; x=1777948283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrPYU8jpATx6dYibgt5k/bs2swMIqC1AsufUhUTJ12E=;
        b=oW1deQ2svdydc5xIgKNT+U8yCuaW80T0NuxwCbDQVKV55rSZYuzEZ1q+BJYm+L0nzp
         SRV42QLpHui3wZRqrZSb7Iv9yVhF8R2NWXMj8sTKvmq0x0bF0hUE5lKQhghqpABJcDWa
         WVZi/3Pw3fLkjfUjIqfAhovpefleryyQ1c0zLE0X0iY0PoOG/GW6RJIR/I0njpApReDZ
         SAZAIKLJDyVXtWTYw8XvbwxHS9fWdjF2/pmhzRhzRwr+Fv0GpsSh30OO/YSZU3T/cu3N
         movqFS4QmSLltPB1DtzITDpy/lJeh4MzIx3AlbLXlkeIjyMR9W0dYKKvvkGep15cokja
         e9WQ==
X-Gm-Message-State: AOJu0YzSn9xrSm6KB6qui12M/KsNz/I9MtbB5i4xe5UJJriGfVOQC3m5
	53ilBFbTNqB4ZByChzkOSlvZWUCew6Dqw+g9jeR2bCgRakNSXkAgl4Uehk3Q3elFdORCBl1moGk
	tgwP/JYLKJHp4OFEhFDcGDqpQ8FqUuG0iIvDmMaHfJ9Pjf2ydK7DtBLjDsXUpab7NKBZlmhUTwA
	aTThw=
X-Gm-Gg: AeBDievz2qE+vljqDkcqKaimWPQxoJQ7TuBeAjuJfbzShFwmgDkpfAhiO9bZS3hbCgh
	Jgyg1fIZtYNmmGI/yWiE//Y7XNUZxlrMQW1uxLMcj8kWeIgxELq9Apy3wds4dYwu18wuV2jKGF+
	1zumlljDFdC3UF2dHp8mXHpCjr4Sqx+yB21ATgREm2bScOtnH8t64QshiWbl5FzZvR3zjatnbS0
	8wCKRUDo22l28tyZc+1g6Qfi7MgDQliSj0iL2XgZhBYdsFfz+SHmuqsgsTsyGRUHvHCIZJ8fv1V
	/ImvYqDkLhbJBMHClqGMYroMTSqfUigArs0TSSoeyhoLj8P58yghuTsrfMg+RgMrOdo1Ele3nYB
	9S2LXqWNPmlweobgT9/dEtq0YBVi880QaZ+j8/QZ1tmksxBzQFLLljw==
X-Received: by 2002:a17:902:d2cb:b0:2b2:4c58:5ba7 with SMTP id d9443c01a7336-2b97c47c73bmr12372405ad.30.1777343483312;
        Mon, 27 Apr 2026 19:31:23 -0700 (PDT)
X-Received: by 2002:a17:902:d2cb:b0:2b2:4c58:5ba7 with SMTP id d9443c01a7336-2b97c47c73bmr12372105ad.30.1777343482829;
        Mon, 27 Apr 2026 19:31:22 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aa7bbbasm8478305ad.3.2026.04.27.19.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:31:22 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5 3/3] profiles/ranging: Read cs_mode_one_data members
Date: Tue, 28 Apr 2026 08:01:11 +0530
Message-Id: <20260428023111.1640377-4-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428023111.1640377-1-prathm@qti.qualcomm.com>
References: <20260428023111.1640377-1-prathm@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69f01bfc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VE_zAK7Kjm7KZJZHiogA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: kR5TTJJD22mRQi4en0k-4cVc9F_BHwX3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyMiBTYWx0ZWRfX6k17658R6Hoo
 L/ulTVwtZeRy59usnxaYO6KLVUHvKOeFyD4oyDPZ/qio9Z/jCQ8r4WYToX9EPpHzjvQmQ50z0Cc
 u3Us6YZnOekL/vvy+unG/HuAPvUIN8gVmP9q32jxgNgRHz+bF67dAQhad/vQWpS1nQYUlYKuCbi
 t1tjm6kacw+ZKEqnv6WaY3XP1psa/1JiIQFXIBx9Z2IVrkLRsXowh3eeqzFJ4+XcASMKFpUaetK
 SuFAU/tNyKEC5G1W1yw7ANGC7v1vFFFkBupcL9RZXUdRovp1L1da9u1TMF902UTAYieP4xHqG8T
 ikTI2ulNTV0aEGQNHGdZT97/Bc9LpoAsJxuOIYEMmA3c8GJkA64TbJau1jBG33sbk433anAE5i1
 IcNexyTxq9CT2tT5n+2xdfu+WdZnw1q6J3WWy1a19kec6VBD53cXvC1aCfl2iZDbF+c7MB/5h88
 ggVzzXvBdAEEGeBs2kw==
X-Proofpoint-GUID: kR5TTJJD22mRQi4en0k-4cVc9F_BHwX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280022

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

