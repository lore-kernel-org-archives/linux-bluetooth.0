Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732422D4C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496451; cv=none; b=QvDwfZyQ2PR7zJ07fRjE9L7B6TCY8624iWx06GemoQRpHmf283ZaFQPqhupmK3y7iEFenrijYK9y7zAubtOhxS84Rdd25MIPsETUwnUzUfHHp3VClSkBVfoj/JAApY5snggeUn2u8pghcdr6CvqdXPyTknHMA0xsTI66cXzEvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496451; c=relaxed/simple;
	bh=AQTePUFOlEptyZWB9FUeFRyBoa2wsLp7mhoTUq0gj3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYr0jUX3Z8b/cnreHZ3846sWXZ4sc5E9XXAFqbK1pTVy8PAL9f91nnLMhdq7JWXhwfp3Fvv5aOv4H11lPPIkO64K7R5onzQrvWo2dllB1QwIOiBAN9bPy2XClZ7QA2KiYCE7M4VkueKGvfTpHpleJMa3PLKVQUxA1K2oCl2NICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H82SVMLt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XTkdMdvH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H82SVMLt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XTkdMdvH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4U5la171359
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gcqgmvEuqbvgg1Aoyn2zGhUSmbD+3Q3+zXP
	WdKPI514=; b=H82SVMLtbX2dZX+269DkXyKjAKnFcx935oOeBRezP9oi/wMKew6
	jsU9KDl6kJhfn3XE7cV/CKj3ikPO6SHdayTR3Rb5nGJfcy5tvFeohjZMejcxvIdP
	dkKiwJQsQqrrFEBbADB+qA4FsiAylrweuky150RDsdk5Y4KK1K386qDz/6wBlboL
	BjOrvQ0shNTJWxIjQKre1W7gzyG3xTiQyYWU94SAc+kvsRJ6rMI0/ZYucdsC+Sk6
	pTvraaO4yiuzn2N5ActC8vienWgEqa0+8C2spiMN1h+Cu0zJ1r8cZOONXeg4+2ig
	lW2wgWZTsc0E7E9YkPWd7mLheQd35r4NkmA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a1k1y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81e7fd70908so9804699b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769496449; x=1770101249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcqgmvEuqbvgg1Aoyn2zGhUSmbD+3Q3+zXPWdKPI514=;
        b=XTkdMdvHtc1cGf2oHPAyxRCfF1hnfW9BuckJTHkWLCjAW05d37IgtlkCNuhPPnttEm
         nosdET4vMj+s3m/HyjrQTvWLiu+g9nGXPu11z+I+/+k7/apqNWDIeO54pgcglRXoUE61
         pIpt/T1ZhEau2j/EoWga3O+JjOx1jmoGmbU324UJnWz0BmFeNLA6RSriUbByQ5GyNPMO
         TcvwUtQOx1ewF22+WZ4z4QHn0u5ZSKp1++p7dLY0lS+IRx3p0y66pf5eMVEF4qrfbDbr
         /s90YWICMB/+zLGmt96pLEKqpkBkhzkGveYOu2os19iHHtWxlva8yBbNAcH5D2n1SXXP
         uRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496449; x=1770101249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcqgmvEuqbvgg1Aoyn2zGhUSmbD+3Q3+zXPWdKPI514=;
        b=QnAnJeN9sLCQNNUXiAPNESLVAPKe/Tyfs2H9ErZB1txykXY2vN+aiAafUx9N/RQlfD
         XYSD5Jx/Wx5o7w8ordTkHB0xaYm02VlGbBR1ubecS2JepnbIkPaEdk2WpiWvh/Ef3VR9
         n9iXac/pKWtDt1ccERcNNU7tfGJNbB++s0ar6VjWtyrEGoTsX/P3QISlBFxKXw91ZmEH
         5yzbZ2qQ5+E2wSaxAxS7MzMhYJh545tzZY/cRGR+nFUQmMp8N734Rc4ZbMarpclBo/ux
         Qc6q20v3Bk7Lt9Q4XrZmkWzd9YfRZf2CwCXOYTm37ttLJsyff1trJp4wYhrW2e6Fhjj9
         qlDw==
X-Gm-Message-State: AOJu0YzH+GDufsbZfPxS7KxtyKmzdZZHWfmVt20IzeLzPZCBUFWpyS/c
	nLOSdozJTb1AKBs3aLDJle51Wbtcr//ESewf/mRbWv5PsApDMv2Ay9zbfE2CKHSmhqz3khZEQGB
	8fOdo6ZAj1zp9H13QnCLpks1XHzVuE9BRxBrli0Tjacyp1vvFexYzbIah3ggxV+6FrytObyQWmi
	C7p24=
