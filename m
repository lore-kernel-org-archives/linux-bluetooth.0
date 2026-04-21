Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F621632DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771118; cv=none; b=c9BYothk1QCWIRfvo+7Bjk6CxKc9F7T1Z2Yo9a4etjmXcURyyIcH+vxRrY2ku/haynsRX+HcXcr1ofafnQJELjTuOLUtXE28Eu7D0deId4n2dm2wpmrzvM1LVnhUANzLIjQDs2/rz5DmgDZoBCXFtEmojM9xAdHJKHvASNk5ZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771118; c=relaxed/simple;
	bh=4duqwNYFlC3MZ4OCrePZ1AWgkBEqoQy63vdz48gIQkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fd6zgeo0HdkNVC4FfzKWSYkZBu11v3Cmjbcv/Wo2eqKG1US7hU6EkGDinoZqy0nkzJej43PPtgYoatw1MJXYGZkgz4T76nZIejq6ecJLLknRXKS4PFJaW+zS2WTNQIIr5mX7Z0h/4rOlPgNVldwVuu2XnuJGlcASFPI1W2M6Zb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkXPce0x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iegDmISO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkXPce0x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iegDmISO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L9nomI046130
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uCKb1r+a74lQJ8E9jFLzZ4bu75MHuvt9O++
	Hdkkzdns=; b=hkXPce0xlgwQMOUxsb1e3HGCnLHJoYeoHm+dFb6UBfe0HDhjSiw
	D8SaUEhcKiukrKF88trbl8lkwh75qBYAaVR6+zjLqcm3J5hx8iOdAJP8r2iQURnk
	SMdIt315fYXE5cQali7uKRWAEMrk5soh7C9gvjmCgZhKilZTjcPhIL95srEetidl
	KFD5tnMdOF8RwnYBNbXL0ALGXjnrqLG6h+vpPS9xZqfPw/rj7yTBD0e3ohUDGzw4
	jAtXLTvIOCAsx6mGt06bFglLXEkR1Mh395PrU056dfap71Ls2ckXfv/yiB/g5jhu
	rYQDuZHyfuVGNIqowVIBj4yL438yko/Nv7A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1sr47-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:31:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3568090851aso10039435a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776771116; x=1777375916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCKb1r+a74lQJ8E9jFLzZ4bu75MHuvt9O++Hdkkzdns=;
        b=iegDmISO0XVX4rv72t/1cN26oVkdy8UCNPVQt+8Ix+uwypajsmt33CvAW8QThiqha5
         dAZjGzDbY2JRPxBoRrTpip3FIkK2bvgYSKTDFdmkqbFmv6CQe9qTFW3Y9mwvUywFiL9R
         V3/ojFHabl8uNWVjsj5SRAWdOS7Z80eEGhvnbvc69ySppcn2sJNfb734aEGqkvo0V3XF
         JCQJKnZsBiIHYZCJ9br8IU3auwwRg9skhBzPl2x8qb+sqTFitRXvpHWpIt7sI064Wwdi
         vSRpcqoxnxAu1EPlvaZ+ZDOSW1wk+A7Cn0zqqKuNOPmpCuTfjgGHdwt5xjrhDCX+on0s
         h5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776771116; x=1777375916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCKb1r+a74lQJ8E9jFLzZ4bu75MHuvt9O++Hdkkzdns=;
        b=Q+v2FJPEW9IbqTBXnazxB9gKOwUeoneFtkNR8FOspGoz8U+IQQNyQtBMOuJxkXHj0Y
         xP34O2Sb9dcQ5000JI3um17gRX1bBwyMYnau69lSqnBx/xDrLg9umtsWI3D7+KUwDzYk
         3qVe7r7hlVDp4XYuanM+uqMWyoLtFxraYZaspON7OFghY1qbozQQubxP7c4rp6dRIKFf
         MfQI/IzIseyckMjK1YLRl5/HAegckuh0iV9CMq0gyH48QLRzfQvHGGsnpJQ5/qrZ7Kpl
         Q3yrRYVPpWWRA2cHRRusFxqkO/yPW2oFXUK8Uao2uFAd+0SVOwMHW7rou+KrwFbOWE6b
         YOPQ==
X-Gm-Message-State: AOJu0YxrHaTJyPbXnGXSBt9Suc+iIxz5veSl+ATWg/WJOCFpHg6fr65o
	MyQqpEWP/O03TK/I5TICN07veRdxmpNFCD+EIDMqw59g+O4U52Bz/D0esfEKJ7Xxa/cKmk475Jk
	B+TtNcZUJtkeVxISicUxcamcREKzU2FD9058cLYsnTWezFhOM5g0wDlh8L+DRomq3Wa4JbZUygI
	C0sSY=
