Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A3224F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776313228; cv=none; b=k0XDTT8caq6PRTXx7X+SUN6eVdJhyipRyoG3uzv4ZTmdE1g9MmCIAtjxM/7MRMr8XvOF/lQUSLxkiR1s8UBniuO1TZLsxo13PZM1M/Tfssecz+L2WcykvIiwInuloqqrnsoYsoySb9z24kh3OYXI7fC9D3A9hyhv8RnvTDP/k3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776313228; c=relaxed/simple;
	bh=0NYvbdKXRQ9QKZJ18+5/cC3zZkM7Y5hYKxzRXXpRj34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pf232PD48p+PAjK7CIaRGFZjnkczCG+Rh7Wsb7we1uyHMVNTHAMYImV3yAg1FlnOo+uLg1HJlNMqQ68SgorhgCmWp6gIcWYRK5oif0NyocOdnnIhmvdWVqHF/tDEkG25DJB9UmUI0Bi6G6xW4KSMG4wAt4wCkDfBQWEW+AOGhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B36LygPG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cJV6l+3k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B36LygPG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cJV6l+3k"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G1R5AE862166
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EP9IvPTc6GvojewcnOBcSg/F14KmvT9cgBp
	Fy5dG0p0=; b=B36LygPGAZ9CCbN5e1+OkTx0oE2AzMp02fM3k63r++sgYtRcSxs
	GXtoXBw7KLZzM/4UJ7TZyQSdUMelTVrukUjvcMpM8zz9FtZ4eTrDhG4hNKhvdlOU
	hq1glF+7BeqQvplwyOD2Xew5H05rDEw5gVo9FtmFhbnQIfK+cKFhybk+mVJuU+XJ
	8RzTf4byZ7lSGqhWIphl/qUpiotHhzftPqkffLF47DWKEBwXS9e3CGnpx8/jZMeF
	jU9W22DEHR+82PBHB2rFskDxoBvh8OvJ6t7VF72ILrRVNhw/kL22/7ocMiNxqM8k
	QN8xefiqT4PQcfI8/s5koysfaz5h+IzwJxg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd0ea6qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2eba42b8dso40322885ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776313224; x=1776918024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EP9IvPTc6GvojewcnOBcSg/F14KmvT9cgBpFy5dG0p0=;
        b=cJV6l+3kl6VHR5ELTI5XYNRW26mqSHho0mhXSjbStSPGqFdjOtMfp96SCV1LEghFF+
         DzcgCxlJ3chVDgdymBP4dICSJvY9/x6220U5xcvtuVOsoQ4mqfT0mWTFGsMeGNcYv4Tn
         /K/YnWbV4XZoEMC7OhQ5/uYTXMwUx+pFZTuIOkVuCOMiKD5hDwTeTME8zTXXbqQRSM+p
         7acqETZjHnZGEnBtDtZy2l5O+64Q8eZctG8/YAnOlyIcN3ZeUZ4iDAbwnRhZUc0Vd0Mq
         Zibi/R/07MdvWMS2/7X2dILaK4kM5bfpGhtHbZkhAKDy7VvRHwlmEhiBpJzPy2fHCfa1
         dMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776313224; x=1776918024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP9IvPTc6GvojewcnOBcSg/F14KmvT9cgBpFy5dG0p0=;
        b=pIUDLQ+uWWvgBb/QVHRXr6/1Fz4HGHnZgcc27ruZT3ZeR5txwUWWilURSxGlbIJkm8
         jNU7uOgu07pm5j1Ep+mn7ZuwltHsWaSUBfYLpOWykgLeTeFcbuMmg/noBh9TLhLOCpiL
         0X1q/oaKQgIZ40d2K8VV1M5h3h8b+Zxc8xn5Xc4DPDwHuvAkZxlk9dr7BccX7cLL7EGN
         QcHCROb4v80+S1XpY4kXRFFAbt8FXmlOGGOfZHqmWZh9blnERZ6zHXqJ30spSpOb+J3B
         OLkwxB4+mv3cMOZAAl+2N6e8EV0pQihAMo391qNomMG1tl5Ef3OclkzMGJ28IBwcuYCH
         /fDQ==
X-Gm-Message-State: AOJu0YzmW4YD4i+rEepYTn/+BzzEFuk9bM/I/TiWlVEem0laSD7Tpe39
	oyPr+Dotoz1qtpMNTR6+ggVSrJLHHBpV15puY9Z56qmUN9AWEk8cHTq4pS5wmunh8WQBXjsS7t0
	fATK6lZKKpP0+f3vcLtvUBSHMpJfMUohHCFahmznKQBIXYgz9jgLslLF0FWE9zuUODOcabW7EDu
	4lNZA=
