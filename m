Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF31E8836
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529295; cv=none; b=WkkpWwBbdHPCaqWq63b9UtJBbRf5Lgk56wPftGRgZUnsPJOG0L8Hvd7X72y+Go874ZwP1M13uMdtXYWn3mUuFu7gY/rnPiBBeVBgRqoP6IGkYFB1ot0BX1XODidlFNk70BkZHYf6p7MsENSHitO+aFWZ319HYmPvE0mXMOO6NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529295; c=relaxed/simple;
	bh=fU4S6SjRr1mz8j6Eeh+ADqOi15XgyVx2BdGFJNpZuUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZTqXzzZ0oZwx0ATx+T6YL4qYNl38cGtDOLbCRCwCQNhlV69VY07L4f2H2+dG7pWgmqiymk34g2sHNDLkPZIT/B26T/WAlqC4m4NR9epu099ZrxW43fLaBtuuPRjNwT17S4LFkFmDpVhIq8LQfFJTeLrvWBPnqpAV/bdD1IkgrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d0oO9NTG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bAg1jmP+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0oO9NTG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bAg1jmP+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAbvNq1268765
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0FEtLm+jPta/2jrCDaC/F5sKsI1IM5qoQI9
	c8PaEz9A=; b=d0oO9NTGCBNJ1EIMypJcZyav4QnuhjCXBaI1Dy+Le0zxCpqB+9y
	lNs8ZDHnwS1GIp4zqdHPjOTY/YN8ewOqf3o8kMWaEjrZyAsz+bxd+VzYKbNgxCHf
	FK30ywzolwu5IBPzfFjo457swmuqNARftF6N+gRC3TLkeIeWvTDt5eAAqssDXMWT
	9vKyW2ZXE/oHPMTSqDxhzUo1udBaPgyzUjTBh0njl5XdTkUv7fGPThBmaCDOKnBX
	7nNhUXr9s0qq2pJQ7iPBOgyDxRltE6aV2yDSOMgJs0KbwdR2bcle+Fe7M4EjFZUm
	X/tsHcyOeTgINRBRFXLDhUcWH3J8mStuvcQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyata3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:54:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a7a98ba326so64250075ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529292; x=1770134092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0FEtLm+jPta/2jrCDaC/F5sKsI1IM5qoQI9c8PaEz9A=;
        b=bAg1jmP+wptRtkgGZpA3ipmWWTsjB4ABKaLYyqxOUbwp15XtflpfDGU4VBFDjXy7UI
         jUQHdFuhS7uJWHYqpRjAHb4TbpM9d3mqhdcmLKzpfYtABdekAssZHqwmVjih67DCqmcb
         4clFcWStoGIwjBKVgv62W+HnsU6eV7ik/i7TdD59hzDsJuo5Rsjmyv+yKHKNnARwXhA3
         LubkeBTgYNLnwcu18XYw1hjc5AmlzupyDSWsPvRvg0WkEDMMU6p+bVXBUQljUnoSbxTO
         r2jMCJYEdWAzASbsjabDdDjMP3rem78Ln4idxO0R/8bPiyI7h89k1vf4BHU3lIlsAWlP
         SPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529292; x=1770134092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FEtLm+jPta/2jrCDaC/F5sKsI1IM5qoQI9c8PaEz9A=;
        b=xKSc8LgkAsFuJQxyZmBxj+6aevJw/Mig0CxOi7UTbv94K9f2+nISistg+IF+2tiCTm
         6LgfH+qu5BuKbQGCQEfS4NwSMBa9L6jCZa/5hl0u/K2f8Ngf5LnGHs4Mdu6PkWQiYaqB
         zIqnE6LiWphqmd36thNkBWdKqDxxYhVeMPCehAFDgev+CerjngGFw9NUsRwiesmQbGRT
         i//UGpR8vmLXhQj6uG173su65m126FcxnKk0C34La9Vqw/o02NjEsVUof10XikqjI2Kj
         +dVWbS4WQQmS0qqyaplom7ObVfYf4GLMW0zMNm01ORlGHnTRKPOxZKKetmkMUoAydQgF
         Atgw==