X-Gm-Gg: AeBDietYMQ5NEtgzCHBDMawRv4EpckmRP1KgByfpQzkA8jjm9KDzzCDPLrbMSpTIC3I
	E1IjKVFw/xWN5WzFqejxtoGd7tJ3W62M10jfRZZnemP0twRLmoXHjusWkWeoOlmWtzwB1hKJa28
	NJlgq0iwb2JBFwUOm1d+R0zdNjxKCQxAYA00YHIDBB3in3BzrmihrmIpQ34dMFpomWsuCxODLKX
	vXAxcawgOKCx+crSI9n4YLZ42QGtSYcb/+O3BQAhIddtzYkk6ZbPpoB3n6bw+bPfrSfj9y13sZJ
	re5gUo0qy6nDlQti0T/FprzFEdhi4OfBXvNJZSwfT/4/lOiKK0nbsdQgpVN3VMstpTzPDxN96V7
	a6/itXkMmJFMQPtTQOT4UHnxXubJt0CDZ3qQ7VZKfjsuP59p6sibHqidHSt0oGQ==
X-Received: by 2002:a05:6a21:328e:b0:39f:632:d1f6 with SMTP id adf61e73a8af0-3a08d8a5c35mr17770762637.26.1776771115473;
        Tue, 21 Apr 2026 04:31:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:328e:b0:39f:632:d1f6 with SMTP id adf61e73a8af0-3a08d8a5c35mr17770728637.26.1776771114981;
        Tue, 21 Apr 2026 04:31:54 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm10334903a12.24.2026.04.21.04.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:31:54 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v11 0/3] Add initial Channel Sounding support for
Date: Tue, 21 Apr 2026 17:01:45 +0530
Message-Id: <20260421113148.3809176-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e7602c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=yZHIT41mjMaBxMvUCkgA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMyBTYWx0ZWRfX4dvg71MjGK/n
 k/nSDpzesr65FaUjKOmYejWqiUztLw74bGY2IsyTxyAVoLluJrr9xOPy4oiBW+vpd1+QfaZRCSY
 6FBkR5fIhhm6K8Wp6fxxN/FnPToZkDOf/Up3sq3totJnGZgkos6oqyHG7OeNhEeV018p697hiE/
 2LkUZoeeevbA0uyFPpPgX72oX3SFfkD5mdlQFD9VU5hMCcmrUFbXRGQ+/nJ1RFnK71gqZnimHkx
 o6iQgmB2QAkev3aPEAt0SpE+hkBRqCJkxu0C6MPOv0qeQ8sCXNu6uhMspFHwiPLQ1JfsUvA1MS4
 IF5eYQYvCM291af1fNb50y/RqAiKLFeJrtwZiVRsn2obbboinZ7RuLFKYkXKrvcKVR2olvGwVCm
 6gqASPD15PimSmYEfUkUr33Lr5IfgGIuQHuSs8jMBeHF8oHUC0X+2oqcqsDsyi41HdEGOXGaYzZ
 +hXc7NkN+Xqhiji+n2A==
X-Proofpoint-ORIG-GUID: dQAE6BjlUZMBeIDsYctod7HGK56jQEhG
X-Proofpoint-GUID: dQAE6BjlUZMBeIDsYctod7HGK56jQEhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210113

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

Changes in v11:
- src/main.c - Fixed cast spacing (`(int8_t) tmp`)

- profiles/ranging/rap.c - Moved HCI state machine from adapter-level to
per-device level,
fixed cast spacing

- profiles/ranging/rap_hci.c - Fixed enum/struct naming
(removed `_t` suffix, added `CS_STATE_` prefix),
replaced indirect callback dispatch with direct function calls,
fixed cast spacing,
added blank lines before `if` statements, and removed double blank lines

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


Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw interface support
  main.conf: Add Channel Sounding config parsing  support
  profiles: ranging: Add HCI LE Event Handling in Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |  190 +++++-
 profiles/ranging/rap_hci.c | 1259 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  132 +++-
 src/main.conf              |   24 +
 src/shared/hci.c           |   62 +-
 src/shared/hci.h           |    3 +
 src/shared/rap.c           |   50 +-
 src/shared/rap.h           |  172 +++++
 11 files changed, 1881 insertions(+), 23 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

