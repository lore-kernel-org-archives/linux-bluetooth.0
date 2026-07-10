Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E43F9287
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676972; cv=none; b=suc2Bcj4LyxSP0Mna8gjdpO8wxct92dvLpyd6sBd4jFP6SYaOKtyyNZG1sCPG+HB6zZrZWK691UXr/WDGMYkMvTH0o/EpfeCKNs6O0UhP3eBJ2CMGCcYYuvgNNoudLiyaKR9XrEvjO0mI+0K23kza85SyXTJh48qiOqpDpbV1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676972; c=relaxed/simple;
	bh=uZaNgwn/+Zwmocm3ej1e0Y8Jp4t3M3eyNPDpXSZEOxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ALxO88ThlDXevkGSmKVNts2t1HA9JBHTT/h6+5cpFRsj19v8IhyFpfDQUycMhPOWzjOVOvJjFp9Ja0yDLiO2dr/2DNRUIBH+MhNPi8eO+g1tDc++K99oNNYxTouRP2Cdc39BE6kbN8elxontXga1Y1dgIwBYeNtAvdGtOMtE8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JVkeOLay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EhlLOHPL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JVkeOLay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EhlLOHPL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dWwO4194177
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b4VyP8FUl27H8hpvcS5ifax29mQaStLkczj
	ssmvcOGM=; b=JVkeOLay8MMMVHCt4iWD9QPHv+lk/dsHFww7i7Rm2hCBrqrr9sE
	LratZNGrotOpfn/TxkrytQJefGFxhXCkbyX3Pfc5M/Vgpppm4MxVJMHsR9iHtiv4
	WyRpom7C5n4R1iI29IWLGS3XcppjIHaChkekU+Cp71dcRR65aTOzgZNWZwOeFre4
	egXUhjLYA3unXkUzmWxucvCvynPMZDO9KvQAmzI9GDefvbUBz0tcySECVn09M9x/
	oNEl0Ona42FwZxFqHsBZOhXWPqRM1is1eE2j2NLtwFwUQU71+DG0mVEIEhtubRBG
	zyls9yDM/AhibBDKt+u4LDvOVLeVjfmZHAw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24updy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c891ed872ddso1152309a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783676966; x=1784281766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4VyP8FUl27H8hpvcS5ifax29mQaStLkczjssmvcOGM=;
        b=EhlLOHPLRFKzr/3/qgwrK2z4oF3OV+sAWaqYsJGzL/fnJkzsEKJ/ZElz0o476rYhhq
         ngxPPqVvFKzwEiqjw0B7LMEP3i/wTTi8l6DV8M3N9+e6kNm5LH5HnJS2t3qpsjrMePhr
         x1syZLJbeON2AxTpcerhaX2k/Wv4RsGDD0Kx1uzmAVuS10OmgB8rQJsS45KCSk/92iU1
         VvWlqqoP6PUi+5OjilTsLBE4+dIxMd7dRXln3DxbD0dIiAnlMvEEeVLV/mTBCHtbAyuc
         L9JqBxcLebnytfgnErfSUyqTruwkJ8MomeseriRmU94YSMAX2EOVyLxdT2dzN9vQ5epc
         BF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676966; x=1784281766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4VyP8FUl27H8hpvcS5ifax29mQaStLkczjssmvcOGM=;
        b=FgtcIiImgyGHp8V+QP3xt6nEXevx1AvQcDeoPQpvNsiA8mW3/5pRfxWMiWTezIzWdv
         eGrqNJHxlHV/6cPuA6PH/GWqMMZ4B0CKmz0rJTOm6/Omd/T7tMWGjoEyi6Lm//SShb2l
         0sY/8l7f2e4S1qip9W1hFQn7zO2oTylhY4I1Z1YlbB9B2qeRkk4f+50QfOw+Tm3qGwO2
         5WC7E2ccpf6ndohJYZwcTcM5K6QnfpzG3tEtEmuu+EN21KO1yIkcGLvlceer+vleApnw
         mzaWOx9Fu596nycNF0+TUfISQGk50uyiacwJOySi1np8aF52u86XxplhI/Cc2813UTHO
         PNfg==
