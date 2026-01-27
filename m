Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D653043BE
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536146; cv=none; b=rH8U7pbOygtsboeED+vAd7QCFdlXW2fg1gKRju8pi3aPFHz08ADiinT0wXe4C0Eid5mZJGuQ1G2Autrd4tP6rF0e8SkIZVRVUChQTIPcqzp8Q1Z0vzE/Ungi0+2SfLMr18zlfCi0mkXQxEYnTxvDEwD31lBRAbJ69BHaa3mED1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536146; c=relaxed/simple;
	bh=2QRYUrc9U8mO+jpVlV4jeiCYb14K0X9Uf+ZkynTN2zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Re63Y3zq0UXGGvld7mB40WEZG86A+zgQrQTGaprvGtm/cvVvsrHwVuJTqwRR9GTnSVX1WeWvSzhTEohlPHBn2YdAXMCH8Xjz6bHPbRfug8n5CKKbX9kLYyiHdr0x7sBo6pWq885mAXSd5ZP5ipI0pXBHIg/7yt4zZP4hp049hzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GatqNnVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mojgz0w4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GatqNnVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mojgz0w4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RFL1oP621206
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=44XEVSaFRvKEjWG0V0zM2AJph329ArWT2UJ
	kIaKz18k=; b=GatqNnVj5qUMdprYEGIo6fXLasQcVeYVAkYD3j1AVkvaj1UurUc
	KZmO1l47Tq+uIzbT1tpSQmMKiq+yDJMzMaXYrmRBkOCTErQvkdQOh0qZN9LIFCRO
	Wfa+0/7Mpk8eE8JIs0tZuMsJnfGcmCrD+rJaZ4trZwyBStd0Kg0paAubRpJEwyHR
	kFqSrM8ytUljptdDVT72GUTvMf7T8NZTx5tUNq4zJXhqox+Ix7Mb9POTqhXwIgR0
	uVekWMoxLfb8D4kWmi0PDokJsSPL2J5gS6wRXBLRDG1LXjPZ63Rtj/8OSXfszoOJ
	wCOoTV+AMS5mxlT7GoUIGLqshzI2QX/F1MQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjehwuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f4822f77so138481875ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769536141; x=1770140941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44XEVSaFRvKEjWG0V0zM2AJph329ArWT2UJkIaKz18k=;
        b=Mojgz0w4Tx/YQbCgaYsEGIMyjlSP1yWCU8j8erW2CcTTXUTmQcArG/WgyVq7DR94QU
         CYXAJuxFn0pnUYD803391O7Ez2GuPvBU+SIrhoXx7dcmfBWqjX8H04mDrMSola70DR+5
         PphDrcML3rT8BI01GZ5/CAillih2aOaYc7iNtsm7k0K4QEKQw0oOgeIkJdL6O0hbgfgI
         MRkvRZpmdEqGuBGefEHH0A0LWsHcKqmE+M2N8ZvOUAQk/YjIW9R4H3CJkMJLhuV4VYo+
         iPFQrH3UfXl9SbGlLEulZEy4xQ++JCnMP9o6CiXav+XYV3iskeQFSSS9UrEc+wHvsUh6
         1pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536141; x=1770140941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44XEVSaFRvKEjWG0V0zM2AJph329ArWT2UJkIaKz18k=;
        b=BoPTu2NiTV8rgZhvkVnySo5EugPkuZU4uhlXSmpcnloV11Wy2uKFlrq3OKCfH0N9+M
         DVyv1e6t7+XW8zz2F4oE+STyDOuKmWoYskCnoch0NsZmmYr8EU7JAj2V2SnBPvEJPHtF
         V9KwxPskoMdemC45dI46UncHEhThLR6VToy+kWCGJdSeoSkd30hvEYfXRLRSorSYls0v
         /GzmIGAgU7SSh1QKb+ts1efaz7sju2BJzJc1s4052318QLXR9Y7DyC6UQiwmw8vxvkPK
         3xQkklazzNDTYzUDLF/j+SvhYK2mE7BdwNiHLPdOmURo0xdzVM7QEenVdUDmcy7VvLwU
         nA2A==
X-Gm-Message-State: AOJu0YwhVT3Dhou/i8zb/0nv6RxiD12Y88Q7RU/NzNZtn5qEzqGTP72R
	nbKS9sm1jMdWbXHWCeY3TMVVcieCiLI2s2kz8bgkfflzdlHKjWqnTbxqRs0UyfzV+d+nPsgbU5C
	iU+K8ZPPTHWPXqcLaM8vkm4O7BJ91Br1kOIaQqXenIVWghd101FqMSvUYMYNtI37DKZUKlAuUK1
	d+hFY=
