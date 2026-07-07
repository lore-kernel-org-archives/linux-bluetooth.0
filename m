Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676AD39DBCF
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406151; cv=none; b=NcICRzlrZ/hHR3m6Zi50naxK4KvZ89MYmsOarwasbvXdF4IQ66T+lpNmgWAiOzO+Z+7GAIlBBSIEmz+XA86jChdIZtoTKhITOhhvkggqJDs/L1K9wLOSDRNP0AgvOQjJEa/q+SNQKXCNe3ZSRwWS/jyrAMsI01PIslkwkd2Pv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406151; c=relaxed/simple;
	bh=YmC0eLJ/iKfmgVQ0x1E1KmWuJTXYtXzuHUB/KShKBf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDgQYDin3mY2rFaDMQT6yihdGo2wIOBKloFSyXOZQ8ghW7dD/OCrG7W9lsQxKL7nnLXZymmgyb/9UXbI2ONnBU3v/G7muVsoOZBHl2x1A18hlECL0Y/KcR1F7sWXJtEHuBpYeCaxbiukq2MoKVChKPRUwfTSXYzDnwmZLByhSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lN2AIj2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jakh1D/+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lN2AIj2w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jakh1D/+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748q4Y2669613
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Jul 2026 06:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+x9MVjr4J2HLgnCMZmHyAg8D17bj5jRyWb9
	Ldg6LjUE=; b=lN2AIj2wEfZXY/aT4pBPyyEadIL1LKVMOmwyi7+60EumwZW4cZe
	pbpzNaSNZnGiVhRgHLFHkOZqqTHtLeGmi4wWLfr2viWID4cIcMZnvGKNdZmVjp8v
	M7qXn6Z6APEznq+t3WYf87QnGqWeWxVUCVMlAURIfYNoFOAlhfsW75yJ7nhu6Uho
	zAjbzvP8AdOIujjjh8xLttEjUUSPnWnncXtMGhX812c23Lg1ci9vsev6v0H9vIOB
	SgmfMJu0KhI1L5AnlooWdUpeDzXbHFSnCLg3f5SK9mWpJuQvIBEqW8Geaiyg2H+w
	0P/vJMk9Jotrv2XunRKZjbbADqmijaQj0wQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgvmd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 06:35:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c80f89b64bso68083895ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783406149; x=1784010949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+x9MVjr4J2HLgnCMZmHyAg8D17bj5jRyWb9Ldg6LjUE=;
        b=Jakh1D/+TeTDvrLpHKccItcUKnGecLod1IDXncHZlxLiInJ+fpBc5PdbjNd+Qc+tls
         gBhpT0Y62dI1WU1yYklSWnKi7xr/ebPng4hfhtouHAYOBM4CDSou5ME32XFLhKzP7VgB
         Ra658gbHxIekOCnQewFq4qJyFBG/Q3/PHTiydIxiaxX2VJZlW2JEFWuLNpvXYTWGi/yp
         3XSVB639m5kBnmQx1KIXOmcbFwIqsIlusbnrQ7Ae7mPemiKrDo7+nYivJ4MadsSIu/0d
         ClEWQ7v9+6vs8vxeRZIoF7i67RhyY2E7Y7VHMzBXxrXwFgawvnVR7TgB8RgzniJV2jx6
         OASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406149; x=1784010949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x9MVjr4J2HLgnCMZmHyAg8D17bj5jRyWb9Ldg6LjUE=;
        b=efS2yHO0IHjvifGsOTr52FopyqDZOy27i3HP6RYg38iFIkXs3l7I8vBLrTNShzvxjS
         nkNyS/gi5DkT7joO7i2G9ZwUqheyL9MgO9eTGn4aLjBZxrd2+G5mzyTFlEvRS3EoBebJ
         RQ+LJ9a3zngimUiBo3Z26mGjPOP7utnS88cYfryYah6c0mpQ7fAY0qpmMq9C1X9J7NGC
         PZjE3XZL3D9lpS9I7svu+MQaKY64dUiNmLUxRGcIjpiTlQbHuUtQ/5OBslpNKuGmXp7G
         YPAv7Bon/v9iHditO2bvTPjDpuSUHQra8KlsM0y3yIg5RS6mMTZDvEhrh3nzh1iczDfb
         jYrQ==
X-Gm-Message-State: AOJu0Yz6hMY5yzKfv7fJ015g1Ge+f6b8X1bw25G5MtZsVgSCHH6e9ddd
	KK4HliBoy9DFPBJ6R5FivBqxxUXiCpxfwzYMn4o8h74KGw8VI0Qi31Ph2HaVQBRe45LIkoHB++i
	J8R05ap5/fBBaJ5S1xjNqUalno7D4ODSjDSh0RRSXOsVl8Z1xxCFImLaJ7/Hal19AUn0ByiW4bB
	ODuAQ=