X-Gm-Message-State: AOJu0YzHCwEtfGznfuLZsx+KpQbKIjHrPccsqcMRprKf+C0gAWmXMueX
	0aOyea7vjh2O/w+vKGNOLtiQZoLCTQEAKeuukEp/Z+i1+ZX+LqIa1B8NRXmWoYyPPzPtxThVsLr
	i3GrijSDuOPAKO6N3iEBH/Lub0ZNPomX1kPfheVulMHH6HvsXmoka+1n/ysynB5Ww0DF43XAwkZ
	XP1eI=
X-Gm-Gg: AZuq6aK2syJ18Kp2Gke0rRK4YCuYJBesfddVLAdk76NDzU4aEvfGAyo2TFs++DjFJDY
	Xiv0u85JgbwrWaQAzeSVq/0bLaApmCr89Y9T3pNdjvPdn7RIPXmhkf1MlGBYaarsCkbOcBrehbb
	S+YKffmkuO0LyvFD0LwlT74nhwHvqmAvepwM3gG4HM3DTlQV28lmmNdVW4CVNPDWcfvcq1qypo5
	y+ighGQ/1qucUuYuLIZ7ZCR6M0TuMsMETjDHwPPk6gj0ZwtXzbJX/4bBdMFfLCNNCoqGUnhcM+5
	cBMDZSpJNZCE/KvL3I/oLNrzgkhuLhEWH49Yr7n/zyvmimClqT0yu8r4214QkQtwuZ4mQ1n18Rk
	Jw233Ge06m1vjkJaRQsPGtYpYJA5zF5P6/cWKYpvOKedmTldr
X-Received: by 2002:a17:902:ef49:b0:2a7:9163:8e60 with SMTP id d9443c01a7336-2a87132bb25mr21125015ad.23.1769529291750;
        Tue, 27 Jan 2026 07:54:51 -0800 (PST)
X-Received: by 2002:a17:902:ef49:b0:2a7:9163:8e60 with SMTP id d9443c01a7336-2a87132bb25mr21124735ad.23.1769529291027;
        Tue, 27 Jan 2026 07:54:51 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa719sm123292855ad.14.2026.01.27.07.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:54:50 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v4 0/5] Add Bluetooth Ranging Service (RAS) support
Date: Tue, 27 Jan 2026 21:24:42 +0530
Message-Id: <20260127155447.3324706-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tLabnyjWgA8Fe45unAdxFUI7WpqVS6Uo
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=6978dfcd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qzLFEn3b8El_mvwVl5sA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: tLabnyjWgA8Fe45unAdxFUI7WpqVS6Uo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX2T+/XX68JJfD
 yBfsgIrQ5+8+LbGEs4/pUW1/17lYnvIGv/uo6yA2nTC6u1Z362RSWI4uT7JoMw/47L/Y7lu9X8K
 4lHxLj2auGb0Za+FnXtwkRwwo44OfBFsr/tqFqsJ6UTR5pOB07CXdjkLxZkNu6iFa5bdflqzH0I
 Anj+Km5dmF9yGADPLP1qSQ2poqE3KLd69KzT6Gyy2V4EdynG+E2BM4jalQw8vOTvH4FqJkIIocF
 kHtOXOEcVQAeM5FfDJsfwZdLj0Mep5x2TczS1IFne4AiSupvXkz3Siedie6woKKb1qDMILQgM5n
 WgA4Mv1QYmmIvIFb4tTGwgbExGFCs13NcB77Uxbi/zhaiNR/L3hkPq/OlpTvZF1mnbhF2zHbZSg
 3M6a3U5WIuABCTDr8+9UBRuwyqrj1+FlXx6wzWlrl6GEaxKV+ljfqfC4Eu0IxCX9/AlANoQWTmx
 OFAt46X5cGUndpxbjIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270130

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
 unit/test-rap.c        | 458 +++++++++++++++++++++++++
 9 files changed, 2058 insertions(+), 3 deletions(-)
 create mode 100644 profiles/ranging/rap.c
 create mode 100644 src/shared/rap.c
 create mode 100644 src/shared/rap.h
 create mode 100644 unit/test-rap.c

-- 
2.34.1

