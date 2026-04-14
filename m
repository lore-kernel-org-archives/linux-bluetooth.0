Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86103DC4C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179302; cv=none; b=scNdA1nIcVxBUPluWyekr7O3YM5pahtj/Fze6d5zR8avfnZGpgSQsMXg9Jaeg9mAuk4Bga0X5bth1joF9kh5Rot7dvaLGqyguh8OMCskaX30G8ARIp5q4kaBmZIKBzTfpee4RZrBErtctjvgaMmTtHasZIM9HQZQ44IUcYAU8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179302; c=relaxed/simple;
	bh=EI8kc7z19/c2M6U/rdqVHXh/Os9u9hSjfSkhqxSDBa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L1AQhIu0/9hobzyjZ7B+QQ3K9f4L9VjkCjxRkec77tjW2gupZFuvyt1uDDFnwFFWQxopRT+QtVq0clNVEZm3cxYxBdQXdB2N4bDNVDBOl3mVfc6i2AZB8lugc99d1ATFVmEpiEQQi4CvMbhVOqI/2oruF+x8blMmAUSwEDxEmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PmdNlLWz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rw0dUgGH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PmdNlLWz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rw0dUgGH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBt10i2633460
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MnT1gnbcm5wmj8Lje6/e2EBWk6IwSlb5CkA
	4nyS+4ME=; b=PmdNlLWzv3sQKY3d/TzUqSXB8Fuyg3uDJR/f6YvgF9aBOoOILto
	SqKi+J55zXFdix/CpisSRvXl6fB/JbkxcOQfMrRpPs9LmKCy+1I8Iobm1G0uw6nV
	7hv9p7NUCgeWw+VsuEKgqpuleCU8hp3dArjPO7QvTvVmz3LSbFsin5iSrcCGEAqQ
	vHtVo4azdz9XSI8J+WaSScBdxbRshKyJrHYp8LEgZltThZO3ya5T3fFPjw1JcX7q
	uEkFCoo2m/z2x8D3Ki+8psjpmzDMAzOPsU/Lu9yq0MowK+SGR57NI2D/8g3vySsd
	2N1q95TwoHOc51e9GanJR4A3srycaIDvc2Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86cb93a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:08:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adef9d486bso52270325ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776179299; x=1776784099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnT1gnbcm5wmj8Lje6/e2EBWk6IwSlb5CkA4nyS+4ME=;
        b=Rw0dUgGHfxmV3r7DkOUrw83XAKQOx4R3tvEn7Slf4axq6iTCQ0PMq1FYetYq5QOamQ
         dw495y6kP/ObD/JQxFHxz72seyELNML2BzOZtvyk62rwZXoVAq2MEssVqaFHgc0O4oEl
         rTePKTsbVn2NRIjyT3f4AbbitVIkTfuXknwFBN54PMK+N5SuGzZiDpQPt+K0bJWc9JEE
         p0XgviEGSUA2SrKp0dUWltAP57fj7s9TqIZMUfcilQ7rSyNOohYE4Y6kotIWsb6iRXx7
         49/9FSAgmtyWZjy2QFXfCg0RUyDNC5HqsY5mGD4Gd5jUYs6iX8vY4ssbksWiEbimvzMN
         pz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179299; x=1776784099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnT1gnbcm5wmj8Lje6/e2EBWk6IwSlb5CkA4nyS+4ME=;
        b=ZOifqJiQccIy/7ZaLFloREubgv/3IlywRqd3/yDD0hwAlJFnuFUvq/K/4wQ+SC9Twj
         2WMQfyShQtFz1Dv/1qy7MORBnS0c89cWwkUNn8pjmzMeMJVf/wKO3amKbwXmsrMofK43
         Vbsz9wVSebo0W/u0e/KFjqQyeHwISIrfoe7fPqeDtbZWFQ4BU5IeNj+r5v4LtTt332H1
         kKgOpEtfgO0Dsg75gIvA6HU9CbCQy5hcm4Ja1/o/bkqODzJYnZx7B4xV7KKyofuUoJ/s
         6eZoIb428ltlHp2cpxuScv3bOM+UQiJr0gP8UuX8E/NqzwE1sGqhayT+bPwGW2xwx7zX
         u5YA==
X-Gm-Message-State: AOJu0Yzw/j16rvnA4bP5tGrMim9SgQPb3ATDFZofI1j8//9vW1jICfnX
	EYyEawd7vVv6R99pjX3HOzavBMS/cZHQU8huhah/WbhO1bfHwNKdzQmcN6XVkqjE5d+beqkW/bn
	av6ScnmQVD4JDVyFe7kVAOsA4POt/gwSOrJaYlSMqh/0exjW+ZG2o+I9BAe5MG0papMBYfgtxmc
	gjjIo=
