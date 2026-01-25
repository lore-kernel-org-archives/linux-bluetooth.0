Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E831A0712
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jan 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769360615; cv=none; b=l3WiLnlpjO4fVIL/2rnlm35tQe7WZKNIrEoe+baDrJtTgxGhUMGDycSBf2oXnf+waXOl5kTpxBbvmIUS0EaksIOPTDEmPQm6uatqmN43qsaXpUrHv9bSAYbF0DzF0EIPcTMAS1hhZBLsrd1y9Ryjeftssp6DjzWb7wmppiyjRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769360615; c=relaxed/simple;
	bh=AQTePUFOlEptyZWB9FUeFRyBoa2wsLp7mhoTUq0gj3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sH4zVnLKCe9RHia0coSdgLOfevLf0cVgMhnJi8hqaThsCg9eGB4ey2AJmDMl1y9jFDrDjRoC+9woqQLteKfNdgbd3vGOf8Jrttfak4GeHd/cCyizYYDRzhOaRqOd/37ShUl7Yyh+pUFE80R49cAW9h/J8bnUu4JhEvXYBjLf76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=biqCgd4a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LmtJUgfO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="biqCgd4a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LmtJUgfO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PFt1XW3509293
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jan 2026 17:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gcqgmvEuqbvgg1Aoyn2zGhUSmbD+3Q3+zXP
	WdKPI514=; b=biqCgd4aqt4uv1Rf/1d3BnxnWrwImCIrZIT57NsQ/WjNZ0qwTZt
	m2hifYIXzTsGbrkmwumk1PbbOMS1lQ+gYkoYUdtRcmNYG3+CD5oqGHFoLvA8RohM
	mCdkH63jL/ZqJPzb58RVVT2//nOmx6UUH4x3oOzNkpJuAz0m/Xth/HnpY6Ye4sHk
	v9Z91qosa7Dshcx8FfbWgoXV5DW/hQ2e8k7dYF/8wFSKYFnBkmMsoBaFbJLmBG0u
	Rc+FOeAyVBiAfdVQOlKFkOcmHNqj1TQSBnz3XrBA5/0NjTOfGbZg0SUg7CwLqRki
	dF1zZgebXzI8MT8zcPA119y9x9beBfkC4/Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6xtddj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jan 2026 17:03:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a13be531b2so37149045ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jan 2026 09:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769360611; x=1769965411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcqgmvEuqbvgg1Aoyn2zGhUSmbD+3Q3+zXPWdKPI514=;
        b=LmtJUgfO/6uhpHoCR4g0YEL5rg07aIKEevdf2RnHKZujqvQnkDFQJw+Hi2zXqroCKO
         c0kU3elKjyHQONl/7v3/S1LtrLBCJuozJgFWrVrJJ0MmpooM5CaDEBqKzpYCQewLgIQT
         o20VKVw95CApvWU7azL//7WA0fhFRsi1KtCHRDKOYWBrMUOsJIe3B62lU8bUdjav2lz0
         zFpqIMQPjJP5TLfbDxhzGEbCJcmySrgfJGtDPUzQ1Xf1AdcIZJaDZz0sNtCS2YdMagtL
         BadAOY570L3xnAdRMj+42Njr/6AkwDm7uf1znLi0XKcV2YW0YyKxHjsrXIjCj2AeSeHG
         NYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769360611; x=1769965411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcqgmvEuqbvgg1Aoyn2zGhUSmbD+3Q3+zXPWdKPI514=;
        b=jYUrNcqX08BxiD0TQct1xTMOsLEumOsfxYEyuTo9C/fNxhBl8l6DAOLI47tJIAgVDz
         QvNZ+FXhyyef+qjqwJq7Lv+N28Z+TwUnNeCt2JllXe8D8gGbOYGuWQz8RYEcGkpD8+We
         rzirc3T4mX2T/UIU+H3GRBR4bLU9t3mkRuNaGYQwQZ721AqMDkWmp21FQACQTdjQUyYQ
         ibPkA9VPlMNkfWCCYWh5kKG4ZP7cEzSG+vc3FTqhtPRNSUdf+JW/LG4PXx867r1+7JlY
         FAGOgVqRqOjbS16nTKH98rvEL8ZfLzlAq2KfpELunUHxl2qWzj7ohCEfMc0lrRD4t6ea
         eWzg==
