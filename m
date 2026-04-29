Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C837E30A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476591; cv=none; b=twfF0FA1wayYXaIX2/EplB/9I7pzNyagnmM4f/tVVX3mDX2QtD+tzdhriikfgXphv+Ok64uV4NoTfSB3mp32mzBz48pN1cxNlizFLxw2/0W3nCJ/j2bu8r7G8r4XZGuh44m0Hw5CMLE4GPPxUvHRRdQOam3B6P4ygltACkR4bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476591; c=relaxed/simple;
	bh=YMjBviDnI4Z+dgdL/JEHnCrgQfVJBdM7fsxPYeJ6LOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDbMHXHrq9Jp5P2NmXHUd0boqXaDjiKofuUoYlijzjO2dJ58ewRLtv2KY3GdXGNhRpBXo4g5jK/2FewmJ792zLTdV7n7TYxFKjBLxT2D00izfPz9npnj7R1akPpBW/JJogax1Bs+VEdOURBcAK99IYZbHK9OhA9VGn6R5jPZ3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6fv+pkA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H5CEIWSe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6fv+pkA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H5CEIWSe"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF5QMo1641530
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nwH4fAXdxqZbsXFSh6pbDXFCrcDVuMj+uWS
	zEXJI3L0=; b=B6fv+pkAk/S8XYu5B2vn2hnCQm6ZTtY7iLyW2+0xpOyQkWT0Lt/
	wVMV1+V+StP71QSaOFFpaAkP+N7wI5EQEKRzThre79Tm9l3RN6hBVjj1BPWMrIAd
	s/fB0gqX5G5wXw71dh7jcOuHjSRKjCnkRTsL6J8qPsIplAZ7CW61YSzc6Nxkxj19
	6s+4JN67LLPbyhFoVOZByYvHmy9F5ash6b4ZqrLVjs9Ly8H/0TXNoU+7xPA1NgmH
	0V/shVfSY615WddFoNZCvf2Pmyvnjm05fRFwDp6c4lhHFpKaQvOTo3PYciVqhHZ3
	StguonxaLrZZis7GfLX9mtOyashL6Ofmj5Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj826me-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 15:29:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso7116405b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777476588; x=1778081388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwH4fAXdxqZbsXFSh6pbDXFCrcDVuMj+uWSzEXJI3L0=;
        b=H5CEIWSefkxevRdJ1QLlq5wgcO7MoM5bJG0G/NPxiDsQfbf4R72FEEnvEi1ro6MJiR
         MbIbptsZ4ao1rYAEVaxENBRaOs8boaei1hnca+QmEGbipR0JfLEza2omsFzm5rogjZl7
         2rtAmpjscLkh3HcBzI/dkqJ87RXulTKgjeY4NiG0CL7ZtJCzQtpRWvCJoSnrW2FRjF7G
         Myw4jiR3NMROqkxAP/C2bJmlyr3s+0UMn82TQtll+BB85oaKPVAd9GRA4D5O2jB4yBuV
         pn/lBb63ZKn7JNUyOvncWCRgzao4gqHz57TnSuOM7ntnzuQ0v6WsG5uIyCww1BcBs+pD
         YGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476588; x=1778081388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwH4fAXdxqZbsXFSh6pbDXFCrcDVuMj+uWSzEXJI3L0=;
        b=V6767eVKfhHVtw3Trk7joz1dV1MrneDheSAHtCusrXN0qeTHuY0wOwVf0AX8MJ7G60
         CaBGEqcjm6JIKWjIoMW+2d6iukC7a4lpMXjb48jJ9QIjoxEa8ltahCyoLH92unSXTT3i
         N2a5oO/Rj3MrlHz2KmWlzTL8aybLTlCigw2TA/P9hk7+Pciy1eJZvdF17GpESZEZWecS
         Dz3Spi21q08w1EKjxTrDJA3AB1DgjfCeW/44WDotXlp4cmkE+9k4YmSdWG1OXL710Hts
         Q3JOmtvNf0GYMtl9jGM88T7RjiGyBGrySp5Sct69RhXuoRqfMXekG+vF6z1Dpavk3CB9
         bjGA==
X-Gm-Message-State: AOJu0YwdPMN5Ok1D5kQ0seQBiYyWglzk3FHyiD7eRBXRNn/XiwwmouRf
	Zv1P/aOM+vSpfkKcAFCLw4F/HtJ1eZFbjlfRu8zbCtX6XVYLTunhA7ktshoP3pCJ/n9sro8Rbo9
	UKR1Jy6BUVmrjfzJPDhreCRjvMfPC4R6nPAJE9kRMpqzuOoMlbNCapc2Ab23992Hm0bXiiko3Ut
	AErBQ=
