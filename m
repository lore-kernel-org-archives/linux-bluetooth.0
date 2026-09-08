Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25539368D67
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841660; cv=none; b=QOpm0Kgqjm1O+3S+q9QE2739+tdLtvhZrYjUx20Vbpne0IZIi/41qR8j4L6Kzmko06aSiEwr6Z79f6jNDWpUDTCUz2lk1ltxvbpAjRSXJDeNOC5TUQFKpq3If/DJhJQpS6whbvTr5zbCRf9Mp6yNuiinUaFCBiWR1MoE9KbBJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841660; c=relaxed/simple;
	bh=y4eK0cg5WqZ5zvlYymckensbxXWczlE2KEysYOT0R7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWLqvYSAUEmfyhmDHf1b+0YXgADABeBk4VPDOdR7ZBK1udxmTEBV0OpR4lSlt8PC0nr+ABE/atZ8pGCB3Ryh+7GpvD7Yig6FvfQk3jhnGiD72rdbewO+kwl5dN+nJF8JCrBhAqIT4/l+xiZ+/r50pwOg70h9mzadG2vB0CINxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ptP5xMFB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=erXWnO6s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ptP5xMFB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="erXWnO6s"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Nlbtd1656566
	for <linux-bluetooth@vger.kernel.org>; Tue, 8 Sep 2026 04:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=j0pCI4GWPwRek0TneHU3UmNQBFLPz2/ZQdH
	EokbtJv0=; b=ptP5xMFBNXBMGYpTqBGtFAZ9cr/CGKTMZWBe+H9Ad+SS56sRjXo
	/vW9+A7wBLNIZjT+mab3NpBqPzmX35Qm4vxAFPRNEZUWVZWEYeqeSLHB1a7MsExn
	32TKhscdVhOJ9vRscjKQsN6EeDoZVxsg8sHM77jLw3dZOTUDWbklL0WhtS9GIoou
	bSwdyaXOfbMKkJJrLMVpLujYayOWkukkAi9v+ODXApX8Iy/Yjg5LzWRO/vKxi+q1
	FKnMqBDMLTI0CDhp8zq09zCV6uLLWqYveAldpIgmdl6C/NDFiOADStPPVQdxWoXq
	B6/iFZ/2+NTr83Iam3qKKaH4eXIftg/OWHA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg3mq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 04:27:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so2805699a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788841656; x=1789446456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0pCI4GWPwRek0TneHU3UmNQBFLPz2/ZQdHEokbtJv0=;
        b=erXWnO6sG0/Yf1wqt2s2ScJGzon8VE2Xo4K7vr7MoOfuJINY8wUZtbos2CrNY5/K25
         ojoAbbJUwk1iUEG395wAmYJdHROg3iREncoYvCUA/2iSlafl0LViWcPKTw8EY14nZbno
         V61XuVF5l/3rTgN5h2bHeYYShqwpaT8QHnEvAI0Dm9sbOFhvDlz+0vDe/EZuL3CH08cn
         qnNz0+zMapd8E07Vwd8obKiO0r4UyBSqu7TTcTUunp2ma07kVfE8/GqiKssPQS0/Wb9x
         Ve0j+DioNF6XUsemg6mHz9GJHwHR5F0SGbG9D0YKfufM7AsnnKjm4f+t3AubjRUWXIYD
         v5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841656; x=1789446456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0pCI4GWPwRek0TneHU3UmNQBFLPz2/ZQdHEokbtJv0=;
        b=CYCJhlV8PLkJI2vkgVNXrHPLQeujI9ug2F1T1fRCRcB2pGhxksR6IY8J0eU5EKd6fu
         5kfcaJmUR+BWYs/nuEbHs5kwGt3FyclEmJ5ca9KOGw9lBru4xUnzX7M36fNXeZw5aGf1
         0wbQAmi4LUShd6ZDojlQKfT6s/ZgXkv8KskJ+0HomRVmCr3qxPOQv/41gWuTCNKZM9/O
         gdCoZEoJnB0yd+z/EFzoHbjJmTQjon9y/+4/pfKS7zZaEK/BXXvLalbaXn8rDLjaEuxT
         7vA7AfQo40dh4UAHvedHlB9goMpA8NKJoPtaznn1toWpfm5hldwxrS6wjDlfHX2gSaMi
         qWOg==
