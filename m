Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776553264D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434177; cv=none; b=Ay5oJr/KrRsJUnQaHzngIODE2Y71oOZT1gZjHGm8Pu+sgUFvOkY0hH1qtSgl/nIG3SRYF8owsjYubhXuu+Y6JurhsPcTm74LCOHE+JW1CGDG+Y1IopEAuoOwgKmdqCItl1Gp7OHJFDCSSNiF2G1xM8UJL8LJpAJ1ofY4I4P7qD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434177; c=relaxed/simple;
	bh=H/QSyMqjRa6gXBy0/KFDZENXfCxDb66sAYrLodpl6KY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SPCwQsLGie6MKkM3GPXYHSI4YSrC7CRT5Fzu+ClvDb3ZfN4fDhaZUQR1/vmznLSPBdxHQ2Qaj1mDhbDNoFCWDPz4A0nDIp5pff45Ba9CsVRPy9K5+wp3YVAblNe+++T6AEG8JNda2mZncj1UUChlGecv9CCBy/Qu7tIIRAdjpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFGOpoVb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=da6tug1l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFGOpoVb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="da6tug1l"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HANNpk1326161
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=B46pdC8738Z8lVr5soEMzfOXQKiJ/sgwXHe
	fjzH6ANY=; b=bFGOpoVb4nrZ24pQq4TeuQg7QaCfphn77zfnlOJDYXMJeDVVTCI
	A4GSGrnvTZTKsHJM2UmoZGtnYdJ/iL4+mnSuI02MVBmdpg9JLLOAxuSBng1O9BXr
	ZEqvs9BXUHMKvXt3TZFTM4Jr4lvGKZyxLXo4Gqu32JRbzkknjqoqq/fRrKf3D8xI
	tyxt/HVXdlrEnSTdcaMF8cDx6ac27UnHBUExVrklLr9ed9PJCh3Uc6qxSv/9M3hf
	1i2XbhceN55+aZejfQ7WEfz1tndtEwtVqKPNAj7p5MEvmzhAd01/cHj3yKFJupZi
	ONQTZk56dD10OVh3wkClEdjAxx480HcNqNQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkdgy203n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76c6280732so922055a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776434175; x=1777038975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B46pdC8738Z8lVr5soEMzfOXQKiJ/sgwXHefjzH6ANY=;
        b=da6tug1l0dZD2xlU94iMp7X68xoIyoQmNkLxsPA28glYconI7d8WHxwiwj/6hcauK5
         ZYvCDod0glBVsN4NAfI41qcXCHjwpB4Tn5Ek/lNkXAJ+phSpIAwf2Pfj38jZv9Npxm1z
         /aCuUK0/yd8xJKpl0GNysK2eZGbgUmXsifumDkDo/nEM2oBTyIEDfBcLvZr02s2leewa
         Cbboc8zHo1gx3z6nYCgrZhAMIuC0i10Ko58rnt9auzAzZOAOw8tT7HsISAwmNSZy92tN
         m+Fcve5DcsZhje3tT7tk94jxBqdgIhIe498OrszAF3fVKMLIHiF+XsQIQb6/FZPOF40D
         KfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434175; x=1777038975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B46pdC8738Z8lVr5soEMzfOXQKiJ/sgwXHefjzH6ANY=;
        b=W52Y/FK7KLmenE5LCbiQyxZ8aR/sPc+4ZLi/pfafVsq67HM2NuN+BpwF0i5rEx4dw5
         /epFXL9DnUcooLjEiRM/0m78jqcgCXtH1rrarFfbprlFFGXYcW6wzfr3vE/qB0oFTUHF
         YnhaCo47IDdPh9imkZxTJdKbkralSvmWPPCkkADMfGC0/ysqMGS+5ZdtJrrN0z13iNNo
         /9nL+RxwsUwY30jpHS1xH9isn2sb0pR7WongSJ9Xi82UyjzNN9iqtmKKdWw7Fym2IPkL
         wJotFrJf0hsvvLo0l2zdhplYq979IgsjzI15DlzQ1D4sbSgAGxr0oz4i931mLCrQu3AG
         e8fA==
X-Gm-Message-State: AOJu0YyHtDPgJtifv3o25FA05MawbVsk5Nj46ryKKW2RFKEv8uthDRkf
	BF+kQwoWo596CJiXacG/NGBWCrCSmwph+3gX5pXIVSyrUhcUu++nAOlZUTH70Lszt9wFn8kze6T
	VXpp+VijB/sJ6vwCMSf3qODINtCuXzMx31FkhE6dXBeSmgXb0mQvv53DRZz5AxonQVOj2yrDYMD
	8+bzI=
