Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C272690C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500072; cv=none; b=LquEQbm9umg5TWTT9IUOSLOAUI2ECmyBc08fQu+fqSq4dhKGJA1hyw3IvfrB8XIclogTe41zTeQP1A/yVw7I3JZSgtAXz1yBR91J0X+fIELadbNieh4M+c4FvRdX4nLUMLNu86IDRF9kYhm6eYgrx6UvOMPSD5E0pSn9HfC0MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500072; c=relaxed/simple;
	bh=Nqi/jQ2Kd5c4w1qWDSCJEZR5U9baR1GVyO/L9dPOQaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f64jP7ROVjIizt6QVj4NbkgybfFW7YyIyQiusaxgQUgW4cNuYzcHata/huAvoExb+Oj8V+ZAsJcB3+PXU5iFh79rbhP8xSfGmkwa2fNo+DS+QZVoPPUswhYyT+xW1frrVuLQbAyg5dumevc+AEjEEalME7ESZ51vEvfjvCAX7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euN86U70; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VHnhdx+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euN86U70";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VHnhdx+s"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4U0PC3857558
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=91eXIJcM2buDZqE7Ys+Va5XQkthNlfTWe5U
	KEbhjmkU=; b=euN86U70TpKT6orCsRiI14nD2uXGVYqtwbYl17zwKCi9Ys7Gf+C
	cvqwHOAiM39iYiHPpUD+d5LvEZBleyJgz6MMZ/7x7kUUKZXbxAAdJDuDsB7dWFAI
	NV+Y4UWqJWIunpZEUslqECSfsyrMRrpdQVpZJu/eMfS4B4WiTv3uLd+b6BNO2z+I
	RggAAVmB6PdxVix+Zlq+gX34fH82NWDlJV00cWqPVgI8ldH+uo9C+D37ye9qU8ax
	cOEegZNJt3wdDiR/MBv3DldHb0RRV8qGEXCwiAHcZxIkk6W9ougXNctQuOTxmD27
	OuPqkICCBbyNnWbiiq+u4yzov4NuGcMR+8Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs1q5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:47:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c5291b89733so3068173a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 23:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769500069; x=1770104869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91eXIJcM2buDZqE7Ys+Va5XQkthNlfTWe5UKEbhjmkU=;
        b=VHnhdx+sCziqNWfYDnfCyb3/0sbljQJMqopolD4alg+ambUU8ohWwTszLQP+UzYOz6
         T0F5Qqk7T6g0qOldCQkYeYN01mJfV3cSFNXSv6VPhmQ2CZFmr+zAeKKKa5y0ZoxjOuhZ
         rYASvw70FT0sIUOmdvNH3Dzx5lCwLISD1xOY7xfV0JcozNgQz/PQ7RNGrvf6Z87+GV7T
         AF0aFtDMBAUeObxSLCGVNa7+CTDYDr+5fDx+lCO0Q8/0FH9UaBPsRgJEH8ImV/26l83G
         cLZeglRMg1nPZN3P0AUNXGfi1BcvvtUbLgfZys8L1VAnPwIOAf1O+dnW/t8KQ2c/zCYg
         mqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500069; x=1770104869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91eXIJcM2buDZqE7Ys+Va5XQkthNlfTWe5UKEbhjmkU=;
        b=nROl6OQsUSncYwXdIaxAuuMLOctJlbx2SqKwJ58lZhS/cpkzzEdwBzRcAE0tvMGL5R
         AaHM86kGLx1szkn7dbAieVK/kfTXZBrJKN6RJeFTjTMuD4b/6fTAsMUGsCR/erytL6tl
         s9iA9yNOQk3rciLiWoUImm5KsxjaViNK3+fxp2CRx/sFntYsmJOJ2iMji7zUKzg+Ly7c
         HB7H2ik/N7vWCwuhlffVOUdZGta3NuikfOSFmq31A7AMPSBal2hWG+SFpTeqa8PFVM1r
         q0pXQwaE+qA5KVLO1rMsj5uQIGcggsXgDNxj5chWwIwupwpOrTkk+rLteZysviccjt8b
         9jPg==
