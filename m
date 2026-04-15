Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A630DECB
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252321; cv=none; b=IOEheGqrCbpI7Lea7V9bA+aPTN6Jzb4z5Pu0p0EQBQsIzRFk4r7+obm0giH3K8eexlQ5TorUJkRmkxzOUqyuLDIbkASrO1zihpMERdAc+Z+tF3xEdhTK3vHtQaucsm2pVoliA8cQ1u3/PC2H+Yyd5dQ2JWeP2FdnYaqLe1isv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252321; c=relaxed/simple;
	bh=dMbKy9AlAnQ3CxTj2Nfip5FdW20ZnZ28/n1qRP6XXhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WJOMb/KKhnNsg0h6sMeiskrJIr176dvf0l5t+fqHUlFa7uGkBUEirMXb4nW5MCQMkaOunj7l7ys7FEHWY1shJsqDH7GPtIummjBBct5Ht3pI95tYkkyAtqLtxztKxCu99vrRp8Fc9+gMiP7m1YgvI+x/k4MPm7+YB9vj4nzWmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gvhtuzHW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XKAVy0xM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gvhtuzHW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XKAVy0xM"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F8kaPZ3936626
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=A+D/aWwNu1UlsU2G829Z02H4H24mz/Xc2J+
	DEzcepH0=; b=gvhtuzHWgysnfP1ryxJRcc8yUL82zzyiB3AnqEBdRmXF/DN6cyC
	uYVzPjEW+p9W8Ba3hzno1LNwYt+S7KOaS7+uenUU0M/WPBbRYMprWrkSpVh/mmO7
	otgq7Art4G769xaYBX0dUn3ppoRyU9LpN9DRdGVjPbtEVMv25FS5InUy8TGDiGzz
	i2miMwWvRAdOpW41eoHTn5ollUIBwbDZ/4B6s7W139w2QqfIjQHzzKrcZUteD6xq
	3NJOb3pMkVUUgWdukpCecS3oxDBo7QUuk8qYZsVyMnOXk6AWgXBDKRuuu3+wtdn2
	A4He4VW+ZZ7hOqKp0oskgccAbx7y0m6NPgg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrbf3hxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82d40278103so4384011b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776252318; x=1776857118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+D/aWwNu1UlsU2G829Z02H4H24mz/Xc2J+DEzcepH0=;
        b=XKAVy0xMIBT+o7azmKCY9qsuVBQq9ZQ5X6TabeEgQEPUYKF4L/QjHbS3enKChtUBgM
         vt9xCUP5hbjn5ocbSOUxJ4VRmBI+YS1P291FL74xUFOXUTFGUYWRDFuHOsgKWfcLsK47
         PGvObp3ebOGRVOlTX/Z6VfbvLmlyN2NDHZJObbLK++2p1X117sKjm+1zUfkgFMqzX1rE
         9mKypPwouUaIpHPAGYHNJlUc5i+zXNaQw12bM6A7MCn+om7AzQ1PbXIFlTmYy3E3o2CQ
         3/EiIRtAkL86smscVz++VrG8sTSQzWr8QPHCCzjmBKwu0AA3pPc0IZve3J+VoEEvrL7n
         sPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252318; x=1776857118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+D/aWwNu1UlsU2G829Z02H4H24mz/Xc2J+DEzcepH0=;
        b=AggQ2JERUeIF+HitRLWcQ4KEUTc9L4r3AfnT8EXATqjHfUp9zieiu9/paCQiqwxnmw
         0zPvdKBj58kpfVzyM9XvUaoW7blYeK2IfKmS8C16QxjBI0KXf012DgBOEg6+8XNdlG77
         4nRmSTjYkmMnL3ijZiFKNaGhL+w1XN5lGliv8BSvFmJK5QYxzZmoo7z+os3z4jIxtX8c
         jY4Gu/2NasC+Kvz30EIGAbMst9q3aeu3POWkn7xkiYpUVRGry2E55hprDcxpM+ObQ2Z2
         nLfT3y8J6Tej5bDMGPFPrGj/2W576EQ59J151E+6kttup4ChAzzifgHGCJNcShqALKtI
         VoRA==
X-Gm-Message-State: AOJu0YxAw1utedcIjkmHKg5kvvZwEJi+cp5E2pBPBdARXkC0m049rBdj
	76NT9Zlh+hXfvqhvJKjtQLop0s1glkw6VTD4E4qF6EFla204ygoQs8s3pRGveMtpDF34ChZx5pS
	GY8dbEGQgC1EHQozR+DXq6Rl56dn1+SC5K186kB7fbzG4NdobGkxPCTuuVjQXZ2FPxHae4x0K64
	YgrUw=
X-Gm-Gg: AeBDietlFw3HUN4Tnprp9dsTHWFhfbIt45RKkJmjpGxw2qoDwQ3dJ2ixV24LVssSgsc
	bkF01CkvtnjhpTi9Wuz2QP74QmzvyOs0uS+AegwcN9H5wNJXvK2V0L3oP3+2xRSGJ52eqjZEZGg
	Wc7kkyrlow+4DMgwLuzip/ESuzily8rU341VT2s+FnoBZsRd83zkSTgd17xRBKZLtQSnTpOgsju
	Za4+JMFxw4wSbwWTFGXUw8HujRa0KkiUausRm+RSpjQxSpIo+1rUCXwHkBq1Ek/Y2VcelBj+A4j
	ia+5k06sosBKn9dSMNplQoem39+m9J40EPmdIbX71YhAyUJBsegd5Gr2c3EYYTgzF/XJ58swXkr
	cR6VO2cRU1iBfMBOJytuBh2aeHmi6hseDFx8IbD2V1GPAF+qZak0=
