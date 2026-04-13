Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A61D6195
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067237; cv=none; b=fK9WIFW2/OiLMqHkndnjjIgJakgb7YT04EFtM6Gs9o45dawsPRdavDSpw+r74taLeveX10s3YHrXGyo7CL6M2JzUUzC2+XK4TPYrMqrJW0yt3mdKnPAOjo0jO3Ar7q2ztMjV8cXHgIPBhvJbAuLHrVbGvuulS00rxPqrSRsIxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067237; c=relaxed/simple;
	bh=zCGk9b7JybZdYIWcjgeGv4lQZ56mwe36db21m2haWbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLJ8rQoc3t9c12cLRfqnKv9+ap/T3sU3uCE6dHMTTeaZ1N9W8/VnLqMWREWPx912rvWrG4hTEYmwDhYJXQFKCOfZg2A2YvjWZSCxhCF3u41dzj7HGCidPoqugeNjMbBAWbQ147VIOgfr3xTlyfYZa0VBMvS78EL1hVOLWzuD/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m7jbPPxr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZK6aKX61; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7jbPPxr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZK6aKX61"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D5FRVi1121288
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=d18daCGlqX+8Vl1EAiWIkoSeijAZx9lNHMh
	UGDmzvzc=; b=m7jbPPxrB2XTUzIrnDknfIHm57wob9oOBj0bPDpe2Ct7d2ar+Sm
	LO9BGGoYa2+1otwflxaex+YcIi/01oWP6GXCBxrTgKs0rVYa+mov2zj52Y/OZiX/
	NIvkc8F2fRxY1bGwUG6G2Y/27IAMWWW5MLA8UP+9wlfD3FzDYxy5zDjXodUJC3cE
	TW8IYrhhskjHEOwzujAr3aUHMZcYhDko1vIkj4showjXtZ1q2CpClxrzQNAI/9tg
	UGpQKgtSHO+EmIfM911clH6vIuk7vgaWjc+QMzQFiIxXonPp/C7Gqcxu/MCRcVxv
	QYToVCGCRI6Z5InEDyq1qCLpMCgOjxVAQjA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jv9m7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a90510a6d1so33357345ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776067234; x=1776672034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d18daCGlqX+8Vl1EAiWIkoSeijAZx9lNHMhUGDmzvzc=;
        b=ZK6aKX61FiXiKvpHKndPxYHD4Q6/NtdOORKegJT/pPgjbLkgsQW2+Ya8rMyez6ZA4x
         nBVT7WpG6rYWiO70FjkIzvqL06OP4rV+Wd15HWK5RrDAi2cH/GxZs7dXNpjz8V4PD7co
         PP3tNZJrzUYwD04wF0uQkTpsB6RsEyog9UltYvQTTHRuBCUTlW+1ZXlOvepcG/qZ+yYA
         QUzSl9Jyiqq9jplGt3Rg8bB4JCasDLYw8s+ATfmKICMVWIGxnDQQj8JBRzZ9r/owLpqL
         s1IgplpMM2LvRFlkUPfxlHYFJhww+FhVJnUtMZcstwQuKxUjYKycH4C06oMJ3/PwT5G3
         LOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067234; x=1776672034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d18daCGlqX+8Vl1EAiWIkoSeijAZx9lNHMhUGDmzvzc=;
        b=KDsDIGBFUOhM7b51goQnEitlA0Zy++qgn+fy3ukF6WwNqYPCv6MmE+Jlrowfu/Z2AQ
         gUP/O6M1+gBXH/KFDV5IGCg2tSbM6l74Cc7Dhtb8bRu/cH30ldITXbfSmPyD7o7bfL0K
         nSez84EOGyHwXrlTNA+TeaPFlTXzIa+sf84GZDl6JcGFeP6BLPp55+vjAx1Ans03DfbE
         7Oy6QxbNURlDFzNKZeJM2KnHxHkihBvKz5YTLncKCdfHx4+0Gpn7bkdVM2w6V/+HQW7v
         tZlp46aLCq860CvX7dQaGalhMg/6+7P7DViQhlMmMuCa/WUdx8AWo3Ok1TkaXZo7R2wy
         htig==