X-Gm-Gg: AeBDieurLt57NF18XPm6GzydxwXWL/JcEYukaZovcPB3wOXdeyVMwEVRe7+XXs71rv0
	rqJ5wkBuTUkulE9qzqFa7/VGVMQ9zjUtGgBiLs3vMJCnrUjRkoCFqRozjOeq/Ls4Nu+FBTsnpqH
	hVCOfyfLq6rN/hTHBPyuCyPtoyXexIC2hA6qoOt4k+qc5jfqTJuTkrLZyxlB9JL2cf1azELz6Q8
	1AwavtBxKKLEo08kYkuxNaudUJLR9gH2w484Hpn9WBF5psGs7iShUfyyDyM1KRxgmBT3G1vNyBk
	HW9tXn5njGoUZ51v4+S1v7TRkAcI624kOxd2R3flFq8ZIl1gNTfur8+ilRkSdXIb4iLliSt+NoT
	kz93DrzeBW23TqJy7hZuV/Dz+6BsmHI3ELPoYEb0D1eS6wKJVJNc=
X-Received: by 2002:a17:903:3c25:b0:2b2:5704:5715 with SMTP id d9443c01a7336-2b2d596af25mr182389395ad.15.1776179299099;
        Tue, 14 Apr 2026 08:08:19 -0700 (PDT)
X-Received: by 2002:a17:903:3c25:b0:2b2:5704:5715 with SMTP id d9443c01a7336-2b2d596af25mr182389005ad.15.1776179298340;
        Tue, 14 Apr 2026 08:08:18 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1d0554sm74476175ad.53.2026.04.14.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:08:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 0/3] Add initial Channel Sounding Reflector
Date: Tue, 14 Apr 2026 20:38:03 +0530
Message-Id: <20260414150806.3135253-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fvDy6Z5O2tpWvHm3eAJKJCuTqWFJpau1
X-Authority-Analysis: v=2.4 cv=RoH16imK c=1 sm=1 tr=0 ts=69de5864 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=JxoTkb2ISLZPhhTfFPgA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0MiBTYWx0ZWRfX+xmdvNMJM4s4
 tXqap/BJoLEhXYbC0wwKqKQlwIu1eR2FYY7AbqPK09g+BHNDcvR0ESjdK7kkirsrPrco+vS3p6l
 WzzbAGqH4vbIBdE0+Iqwp20bkGFUJZllwDG3aFEMLpudVKt+g7HVTQlQ4CijcbXwne0Y9jDe9AW
 +HpZFxSm9+KF1rFLfhB+V5CCMons5rzAnGxT6NWJBG9bM3S1i4nrNpWn/+/TjqSOjhtTBrgpIi/
 J4I+sq48tHZMnyqAWUg9PoWkihSfhdPHKtEuY8mmN8p01ErIraEdRsTjArmrLKbpaS6N7rDqejv
 /ypdCTRP8fghUvaDSXRvtWIACtDttBPWxHsx3nsaOJaJnSbtpaVsvqFa4DJqikVNRxkry9ru6+C
 glgFCnMlr/Hw5ICubR1L8m2iCwtb1mlwB7G4hJ1SKxn0hYZUaqFqSJ+f4OifS/BZLgd5JtykXVk
 NdBcl+OSmGzvlz3vI7Q==
X-Proofpoint-GUID: fvDy6Z5O2tpWvHm3eAJKJCuTqWFJpau1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140142

This patch series introduces initial support for Bluetooth Channel Sounding
(CS) using the raw HCI interface.
This series lays the groundwork for CS support by adding commonly
required protocol definitions, configuration parsing, and event handling
for the reflector role.

The changes include:

  1) Introduction of raw HCI support structures and callbacks for Channel
     Sounding procedures and events. This provides the foundational data
     definitions and HCI subevent handling needed by higher-level profiles.

  2) Addition of Channel Sounding configuration parsing from the BlueZ
     configuration file.This patch also updates the systemd
     service capability bounding set to include CAP_NET_RAW, which is
     required for bluetoothd to receive and process LE Channel Sounding
     events when running under a constrained systemd environment.

  3) Implementation of HCI LE Channel Sounding event handling in the Ranging
     profile for the reflector role. This includes opening a raw HCI channel,
     parsing relevant CS LE events, routing them to the RAP profile

Patch overview:
 1/3 shared: rap: introduce Channel Sounding HCI raw interface support
 2/3 main.conf: add Channel Sounding config parsing support
 3/3 profiles: ranging: add HCI LE Channel Sounding event handling (reflector)

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