X-Gm-Message-State: AOJu0YyHhRCOED5GJHXfPRE4s315XcgqYZv+GR5oA204AlJoLZoRpAD2
	LL6cMCStuAQuQwpqb9yFbakLzIQZYIbglN8j7epWtNavHBCYqt+vgR09b0y9WUFArJa0Ce/kavP
	zSxoid1hvsxcU78YfdjffFXAgdUndOr1P0bC9Xjs3k+aJ8fLTKYCicyWpd68gGM9RewteEZ7ZKO
	aGUu8=
X-Gm-Gg: AZuq6aKiqWbtinBonkhGdaZdxnC1bS9gI6Sx+rRXYo5W9YOBMEpusAkZo9ctFRT8KCF
	J3/GGN8qgAX92tYTIm7wtRZ8ce1mK49eGZmObMmprKa43b7t+tyK1u5I2mKaPIpzkl7+L0Rwuwj
	2KOE+Ug+og1RpXr/uELSfFK9pju1JPnjhYXU8J++FnjOnI9rKEo0zUK8nwHwXOuq4UhXuPAQAry
	BrVjHrOQ+/mmplm8idvToQyyIEFoL0Y0A4l+FhLqg1XU0ASDmt7JpqIRKxridhniOyjzx8RbOUz
	swjXw59/ZKvh5oC67XMoUDmP1/cLTZ9gbWPcO54Sv4Bs20oQ32pM/NTvsHTKW3OOTvQkovv4YEG
	tgpLv3S0iAXrTbRdffqGQuiJHsO82E7XE+Rbjyyf0l+svYBh7
X-Received: by 2002:a17:90b:1f81:b0:341:d265:1e82 with SMTP id 98e67ed59e1d1-353c4186e65mr1908946a91.29.1769360611366;
        Sun, 25 Jan 2026 09:03:31 -0800 (PST)
X-Received: by 2002:a17:90b:1f81:b0:341:d265:1e82 with SMTP id 98e67ed59e1d1-353c4186e65mr1908916a91.29.1769360610809;
        Sun, 25 Jan 2026 09:03:30 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a12ee41sm6500345a12.1.2026.01.25.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 09:03:30 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 0/5] Add Bluetooth Ranging Service (RAS) support
Date: Sun, 25 Jan 2026 22:33:27 +0530
Message-Id: <20260125170327.1960600-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: itbcs_iAS6X-OIu0ClYqj33OyOdSLqUB
X-Proofpoint-ORIG-GUID: itbcs_iAS6X-OIu0ClYqj33OyOdSLqUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI1MDE0MyBTYWx0ZWRfX1WaFdKVKVRt1
 Ikj3Cfp+zf2PisjBvmROdf+sQ2ZDuowt7LDTg5TtwRCikNoM4yDBkvpHLq/MYYhOVGhU+TYTXyH
 A0gCxyA929xFNYaFSbbOtd7UrIUw+g082PH0sJ9WLwKymyJ/FPDCcrYjE3QNAmEIURuxTt0A2XV
 X7fx7zA3aRixqr1DKmWyF05tEyfzbUOZGOnM87SvMlYGfGE+2HTbbJ8I1xh2l6o+tRwMYwo0CmD
 7GgEvktA/Qu/6f0NEh1PbL5kdepswvXHVa7ChSvk4WGaQsgWRgdidNYwFn78SHmFBQs5QYdfWqg
 HAjuiOp1lUa2Py9hR3HOjIbF6put6i230RAK5+3SaBELJIeWXb2e2aTZ+FZezVBZTLM95Z+v2p8
 dqo+gagMb75a5iaFjylwOyMjucj0TxFjQe/bWYDPCoQAKb4vlkQWs5mAIXe84olfcwLFzgot9xM
 5coOdMyPc9W9y3Mvknw==
X-Authority-Analysis: v=2.4 cv=Htd72kTS c=1 sm=1 tr=0 ts=69764ce4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KtAqvfYvIA5HRFhllTEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-25_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601250143

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

