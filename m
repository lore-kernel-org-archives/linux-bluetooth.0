Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0A4AA003
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789378; cv=none; b=ewxorCQhaMWHfMoN53WPC+/E2qB6bTariBIt8w3FBbD+yFxnENhRHmeb9TdjMsECU8amHMHx8T2Sj0UfTcv+/MdlxU1cCeedpT5MSKI9JwxfYpYeQF4W0h23OWvKY/MThpOvF8h2iPORh+2tNn/jRsvZme7RikLb2b7q6TgPMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789378; c=relaxed/simple;
	bh=+st6aOtkVOwIQB8FznPbrra9xEXHBmWzhoKeTAdIbR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d7sD5Ad9tYob3JNOanxCmTUyr40V0zLe90N9o/z8Z4Y4IGPcWVMAPjP/ONboyNYITIyziOBZtnwOymQzpCep7edXe21DaRw8feCEXGpgdulv2+K0fvto2MwB8dqwYzyaNHFeGgR3fFm09Z6h0Kn7D1ekPv+3vs2aLGUxRZjpVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hOhmm+0w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E/QUWaR+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hOhmm+0w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E/QUWaR+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DdSXU376834
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 13:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1wKDFXThup+vdkQgrHjMfbGNbE4gFAWi4L0
	Em8PIFbU=; b=hOhmm+0wHmd7n5vrNsqFm8F0IYY/0Do/DaMfLgbBccJcn+GN5Ml
	hDsfZyUQpusKt3FqnKzBbNUB6Be/Dp5j5X1NghOA3fBP0Ci4BumTsrOa65pmcbNU
	XELTFHldWdcuYn9ZiLByORK0NM1eOgg7lrkxIMh04dkQ8UadMO6lD6aL9LgdTv1Y
	+HQCJCvVqm+3ZcUsxw60jmlkZhelqSsPFAUTzGzi2kzE16BO0st6gMpyP40DMTOv
	+A+IXMZKL1LKhsE6y9bqT4V05waKanjdPr9AH3Hh52fMo2qFqdaV7vNtsl7d82ta
	92VJ+Mo4lYs0tXuZXTQh5g/NMbaRP9LSdxQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg19ke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 13:56:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc489e7a701so501896a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788789375; x=1789394175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1wKDFXThup+vdkQgrHjMfbGNbE4gFAWi4L0Em8PIFbU=;
        b=E/QUWaR+5C5xFUy+fY3dpIumyBmPlnO2kgPCScb2q2mnAZhy5c6QK6dYs9CTW4x6A4
         4KYSWyBYq732jQOJFdwAiJ88NJRoJXNhYDbtOM3E2McewTLd72WITU3WnppIUhFb76b3
         KF56qI4Z+9hV3+YtPInx+riE88XRq1VhEhy7bhG3u+W1pjRtvpLoRFW+wy1dm5feiCLi
         GiLMQxHvCfJ+HAXwHxTSPD/gJtXOHCWuNdyn2ViKjINDiVcJGdXLrZ/4kwse1UOqjoBN
         svwDze/Vg+CEAKgzjabPZU7H629ZSLWTy90lupzr6waNJuiVputCipZ4M7J9hFGcM2Q1
         tfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789375; x=1789394175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wKDFXThup+vdkQgrHjMfbGNbE4gFAWi4L0Em8PIFbU=;
        b=eXNZ29T1wvZq7yhPwGhR9YWPSVchFD7TWsIYThB0MEbUEcUJ5tAi/WVlhJTfQGv7RR
         Olu1Y+SNxuC1UnyjwnXHAH639mmWi01s2fgT3wy0H85KDxCYd88S781jDA9gKlegGe8j
         UrDsBjS/RtrMsHguCFKDGSIb32IFq014Nvc5KFwhqX6xFfZr/FFSSznXAprQ+vexpfnC
         7GPfRhk6wDd6xj/aIpU2FiZyP59GJAwCR3VklL7N/oaG4NmQv8xoY3GBV9zsVegJheNr
         N4L2Z2SdDlFH5lNvuRUDxhIPOlNmA1BODzVL7O+76nftcckLBJI/doxQZtkVRGqPQZDm
         NJLw==
X-Gm-Message-State: AFuF++mOBTQyUxgTd00mJ/cGBycgzSl2FvWGqedsEhsY3xjL0yAoFmVk
	t1DzPQ1ANSrExiiQUx/LQBEvnQvQGKtd2iJNGz1TYwtGSEw7tOujsXLb3RCcFqg52LYRh3ivXG+
	tkPGIv/QRPVjtoaXHHILkF9aGfCOYNt7J8ob+7ZiE8mqswM6WQ0Ubakb5ZPGNUUTFF0X0WTN2yf
	1VKpA=
