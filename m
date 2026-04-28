Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A55154425
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343479; cv=none; b=KnvJIzWialhl9t7kSe/ex0V4nSx1fJOryJrV6pzPKOnWa04bHEppr+YZM25XEwfSOVbAAdx1CIu9kBthyVya2slDRIPgIj7ZLLsr77GH672GGs2ZFnDfS6pSa6hEoPfcwM/ax1IvcJ0MA4btm7LoBMSG45m3P93jA8smVT0a0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343479; c=relaxed/simple;
	bh=x7L2/RjvQXC42VCkLZGy9o6CrYZowHsaOI1JDKDHDNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JuWHE4M7O0wZWC58SWU/KtV5rXVxuniaH9Q4KVFeubMlpFSX3wVAw210lVM7P1KCOhU1ymTOAQ/NLtEFq8GLXDe8CC7A2d59ilRLmtrvB4f366X0sxoRAIPFDhSL6U6CiCwQvL18v1pGTEw1x0SniOEDFRjCjHk8XjpwC+akNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=giRzDm2V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZYho059/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="giRzDm2V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZYho059/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RIxemk2006439
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uSMXYjkStNssGTaG5FeUU0yrH2O0RxZiqJ3
	W9lb9eys=; b=giRzDm2VjWy3Wvopp5kzQts0rpSRJ9qqgHfgzh+pbEG/ziFLX26
	Z7Q2VxR+xAqgYKzQu98Fit1NBZg839nP8bbbs2yzHOQnDWFgMCL5eKEMIT8klfhB
	HQzgDdFnKRI/6gp3FBvLp0jtY2+xBQuzTmSazeJt+x5SRqTa8CcziQOMg0XT6/xX
	4sFx7rb498n5x1TEfNX9laTSn4w4vTRvv9ooXe6tfLrDcKBjxZAcyLNMnZqznaz0
	L1Ecb9GbWN4rscHTNWcYv+Jq9DVyQXmZ94jnd92RWAEPmM76bhwrIOvypJjEtvjX
	yMOxmsGUY8+5ModMixKHBAnM42VZDjDzBLA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkjwyy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:31:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b250d3699aso218630105ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777343476; x=1777948276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uSMXYjkStNssGTaG5FeUU0yrH2O0RxZiqJ3W9lb9eys=;
        b=ZYho059/HIAVvLJt92UZ/h/5M1i/0tb919aZKJ/l3b5Sj9KA1Bjb5SfYcgMA72S2PI
         SGnFN1U9DZzR5XOSyn4+QTt7nG6/Rhu+Hd6CZM4Z6LDZmRZp59WBdh5RTMDbH45rwSk2
         Ved58OfBGT5IJDhefVIZIvEJwQUwrFeScKKNlpu2xdhnUc0+g/Z1AR/Isl8L5Cb7BMWD
         WpXnho+GPnlu71Gsrz4xWce+SA1jTbm6VZM1FZD8phxh8F01AKJqAL9YXKFf2UEQ+zhU
         GQLFOD/pM2nElYXona5oU+44eV+06Tv3MJfqNQ5Qoq2VdWUcLbrY/L2RHKK4XpmSqmil
         SpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343476; x=1777948276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSMXYjkStNssGTaG5FeUU0yrH2O0RxZiqJ3W9lb9eys=;
        b=LcH+3ZQLffkUOxy5O+DhLxaxJna0bHtIJ2jvYuNv0HcYlL5MvIsG1ie2qfWIrJmOvq
         V11LoCwd5b3FSGdV+ncf7kVQha079IG2T1xEH/S2xF5kiYGbQWiz5JYMNnhCA6ouWbt1
         7DesFnZqGJgBXudpix7nepYJoExxMWLLC0DAzsWm5sKDj8tlyUs7YbqqaZVWJwIUTBaw
         LUpTlHu/YX4nI3gEG4WwU1i64MN+4poUEjoAt2Y7vrY0w2WGViYU7LdVwyo2fBy6lOb+
         fQlPtAd2ER8ZuSMz91EavEl0FiOUAhchtQVQMzFNUTAGStPMGdn/OzD2hUQLqfFFTYMb
         wtww==
