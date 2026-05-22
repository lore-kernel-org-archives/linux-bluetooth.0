Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA539DBF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428423; cv=none; b=FbZWAWBu3QZVoCGdMWpr5KCZIeyuja4d0o3Gdk5Mx96qv1yUgHI+55q2uREcWKxdtoxdjxM5VnPKc50Uu42ZTdd75uXNPrmLYfOFUrhe2Gd0LenfVyF9DqJPTmjgEeRDyykaAJ8+rqshEl9kXJcGh6UcgilNVRdi/gg9WzYrXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428423; c=relaxed/simple;
	bh=gFQYoN5gbjbWJLhrazIt3fGiD3H72iRAmSbDGZFrBQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5s6tFu8N8g43CqWSN6OH4Z0Tlh2Ima5I9+BDsjSQxDGGiTSvn4ToFRl1tGIYoBibmrePnl2+d2WgG0X7fKkxpcweK1A1bi3atdzDmcerxQpxwdRZxV8HlmSAfaq0Hp3UOboJR1lLpW+T7ybncGMebZ0JAJ++vCTXbvUf00NOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e0/tzI3S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GVgjcXc4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e0/tzI3S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GVgjcXc4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LNxf3R778703
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 05:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FAruGUbb8HCDKX15WiJ7MntpGm65n6LK9ch
	L1PS+vUs=; b=e0/tzI3S+aM6Svu+xvb+0bKzuchyH9FB8i8dMa4m5rfUOYHgRxM
	8mhh7n9gN7HAu33bbI+V1wpQGJvyHRUxhFcXQXBtUHRmOKkqvsmqPaRX0h8OGWf8
	bcoDNYCwiSYMS9gerpmrPNpfxqXNtdmLN3C0aB+o0ewk6Uq+vYYZJx3r5H7n2Q5F
	nIYYsclLRrmbh/xKqMLPtko+NmBlfUa3C+1kqyDUowbOsfbeSyCjYuILrOFiJass
	881Nsje2TY1KZca/G4Nih58SOmPxntamXXkkvDwrHBHhm2TDxawsAsQXzYAIu2Y9
	5cca4zDD2oHpazQkxoY134eo3CEWlhwOLNA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7ary36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 05:40:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f50f4b826eso870660eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779428420; x=1780033220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAruGUbb8HCDKX15WiJ7MntpGm65n6LK9chL1PS+vUs=;
        b=GVgjcXc4dCv4TshjIXiRuY8Jv9DoPoamazkLxrNvHMQ+ws79apxDbd6u1+Ty9ZuFef
         Ac+0J9yAXH9DLO7H2eGZNwIxEU0rrfL20HPhhVeg8I0eKfOWUWzUCa3+aWOOcQNCR/5e
         /meMcsOZpbvI9yt00d+RrsxxxGPdIW/JFU0OPsyBpIg2FIeNLoL2RzAk//1l66enDQVW
         YXX1HLhvk0L2DK5VQ6uxRALyV21eUqbrf1QckohQjG5MKaDMdnq6X+Zoz6AqkmbV1O9J
         UOCj8CuWuTiL346dEjJJAR1jULn+L4g5EM/dXOXWwhT5G4MhjaxuRfqKhqyuTgicd44x
         JhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428420; x=1780033220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAruGUbb8HCDKX15WiJ7MntpGm65n6LK9chL1PS+vUs=;
        b=P2VEBUGYnYovYz2ySbzn1GpxJfBLzTBj9G+RpeZh13PqxbdFmKxq0iSpfZ98rQuUxU
         +DalG4kdPk+knCttOo4Ny3HHHj32K432jnQRRbAeAIShRvXJxIbjaJwKCa99SJaboktN
         caW8ApLFX8AbzOGBqYGejJr2dvbrXHgJd4QzkzuXhN8cCZm5cA9/cUjXjX6cBJfTNC4+
         wpdJmm8Z++PGgzh/Y7NgyjQCG23nbjSfkBMxvFYRZNBnRkHJgODd7y7+LDVCLvu+xb+K
         v2MfxjbtGyLs6rBw4bgCMTL5M0UYIkJEhO0hePJJpEZXRFLcHJBz4/2FEQW/aVClcEHf
         y99Q==
X-Gm-Message-State: AOJu0Yxk0dfHpO1aaoC/KI77WDVSQSBoRFsPl/OM8FgGQHJNsyGmveaM
	8Z6Zs3T18J19CmwbYD/F/+QWFFIFa//O/NxhpKx7NL84z9S8mC275n5EhDMz3hCDnCLEQLo/3ab
	7HdWNdRO6tGUkUQR2jZzGR1UHs4Lyc6Eavcgc2+I3m1qaVhj2M90XEazeiHCsAedV1vGtaEThVa
	VZXRk=
