Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684B3403F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826818; cv=none; b=iXdQPw8wmG4cePAJYMf75D1A8iKSB/FQmPtW2afp5c5ttv+a+0yd5G8jD4amRQU5rTAMt+5QLco9k4jdqHwu8U5uwptnnkw7YaTLAGRmBRaumF4Ivr1xwGoskG9NC8ERbTtQbSoY78k6rSABYrRLL3ImCDIGNuA6h5Jkbw1m6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826818; c=relaxed/simple;
	bh=rmtEq+aZuMgJqNY1iXngb3FKznWRV7odwzmb4AF7qhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzjeDpk/DX3rD7vvKrI2z19YPPjiyRC4JaO707AinV6HP/NFjIP1NksLsNkYb/e5Aa/LoL2ikHdJWedjt10RkCOeQ9JVf72d17RdCMaqlnDbTOaI3W4cUPpUO5lm2PceJIQiPafKGVORxszLci+2C/VGHSMIzpjp/xoY1tO9vCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+pbrQdi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HGo4Ij+V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+pbrQdi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HGo4Ij+V"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mnwC1542038
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8aXqj6VEa4q
	swaOTvjS9Wy29KZ/Ur9JPuvnuqfAH9Fg=; b=P+pbrQdivuXcnhlo/pxt8cjll32
	CSUQPR2yhehhwv90puIy3IvZlqVxF+aFRIJvTydn+keX5QxPFWBWvzxZMzHVufFf
	OU9PVBS/3ehx26Tb8WGVsb1F2b8QI6wwtLkaJp4UvhBoIgYeJPto4dwTB2kKtP6y
	1EGYskMgo1WBYrt2BmhOtFJD1KBfkIbsge8OkXIXPLmnvm9OGkMwXBaxSPJ/JHN7
	nG959QAyk819HyBvYZeL6ajWYaTuLAAKyR8yxo6dZ2Z+TBvnJ1EdiO9NDl8i7gCP
	BAf8j6kr9zGuRo66nx9sD0F7MALxjMORg2we0SpOqER4WkTGm+UpCPq/oDw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4jqqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c9bd8b9c7so5553707eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826816; x=1783431616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aXqj6VEa4qswaOTvjS9Wy29KZ/Ur9JPuvnuqfAH9Fg=;
        b=HGo4Ij+VAAOYq/Csgdbm08ognC2q9frQ6rcdQbLnTsWM4i/53ay+B+uP7Pzr4/wL55
         UPsXnNblwReS0AMqA5NYwgNkZafYc9wQVd4e9F0+EBZ/z20IIuKjoq1iFLzoKqLg170v
         iHPdQXtzjtOxMXD2ge+VB3cg1cNJQbAahFo1PqiKo0VrriPJ17j1rkiPLBhDB1myt35a
         f7CUU7dwzsMvFoow6+vIjhm/K7ERWKNOHD6fVry2Q/Kz63g+msruK65iZOP4WkHq5Tbv
         ubmmwXLMCMVxmsQSnLUutKgbi2c86fKAgoO1yCvoGg0iD1DGuQUCeiHzyh3pCAv00P18
         RTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826816; x=1783431616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8aXqj6VEa4qswaOTvjS9Wy29KZ/Ur9JPuvnuqfAH9Fg=;
        b=HesL3ZXOVA7IxsAJ2ZgLvuyOOa04j8UcAwUTQfcV4q6o7/s0Du8MuwVwbNKO+fvc9l
         GCugs/kmtew5Tgu5hPzY5D94YZTy97ksLJuSvtFJnfaA9OElVg8oGIUVAmuJ5TLatAvE
         v93P2BdyjQ0iUHKJ19eJHECEJsKSxoX5hR3KICKwESKQBp1D0bnbD6sttFAlwFNsiCYK
         hyO8/uHcazQsrAcXG9wbzg2wrU782e4gOf3gqz1hlrfViU2sJ1wwSWRqDOy92W0uTUFR
         MZR3dLTSKVBUtlhYvxdeXzsRvsk0SEgQV9EAU9aD7dobKjm/GPwLqSZ46pN782k2OPlT
         ICrw==