X-Gm-Message-State: AFuF++kAZMtrg77jKBXcKeJANMQNHWXC7MmvsVrGM8Z6Fb3zA1YqBaic
	REX4zfblo/+FCf26XxK+1bm20q9pdbtHfLv4j3ilmid1gZoUc1AZ/mOv70FK2UXckELrgIwmB6P
	PD+rGMepPRb9xn7C9yg7aL+h7YT6iBFBRiDegBqyTDpeGBPFvo/zrtk+nFmbPUIQx33zuxL29Om
	Q5PUk=
X-Gm-Gg: AYBFou1gQWpbdGszcPmfzo7NszSbfRiS86U5kX+n9ygT+e/+6YjDD0ox9qYE32onpVw
	CKV6dZI60pL/1OIxDlrGsbTbZCE7ZJvODeq4BF3cp9YuDvES7jIvqhRbODhNKPcybVdE6wvFPBI
	oDI/NNi1EQG04G9koDdLVzzfnxAXplS10u/bigOoWYm82TEbyQP46MzFke+N5tAWFtK3Mw3EsO5
	K46u6iiY8a4e4xU5k+UGgHtQOCs0ogT4t6Qo1tZa5lhqw8uzUWVnUnpLZnzYjgCCOByvP56HnU1
	3hNpkcXNRVZuoeLyKyZVHI2VrxXdkOn5egoaPgS4sWgu5oL6+OxnGJym70nHWU6kXWGIiJZpS+2
	RwXyytevE+OTKMvBMQJJV6UT3kJ8o7A==
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-39b26169b1fmr40432809a91.11.1788841656334;
        Mon, 07 Sep 2026 21:27:36 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-39b26169b1fmr40432725a91.11.1788841655874;
        Mon, 07 Sep 2026 21:27:35 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm31577301eec.22.2026.09.07.21.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:27:35 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/3] RAS: Add support for on-demand ranging data
Date: Tue,  8 Sep 2026 09:57:24 +0530
Message-Id: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfXyoClXb1o7Skd
 xgKTxIzLfD8tSxJQd3rvM3MTifND1zMpAMNUXz+nrUlt0DyBkVH5OIl/ma5GxPb77zqPEiwjX8/
 bxoyPBy0te12DqlyaoMD7VUOP/hKLwxKJwdhOrA+XMPDRSZ8QaEpGTbqtdbuLNU4x2Qoi3vcmkx
 A9w6SxkTI9S6JfvWKB2hWMQ+IESkzrdt/OjHVor5/yPaKbmJRrDUTPjDfjTBfRzkveCi1FuTvyN
 c0pa2Z3BSIIVPoavorQbexHqzD3vZ1Keho01mRaGefdOepc4GA6Fok0SJDG5vHek44setP+QSrc
 FMGFheuMUiiKV6/G1lTJJDoIh8mAAyrstmp7q3SOs1xGKdrbMwID8iRoXScjhmldKqPbowo1CNr
 Rg+ssJ99zLraTATN8CxMl/ALGAS7/NZiF5wzAwshVVPC00MTnMgcrUcy0W5S9bpLeHEqHYG9b9u
 rPY2/sOsqU10dLmb3vw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9f8eb9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=dJP4SoC10iFzG_7YnnYA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 7deXuPZHKjJzuXqbXKubxgaIhQgroDCq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfX9WLcChLLtrYt
 g0d5QmkFVF7FdtI1/41m91/5Z2+xTSdN4TeSmXKGWjpv0x1Tx3o89UDg3PrKUWmXNo1YqeppG16
 ddJpGKXBwRh7PKoYuED/hHsq0BXw0Vc=
X-Proofpoint-GUID: 7deXuPZHKjJzuXqbXKubxgaIhQgroDCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080046

This series adds support for on-demand ranging data
delivery in RAS through a new OndemandRanging configuration option.
When enabled, the initiator uses the Get_Ranging_Data/
ACK_Ranging_Data procedure instead of real-time ranging data notifications.

The series adds configuration parsing, enables on-demand data delivery
in the reflector role, handles the associated notifications and
control point procedures in the initiator role
and ensures the initiator honors the configured setting during RAP setup.

Patches:

rap: Add OndemandRanging configuration option
shared: add on demand notification handling
profiles: honor OndemandRanging config for RAS Initiator


Naga Bhavani Akella (3):
  rap: Add OndemandRanging configuration option
  shared: add support for on-demand notification handling
  profiles: honor OndemandRanging config for RAS Initiator

 profiles/ranging/rap.c |   3 +
 src/btd.h              |   1 +
 src/main.c             |   4 +
 src/main.conf          |   8 +
 src/shared/rap.c       | 849 +++++++++++++++++++++++++++++++++++++----
 src/shared/rap.h       |   6 +
 6 files changed, 804 insertions(+), 67 deletions(-)

-- 