X-Gm-Gg: AfdE7clxkdQYbDSELQFnlbpDwel9P7Ti/wvBLrQiuULVodnw+jqcGW+iSGgM6kGdcmx
	o3URhur7Uu4UIcFfIPS79Fn9oGEsnmdJ7D1XQPpF4qKav5DAjSw2fGvwdzjhp+Ww94NJ3aSpi0Y
	n55auoCnGfwsomp4oP7635ZSEMBzU2EmlbOLJ3/NUhN4wZRZ+DBg4O6aXYkjUdX/P/lhzOzFbO2
	jnYBBCCDxtYgNnayIqY6PPQ7waTbwxHLbq9uH6CTGxUBWBPCy2q6novJondErsxuP3jDN8n9ehq
	28/hi64b5izSrWt/GRl9vbK2wrOhlUKshcsm0KGQ3lPpM6YW0GSpz/16qjwhWKKHPm8ZR70Pic0
	ICvCgHlaqiXGMnBzbGpdbMF5VOC3JLOnaQmhQjMZA
X-Received: by 2002:a17:902:ff8e:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2ccbe628ac2mr40295925ad.16.1783406149044;
        Mon, 06 Jul 2026 23:35:49 -0700 (PDT)
X-Received: by 2002:a17:902:ff8e:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2ccbe628ac2mr40295735ad.16.1783406148586;
        Mon, 06 Jul 2026 23:35:48 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1ea7fsm6035045ad.38.2026.07.06.23.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:35:48 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Rahul Samana <rahul.samana@oss.qualcomm.com>
Subject: [PATCH v1] gobex: Fix use-after-free when cancelling SRM PUT transfer
Date: Tue,  7 Jul 2026 12:05:43 +0530
Message-Id: <20260707063543.80320-1-rahul.samana@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jtZkMUvg9FpiWhAU4cQ8Qx3o05LFZlGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2MSBTYWx0ZWRfXywt8MVvFLe2N
 ykfkPYZJYGhUNs+XuLowFqrUkppb/sEIwH97vWIEZW0Tm9wiU2D08iIoDSRrQWHkmuTCowbwzEZ
 kpLSyaMVesMQ4lM6saAHOEueg5bwx+rCI9OESFvE6cuQduWwqdOMws3hT+MJ2kcBCg66nCvJw5t
 /8GQmlcqvpYBhHm9gV2FlYrChXsnTini8Q5iBBETVJXiLq4wGgGunY3Z4n8wH+B2yKcDwsLagHx
 FqAkoLGMM4nRHvEe5rHGBFaZzkvziOfIMl2af0lphndPMBWbZY3P8KYS82sr1Gy8N1NGDv2lL/r
 lr3pKcmsRu+QQITo24teBvMTczz7Pgo4HUxr8ZpPbhIaH1mfEngPdQ9ijE44ump+NBokwT5DGXd
 18ATTcLjzTyLOlcE8JiWpiobAwp6t3N96cvqsJBvJy36IKxUkiTWB+q8yoZ1Ah8s8kzRg7xV/zW
 UNHbBOch86kU0JjjTzQ==
X-Proofpoint-ORIG-GUID: jtZkMUvg9FpiWhAU4cQ8Qx3o05LFZlGW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2MSBTYWx0ZWRfXw2IQXFF8BjYp
 LFnE3K/MFchtAQj/KoGBDxe6LxZQIsp0hdBWrMiUb57nCxW2k6FtWvCXZejNfZziKsnc+LnQerM
 P506TIqLAIe1K4mDc2JM/dUgh2xv4c0=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c9e45 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=NQ0E5NPx2nxNijSLWlEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070061

In SRM mode put_get_data() queues the next packet during encoding of
the current one, so transfer->req_id and pending_req->id can diverge.
When g_obex_cancel_transfer() cancels the queued packet from tx_queue,
cancel_complete() frees the transfer while pending_req still holds a
callback pointing to it. Its G_OBEX_DEFAULT_TIMEOUT (10s) then fires
on freed memory causing a SIGSEGV.

Fix by clearing pending_req->rsp_func if it belongs to the same
transfer being cancelled.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 gobex/gobex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index df80d79f3..10a438391 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -861,6 +861,14 @@ gboolean g_obex_cancel_req(GObex *obex, guint req_id, gboolean remove_callback)
 
 	g_queue_delete_link(obex->tx_queue, match);
 
+	/* In SRM mode pending_req may belong to the same transfer but carry
+	 * a different req_id. Clear its callback to avoid use-after-free
+	 * when its timeout fires after transfer_free().
+	 */
+	if (remove_callback && obex->pending_req &&
+				obex->pending_req->rsp_data == p->rsp_data)
+		obex->pending_req->rsp_func = NULL;
+
 immediate_completion:
 	p->cancelled = TRUE;
 	p->obex = g_obex_ref(obex);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