X-Gm-Gg: AeBDievMmnDabm8Zx/sHvbg+s7/KPNOCj6WBeKENhIaTRax9JnOmDzLpFPzLQzMXhVG
	R/epmC2BHI3UyvDwd5MnNHR/UPz8EaHp1EinlA7o6ZmbXlvOpojn9KFNofReNLWamqGHS3Dwx/P
	jnq5lKDUzY6EdFgu67Rhi1zlnxppsEG936hPEsu8gimIjU7A3p/X/4nDIzhJWp9TiMlBuUsZEQg
	4bqQ5S55NxP42sM0PeEHizOi7PCTGqtTdsKvhLmNjUJxRVrSZ/DhRmvC2NLx7jV+PwWlIQ6gxdw
	M6vSD2gRrPPoUa5NSSsYNeL6ruyXP0t6q6CYtFqQvWCSztUTZgvvdkgnkYw+bCIY/9Lp84+W4DY
	r1YevaQN3R//vAEt8dC5LQd4iEuSGO7fNvW3uYExw7/BbroJi244Yy+W4docIPA==
X-Received: by 2002:a05:6a00:3e16:b0:82f:5571:1a8d with SMTP id d2e1a72fcca58-82f8c8308e0mr3071331b3a.2.1776434174929;
        Fri, 17 Apr 2026 06:56:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e16:b0:82f:5571:1a8d with SMTP id d2e1a72fcca58-82f8c8308e0mr3071309b3a.2.1776434174428;
        Fri, 17 Apr 2026 06:56:14 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c12sm2652375b3a.6.2026.04.17.06.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:56:14 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v10 0/3] Add initial Channel Sounding support for
Date: Fri, 17 Apr 2026 19:26:01 +0530
Message-Id: <20260417135604.3044630-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HB51CzVzCS5QyoeneulNbulJdndWS9Nu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0MCBTYWx0ZWRfX10J2tf4qVu+M
 NyyWvjIJOF/b8BpSjY5ta+bJIYOWUJVHfJ4UCmX2hVisN2MQcMIkS8YGkkTU9ilu6QcXdu23W48
 A7lyusVwzng81T6fRaxHAoFoq5KXryStx16kLutHarRxh2IP7eZUaXGFO326G4MmR64bk4VGYrO
 OgDRO/kG7TMVB/XhicUNYIF+dSerbpPdGwBlNapIyIN7K0ep+xLDu4EwYKgISC8fvExRUZqopt7
 W078JUIuz9rQi3t9UB1CnTv6L2ED/gyuzZWD2UUdUINycjFMzG1nIR4JSWY6aEzO/+gw4bMgUUT
 MavWtj/Tk3Zrtu3zX310BCJLHE+17q3k6GezDXsGKSrtlegQfoTBykbTaTp+V6NsdItdbkpuW34
 0MsgL1szRfrSvTlM8kZbCxMBlNbrog7onZWDK3DpK+UrOxP6HzHzCBLDdHO+aQdstUk4GnfxYnD
 RY/zCsIRz3tIis0SSxw==
X-Authority-Analysis: v=2.4 cv=GN041ONK c=1 sm=1 tr=0 ts=69e23bff cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=APRDg7Au6S8_GZJoVLUA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: HB51CzVzCS5QyoeneulNbulJdndWS9Nu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170140

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

Changes in v10:
- src/main.c: fixed parse_config_signed_int to use
`long` instead of `size_t` for signed ranges

- src/shared/rap.h: Updated bt_rap_attach_hci signature to
take CS options as parameters,
added bt_rap_get/set_hci_sm functions

- src/shared/rap.c: Added per-instance HCI state machine storage
with getter/setter functions

- profiles/ranging/rap.c: Updated to pass CS options directly to
bt_rap_attach_hci,
added NULL check for HCI device creation

- profiles/ranging/rap_hci.c: Converted global state machine and
cs_opt to per-instance,
added role_enable field to preserve HCI command values
separately from parsing values,
fixed C99 for-loop declarations,
made state_names and cs_callback_map static const,
replaced malloc with malloc0,
fixed off-by-one error in subevent length validation,
removed dead bt_hci_unref call

Changes in v9:
- src/shared/hci.c: Remove unused functions bt_hci_get_index
and bt_hci_get_fd
- profiles/ranging/rap_hci.c: Remove unused function
cs_is_procedure_active

Changes in v8:
- profiles/ranging/rap_hci.c: Add static for cs_state_machine_init,
cs_set_state, cs_get_current_state,
cs_is_procedure_active, rap_send_hci_def_settings_command


Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw  interface support
  main.conf: Add Channel Sounding config parsing  support
  profiles: ranging: Add HCI LE Event Handling in  Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   51 ++
 profiles/ranging/rap_hci.c | 1287 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  132 +++-
 src/main.conf              |   24 +
 src/shared/hci.c           |   62 +-
 src/shared/hci.h           |    3 +
 src/shared/rap.c           |   68 +-
 src/shared/rap.h           |  176 +++++
 11 files changed, 1793 insertions(+), 22 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

