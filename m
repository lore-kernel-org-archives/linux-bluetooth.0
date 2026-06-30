Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683E325483
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826814; cv=none; b=EnP5qWyRGpxtDgfJL9hAQRP7pXI2WlW6bfsLlNVXigpxWlz9QcJhn5+LiHm8G1dltS7wBjtcg3/lFu/2FeI8SbAjYo2iiI9KNeh2hklxRDn6SYMAtnqvkFmfKnEIbRTRxBfnXTuutZN/L9eOi7olnJKCZsZ97DmxDkbLEiopxkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826814; c=relaxed/simple;
	bh=d2aNMTN8+hunSS38zcukSOmwecqtZC5jpcsM0Akep50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTwJ43T96x5vT2sNCX5Bw/CcgIKwFPOyqlrsV3yGeQ6jIE5+BUI909rH6pwabFHY7s2v4whBcyMjQdOPJVeurvL1GiL9gJGevxosrhzriYZCeMmPXol7eAfPBAEHb5/tO1YBFZbRx1gobTq7esVHfhKSbypgSS+wM5i+9Ujbj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aoqQ1cDL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XZpgyWyC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aoqQ1cDL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZpgyWyC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mu9D1604830
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rekD2/6Ee8n
	++Es443VDyfHcNZ9NxgkcDTPd7FZZTlg=; b=aoqQ1cDLPsaPBy2WQWZC1A4/PZR
	q+M4XOi+UuEqJDKXHQigDllgyUXXky+6sV79ACObnzmrSE2cBrrwl2AuiwEayUdB
	zzkghRioTcst38TxgXd1ELm0R8Cakjd1AwOrNUApNZAoWH52ryMQzlTq/KJoy7w1
	CtldPqYRcDSerLMGDwMvQkhXREihExAmZc35ZIzLvp5uXob8bDe01FXEvru9Z774
	6swU8nk1bQHS89pm20dEUL353xW7klg063zmY930jRro1Lm1M7XIHec7N+Xu1iP8
	GZw7zBfN7Ak9bSFRmFaIki7t7VQd5mdMdFH7mFfT9nN6cXRRr6naTX5EA3w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfjx29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c1f6c5559so4982122eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826812; x=1783431612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rekD2/6Ee8n++Es443VDyfHcNZ9NxgkcDTPd7FZZTlg=;
        b=XZpgyWyCPkCbbipXhjiTSZSBZHNSM62Gmk5WRohvuXH/IjiuyXXaxN6fk/ngZgJAwa
         n6izkPWwEpbHcbNVMLR9PrcRBKvuds1EX1lt7HNeOldgqlIx1oBNX7PUTevxCuNb9Aj+
         xr3ah62dFrkTXwYQs9gvKZL/gz6IG9FQoVjXupQtkowR3VjDAkfqOR/hRmsvKqj5XES8
         fH/my6UFRty/2Z2C1FKa12/KUrmJ7YJ9AWDec47cv0xnGgz0TCH//Rkf9JgDH2lc6VoH
         5tjhqDSpxdzbHeqOd40sOCv8Q+Afu4uEA5fwLNi5wd1+0WdA6IzRcX1yLZbPFnel3HdC
         miQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826812; x=1783431612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rekD2/6Ee8n++Es443VDyfHcNZ9NxgkcDTPd7FZZTlg=;
        b=k5eAyM9AGPyLfS5Raia7/AjNe4mA2el2rWLCkODndtStAb5z1zTBm5zo57DmZgdx39
         uDm3Bgw4I+cjwo/rk6zMhV0U0Fg46mzN0+EEuVzbLAuraJfLuFLUUWZRJHrsHorPolsJ
         FKiCL7p1ZGwBFcf+P3BCXw7y/+z3qQTluVZ3sPLqf7Nbdypn/Uzz+0rTrbfD3UFMii6S
         gALykFJdwoRpRPGUkN92/tk4fSHaIz0gkG4VHfX5rYcq9gUu0MsulS/HYrp2Jz4oRIIx
         PAPwIDFOH0m3sSkJFeqhBdGQqy/tqTTfq7/35/en7KlFs9KmMBbUBlI5o2DJV1Q/cVAF
         9RgQ==
X-Gm-Message-State: AOJu0YzpZ7+Sk8xshF8acpjWRm+3RhqgLTaCT/N74onXuo+OQ8H4f6Xn
	6VT22s46LnWDv0SU79vzsTffv+i9M+bQKcYjh0qrEi1POeGNOTxweJqm2jnhzzTySiH94V3dC/1
	3vU+BxU/06xim4AFCJIDT22RuyYTLZYM0XPTTfDS7Al1d75bU6kwHcZO8VoopY9IxmROIb2pzae
	kf0Q0=