X-Received: by 2002:a05:6a00:1946:b0:82c:e1a0:3453 with SMTP id d2e1a72fcca58-82f0c3568e4mr21140227b3a.26.1776252318133;
        Wed, 15 Apr 2026 04:25:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:1946:b0:82c:e1a0:3453 with SMTP id d2e1a72fcca58-82f0c3568e4mr21140190b3a.26.1776252317527;
        Wed, 15 Apr 2026 04:25:17 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f69ef0b79sm1492172b3a.36.2026.04.15.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:25:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v7 0/3] Add initial Channel Sounding support -
Date: Wed, 15 Apr 2026 16:55:07 +0530
Message-Id: <20260415112510.195491-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V-P7spPAtaYesTaosSQioH_RQ88wCN_5
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=69df759f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=yE--P-Ky-lm8XdBANnsA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: V-P7spPAtaYesTaosSQioH_RQ88wCN_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNSBTYWx0ZWRfX5Kpd/HuoPlYN
 7f1v6IL+0877RF6ACzcKaDpvYHESYw+56H9qCXON+empLeqBC0CQKVV1ccfTP5DSgwIkVWX01Mk
 ZBfR2i9SCgETexhDd762H/GmagKFtaGN78gVllxp43CTscgX9B8dPpiOO7xfqpIk+UzezrPHWKE
 xw6xPj1RnGatYfil/p6BegY7nGIdM2GYmbRT7dkuxB5OP5ez1YkNSkC1KJAR5xQ6AYlWPHPMkaB
 tscCBNWG0Q8iN8Ou312L7HPI2Fk7RQCUnjgqAkVaz4yVuz1hNjqgaLNhAq1PPln+fl5C6uINDr/
 u5dLo8l+9WUJgkczMby/m33r+0BwDrguitDZbGvNIrME9WMDyWjwXfmcLCQy+qlk1v7sb2mH5z6
 oO1RmSvI5X+Yb/onnAWIBBNIoshN+7RN1ljo3H315gVVUf0ooXY0fO5EjNsVtIBjx0Ye9HFx/Zc
 dmd173YJly4oYhDKXDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150105

This patch series introduces initial support for Bluetooth Channel
Sounding (CS) using the raw HCI interface.
This series lays the groundwork for CS support by adding commonly required
protocol definitions, configuration parsing, and event handling for
the reflector role.

The changes include:

  1) Introduction of raw HCI support structures and callbacks for Channel
     Sounding procedures and events. This provides the foundational data
     definitions and HCI subevent handling needed by higher-level profiles

  2) Addition of Channel Sounding configuration parsing from the BlueZ
     configuration file.This patch also updates the systemd
     service capability bounding set to include CAP_NET_RAW, which is
     required for bluetoothd to receive and process LE Channel Sounding
     events when running under a constrained systemd environment

  3) Implementation of HCI LE Channel Sounding event handling in the
     Ranging profile for the reflector role.
     This includes opening a raw HCI channel,
     parsing relevant CS LE events, routing them to the RAP profile

Patch overview:
 1/3 shared: rap: introduce Channel Sounding HCI raw interface support
 2/3 main.conf: add Channel Sounding config parsing support
 3/3 profiles: ranging: add HCI LE Channel Sounding event handling

Changes in v7:
- src/main.c: Add second const to bcs_options array,
updated group_table and check_options to use const char * const *
- Move endptr to start of the function parse_cs_role

- profiles/ranging/rap.c: Move hci_index declaration to
start of function for C90 compliance
-Replace inefficient loop (0x0001-0x0EFF)
with single bt_hci_get_conn_handle call in rap_accept

- src/shared/rap.h: Add forward declarations for
struct gatt_db and struct bt_gatt_client

- src/shared/hci.h: Add bt_hci_get_conn_handle, bt_hci_get_fd,
bt_hci_get_index declarations
-Remove bt_hci_get_conn_info declaration

- src/shared/hci.c: Implement bt_hci_get_conn_handle to find handle
by bdaddr using HCIGETCONNLIST,
Add helper functions bt_hci_get_fd and bt_hci_get_index
-Remove bt_hci_get_conn_info implementation

- profiles/ranging/rap_hci.: Remove unnecessary fallback ioctl
debug code from resolve_handle_to_rap
- Add HCI_EVT macro to simplify subevent table entries,
Add SIGN_EXTEND_TO_16 macro for bit manipulation,
refactored parse_i_q_sample to use util_iov_pull_le24 and sign-extend macro

Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw  interface support
  main.conf: Add Channel Sounding config parsing  support
  profiles: ranging: Add HCI LE Event Handling in Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   52 ++
 profiles/ranging/rap_hci.c | 1267 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  132 +++-
 src/main.conf              |   24 +
 src/shared/hci.c           |   89 ++-
 src/shared/hci.h           |   15 +
 src/shared/rap.c           |   50 +-
 src/shared/rap.h           |  176 +++++
 11 files changed, 1795 insertions(+), 22 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