X-Gm-Gg: AeBDievkSyIUjW9nggvEO1gkQfbqED8qmtmdv+nbAX9DF2/4Xe2LysBWa7YrCYxOaFP
	Jjsbe4d2B7SbLyvXFFKQ/zr8tl5G6pf5OY6VE1ICNZAskXf/JbK7Eq98rTJ6kMB7VmL+2LJU8yl
	CSGUrPvSuc0XhIWEpZlmorj08xuXLVALSpcrAglLM9F8ajVMxlG3Prmx4R7HOGpg1tEMTtHy9lO
	HFx814WuuuY8GF0Vpn485RE7fQ9RQMu+U3FSUnitCbzaRdkXXLES5YE4jsl/761Awyy0dpX98IA
	WSslFsBfRqsN7WZ7wQFKKG2xrv+glooG0ujXKa+aCh6HKjGfwxBHHHy5/gZP79qfvy4/sx1TuSr
	1+XZLSoqs2bvoxfeVFQM4wxb0mBGlNQsyVtu6GJjvzv+dl3To110=
X-Received: by 2002:a17:903:2287:b0:2b4:6130:f65e with SMTP id d9443c01a7336-2b46131082dmr135704505ad.43.1776313224186;
        Wed, 15 Apr 2026 21:20:24 -0700 (PDT)
X-Received: by 2002:a17:903:2287:b0:2b4:6130:f65e with SMTP id d9443c01a7336-2b46131082dmr135704245ad.43.1776313223651;
        Wed, 15 Apr 2026 21:20:23 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782abd6csm37208465ad.63.2026.04.15.21.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 21:20:23 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v9 0/3] Add initial Channel Sounding support
Date: Thu, 16 Apr 2026 09:50:09 +0530
Message-Id: <20260416042012.1204688-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: N0-VliDs0zP3KPOifgUP9cYRcESrBZ0X
X-Proofpoint-ORIG-GUID: N0-VliDs0zP3KPOifgUP9cYRcESrBZ0X
X-Authority-Analysis: v=2.4 cv=GP441ONK c=1 sm=1 tr=0 ts=69e06389 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QpjNiSjNCGZofIy3_3AA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAzNyBTYWx0ZWRfX3OeQTaLySmuT
 /d2uFDLocWyYQdRjpVWaopQ3KkXf0plpgrRiKTEGv+E9aLC28NM4e68ITQvRa7q5tBU79E/+SGp
 yQS7YO+XmksO85p6GhK+dQMbVBQScukP6IbNDrIgEziTkOj4QMQMSbna8uNxlfjoyeyFGneixA7
 iwuF441i5Kw0MlirRy7u43SY8cl3vZyDB4Sg89x+SzKrUOZFQ/1z7Fr1LFwpVYYuzBG0J9cDNfD
 +6qFYAZlvo6hcSRR0Dp8Y72jZjyQKJhBfKq3OpD9fQd5k4WGbzAmiNf7ZVe0oD4hZ4LbQjjylhy
 X6YSQekdpgyTmxKByy0/18Q+wxlhdpH0lxeRh1U9bQFB6p9zSIuKkoO420N2f6okW2ZIgW0nvCk
 GfkoR48BmCY8ZMy4Re/t4GFTetIRS0AU6mXg4vMkYxB2NXwdneITugF+WcwZEoLdyP4Dc9Wm2aC
 2oO84KuTQTk2wy8Ddfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160037

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

Changes in v9:
- src/shared/hci.c: Remove unused functions bt_hci_get_index
and bt_hci_get_fd
- profiles/ranging/rap_hci.c: Remove unused function
cs_is_procedure_active

Changes in v8:
- profiles/ranging/rap_hci.c: Add static for cs_state_machine_init,
cs_set_state, cs_get_current_state,
cs_is_procedure_active, rap_send_hci_def_settings_command

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

- profiles/ranging/rap_hci.c: Remove unnecessary fallback ioctl
debug code from resolve_handle_to_rap
- Add HCI_EVT macro to simplify subevent table entries,
- Add SIGN_EXTEND_TO_16 macro for bit manipulation,
refactored parse_i_q_sample to use util_iov_pull_le24 and sign-extend macro


Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw  interface support
  main.conf: Add Channel Sounding config parsing  support
  profiles: ranging: Add HCI LE Event Handling in  Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   52 ++
 profiles/ranging/rap_hci.c | 1263 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  132 +++-
 src/main.conf              |   24 +
 src/shared/hci.c           |   62 +-
 src/shared/hci.h           |   12 +
 src/shared/rap.c           |   50 +-
 src/shared/rap.h           |  176 +++++
 11 files changed, 1761 insertions(+), 22 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