X-Gm-Gg: AYBFou3Tib/JdJNz6CGBdQPi6TKXTu7SiGE1KthI3K4bHsvp1KTm6I61u3B/1do1Ruw
	l8F3LS6YC1VeNX7/sMFMfDZnXNCZ0HWdFnOq7uzWeeLUBu5t/LsJDbtk1dKQL4ASgnzo1yVa79b
	ke6m2gKnkH22ZJxtkyGZ10xwj48lrNHOcv25v7Vn8MiOgLUCLC6saQL6+FqQeOl4F6JqkyQVaKE
	T+gYghQEHxDlVUTg8QbLR6Mi9iBM6EGx4GzSdHDeKw40bDgazy1WZN/Klvvb6CYEnCTAw0T1dIE
	JoxRV/MpDWy41eEjNH4PaeZVq9VH6+XRvPwcjS9MjwdNCHNC9ZRDgwEiv8k41dACOK3wYunJgHH
	8poCbXiBjTnfjbukLYBHZqMVr7++Q+w==
X-Received: by 2002:a05:6a21:e0a7:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3da3a03cc31mr34282307637.13.1788789373105;
        Mon, 07 Sep 2026 06:56:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:e0a7:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3da3a03cc31mr34282254637.13.1788789372665;
        Mon, 07 Sep 2026 06:56:12 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm31561116eec.2.2026.09.07.06.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:56:12 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/3] RAS: Add support for on-demand ranging data
Date: Mon,  7 Sep 2026 19:26:03 +0530
Message-Id: <20260907135606.824752-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE1NSBTYWx0ZWRfX88OQpQhZbsJx
 IGcpznClosC9GAZTc5PtTDWawGUkgLwpGnCwE7PAJ6IAJmsym0feF7IWiKG7bQ84EynqNfrLx1a
 gTtFoFYwpKWWxQIP+QeE/O3rpQ2WKxcl1fgPEK+bqkdNXOpMG4uRcwPH5aBXrqhrpZXKbo1hbS6
 PlVLRzoh8gV/RKTu/WS573kl9tLpygGuADbW1EUKZgkULZQ8rfcnZM1qrHN+le/Mz5mxW+V9vbQ
 c8+UwZ7pL+9sLmg/jZzEWrq73D5qWHImkqxD1AMGHVQoyjJFtju/BSsQLlMHzTM6YBiBY5PsEyV
 VuP4faf9//qVDv5qmNGGgE26jpdTzNlvjY/Jhvx655kDSISJmTzbyt33ZQAwE5EGR88iwa3bJ5D
 YsN2pMRvyNU2FUGyDQ9/3uYN1QRxzRRhifFUkOHV+DNuv0igcAsoynlmoio47CFl5Wjdkucdf3M
 QH7DtQp2zFRWfLdXO0w==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9ec27f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=dJP4SoC10iFzG_7YnnYA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: B2n6csKtudMNJ6XV-45XXSPPTX6iydQH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE1NSBTYWx0ZWRfX7YlU8dBX3mL1
 jzpB/gVt12PzvKj6tlzIfJvU6TRjSNxXDCVXolVctfJ6Al1ePr8G6zj3P5WnyTl0xzo1bl8djpQ
 ede0gKjW1DSmqfiPJBRUauxlVZ7rGcw=
X-Proofpoint-GUID: B2n6csKtudMNJ6XV-45XXSPPTX6iydQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070155

This series adds support for on-demand ranging data
delivery in RAS through a new OndemandRanging configuration option.
When enabled, the initiator uses the Get_Ranging_Data/
ACK_Ranging_Data procedure instead of real-time ranging data notifications.

The series adds configuration parsing, enables on-demand data delivery
in the reflector role, handles the associated notifications and
control point procedures in the initiator role
and ensures the initiator honors the configured setting during RAP setup.

Patches:

rap: Add OndemandRanging configuration option
shared: add on demand notification handling
profiles: honor OndemandRanging config for RAS Initiator

Naga Bhavani Akella (3):
  rap: Add OndemandRanging configuration option
  shared: add on demand notification handling
  profiles: honor OndemandRanging config for RAS Initiator

 profiles/ranging/rap.c |   3 +
 src/btd.h              |   1 +
 src/main.c             |   4 +
 src/main.conf          |   8 +
 src/shared/rap.c       | 842 ++++++++++++++++++++++++++++++++++++++---
 src/shared/rap.h       |   6 +
 6 files changed, 801 insertions(+), 63 deletions(-)

-- 