X-Gm-Gg: AZuq6aJLO/C7L30tMii/CqUTYUoWdCKYqp4KjGXeFkyTVtxunI0YT/YamB8Y+4/gTcS
	6wjpYGFpYbRzhPBCSBHVBPXng22ckOzdx/q+xKVxFtB9RF9wlfccSpUvYE/ReuKVOZ5Odwldw6h
	kwQVDfbkieyohnFt1DwvOc+K0MmFB8D8oe9RVEx81GBJRbgjELOa4IJR75lLUZr1PV0VzyWXgPb
	T9hMba4lzR1huuXH+D6489Ii/Yu72PCdIuBf4O2Kd8FZVXIpOaWom7tpAok81Yt/QfShuAjMyjC
	armF4BOxWUTlQlYCxuQKJVxYYnBlq+uZeovz3vkwKF/D+iKstHnn9jciOJbI9fefYsTcloXL600
	z3MFsN+OrjbveMBcD866R+HLRlX6jm9SpBwjisc7SC6M508nS
X-Received: by 2002:a17:903:196b:b0:2a2:f1d4:3b64 with SMTP id d9443c01a7336-2a870d7228bmr26002755ad.21.1769536140800;
        Tue, 27 Jan 2026 09:49:00 -0800 (PST)
X-Received: by 2002:a17:903:196b:b0:2a2:f1d4:3b64 with SMTP id d9443c01a7336-2a870d7228bmr26002575ad.21.1769536140316;
        Tue, 27 Jan 2026 09:49:00 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e5fb0sm110385ad.91.2026.01.27.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:49:00 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5 0/5] Add Bluetooth Ranging Service (RAS) support
Date: Tue, 27 Jan 2026 23:18:51 +0530
Message-Id: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NSBTYWx0ZWRfX9+BlA3zeC/Pz
 /nfYlI5X/O9h4y9lKmJqtROO+Td3d16hNfut4py+HL+ehY5a9PuWEn3rcQ+PgA/4u7QPsQa3xSm
 wyO9dwH9Hbo083Dir6EA9C4r6fW2UqtrdrwptLgeb5DPat/2q3tOxy1Vtp+y56r+jV9SuZqmSml
 NLu6M+fmDi1wgWjShOiGpV/s03hf1U/W7Fv3jJ30MTNGP4GS/Q5TQw65HLFZLnYwkTWWcSjTGeM
 74pNeQOaiRg8JYq/IuA0V4GpwnKsyrTgpOf/Kv5G1mE5rmKL/Is8PNO0+omEcEchDPnmTpye6l+
 lWfq5ClJJTkq70nYtKm39hq0cXCjS7EZcxDDNokJ720dhrc5cvIIpZ1yOsl9KrDUYyVeX7K5cjE
 dCKR53xp9q+Pov/zwXSldjyZ1QNnrszc0aXXbtGoZ+A8jPLG990lceYY6zVpKJyg3EIdKePKSSx
 DUk48oh8+00OIXxJgPQ==
X-Authority-Analysis: v=2.4 cv=Qelrf8bv c=1 sm=1 tr=0 ts=6978fa8f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qzLFEn3b8El_mvwVl5sA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: tQmbSlb7Ql9AhwJUXvyrDEq0EyPaVHuk
X-Proofpoint-GUID: tQmbSlb7Ql9AhwJUXvyrDEq0EyPaVHuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270145

The series must be applied as a whole, as later patches depend on
infrastructure introduced by earlier ones. It includes UUID 
definitions, monitor support, the GATT server/client implementation,
and unit tests.

The Ranging Profile is marked as experimental and requires the D-Bus
experimental flag to be enabled.

Patch overview:
  1/5 lib/uuid: Add RAS service and characteristic UUIDs
  2/5 monitor: Add ATT monitor decoding for Ranging Service (RAS)
  3/5 src/shared: Implement Bluetooth RAP GATT server and client
  4/5 unit: Add unit tests for Ranging Profile (RAP)
  5/5 profiles: Add experimental Ranging Profile (RAP) support

Changes in v5:
- unit/test-rap.c: Remove unused fuctions

Changes in v4:
- src/shared/rap.c: Remove unused variables and fuctions

Changes in v3:
- Fix patch formatting issues (corruption) reported by CI.

Changes in v2:
- src/shared/rap.h: Remove unnecessary include of 
  "src/shared/gatt-client.h" to fix build error caused by redundant 
  redeclarations.

 Makefile.am            |  10 +-
 Makefile.plugins       |   3 +
 lib/bluetooth/uuid.h   |   8 +
 monitor/att.c          | 447 +++++++++++++++++++++++-
 profiles/ranging/rap.c | 333 ++++++++++++++++++
 src/shared/rap.c       | 748 +++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h       |  45 +++
 src/shared/util.c      |   9 +-
 unit/test-rap.c        | 446 ++++++++++++++++++++++++
 9 files changed, 2046 insertions(+), 3 deletions(-)
 create mode 100644 profiles/ranging/rap.c
 create mode 100644 src/shared/rap.c
 create mode 100644 src/shared/rap.h
 create mode 100644 unit/test-rap.c

-- 
2.34.1

