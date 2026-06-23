Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5663D3482
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213081; cv=none; b=raG/U0Sct4xBT8/HO8N/6vjH74dP/udp/W7BNOFetlRJ+qd5Vc6HJ5cw3p/t8cwBLTbmIwAONlVZP3n7Zx6LSQlkCLHqFVUv4rnY/a72uOvGiFXxICi9mgtoEYhFd9LS2oF0PJJtv+CrQUB0moBW3IaF8pGI7sFrZNGavUl9ju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213081; c=relaxed/simple;
	bh=z0mMcRP/ItuYg0YGeWJhdyZG4giPUGXUem1uiKMbRmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fBjhel6uSLUMMv3RSTwa6nI46UCz4lJMfqKK/PHyZFhYkdDTYNDbpLdWta67G8Aa3xVP4vZ4xWu56xglEKYSSH7FOcFqXSQkQEoiD4vt+kghxLwlz/KlXvDxKBXhW578X6UgV2aaf69F20gC6Lm1OCNTSfDXOxWoTELd1EMUTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYnGHSkv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fcS/enLI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYnGHSkv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fcS/enLI"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NAsdEJ3663949
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=j6fat+6nqIezGX5cOP6I3g
	ZOICf0lmW4KtZgfpoMiaw=; b=AYnGHSkv2sNJk8+dURtMvp/ympssn7HkH+Ogfe
	AmNHBFweqNUjyksAJ+8aAwgO5OtBFEEppkIhj/5phTuE24kc1G8Op20C/jjYgbfl
	V19NNziyE6HHJRLMg+bF3wsTT0MN0aSM3XF40LbNzPGYq0hjFzQ+Xrsb3ZJAuoPi
	mFlNAXUfj8D7XitKgY4/Sf2CRjQdSJGAKqA1Njdyz8VLDuoijcxO2Ww3bh2Tjh6x
	SY96EO8jN5Q+2Tg7dMOkE+z9oxyQn6bUM/6BX8oFhZEni/fPQJdJ+fZvtYM/j2cU
	HM31Tv8fTzrnIcO43Z5/1n1gdMBv4D0OdccFiPD83PVXxwew==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29gu7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:11:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so5019395ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782213077; x=1782817877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6fat+6nqIezGX5cOP6I3gZOICf0lmW4KtZgfpoMiaw=;
        b=fcS/enLIEnZpaKXPPRZePxgPdvBGZlyYXJtI64NXJLtQi0hsbrbfiDy34jtFHfP+XX
         J2PFuLW+RxJ00iyErhODPei13yE1fCrepb8tLkHWiDYS0gWPHFMYCL/jcwH4UhI0VhY5
         UdY805KtYAYrdFRyUSfvOEGX3aZMs+nPQwxyOt7VZTZcKeqR2UbE2KyHbBuwfSmWIKsQ
         Dvd60z53QXuHv6vlSGoR0eBWFgqq2QwjwDbFrqpBpQM/Zjz1OIkEndl6fvLcthMLvfed
         5IlFyzWoPQTtLb1bam+8kMmOvsde6VI9oPb7Mf/2YMhBo/zhi7evkt11tTVOrV7fkIG7
         YWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213077; x=1782817877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6fat+6nqIezGX5cOP6I3gZOICf0lmW4KtZgfpoMiaw=;
        b=PdxQIbXVJvidMSLV1yHBs2J/tLKAxpaix0NXSXnIPDqHVh2L7RM8Xi6JwGI33070fW
         gQXekOIl6xmTtjkLMxtQCf5oSjYn688zQYZpC2DO0GsfPQH45ItSO/2Hr1uQnUioFn1v
         XXW3ejoPBgP4wIJNOHZg1FkL0MEbLyBsojv5SJX/xSP5ldgBPNHOdUykWyR+WDXvY1CL
         4Ao4Xv3qlib03IQ4OO+Rfxavh2Z43Kf+QFW7pLi1wpTCMvtuHxsVs8WMp44z8RDUlX5v
         dMkonAYa0M6jN/TiWf2r4vwsqEJ2rMhBP6Jj5Ks158doWIw/fKWtdNGpwVymOCQmaEr9
         Hv4g==
X-Gm-Message-State: AOJu0YzMe1FFxEuvkjY82PYRYVC2zYtD+M8hQaTmzTXDoPUUaike8+n7
	GjSEESwVn2375RI9MFWSeGbT8c5mlba+V1D4Bjz8jstCaeMWEVr6rbOtoKbjNKc6cHcdwsqyFgM
	pzGAmYnAT40aRfEdneu5OVtX92vXA+KVY0SfgYrLZxxN5XYQA+I/QbwbB7FgoHIWakVrN55CJ0s
	OHX0M=