X-Gm-Message-State: AOJu0YxEfEB0JZmHpoJXpDou4nc2vJOk0U7/VdasGucqKDB7lfEmFAJp
	xrJkRrDPo4YiZ+cWUg2gdYC8qBpR9joCFEPaOygmKy/vVWlDFenKkj+EvYbVR7Np9js6mYO5kRh
	EQVGhsgZzWhwBgaeG36/BzuEXjKt0koMcANWjf7X1lL1wueZ/90eLW/Qt/dv6bS3CeQlytB/HbY
	3qKvU=
X-Gm-Gg: AfdE7ck/y+twRhzbQ/5Ntt4b84LxbZSZ9yymYV5j7dvh5SeQv1MdTOMjdzwi6xe/j1s
	lY/OoOKvFB7ESuc0JqqN2ErNOi8v4/MN4NXBbFHjLyA1/eCnwBnoMAnUtvC/E8b5sJF39Yt9d2v
	4UksxBXP+rCA5IbgtrU3UFsAdenXhmq9xbucBgaTJEKJijbFW2jVukSSsT1jHtEBXYOTy8BOhUL
	AZC5zaUvlVWooGTJq3VVLiP9Mcw6MYmZxN57lCY7F0TDgj+fpBH04KJt3NTCoh+rZ0Yrj5m+RaC
	ChqsRSjq+x50LH9iPqJVD7NZ1Ixms+wkDRYFmdhFqK0X5PGqDTaa+/JL/umaT5PuTxKH9d6MYIH
	5TW/pt8e9UavQ84inL3aJVX9G+wWMEs/ljLlO96GC
X-Received: by 2002:a05:693c:2d8a:b0:30e:c0d2:7ec0 with SMTP id 5a478bee46e88-30ee149b0c2mr2885596eec.39.1782826815851;
        Tue, 30 Jun 2026 06:40:15 -0700 (PDT)
X-Received: by 2002:a05:693c:2d8a:b0:30e:c0d2:7ec0 with SMTP id 5a478bee46e88-30ee149b0c2mr2885569eec.39.1782826815308;
        Tue, 30 Jun 2026 06:40:15 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm8704158eec.5.2026.06.30.06.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:40:15 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 6/6] shared: remove wrapper API
Date: Tue, 30 Jun 2026 19:09:40 +0530
Message-Id: <20260630133940.2461816-7-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
References: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zD8FXeVQw1Y2kOjIqQYMZDpinSv9-Djq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX1aByeLEU85xb
 JiSam3h2DxWBpbZ9hPiW3y0zVhhU5YgcWbnsGkEgrKpXehTh2viMKSb6//JL/hFNnD5n99tHYnG
 PePfXlN+UI+k8CsI468Ez5xAPy07+Q4=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43c740 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=hz3V2_9aOsqkU0mBppkA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: zD8FXeVQw1Y2kOjIqQYMZDpinSv9-Djq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX1IzDENqULFYQ
 f+0SBxFBc+lWJ4Vks+yalTHsE0t5bXGANFsGTm4g1QIwYXc0lgpEeeXFMCpRrQ7k/KBWmhqcm0f
 sN5eBFr1STd/AnQGtvvgU1lM13vQpfnCvZFw1Hte7rjjJ/d5Yh+MJy9xmt0avnYE40G3LE41KmB
 3wnznlIfSIi85Bjy3AjauZdZTwDXm1c+H1Hb7d3bn/HhnBwNO1S490vJbMFW1jNguBEtM/Wj5Zb
 zKZhVXu9VWkbu6cMWwSRk1Kfrw6455MZzmx3cls1cs/GJ3fsnB5ZIMOdpEGOOpUqXrDXMV6FZQi
 pvh5Ft9hve2bsIbwc9xCuyrReBa6hfKQ8I2YRCwGG/E1nUS5JgxF/Xy80nzU9THi6YUhhhN+sBQ
 OaXBYcahhTSCWnBiQ3HrwlHQeDBtwrHtpXog6RcQwPQJBwlcVuqYqpPuk/hQX7v/SJEDfEBU40a
 WtFvrg5XiSKpfZBJDEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300127

Remove bt_rap_attach_hci_v2 wrapper API
which was added to prevent compilation error
in individual patchsets
---
 src/shared/rap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/shared/rap.h b/src/shared/rap.h
index b6fce8b54..09d392e38 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -206,7 +206,6 @@ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 						  const void *param,
 						  void *user_data);
 
-void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci);
 void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
-- 

