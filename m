Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31352374E7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534910; cv=none; b=IIAZ1pWXgAQ/wwBCBComd1vOlsLAvVnLD5Gy+Ywox8hnXgEFV0sQrJlVWX/ilO0cDRE0aw/8lwjwBJD/sj7v7zpt5WLil8sPUKtx+ejnqi8nirdXmvWXY33Uzypa1qWBmnJiaFFGJiUHLoWWZBCao+SEBaarL6lkrjVTa+x85dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534910; c=relaxed/simple;
	bh=nYnkUBKlCO1ZsKsU8IiLcojmzfxqh0b8bqY2dZJTF2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpKlY7MgoVZMWsLBeKnKaBV5oDI1zRc6iwSp9zJsfK1sPA/NOEyx0fJeOsAc808EZIdt0HFhiV/Y7zHIYtFjG+Cm4PRfoMbPaQuzZQgfUowmAuf3GAVcU4O4cFwWe6jyVm2T72CGmfJPU4GGsSwBptFUN0OV+19di4GwlqI6ScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h9dFXPFL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FldZLQO1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h9dFXPFL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FldZLQO1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U7527M830410
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FbvVIRjkkPDefVw965IgjzaBls9RN7Eu0fc
	UezyRI88=; b=h9dFXPFLptdmCMoBtZcaWAAq4clx+lBRiIVQIYSxZPw8PnruiTk
	j3i/uj8ZcgmWIe14TIZphtfJPpmpBwik2lS8Be+tS4ChXyOybuYr0FJn2T9I/cQA
	bcKlBYs3zR/DJK1pxStqMF0JsfhrBEq5ZNrkPsWwdtNPWwUA3XYtrYkr7LscLil7
	o4sps2ZxhZAoxpwv+iO69NaejWt+Bw56u1bVVBrkXVhxer60e/i2mRmpmxlmxu3W
	j6Fa+nKUuu663A+OIihvgUUblojZigB8/h94xdhsEAcASMWpOqS8TD880/5km/0n
	Sd5f41SLkdBnawDAGHFPBi0DT9GiSd/senQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv2cq049n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:41:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso610413a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777534907; x=1778139707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbvVIRjkkPDefVw965IgjzaBls9RN7Eu0fcUezyRI88=;
        b=FldZLQO1n+a0ej7QvrUWyUowQeNB+Cw6uovuccs97WYaFHsBSQ6vaLPoy8Bgm5SmZF
         nvM4790CU+eA1cryTNbbpAg1tukT/t9Lh3KYPoyQWfYXckTggWmgPah3mLDl0e1EVx9f
         TvjYgL6mBvFtsfW6ZE03B9uiem9CdUuKPix04IyQaHTIm1M+ZMXNLaHC6fDJLJFAWN5N
         RBKR05Uw9NkX2GVoqsP4iN4yei7/94oEut4zaYGr6+XRy0cx0UecmkWAOPioVeTUTTd5
         CmrhGCSMSMquVQgx/LSetVoxbwMVw+vk6eUI63i1XTY1BCk8dLzkEyqtCcHkV7NImoPC
         xBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534907; x=1778139707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbvVIRjkkPDefVw965IgjzaBls9RN7Eu0fcUezyRI88=;
        b=MpehK+vuSEroJ9yR98OwLNp7j5mmW4qxvOg+J47YiL6qzAUippZAhT6eC42jSrR/aQ
         OcQMt/oB+DkTQl0SyIuwgZ8OdmruOp4wXGczJFkPVPV0qru1qwn3swAi6B+QIuzyNWYl
         InxWuDhJMSGgncMY7JQey8ktMFuXhH7JTo78vkyc8zy0QaiFT0Mm5C/LhaEn5JtRCIH4
         m4HVNmQ7emfUOKllbHM0l4jrftQoXWxqH5ic1iPQUsey/cY6pqBstIDzGKTbvbvENMEo
         QV3zPL9y+J83LH80n8NcFOozasrdG3jGNmq4DbzN4bhBx2zOK552/vrSmrrd0fyNzCZx
         RI3g==