X-Gm-Message-State: AOJu0YwHp8LZSoDjLt4Uo8WIMgFwNcAbKDVz1sxm20saImOErxIyhwS4
	m+rO8mNDXXMMbEAMetf8Pfpi2XI77BMuXjs/HWBDKbLaqPxCZQKSuTbm6Fpj2rDaGpjBb6I+eSW
	geErm7I1pZNLTesIHSkNOeSDECNjrKhELa3HYoRr+DIeQLVrMlxUPckawxSuNyjGtu+Bi3t23y/
	oEEvI=
X-Gm-Gg: AeBDievu6tzNERuxJds6t625RsNapl2nGqum85MsNgOVrMIFgwlIFQjYsmLni6lESSD
	iS1+VH3i1Pu/qh8p5/qDRTI89UwsK3fk5LpgxZfj4AdWodcLXVRv1wZ0LbEzAd5CmN7O3t7mrCV
	egqAfX4h2+hVdxMd0ZoqibXgDFKPSE4s4zhKrGaCLRTCdOMo4Kqai5hUHxPHKsF0o3cDw4n0XHx
	UCW0aQwjAxtHuXRnru4PdCHPZrt+IZQ0NPgFUPwsOiRjMsr1Eos+EpoqUtsZIF8rcD3peAXun6G
	jAc2/i3lzxeo4ubX5CNYhQKQmh9CySwxU+xd7tmrKXIYiwlUYiYpLjYvutOpwsEN9VM7DTnADWD
	R11+mok+OAM9/sabH8ilwMI5fFLm25HXkjYsWpJeHLXpKXkUxLpM=
X-Received: by 2002:a17:903:2ed0:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b2c73a4423mr152501875ad.28.1776067233695;
        Mon, 13 Apr 2026 01:00:33 -0700 (PDT)
X-Received: by 2002:a17:903:2ed0:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b2c73a4423mr152501595ad.28.1776067233246;
        Mon, 13 Apr 2026 01:00:33 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0adbbsm107930475ad.46.2026.04.13.01.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:00:32 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 0/3] Bluetooth: Add initial Channel Sounding
Date: Mon, 13 Apr 2026 13:30:20 +0530
Message-Id: <20260413080023.1455582-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA3NiBTYWx0ZWRfXwe5KFd6pKDmt
 ECGhTDLa1gzHyTJ+mG1svvAXFnooVAtwyXhcRvksqvXuX5QDSuMfefCflz6a8Y+2+ngXtf6G8wo
 HsN7okk7Fz/FcLoD4czVzL8AcXnqKJorJqy+8g49qbrbaJcV6U59lDTppVEW8IdrvKNYlv4Z7pg
 kvgsL9YXxElJYfsVfOdovmK0bcBp+OkgQLVqKLhCyCq2o21/JroHr0XzQFgp2+Bh+qh5QeVBhPf
 70Jg6cOEbsRxXux0o9GdKeg/t/Q5K1WTotgj98TY/WnZmY6HS8Ws8cipIP7jXi4Xwuo3i++9LNM
 sn2PJPHYuX/GzSEHWY5Z2y2J/rCzOX7Nb55ZA+27CozvuChQAOiIhqFSjPX4c1dq4XMY+svNqBF
 TLsqhNTgLHdMHaGzNjAgBZhnF2EGAKUL+zCdCq1ltD5NApX9k5/OzzqSW7R7PjoSzyb9aR11QF/
 IzjWBiVDl2q4YT8eFrw==
X-Proofpoint-ORIG-GUID: uzyVFpSdZLS_V3lfvgFt4qfg64dda5WI
X-Proofpoint-GUID: uzyVFpSdZLS_V3lfvgFt4qfg64dda5WI
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69dca2a3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=JxoTkb2ISLZPhhTfFPgA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130076

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
 2/3 bluetooth: add Channel Sounding config parsing support
 3/3 profiles: ranging: add HCI LE Channel Sounding event handling (reflector)

Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw  interface support
  bluetooth: Add Channel Sounding config parsing  support
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

