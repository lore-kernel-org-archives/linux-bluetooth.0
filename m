Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07453EBF29
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180826; cv=none; b=E3t0u6zeiz4OnsoJAU0g3MyXar7sqV7mIR9It4tMtlSOQIET1WP+1wnGm5Q9mWP3PEbDv/PzEHKFoUUfVgZEoiDVXL2qJunKFPxXx9T0CkRuJ2XkNsKZTzL2vsSSnFBWiDQBB02gVh5fdKkUXJ29dsqdeSlQsh6B93CNTGwS7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180826; c=relaxed/simple;
	bh=gn5cbL/55TUeUJ4uVI26gY+aX4PYi3zELK8G9F5jlLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oxW3SxMktign/rQVc81p7tYAew6GjO3xW64ajyhYYZwpTXROINWLpQpPaqZlMv7hd4xM5mgGTg8fYXLQstubIVHMnMkYiIe1TeG5lXPBx8BuFcfRpRLmoXp02XtK41co62mmKY3iydMI7DtT2XHxze71KxPspOGSiheeMFrqRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2Y2m1LI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MpWW21y0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2Y2m1LI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MpWW21y0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBSwFY3681515
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ApXpqGaGrE15q57xV1tkKuyae4H8t1hktVX
	5lOWMGbo=; b=E2Y2m1LIpnhro+pQji2fPTFJzY7ki1lm+5KI31+haK2egcwU3UZ
	VKo1Y+KupkgeB96SA8hNQfAJqe4w1HDn8R9aXcaF5qhnzYqWwx7U0P9+UbB1hC8C
	R+EmWPlOT1YVsGE8imyGgG5MDosZ4qI82NJQNMsGmoGEmAmEswpLg8QBZzSSRFE+
	3IRQ6Hi8jDuFI8Ym6Er0tEfXst+efCVThNXxJZvRG7Gs87m65YoDZ5eJ3klXXVYS
	S4P1tbPQ8/LjDw9kmsiygPNQSar+AB21wX6vcbDkHOz63sVt9e2jlav58d+/Ylub
	JaKlIgZ6LwUNGwpMQiLSPDIf/Sd84tSLgKQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d3amc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:33:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f37744f01so3079609b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776180823; x=1776785623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApXpqGaGrE15q57xV1tkKuyae4H8t1hktVX5lOWMGbo=;
        b=MpWW21y0utq4Wgnpg4+F+a8+prX3Q9vlZAfNU0u7ErAHrOdaEaam9jayYZULUqCC5H
         codJZO81s12CrTIwZ2dUIkbw+i/701fYh4jTnvz6FY/RThPratSV2+v320b4te/Lpard
         FMCGQ+L5joDvh+tlQc4f9fDfCMB1mSHRprizJuYNCzpgthzcoi+V7tQY4d9GOPGS7+Fh
         LtM1A5NQ5TtTI7t/+ZJUg4J49YQMeOZtpx0w//NaIOtp2Sgn1xK4XhzBJYyT717FuoXI
         xBs6PmHII6v1SzgmwKU/Myki7j4HgZDycu8k0M40BvzRM4OjNGu0vCTOrU1/hgItws53
         GGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180823; x=1776785623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApXpqGaGrE15q57xV1tkKuyae4H8t1hktVX5lOWMGbo=;
        b=ESYc7olXOs7J7jsNERICl55xxtS6yUwpdL1Vg8CUHB5h61HhK64dvJmLcUz/bZwuWD
         H8oDddE78+nIfnkVj/CR0+CAnKhhY73IGBZGBDZzlJCwO4rr9Sqg2FMBhpGw3sufmbil
         eBVPZ+4fAHh8c+2CIJvTBvVdI3xm5Yy8i1ZRs7Cyq6ixZ2yPBE/OARCyWP4UKppMX3Jn
         48JIitA/Gb8exOVjGVkYhliSvUiOtDltsSzuPjeZlL1OpGISo5ITi7qmInCGozEoQrrq
         UkPPfmCLWBVmveKt9kX67GUh0addz9XJH9V3LST4vrCqkEj07a8Rmu0eOs0q+9O2G1vU
         FrRw==
X-Gm-Message-State: AOJu0Yz/C8KCbgnBxvmA73yVJRonB/ZdCKtwW0YzBXEqYdHKDGFPmwIR
	Qj0On+Ie4hsABkLhKRoThNx1I+c2PWrxnrTGv7ZduBy0TWm8ySZzqYsKmsp5SzEKzqA9cahf1hc
	GT5JEZie2SB/MkZOfDCrcyl76b/uDIEfCaWr2mBq8w9I2B0fSUvEdz4njHW3oSh0iD+cs4nhn6K
	CYezk=