X-Gm-Gg: AeBDievQrOty/Muh2AogWVwSVRuptqjm8fRvz98pnv3Uzx6i74Tav+yvoOQz5zEFTTF
	9uxxUzrp8p8+4yb6fi4h28BO/vF09JCdHFz4JRy0xwXr1xtdyTdEU/IOet8fBCmxoAagqUAaM2m
	nLm+uv4WSiFxCW0Egq6oNb6xlcI6IUz7CpfuGB7R8afbPGS3SLiiqARcxR6FXlohaDewR+XKmjB
	ja5ZCp2308vO45ClsubMurC5Xz4MlR0It0KEjyM8QM0Up78gG8jaXTXjhDpAInKt/TtMeV5lMiG
	ru69oUsJI0KfklY5EH6xsDjRwFn1r+NRuroNZT4Pj5iAAMOGxY+EYCoBKkEvjpBXjUFBg0PzKRO
	gwMiyKsQHHG7UeW6DuvxmNoRmlFWS5VRLgCJuG7qX6LXePc7noutTnQ==
X-Received: by 2002:a05:6a00:2350:b0:82f:5e65:2e19 with SMTP id d2e1a72fcca58-834ddb61758mr8611972b3a.22.1777476587440;
        Wed, 29 Apr 2026 08:29:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:2350:b0:82f:5e65:2e19 with SMTP id d2e1a72fcca58-834ddb61758mr8611943b3a.22.1777476586947;
        Wed, 29 Apr 2026 08:29:46 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6debacsm2386128b3a.33.2026.04.29.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:29:46 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v6 0/3] Add RAS Packet format and Notification support
Date: Wed, 29 Apr 2026 20:59:39 +0530
Message-Id: <20260429152942.2940978-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GT6Wtte6HuPlPrXpAW6WKIqJbEo90EQ9
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f223ec cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=lQmlWkfr8KketHAhfwwA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: GT6Wtte6HuPlPrXpAW6WKIqJbEo90EQ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE1NiBTYWx0ZWRfXwRh5RgmEqqMM
 mPfo8AJWvmzl75BI7hhUWpcwb0Pfy/vwkaolnTq24Dk9PnRq+UgDjYSFJeyZlbZkNx0zNvopUZi
 wc+wOzYEpeTCElwm26fGqZWxymbXjetfX0V4g7extYij8UvcmrL3k9gVsxaEMtFrUM/TybXIrX0
 U/yrkKQJZlxLXt9sj5Tbqjmea7Vo4BjE4Uyp/1EEU+wUBSmowqmlLsGtzJu0936uQoLyEcKhtmS
 BWPYGhRvgm8fImGywIW3k4MdrSE5u0dUBl9ZRXeZyswYVmmRQ3a/BWJJKBn1yAQlEBeuURvIRYj
 4dmmnTIGGamh/OtpAAez2p+XWQ5rCJMCkNH4WGN2492VOs3M0A70jaQ6bLXc9wI+UjcRaHogEsT
 c1pRFJzo/OToZi5k+6RHvRWiMQXwOezwkebhcRI00EGLoUdUq+crtfpI3RFBR80Dt7EOkMwzUJ3
 ULI0ZcdCxkqlMFmG0Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290156

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Changes in v6:
src/shared:
 Removed 5 separate CCC write callbacks
 Added unified ras_ranging_data_ccc_write_cb for Real-time and On-demand
 Removed unused macros
 refactored CS mode processing into separate functions
 Improved iov_prepend_bytes - use realloc/memmove instead of malloc/memcpy
unit/test-rap:
 Added RAS/SR/SPE/BI-11-C test case for mutual exclusivity validation

Changes in v5:
 Fixed Max length err in title

Changes in v4:
 Fixed declaration after statement in src/shared/rap.c

Changes in v3:
 Fix for cs_mode_one_data struct members rearrage as per spec
 Reading of cs_mode_one_data in rap_hci.c
 Address cs_mode data struct padding in src/shared/rap.c

Changes in v2:
 Fixed missing declaration in src/shared/rap.c

Patch overview:
  1/3 src/shared: Add RAS packet format and sending notifications to client
  2/3 uint/test-rap : Add PTS tests for CS reflector
  3/3 profiles/ranging: Read cs_mode_one_data members as per spec

 profiles/ranging/rap_hci.c |   25 +-
 src/shared/rap.c           | 1188 +++++++++++++++++++++++++++++++++++-
 src/shared/rap.h           |    4 +-
 unit/test-rap.c            |  327 +++++++++-
 4 files changed, 1515 insertions(+), 29 deletions(-)

-- 
2.34.1