X-Gm-Gg: AfdE7ck2iMnIh3aEJgIe+mF8f7iBcDXqpritPx1gZF2/R2fKPTdh00yO+Ehtpy+AVey
	utG6orlFj6sc83oXL024kL5o72/Ptn67bSwi2ORXdcWKEAubour8CjyxX76k6uF6dZxqJZAMw59
	aJuehiyi3JGg0el+2Ekm/PtD4qVfgLScQNlglfKj2Sft04PDGBIoDFCRVmILJ8KSLYUBLGXDyy4
	xtdnAA5SqAP8ITxF2AovSLd5LOPxvJRmETL6iWfsdBI+hZWlLiHVNavJJQv9UHiKMFEZEPJsekF
	Lk4H7wuOu9IrN7B0S66Vobb09qnaYzR2oh4KUz8xY0QuUJJF8gxfZc0z0j9BO4p77m5qNRScALN
	3+do7Jw5FAYOsiaNcA3jSmLRQLY09Q3PY8zm6Au4o
X-Received: by 2002:a05:7300:6405:b0:30e:ec9b:7c52 with SMTP id 5a478bee46e88-30ef0a3f2f8mr447330eec.40.1782826811830;
        Tue, 30 Jun 2026 06:40:11 -0700 (PDT)
X-Received: by 2002:a05:7300:6405:b0:30e:ec9b:7c52 with SMTP id 5a478bee46e88-30ef0a3f2f8mr447309eec.40.1782826811285;
        Tue, 30 Jun 2026 06:40:11 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm8704158eec.5.2026.06.30.06.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:40:10 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 5/6] profiles: replace wrapper API
Date: Tue, 30 Jun 2026 19:09:39 +0530
Message-Id: <20260630133940.2461816-6-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: T_zPqB4dLs2hClkdCrnXTlXSM5DgX9lB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX6kgXTiXDi/H2
 zFMtkmLBOVab8XY8X+VzaNcWXoTCGtOvrOm7lY2RB7relhJ1b6vsR7AchDfwUt/fu9QAxEkCao5
 5XxbETOv6EStQQXvi3uOB1Ft7g9RDq4JnmUtlDPwyZ016doDNIfAEZhUgkMvuRYJXUZ4zDOfNwB
 HpfT7IR9K7T9WwFuLcn+DzI9EYWZQUZeELuw3Hj9ciOr4U7f1tmwCu4EONunpSsXo18ZAHoCvNr
 9KtV/Zp93z/Udna3CI0xQvEbm574EE+86N1O2/K3TUliEbSlCkuMMiSBNTGplxnhCroTc9rNuHc
 gy4Eawy830VbrIN5F6LaUTUbWyWIVssHLES+oaAA5U3mp66OdDj8cZqKZ+gBz5lAkYgX5PjyNmW
 VW0Jwvrwl+XFVBBuPOCn7WIw70hTigOGKDuvJK82wyMgs866h+72cyz108ex/50Yh9JSHj3FO6A
 oRx8iohM24dnKNtlSzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX8s1r7ouu24rF
 Qsdq1Ne6BmWssUeSvyJ2NRtexOa9fHLbSFxMoQJoXWR4ctgKLu5hlMsnBItsMct8xu2jw6pkT1M
 B9l63hhpSuErX+C30k0+s1osgrp9lU0=
X-Proofpoint-GUID: T_zPqB4dLs2hClkdCrnXTlXSM5DgX9lB
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43c73c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=o7YyXcfzcSjnOG7JtQcA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300127

replace bt_rap_attach_hci_v2 with bt_rap_attach_hci API
which has less parameters to avoid compilation error
in individual patchsets
---
 profiles/ranging/rap.c     | 2 +-
 profiles/ranging/rap_hci.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index da6f1241b..a0bd360cc 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -383,7 +383,7 @@ static int rap_accept(struct btd_service *service)
 
 	/* per-device HCI state machine */
 	if (!data->hci_sm) {
-		data->hci_sm = bt_rap_attach_hci_v2(data->rap,
+		data->hci_sm = bt_rap_attach_hci(data->rap,
 					data->adapter_data->hci);
 		if (!data->hci_sm) {
 			error("Failed to attach HCI state machine for device");
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 8726ce824..944b7e2a3 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -1533,7 +1533,7 @@ static void unregister_event_id(void *data, void *user_data)
 	bt_hci_unregister_subevent(hci, PTR_TO_UINT(data));
 }
 
-void *bt_rap_attach_hci_v2(struct bt_rap *rap, struct bt_hci *hci)
+void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci)
 {
 	struct cs_state_machine *sm;
 	unsigned int id;
-- 