X-Gm-Gg: AeBDies4mdYTAhMqVGU2MwidbxqJdtvDZdwX5ZjZ6LCd1lYSDkqFA+Do0zofSEekWUZ
	Aml+/548ooXmT85QM9rh7xpe3LQM63mgXhr4o/mvI93G+fkLatuJguDiEpvrsbb51jCJ//SvtHK
	XT/7GFZLe8gli8k6zqNDzomVu8G6g5DxvVOY08jL6CNM+FN4Eho7KuWW70F8fp/zAXhzGFCwmiu
	jrhfWh0slTwTdoJ0dKBM8odjQM7KkydRucDkGWDe2RO8C3JSLZ80LZzFCRbOgVRCWEy0epHJ0Lb
	JUZRe+MOAj0XOQyMqn8kiPyArkxzqgp8ywH/NUJgtu2hjwZQWmkzrSQR3neQiZUv4uXpmxdbUsw
	Eds0tONl1LhVRnS2Ab9slBKizQtVPPANIREOJ9cz8K81oNr1coGE=
X-Received: by 2002:a05:6a00:1944:b0:82f:288:e572 with SMTP id d2e1a72fcca58-82f0c1e669bmr19496149b3a.11.1776180823412;
        Tue, 14 Apr 2026 08:33:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:1944:b0:82f:288:e572 with SMTP id d2e1a72fcca58-82f0c1e669bmr19496104b3a.11.1776180822753;
        Tue, 14 Apr 2026 08:33:42 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e182csm15025163b3a.45.2026.04.14.08.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:33:42 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 0/3] Add initial Channel Sounding support
Date: Tue, 14 Apr 2026 21:03:32 +0530
Message-Id: <20260414153335.3169542-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0NSBTYWx0ZWRfXwEQNcS2Tw53r
 DDrGRj6m9DWLdxN1n81L5l285+DHoBnkI5F3PeI15exlTBtQqoW3p1pgLEwych77/wBWOV7lHNI
 f3HWkrPcGhctM3xp+WBtVQJT0UXLczyg7pI3gjx0HfbBTkLKV1TWRCF1lQe64HkfddoAOtIwZiT
 4SVV0w089Cjm7AZ5adTe9eHyjcHQKRS+MOv3X6tX79yPqXP9xfmciatDa76kCzoirAuMT15VGxQ
 Qg7DXxSHaiSEKawyAUJVceUBC9mVjKxJXvPeMSX3zoa6/4Wn1fww+6XU48faKRjgi+Duu1DDJIt
 C9rSKylSeBI6Fohvk+0i4cs0xBOb/h03Zht46cM9euLuDKYJ+sShajP9gCBJtaeQRv8PXIfQ/PE
 SgPneWE9RPWrhASxHUgyQbKazyl+1U2D/cZoTfgrRMVUT3PV9umLtTVuz0TB4S7Sk5cJ1yRE4PQ
 zwhK4VpmC8kEJIrugHA==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69de5e58 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=yTpKK7hoq-mwBt7qsSEA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: KVrFc80Vv6J9UpY5Rz49873HR6h_XuBQ
X-Proofpoint-ORIG-GUID: KVrFc80Vv6J9UpY5Rz49873HR6h_XuBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140145

This patch series introduces initial support for Bluetooth Channel
Sounding (CS) using the raw HCI interface.
This series lays the groundwork for CS support by adding commonly required
protocol definitions, configuration parsing, and event handling for
the reflector role.

The changes include:

  1) Introduction of raw HCI support structures and callbacks for Channel
     Sounding procedures and events. This provides the foundational data
     definitions and HCI subevent handling needed by higher-level profiles

  2) Addition of Channel Sounding configuration parsing from the BlueZ
     configuration file.This patch also updates the systemd
     service capability bounding set to include CAP_NET_RAW, which is
     required for bluetoothd to receive and process LE Channel Sounding
     events when running under a constrained systemd environment

  3) Implementation of HCI LE Channel Sounding event handling in the
     Ranging profile for the reflector role.
     This includes opening a raw HCI channel,
     parsing relevant CS LE events, routing them to the RAP profile

Patch overview:
 1/3 shared: rap: introduce Channel Sounding HCI raw interface support
 2/3 main.conf: add Channel Sounding config parsing support
 3/3 profiles: ranging: add HCI LE Channel Sounding event handling

Changes in v6:
Missed sending patchset 3 in v5

Changes in v5:
Changed the commit message for patchset 2

Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw  interface support
  main.conf: Add Channel Sounding config parsing  support
  profiles: ranging: Add HCI LE Event Handling in  Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   83 ++-
 profiles/ranging/rap_hci.c | 1288 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  129 ++++
 src/main.conf              |   24 +
 src/shared/hci.c           |   67 +-
 src/shared/hci.h           |   12 +
 src/shared/rap.c           |   50 +-
 src/shared/rap.h           |  174 +++++
 11 files changed, 1813 insertions(+), 26 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