X-Gm-Gg: AZuq6aKMzn+wvnUpiScJyIxNlm3iI9zgi6fmFcOK6F1kO0vsk3lcX2oA01D3FE5BoYQ
	b9vT5nd8Yx7x3CzlJsYBhaDQT2qB1OXRZZQFVvIsaZB6xySOu/ZOQSJGob4SmGTEjBvF20I9Z5S
	YBOK6odhL79Ix6O7MG7PwNha+Vdb8/i1HvMztJRjXvexAe7/iRZqBMy2qKJG/o2fzYj8Gp/iAV3
	be2byNP55Bz6dHBEbNoDTTikPYyQQ9/yZgf9NRfp2MC49qVj/CaWnSE0WLxtoEIBxF4kMRWp3MD
	yHhyLjozNiAzUvnIMajzxPAnWayMeLGKXS7jeUpgTrFUFni41fDz+9W+Nx+QTovOZNIMx2dsF/E
	YcFnIRNWvinKgQnieLtZTwYs1uUPCj+kEr3pnFGtQAxYztNw1
X-Received: by 2002:a05:6a00:1804:b0:823:5270:ef48 with SMTP id d2e1a72fcca58-823692a19e1mr849821b3a.33.1769496448748;
        Mon, 26 Jan 2026 22:47:28 -0800 (PST)
X-Received: by 2002:a05:6a00:1804:b0:823:5270:ef48 with SMTP id d2e1a72fcca58-823692a19e1mr849809b3a.33.1769496448325;
        Mon, 26 Jan 2026 22:47:28 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876e5d0sm11032924b3a.61.2026.01.26.22.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:47:28 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 0/5] Add Bluetooth Ranging Service (RAS) support
Date: Tue, 27 Jan 2026 12:17:19 +0530
Message-Id: <20260127064724.2949465-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA1MyBTYWx0ZWRfX9Jis9GEHTXT/
 lLvSj6XyqQanf79zGvA52bTY91W0vvS/Ey7n3jo7/TYCZBai7dY4tJbeLRDilXXoNM4Khzr0AFV
 Ec7UIDTBTGHhCnaJSDSh/TFu6eJwRJK9DNBoWQjbFIfD3i52FsRJlI4NpuyTG1fVGXlj4XeMcGA
 slfOsOUnutoTU4M53/YYQB0kIU6yxGuPSxr4kY8B9dCtY70AOylX2/4+IRcR4ijhgxg9UT2ZN2j
 dt0QiHU2PyRis+GJGlKGwMgV0lxAIYpELUpklhN5dcjcHtq77rSQRg/dwR4pOBflp3bZSCI+zZy
 y2i9s2LyVVLGjR6HBOWzVUWNuM7A7K+8bTuUGyrKirmr0IGlqwbpTC1QNSpi6nfOm7c823t/XFJ
 TcjU0xhahK06hrzFYMVhGjeekghspAUHU1B69QM02VIHg/W8TwSXOF6teTiudR6PsnDSoBjB+0T
 MfVOzim4xL8jRnzsYiw==
X-Proofpoint-ORIG-GUID: 15wAAUWiZalNtwg67SyQFNAyRV5v30bd
X-Proofpoint-GUID: 15wAAUWiZalNtwg67SyQFNAyRV5v30bd
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=69785f81 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KtAqvfYvIA5HRFhllTEA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270053

The series must be applied as a whole, as later patches depend on
infrastructure introduced by earlier ones. It includes UUID definitions,
monitor support, the GATT server/client implementation, and unit tests.

The Ranging Profile is marked as experimental and requires the D-Bus
experimental flag to be enabled.

Patch overview:
  1/5 lib/uuid: Add RAS service and characteristic UUIDs
  2/5 monitor: Add ATT monitor decoding for Ranging Service (RAS)
  3/5 src/shared: Implement Bluetooth RAP GATT server and client
  4/5 unit: Add unit tests for Ranging Profile (RAP)
  5/5 profiles: Add experimental Ranging Profile (RAP) support


 Makefile.am            |  10 +-
 Makefile.plugins       |   3 +
 lib/bluetooth/uuid.h   |   8 +
 monitor/att.c          | 447 ++++++++++++++++++++-
 profiles/ranging/rap.c | 333 ++++++++++++++++
 src/shared/rap.c       | 874 +++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h       |  48 +++
 src/shared/util.c      |   9 +-
 unit/test-rap.c        | 458 +++++++++++++++++++++
 9 files changed, 2187 insertions(+), 3 deletions(-)
 create mode 100644 profiles/ranging/rap.c
 create mode 100644 src/shared/rap.c
 create mode 100644 src/shared/rap.h
 create mode 100644 unit/test-rap.c

-- 
2.34.1

