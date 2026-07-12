Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F62370D5E
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858674; cv=none; b=sKISliGRK7ePqev9Juuu8wm3ZDix0LzYoC8Lcd7UC0xp5Qr5Mt5kZl1ccmh+VOVn37/575Xl9BnE3tgvZdqNAk8o6oMxa0uyd6n2dm8SvqLWeuqRk7iPEMweV9E1sedKHQsvJhFQbNEdpenyDGXvM5cCN2WnQxn40XCYiCibNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858674; c=relaxed/simple;
	bh=RFpQ8jidSM7fVWD5XHbZAIvOo3lOSCwrv7N8jR2wxU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KT6tVdVC9aPlrVtxqIJxsjunAwpwG6D98y9i9p4Lk7mxinaghTtV3JLYscrugzJqnXlt0vEi26i3Jq1iJgnUaJfQtGdJu7U1xadjG4j5LAzil1fpVZxFijLpnd6IjR32Nh8hncqKLwCaD5i1smULP7OvSj45mif3ZnKyBAjzmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ReEhf7NW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+ZvzryF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ReEhf7NW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+ZvzryF"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CAcnut2388418
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tCqMdVqc547oPSWrDGKuCcGmXNdKSwXE2FZ
	r/A4sC8I=; b=ReEhf7NWIOUhj4TpUZNEoyg0SOqQn+XCSy7RX61Gn1s3zypBG9d
	8QlLBK70uhnTu4dGx9a80GJBHuOZaLbE9nHJ/IhZv2OQNtVHqI14GJGd81Ao6HwE
	fucbZNOd1U1qlu7fvzLvpcnqsC5WNpsP2tZMOKj9iE1FeKkd52NdUOtd8VlPctMY
	b7g6E4Upc8uSDzyODX1b4MFpcjbJSnBpo3l7ZZD/TTBJHEo3ZruHHnVJGWt6I7q9
	Mpb8/bmoSmrQpCvlTiTWyL3++d78NDXvDgJeZUbH0zKL6pezeoAa9JbFs3zyXwNT
	RqCGuVW3XLvIUcLxp+lf4S7r8Uo1EHZ2sZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgjs11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:17:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so44637815ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783858671; x=1784463471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCqMdVqc547oPSWrDGKuCcGmXNdKSwXE2FZr/A4sC8I=;
        b=Y+ZvzryFNSELYNb66vdlwKr7sQn+Lm7EGdOQleb93dYN7821rQmPE66fvdxKztjwXa
         MqQ+TdcGjUqKYGfX2wORC9hnMNJknITG72H7cmGUji9LXi/j9iMYQlpEHtIOt42lOOL6
         UT5iELV5PWHzs+ajlBNiwOBXWZFsX34Ect4h4IfGKqQPiKVHjPR153arGyQu/GHdpWDg
         DL0Rv1is0LJJYYtGU0KpD3PCV2gB1VDKuxHzpXnWU1DQ3hpkRYG7Vg9fFgFLYn01z4rW
         OSFFymCL5eCAW8xZajtyNc+vMs7fZ0Tsofuxp+11pc93UwYCDRobbw+7m1dSN7XQdB9T
         mPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783858671; x=1784463471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCqMdVqc547oPSWrDGKuCcGmXNdKSwXE2FZr/A4sC8I=;
        b=PgNjnJsl3RqzN9ELMFDF513Mi7HDSO/cyliqs0HbAJXikne4m4R9gPBQWYKxhQ6rUf
         KxgJd3h4GMx4rLKhCZ3X94V9Di4hp/e/tIrFtdopi4qMZ7MaK6uzu8z0mopMLgt31Sqc
         SmkEz2xi9+gMruBxFXzG9P69p3qelOkjR/1IUbwxYMVzdmeYxHenHw1lAo3ujpXhLkSy
         j1ilIhDglOtyrXY+PTey91ffZuGBekVnfDiE5LUqhZRLyzFkDUMKlQkD0llE2UNlYSlL
         3mS8YqRcIP043UBJQLtFAy50vEaxezkAukqudFn1l0O2/O5kW169Es57uSgx7BEXKfH2
         Hc5g==
X-Gm-Message-State: AOJu0YyXOvcINYNqKTp66hB05ZOmPVHl7ZTO0nTmzqrhW7qhC6kkvKz0
	YcIxrl3A96LTH3LIOajyFjjGAYlNsrwHJGZrHKcz0Fmep47ldqJHv3rv+TsYk3BkzAKa5vpKVFi
	228upyGWAN12UDke326l1mAJdq9R99295iMzNTiADoWZ2iQHINPotwjwlVedt1SQhnYn0k0ePn9
	l2AfM=