X-Gm-Message-State: AOJu0YyL8YZyAROzSaG8ulE0Jm6Ja0wr2Ikuy2nBk0OYRCya/TlGlXzI
	AfhIZUT4EgPk6W26hDo2q54XjcnaZQDaGTn8wu78BJPj3GTiHe2JHoVcyxvwiIpn6vHRysuU3vs
	y7vkcM5HacCK9C4CUCaoOMWIh/3zVVNrd/FV6ZVku+LRrlxRO8D6NaVMqTDmovnKmO7a0zwp2L6
	OFcWo=
X-Gm-Gg: AZuq6aIRRvkJ9cV/heuopZspGbmPiwx2w/eVSyNGMa88rKvg68IQPQ2OCeRGhnwXK9l
	jGBMDLae66TTQCgQGKAxNATRFA9zJfRl4BGtHTenIABLZR8vW1HJkaXnaYUDCzWrWA5DMSiriy+
	QKB4YVbPxOFvZRrWi2e01CWErB8Bikip5uo3/vuc8mFvPSLWHqtafAP5RjPPY4ytwffOnXt4uET
	LgWX/thMtF2Pc0Vq+ZkE2qBUFcO0VaNigqbS/f72ZexLEafXttOyJCHXHnG9SaPhnPngnIurhsZ
	psmc3pAhanj0wS4sMhTpB/M5lNyjqVi7E31V5Neg1e7IDouvT9sfEcwXm9m1CU4Ce452ORDB4qM
	YNZGaMWQR9enL+bBhpex1Cb86Pmhb6JiUluWeVsxV4U26VRCZ
X-Received: by 2002:a17:903:906:b0:297:d764:9874 with SMTP id d9443c01a7336-2a870d5a24amr9085135ad.21.1769500069067;
        Mon, 26 Jan 2026 23:47:49 -0800 (PST)
X-Received: by 2002:a17:903:906:b0:297:d764:9874 with SMTP id d9443c01a7336-2a870d5a24amr9084975ad.21.1769500068550;
        Mon, 26 Jan 2026 23:47:48 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcfaf7sm109483675ad.34.2026.01.26.23.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:47:48 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v2 0/5] Add Bluetooth Ranging Service (RAS) support
Date: Tue, 27 Jan 2026 13:17:40 +0530
Message-Id: <20260127074745.2984874-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K6ZGIQbEslUVcAE3Ii24F5VleIcw-xZV
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=69786da6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KtAqvfYvIA5HRFhllTEA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: K6ZGIQbEslUVcAE3Ii24F5VleIcw-xZV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA2MiBTYWx0ZWRfX3imtI7yMzZfJ
 bv4RRciqf4/iFNSW1Zn+8z50nery83/u9k2ef7jA4PeUyDVxxN+DepGFhEOx6NVMcbT+R/rgXuH
 NGXnWz2x9Dvqp55vaUcptpvzjpd93WCsglClG/bOExwJy5xmgWDF5kx8T5Q/VVsenSlNhkzO/L1
 Noba+tmvM+nl64iQ1/t5gb2q5I9csu+d27OS//sr341EX2GT2gf9UVzXEHRegrvC4+dpt9XS8jW
 W90MO3dxZrqrH6fSGUV/V69KyfDC+4pjt63YPzDyubzM1iegi70pLvdndL5CJCzExuMo3LuHPrT
 iT3Rb7QMZw39bn3ugg6maQrSEc2etwMlrVBMx9soOZNTyn2NWCZWu6WqW4HKKFegAUSW/7eRrl5
 UX5KxU8lE8qL9QZWLNWpWS6RPJD99dCNdsfHlg6yqFLfjYSOD/1gN+bQXn7224PApAxKgAeNDJq
 l+gUudqC44C0eyR2krA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270062

The series must be applied as a whole, as later patches depend on
infrastructure introduced by earlier ones. It includes UUID definitions,
monitor support, the GATT server/client implementation, and unit tests.

The Ranging Profile is marked as experimental and requires the D-Bus
experimental flag to be enabled.

Changes in v2:
- src/shared/rap.h: Remove unnecessary include of 
  "src/shared/gatt-client.h" to fix build error caused by redundant 
  redeclarations.

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