X-Gm-Message-State: AOJu0Ywp6g+rDounUGkRc9C468kcwUZaAT1nLpvjBnf7CKPhSKSSJhHD
	YXgmwuHQAzBNM6743Py0RCQXZWEaCOKGoRDStzvdXL9yRAbiIpKLIaj/rz/a5QxAURrnF6oS3my
	6fwiPzEk1RRkbrRx8PPUPnGMz81sToD9erYNrGkUmBIX8QpO3HbEE3qiV9xYxvBhs1KUNCtXdcq
	qIiF4=
X-Gm-Gg: AeBDieuDG+sQ7qKApn91Mdxx2mYORYspXLr64UJtXyKnLaD3venE/dihlw4QsRpUHXx
	kJLfAEDFckvynJjPijzFzFdE9fMJmhxPZaAjl9sxPVrb+0h9zz41ey0wvmzxK58aKR3ld1bUd3A
	09FLLTAnMrYM+aU2cMNjQ0HWiKqC+Rhzblj0d3S7CoYKWi1+r4GusWXmWSU495TO859NLZuQ6UH
	LmPDIIFUWIrIWOOIKiPlYm0khDhTdC+VnjnB/vc2aSAj/ezQpbsH9o0SzWgiYSLOPDdLcWSOBuh
	GSE9u5pVUFavC8a+/IYf0tiaB0CgM2RslypYSJEb7DkLFZ8XoZt0S6fga+J+ufe2s/UqvYZp0hs
	PHsu0NjM76JPdXfqV3q2Y4DCV460eZbkfCHcEobzEOTURV9ucWq9Xdg==
X-Received: by 2002:a17:90b:380b:b0:35e:b017:da6a with SMTP id 98e67ed59e1d1-364c2dd0b70mr1782808a91.0.1777534906750;
        Thu, 30 Apr 2026 00:41:46 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:35e:b017:da6a with SMTP id 98e67ed59e1d1-364c2dd0b70mr1782784a91.0.1777534906294;
        Thu, 30 Apr 2026 00:41:46 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf54419sm1881432a91.8.2026.04.30.00.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:41:45 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v7 0/3] Add RAS Packet format and Notification support
Date: Thu, 30 Apr 2026 13:11:39 +0530
Message-Id: <20260430074142.3599484-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W_kR3UiH82MM1ydUJdrcyp5oh4Yyr6cX
X-Authority-Analysis: v=2.4 cv=aYRRWxot c=1 sm=1 tr=0 ts=69f307bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lQmlWkfr8KketHAhfwwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA3MyBTYWx0ZWRfX8M03NQZqf11v
 9xqFzt36EOi8Baw1kwpYDdDcDkr8RFuTaUdHIwEphuYMmUzEJaVzL59n8yo6ftGhDnga44qAQ7w
 xqL2glWAqgARyVy36PV7zdFdbjPDXsE9MWZXAGXwilCCw+1SlCIleu5Z6cMMMFzOSYUoJb/hMia
 sTefpknTlv1wVlilYvNJ6TkwRvaVpjefj17MfI7bbYHnQecgsldiT58LVZXWP1wHIXLsnbs4yMP
 9B+IpWwVt0836nF9kT8blQ/kLYET6+lJa8GXvql730hDrvvJwrMVv64jVnOy/xB3VqOhrWpMHxM
 wDhY/JpQMphcmaFHAgBnQoDkBSE6wfzuCrJaPqSIinvtHqX4nSKfTfuj3hnABPi6G4s6YMlIuIP
 JxX4uL8/PbUWH5cLuniJtNZf8N9Ry0VLhnRMDS+S1SfUlfcl/4TxLYSKFWcDyMbe28txzYemyO9
 VBpxACKJU5svOMAN9Nw==
X-Proofpoint-ORIG-GUID: W_kR3UiH82MM1ydUJdrcyp5oh4Yyr6cX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300073

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Changes in v7:
src/shared:
 Replace pointer operations to util_iov operations
 Club ranging counter and config id into one field
 Add helper functions for ranging counter and config id

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
 src/shared/rap.c           | 1258 +++++++++++++++++++++++++++++++++++-
 src/shared/rap.h           |    4 +-
 unit/test-rap.c            |  325 +++++++++-
 4 files changed, 1584 insertions(+), 28 deletions(-)

-- 
2.34.1