X-Gm-Gg: AfdE7cn+smHYbbf6+pzhog+L+32/RR2qxUkdOlEDTK8FC4R1cjz+u6SVxIWc25pwzOr
	SyzYvCiwAKmG9Pq1dkxTnlTydr1EPYhYi5fSKdJvgRcy7Nw1p5Vf7RqRT7kh/ewpO77hnwaXxzG
	yPPCgTaAmYYIIyrnMeNjxFbSiAsM5IfC5Vcz8Z8D6HDusS7+lEBK7izvVDb+WCRvK+CjqhGf9w+
	MlgVROVK+gBMai7pKQMDhGPwMxVmncfKr4ShoVB3QqjJXoZ9TOwgmUyom0cmYtEv0nJ7K2o4z1K
	3vJtE6w2YcqbzYf80u+BkX+g+2JXnuCasoZYLL0Qb2OshXI9hwfGyR5ajddpvyLDz0izTYVlNhx
	/eJUovwnuS2xzSMUJbuH3PDHGUoRHqf5T
X-Received: by 2002:a17:902:e811:b0:2c6:b429:f111 with SMTP id d9443c01a7336-2c7c411c580mr23928815ad.29.1782213076791;
        Tue, 23 Jun 2026 04:11:16 -0700 (PDT)
X-Received: by 2002:a17:902:e811:b0:2c6:b429:f111 with SMTP id d9443c01a7336-2c7c411c580mr23928465ad.29.1782213076287;
        Tue, 23 Jun 2026 04:11:16 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444a9c5asm100991145ad.74.2026.06.23.04.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:11:15 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1] shared/rap: Fix step payload pointer in parse_step
Date: Tue, 23 Jun 2026 16:41:12 +0530
Message-Id: <20260623111112.1332742-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a69d5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kQVhg277aiAQblvVS00A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: yaf8SejFiMuIIzp9v7TOp4gPDgl_hoZf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5MSBTYWx0ZWRfX9Hs2t7mg0vCE
 LI6a8Svb+ifZiEshxPNQExZUq+1E+6j3aIM+YI1X/7oDE1K1AIzOIS+wB+SY3YdfH8DoewDgcF+
 iDLXfzNOXxJs1VPTs87HQ4kwtcV6NCM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5MSBTYWx0ZWRfX28Md48oqYmr7
 QSM7jLo4E3wbBBpi1cu68mO+oHz6yCV1Q4rqgGxUrgnoHcPrC45Wiz2bfKpZzbgwcX+Ypl84dxn
 JbbPLKHjRc6Q8RukbgMm4zdEeKrBHGzdD2hwVXQBSRwGfwgHBS0rprFOvbLpjbU3YuN0eyIRluk
 jPMpWQ3+xCKPE0yIuFATC4/CIeURIuiRddEnBzV2VRmolSsS6gxAvLnb1xj5NdEhvfE5EBkvGiT
 BUaLqqbf9vgWdPCH4/OTQXY1A5Yc3tJxePdGHkxxURiJIeb7XOyro2wfpzTvKdJZYVbqC0CxzeG
 YcI7UaoBnBq01gYVMDjzw4W8HEIiok8C7ZYFWOVmqptP9DGMobZCDYY6vxtdu7OrPTqDTTfqDrN
 blwV97ZYBcoOvkFK6nfBFc2QwTYJ5Q==
X-Proofpoint-ORIG-GUID: yaf8SejFiMuIIzp9v7TOp4gPDgl_hoZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230091

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

util_iov_pull advances iov_base before returning the new pointer, so
mode_iov.iov_base was set to the start of the *next* step's data.
Every step was therefore parsed using its successor's bytes.

Switch to util_iov_pull_mem which saves the original base, advances
iov, and returns the pre-advance pointer — correctly pointing to the
current step's payload.
---
 src/shared/rap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index ecf7df5a7..dfb272d3a 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -2326,7 +2326,7 @@ static bool parse_step(struct bt_rap *rap, struct iovec *iov,
 	DBG(rap, "  Step %u: mode=%u payload_len=%zu",
 	    step_idx, step_mode, step_payload_len);
 
-	payload = util_iov_pull(iov, step_payload_len);
+	payload = util_iov_pull_mem(iov, step_payload_len);
 	if (!payload) {
 		DBG(rap, "Insufficient data for step %u payload "
 			"(need %zu, have %zu)",
-- 
2.34.1