X-Gm-Message-State: AOJu0YzghJw8ErexWAP9shz9aW//tMGWOdMXRhwRxKg8lnOa3eAVOXO6
	GFUHrKDXJcJ7IfBiIKgdyrXb3BdeL+Dlv5RDx276dp+UtF+67BIk8cC5ydsvfJCJecOWW0Th93F
	pgczyDtMcgUX7WfYUWyyiH+zLwAaMrXev7vSeur0wHoZwQQ8u7wbIfmTVXgbg7k/IuRF2tJXXKt
	nENns=
X-Gm-Gg: AeBDiesw2tOKG2/wWkbXJ1GN3hkzzBM/1vPHZFOIyigl1f4cPvLdL9VygqXtxBktaPu
	0ChnvLQ3j7bq9uyz6O2nLltFxVtTCMXjmoLsFbMpUUIL/nTSOq1GdhZaomLLrSSawFZ5QEeQPLQ
	IaB7bjzHZgVwyBEy2IalwkyVGzBZlxYJCE0vEMGpF+YkR+mWBGjnLdYRHWPYIRCa3LZMwj/NZjm
	7ncgZLsDdYGhIBzMku7gK61CkOo6mUO4q25n+pWj0J5Kihre+G24vYwuI/JaYZUlvrvQ22Fznab
	7oQ2MSiIB0c3Jrt4ty1wnlB9tQ8N3e3ysFWZetHgqDUNzYeeU/PHIqluPmiRHfvxj4aXtrNIVPz
	Ieiq3AV9944NPBuj+UvSFEJwVUNSwipETK0r2nR44vm9NFtGoj+E21Q==
X-Received: by 2002:a17:902:6907:b0:2b2:53f5:4627 with SMTP id d9443c01a7336-2b97c3d437cmr8221955ad.4.1777343475867;
        Mon, 27 Apr 2026 19:31:15 -0700 (PDT)
X-Received: by 2002:a17:902:6907:b0:2b2:53f5:4627 with SMTP id d9443c01a7336-2b97c3d437cmr8221745ad.4.1777343475398;
        Mon, 27 Apr 2026 19:31:15 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aa7bbbasm8478305ad.3.2026.04.27.19.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:31:15 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5 0/3] Add RAS Packet format and Notification support
Date: Tue, 28 Apr 2026 08:01:08 +0530
Message-Id: <20260428023111.1640377-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F77k_ObHKPemVh7P5lB_JpFMEElxFm_c
X-Proofpoint-ORIG-GUID: F77k_ObHKPemVh7P5lB_JpFMEElxFm_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyMiBTYWx0ZWRfXw+WeHDNx1qGx
 kbYEGn08V5fDbsId/7i/XL0BXCPASycm+6XhuLUu4YmAEKcViZgxi4le68csowp/Up3UNf8U6wz
 71tChCXTpGa93U0yMCMnxjpiZFaRRlpVzpk02kTz4r5n+oZKLrUV76WJ0AqPbCubo1G0gm52MzB
 Hv9z1jAckF9NjHpURLv+2MPwWB56/o28zEKnZKB9qvVycUF5qd7g+Yi4EKodYTNtPxpZsyU53kx
 B/hSEmHE7Vr+52y43ws+l5EY8GFprZ5z2IczVYF7MikqQp1AggaJgNAjpAYweeS1zmhJxFFeFJF
 j7bdshfOGVPEQiGrLFJacZFIT5UrYHLRY4skPalxOTd0qLPcR09YoimreXKVUFXmdB7koa2bxbr
 rJal6MaRpCe3Nyux8HebTWmUqNSqM2X7fDgxnbCmyG3U5tbM3CHWd6vUaxjbtOXEtBhervw4gHJ
 YoEOvucpuZt1csgTa6Q==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69f01bf5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=uroqZWPkk4z-oJcJK0MA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280022

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

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
 src/shared/rap.c           | 1376 +++++++++++++++++++++++++++++++++++-
 src/shared/rap.h           |    4 +-
 unit/test-rap.c            |  264 ++++++-
 4 files changed, 1640 insertions(+), 29 deletions(-)

-- 
2.34.1