X-Gm-Gg: Acq92OEqRWFMU/viHw/+W1hi58AD12OWV1lXPcPtdSulgdwjz/OD+M3k+pPXs2RixYb
	PvDjSfBBsGdpE6cVyS6+2ysQdLj03y7MgqWW5sC9Fof1Exwt7XuyQninQPn0YIReYldtRorZ/uD
	M5wHJfhvLxb8zAEhjjPr91IW0qNW+b2Cg27ZGxQThNz+u/X0NV7M0EPb+NVaJNLI0kjmg9YHXp1
	734h06ocENwOG0S2m84vYzBpp7bGSIRDbavE5QUQ0X4bxitOhSBnJQQc+IfSxtQ1sz+gQu18RFe
	AojThQVRizf0bY4GWzauXU6HfqrFL9mp6afIHqHCMzN5ikkNf1BKWMCdkPFXqo88psaikQd9VXR
	pGwg7DU8jnee1XzSXaVZVmHYHhPPEPMBCvmwNos9v989gZ77KxVGwzEtI8+vx1m5KH7nzOvRj
X-Received: by 2002:a05:7300:f108:b0:304:2ed3:31c7 with SMTP id 5a478bee46e88-30449178b06mr558894eec.4.1779428420114;
        Thu, 21 May 2026 22:40:20 -0700 (PDT)
X-Received: by 2002:a05:7300:f108:b0:304:2ed3:31c7 with SMTP id 5a478bee46e88-30449178b06mr558888eec.4.1779428419527;
        Thu, 21 May 2026 22:40:19 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f20ddbsm231326eec.11.2026.05.21.22.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:40:19 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, cheng.jiang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        wei.deng@oss.qualcomm.com
Subject: [PATCH v1] profile: Set L2CAP IMTU for external profile listeners
Date: Fri, 22 May 2026 11:10:15 +0530
Message-Id: <20260522054015.431152-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UOVJGyhHNsdP6q-NHtWeMb0r3T2tvXqB
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a0fec45 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Q45P9dghp0UMl59skbQA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: UOVJGyhHNsdP6q-NHtWeMb0r3T2tvXqB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1MyBTYWx0ZWRfXx2kP0FgML5RB
 4ualgvn7T/LRA6WB67mpDqlOT4+hc5w/oM2ZcLjWH51oCzCuEGUL2QdhuosIbphy9ylOHfulVbw
 5nr5ht0XtGibrgK7vheNs8OBwR4UdIBdyHhxyU3AiqtehAKY52YhROM/b1oLfabuFiKXPdMdhaW
 T15i9Q9Y7OdJzDYFFjk8EOUtGfRznqJyzXK0126bb4vLuR1KkKQSZxzEEQ9MoiRxuz/6i7D7FOY
 1Kzjtde+gSqjzF7/eLKSyyVHF+Iahv/yKDrmFQCOcAkRh+Ivwt44j4Qgz740YqAhJIaUIBVi0Of
 3HbleNGX5QjRanHLQU/IGzH/4t5QTt8ipoZbfshS46kW0Ta6ZRKEg6tHAxp59fNc0utUylztxBU
 ls5JoInrU9IQXSStK1NzrwRbGjpsm5ET5D9ZZj8Uq1DCk5r/GN4mnQipArzHJx/NBz7aio0nP8q
 kEn4hGddK6SB5ol/XCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220053

bt_io_listen() in ext_start_servers() creates the L2CAP listening
socket for external profiles without an explicit IMTU, causing the
socket to default to the L2CAP minimum of 672 bytes. This is advertised
to the peer in L2CAP_CONFIGURATION_RSP and limits PDU size, degrading
Rx throughput.

The obexd client side (obexd/client/bluetooth.c) already sets IMTU to
BT_RX_MTU (32767) when connecting. Mirror that on the server side by
setting BT_IO_OPT_IMTU to 32767 in ext_start_servers().

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 src/profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index dfc5f7161..297959f3c 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -55,6 +55,8 @@
 #define MAS_DEFAULT_CHANNEL	16
 #define MNS_DEFAULT_CHANNEL	17
 
+#define BT_RX_MTU		32767
+
 #define BTD_PROFILE_PSM_AUTO	-1
 #define BTD_PROFILE_CHAN_AUTO	-1
 
@@ -1411,6 +1413,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
 					BT_IO_OPT_MODE, ext->mode,
 					BT_IO_OPT_PSM, psm,
 					BT_IO_OPT_SEC_LEVEL, ext->sec_level,
+					BT_IO_OPT_IMTU, BT_RX_MTU,
 					BT_IO_OPT_INVALID);
 		if (err != NULL) {
 			error("L2CAP server failed for %s: %s",
-- 
2.34.1

