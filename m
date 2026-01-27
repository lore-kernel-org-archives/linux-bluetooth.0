Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922F1F63CD
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508208; cv=none; b=TsCwAGBuRJwcfKOTkvH3yw+PlnaIWIGG4vI8QQlx7xFAZEIweCsfJdkK0QmqzkGCSb7gxe0T34HRqImYGi2lCHuglcznrn7EDIGgFJ0nsIGjNV4zu/lZm3cRuWJzRri5Ss5pmQtl7Mh1TT2/rn2xpEiCDWarfgwkCq9A2leGlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508208; c=relaxed/simple;
	bh=PwaPmu/01ti47tPDuqAilyD1mBnQ3+u1nLySHqU3lEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5Rul96Ws/cp8z/YDcNjIODbtbE/cpEgpjgsxonXuRCUGLJreOHjQtAFzLLeTCdQv3XVyxVi71wTqvjOLQPhcegSoFMBH859iaBCXGjQs12XPXNTGKB7MJ60YRsUTip1CuBK8Yvsb9sFDS0xvWuxUkyYGmMP3UZst1BUwRvSaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZDYEbha; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IgAEqqZ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZDYEbha";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgAEqqZ9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4U1Z4786605
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CiriBT0BMBPi7+/CE66AbbvjfRL4+UqawP1
	cra/HqTA=; b=CZDYEbhaMKncA0yIkvS/gd7FXcbG+nYis5EjxPRrrbAOiy3Xqe0
	fJpVXYxFg4IsePywrneomVCCLKEoboeaUUWiuOeqbgZLS/OW7h19Cb9RTtLT3v72
	u7jvS6O9u97ZH6sYb0B5+xrTAPEZSMx57CY/E+C/xvxoiku9VG9ahn0erYxr0A5S
	iQoGm8E7JX4d0TRWivjj4lAF4zmuDJShxtMiJPW7RgO91Phgi2DEgcRzK1MDEka7
	88OHsoFluHovZQyZ8IzwOcSXpvQ2ZUgajnrwuuKnzDVOrTJbRtpbvoPW4UQEUkfa
	KXjF5/+yw1bo10tdYBgoUAik4LHlE7bEhVQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxg93j51q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a784b2234dso11390385ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769508205; x=1770113005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiriBT0BMBPi7+/CE66AbbvjfRL4+UqawP1cra/HqTA=;
        b=IgAEqqZ9H8Dv1D/8zpREuxE4OuaaeFVqHmV4y/PlHnr0/KFUc2zV04Dc8BLPmTwBJU
         AUl3Ull2E65nzTMyxSTdAuIzq+O7uOpQ6cSsNleXznXiG75bZmAdA4rGhSNLk7NN6+xv
         SqPZcfGkNmh78w6dYTlHNo1oZcIIraoMBwUbPWZ3lM9YwTd0A8KeW/3ROBG7waK1dJoV
         LKzQQCeFcqhOOw4qbDS9QnnQx7WXAknJNIdyN3HsNve7FKXzVaMhgLapm+lOTtev1ues
         WIx/kQOFmj+tQFADZRi6CRXbrEFevOnRAJtA6L3cv3xWR9l4W0J5xEhcjuhUqbhVKpm0
         rAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508205; x=1770113005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiriBT0BMBPi7+/CE66AbbvjfRL4+UqawP1cra/HqTA=;
        b=hhdrR3r5czViIwxGh4pQ0ulIsp13PaniFbIKxJdgQN4+BwJDFeG50Yt1aIaCU0WD+v
         KuiH4DlAxiwrTsQrFiIkElg1XwVKMNiRLGFwO8geWiPbBsTOyCeNqhVBYaODVVFxVJWv
         NJgVzGp0zuB8Z1IsFTJiqBkFCCpZuzkqpm2Rnr9ZbbPyLYLCjoQ4Gu1Uva/TcNHadZug
         zYkhLS95JoTPAoQDP3dbolnjkCjOkaN4pB/gueiXgASw6wE0S9JxyziWi4wx/Serxe3X
         Bpdtp36kciw4CsI7Xz336Ltq0F9cnCn8qnXe0eE9e8iZGf5vOeLb8A95xKK3MSd9V7Sb
         gPww==
X-Gm-Message-State: AOJu0YyHKVM8IEmLeCKCV/u8aU0FspeRDC9qvCIht+CFEHshHtcRW2vR
	qL/3vhn5+khdtL7/E0lDL7E5j5kCDU+Rf+0ilbLBXLtgcfDEk2jHAX8VonuIfAEGTk5/A1Q2Mcx
	T6UYkLwv6nVO86kgR1M1lRZ6wnR66m5D0PyxR6LjP1ULtRpHIP2bvYTITx8a5QdMSkIt+jizwia
	w8RQM=