X-Gm-Gg: AfdE7ckQHlSdxOas5UtZWqkydW2Td23KXzH6SOszrwQbHX4Hqso/ktalSiKv1Zn2DSf
	Pc/elaC4jbs/zeHFptxX3CdwDi/gzECAwcBuTgQmqdCLTDN7m6f0/KNAZa+FN+YRPALlLgVjN/M
	fqqgj9x+yGToyM3zCP7MZPi1kWFxSXB3kpqUJDClseo1dUgqmc1csZ+SJcCY0s9jhNnr3nWbbIy
	/Qjh/wZ+JcWJr/Hk7x39L5sspc0cGk+acJjgOEoM7nALfm3Rm4lRQh4jG+0L6x+gJ/mls0m1/jA
	70U+pf0zBoPm9AcutOfvYVei3niH7Pnjbkjbb2izInxbC+bhBxY39QniUs+3CLuAMITZiibGkrC
	QLH4LuvYs5yeQMdMwAqe/sNeWQPdPIZVxxEJJKxJJ
X-Received: by 2002:a05:6a21:9d48:b0:3c1:85d:fa2f with SMTP id adf61e73a8af0-3c1108c2d4fmr5745736637.36.1783858671006;
        Sun, 12 Jul 2026 05:17:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:9d48:b0:3c1:85d:fa2f with SMTP id adf61e73a8af0-3c1108c2d4fmr5745715637.36.1783858670583;
        Sun, 12 Jul 2026 05:17:50 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm29061040c88.1.2026.07.12.05.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:17:50 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 0/4] Add Channel Sounding Dbus support and
Date: Sun, 12 Jul 2026 17:47:39 +0530
Message-Id: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfX5cayQ54GhEVd
 sxMIwqX6N7+uT6iYMcy1VeXA1b0k49tQxWcS08HqB4PL5MOnnwSWbsvVUNw+F0oS7HOv03P8cet
 H6Vow8mBUP4n03fhOBDwcIZGg/ic+5Q=
X-Proofpoint-ORIG-GUID: BO3uTBiKhoHu8rLH1ve1KVF_JzgVkid9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfX0cWTfBmmEEHt
 6LW6QiP12X2YLRZ/chYwI3nmd5V6X0woRMZq0SG5htqFYxv5PXd8wvrRN6pIc+8SKh12ztqrh+b
 ej6AOHX4oQaXd46BRT8Ud1c4lN54jyNjx18Ev4Xki5BY/Vmrq9vx2Ajs0cZXkjtLqyYCTHUngv4
 qPT+izs1hC0k6JO61NwNPyx1XTYSOF+rxkK8S+vuDIFHjrCTPdD3ezEz6xHQ5LKLp8WHhvlsvFO
 c7wWU7X9N+cAyvIwzaDGTEEx3nfnFAA34V//GQgm4P0nibj5PR7VtFUwSHZ/Z5cB7UGKGcOzVEW
 Y65Xu9niFGLULItk/IpA3zh9V7+ZpihYjC+NiCJGbSMGbcedU/NaNniOXDwY7kQ7MhmbtvpV2yW
 OPgmPGEeTCjHcOUwzltGC9HR4wRAUaXFgInaTwEEh0G8ZyQg6I1e6SeIDGLW4nxz7rUd0xWscGH
 4EaGdpsBOTXFyYHKZqg==
X-Proofpoint-GUID: BO3uTBiKhoHu8rLH1ve1KVF_JzgVkid9
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a5385f0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=baiOLSkq7RQfvYsvGPgA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120129

This series adds user-facing control and configuration support for
Bluetooth LE Channel Sounding (CS) through a new DBus interface and
bluetoothctl integration.

The RAP profile is extended to expose an
org.bluez.ChannelSounding1 interface, allowing external applications
to configure default Channel Sounding settings and start or stop
measurement procedures. CS configuration, frequency, and default
settings are moved from hardcoded values into shared parameter
structures and accessor APIs, enabling runtime configuration from the
DBus layer.

To make the new functionality accessible from the command line,
bluetoothctl adds a dedicated "cs" submenu for configuring parameters,
starting and stopping measurements, and monitoring active sessions.

The series also ensures the Channel Sounding interface is available on
reflector devices by registering relevant GATT profiles even when GATT
client discovery is skipped

Changes in v3:
- Add an explicit case CS_TARGET_SETTINGS to satisfy the condition

Changes in v2:
- Add patches 3-4 to support channel sounding dbus implementation


Naga Bhavani Akella (4):
  rap: Add Channel Sounding parameter types and APIs
  src: Register GATT profiles for Channel Sounding reflector
  profiles: Add D-Bus Channel Sounding control APIs
  client: Add Channel Sounding shell submenu

 Makefile.am                |    2 +-
 Makefile.tools             |    3 +-
 client/cs.c                | 1157 ++++++++++++++++++++++++++++++++++++
 client/cs.h                |   18 +
 client/main.c              |   27 +-
 profiles/ranging/rap.c     |  350 ++++++++++-
 profiles/ranging/rap_hci.c |  531 +++++++++++------
 src/device.c               |   28 +-
 src/shared/cs-types.h      |   50 ++
 src/shared/rap.h           |   27 +-
 10 files changed, 2003 insertions(+), 190 deletions(-)
 create mode 100644 client/cs.c
 create mode 100644 client/cs.h
 create mode 100644 src/shared/cs-types.h

-- 