X-Gm-Message-State: AOJu0YzuF6X34QbmIoLQXenveZwUV+QCfOUK3NgnP8tHQzDzH8L0XUC8
	V0pzdJTfTUSMAvanLT5oEkHV6V2tcpmJ2A5F9pGZg+LXwADvLLPjv8c5KmdL+Z9FVDvcEaTw6gt
	64fTR1goiC0i5ogkcp+3AwZHPHAiLYflMEwgVlks7OkX0AciRQY12HVVv45FkgNfZEfpz7HQIcz
	PVj/0=
X-Gm-Gg: AfdE7cnGuxnt7i8KdKHNr0K8a78RT5aOHHwNu4EmhD76IFWnpBeBPxVkQW0L4bWMaDQ
	9JKilR171StKomxdWMAQlEvFnqPkMUD1AG2u0i2VVTQKuLqU5dqsbFX16DgXejb4lw1Mvsma9Br
	QJBbj2YZHYUsstnmwXvkrsqBaFOKv+/htZrOkchx13kFOhk1uxRZLAUBFG7yHYULVkfkeETkYtM
	bzspxiSh4UUcwhTpmZUiqLcj62zywyJPK6NfBiWLP9x1CoCys3/Lz7/3cLjLclTcZH9WUovRDam
	eL3MLab43UTv4651I1N+enX0xprJ3g1Iz8hBzQFfPjCQnZX0gcZQZk5i8Dhwmmb39vbTQZs+Gvb
	lq3BJJpmpBh0uzK+3/lzL2GzC0JCfa8EFXWOFelWJ
X-Received: by 2002:a05:6a21:a89:b0:3c0:9c1a:8937 with SMTP id adf61e73a8af0-3c0bcc6a263mr14303841637.63.1783676966277;
        Fri, 10 Jul 2026 02:49:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:a89:b0:3c0:9c1a:8937 with SMTP id adf61e73a8af0-3c0bcc6a263mr14303795637.63.1783676965724;
        Fri, 10 Jul 2026 02:49:25 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b3206aaasm4106526eec.13.2026.07.10.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:49:25 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/4] Add Channel Sounding Dbus support and
Date: Fri, 10 Jul 2026 15:19:15 +0530
Message-Id: <20260710094919.4047204-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NlVeQ0loTHgLhX8IoTqslj0nyiSmhuXZ
X-Proofpoint-ORIG-GUID: NlVeQ0loTHgLhX8IoTqslj0nyiSmhuXZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfX+5MMUDOTs5Cw
 tr1hisqTSKmyjaTp65GGe8hAR0mgFTYx2R36EMOxxdfT83DMQrdhmsfyhKENIf9mnspCCRmLO4S
 yuZOOkeOojJy69VKcCGL7QFsJl8hKWY=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50c027 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=XHHUWyw0eKzNyklp_SAA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfX6VvDxQrUURiu
 onFwsAaLIuPHk5ilsYEKcFyKOe13MZIAnDlOGQ3qvOsOw4IXlKBPVKqUVrjSUCE2xHuitIQEYQp
 iMAUCwE2pPG+MXnZM9FK1jRX6KjcKGCxudb7eM4+EDULCT6s0tBrThtqk/IMIU1tqCVoxMPdBx8
 YVjmPYSANiXX310JmywtF1HaeIXnEkaJ806MCqAo2aTz6JrzBINKT+4Wd+NScOYdWjafTN+9d9u
 2WwZ+6Zs01ssd9mDhp0ARzKAN7CUKIVCuQg2+RmE04sMPWcQZb+qgTQREr5k2gCmLx+AfBFpyif
 PPfJa0pVxCHTWgSXnAfkAZbgwud8qtR5N6xewg8oTZ08H5x/bkg2CM7NqOd5EDNpo0oiZeJAEPp
 kMPXy9JP7GzwEZhTZqSUmmtsMeok+dkBwa7tt6GfwdAU4/n/23Q8UgcYB1y8BBXbkJJ+6xU6LIm
 PaUb9vnTdaaMjJ85AUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100096

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
 profiles/ranging/rap.c     |  347 ++++++++++-
 profiles/ranging/rap_hci.c |  531 +++++++++++------
 src/device.c               |   28 +-
 src/shared/cs-types.h      |   50 ++
 src/shared/rap.h           |   27 +-
 10 files changed, 2000 insertions(+), 190 deletions(-)
 create mode 100644 client/cs.c
 create mode 100644 client/cs.h
 create mode 100644 src/shared/cs-types.h

-- 