X-Gm-Gg: AZuq6aK5vhcUR/8sM+egKbptbD63uuh44F8Vd8Bm2eHn75fbGe+iE7VK0Kq629g4PhG
	w27TVn83ypjgaT4ZEk8G1Dm5LzGrs251Wp6XvcDYC9vDp8v1Mm9lMujXp6fFL8CSkBULa9XcT3+
	xOsvW1Lsu6o9WEEPWx8QwOAlANW/iYtL9N6y8vPBb7OtP6+sFG8mh6XEpH9a09oEzmfK0YrcRDR
	ONMq6hRSOixLrM3ne+EXonPUBS4TBeD8vUs32WBkQYev4er8nBJdfl2S/aIlPNNlEDjllSP5OCl
	XfRsDrmJzX7MSWP/ZBelWCwzXBBYu2XAhMbwYbvQJ/u+zfm/6+vK8XHNRACsDjkm1h3o3rsOtbM
	O1vvH9XS3NFGWNvcgtaG5sMQIePnkfMiSO5XHaheQ+KXY2nOr
X-Received: by 2002:a17:903:22d2:b0:2a7:5751:5b27 with SMTP id d9443c01a7336-2a870e192ecmr13985495ad.39.1769508205034;
        Tue, 27 Jan 2026 02:03:25 -0800 (PST)
X-Received: by 2002:a17:903:22d2:b0:2a7:5751:5b27 with SMTP id d9443c01a7336-2a870e192ecmr13985265ad.39.1769508204547;
        Tue, 27 Jan 2026 02:03:24 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a87842538bsm7619455ad.60.2026.01.27.02.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:03:24 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v3 0/5] Add Bluetooth Ranging Service (RAS) support
Date: Tue, 27 Jan 2026 15:33:15 +0530
Message-Id: <20260127100320.3055119-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4MiBTYWx0ZWRfX58roGOy+sBcz
 PLgxRZLBycdzS9q8zkUnzE+LWspZZf7vCANOeN37qnlXKGUrEE8mjlR0a20JxNVvoJShbe3YA93
 vJmOoQAQIaWZh/CAWYQ3yPCUtD/+ocbruaD/dQ/5dPvRtpsqSxWO9fJEjOxZdAh2Ne1Sii25EHQ
 06HuFYRocrfhaXa8dSy9F/jC9BD0tECPLnxSsJ49yM7shQh+KrLN+OJuoi1MGy8XvCOBKwWELXF
 CLW0SRSDIw+20RdRmL4/scFqZSHaKeplU2zuzpvkRMCPoh2/G/HgpOz7JSZydtXtTXV2fnGGW+p
 h1Mg8DqqhL271m/uZw/ittNKr/lCPIg7F6nsRS26iHNy40nMnSZVr5lff8RLP04W3EPMv5L0qLi
 bLlZu59NCuOGDC3KCHyvCwrEiuCtqpWvrs5pyXhALhRN6lKCjXxxJgXVQRkQ8RVl8Ps98JN7qTL
 PGDJtwycolqJn+LaihA==
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=69788d6e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KtAqvfYvIA5HRFhllTEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: VH8w3zPk69vUmRjmPoGbEpRUJzadzylk
X-Proofpoint-GUID: VH8w3zPk69vUmRjmPoGbEpRUJzadzylk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270082

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

Changes in v3:
- Fix patch formatting issues (corruption) reported by CI.

Changes in v2:
- src/shared/rap.h: Remove unnecessary include of 
  "src/shared/gatt-client.h" to fix build error caused by redundant 
  redeclarations.

 Makefile.am            |  10 +-
 Makefile.plugins       |   3 +
 lib/bluetooth/uuid.h   |   8 +
 monitor/att.c          | 447 ++++++++++++++++++++-
 profiles/ranging/rap.c | 333 ++++++++++++++++
 src/shared/rap.c       | 874 +++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h       |  45 +++
 src/shared/util.c      |   9 +-
 unit/test-rap.c        | 458 +++++++++++++++++++++
 9 files changed, 2184 insertions(+), 3 deletions(-)
 create mode 100644 profiles/ranging/rap.c
 create mode 100644 src/shared/rap.c
 create mode 100644 src/shared/rap.h
 create mode 100644 unit/test-rap.c

-- 
2.34.1

