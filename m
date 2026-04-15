Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92471277035
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271095; cv=none; b=D6cs9GOFPElCFAdS8weZKKvY7VbJCPqV/qDCxkLBy1s6FK+80FASUfau3vaAmefvYgeArB2ryBHIx1URn753dODBGK3+WihMW/EvZXRc07TwrNCa0uPJm3XEAqUaO5Qu/N8z34biO4OAFW+gx9wwMW9LK5R5BSIVahLfxwRQwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271095; c=relaxed/simple;
	bh=/ccVXpr+IFDPncmfH9WgJEHzjIl0v2x8dQd6D++9FfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQpNYtBzH1yrQNhYxyvF1uo/KwN+v2xwTPNBLq+4kEXh9J7vHYQ4728gDAfHoL9PbMjw5lSv9PjEtk1w2SBEKVu0SzPwgEmKk8dIDA58c6gOHq951zqxo+IS/+tIVqQksSj0tNL3I3NW8qjUBNZnQbl9dZURwPZOioCS074p4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gelf2sY4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hxgOP2Ow; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gelf2sY4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hxgOP2Ow"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FFVGvf1565849
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TNZ/v3NxZKAuF3eNKvyKwSqm5h6AnrZ9kVl
	5yNZO1w4=; b=Gelf2sY4SfBhZTwA3hr7v8VwRKijJtM/6mFSl81g3nHu7EF6a9u
	KO0P5+S3cuxS9ocxiJqA7Mnam+pQQVGwwMiv7J+RD+zYfuG40PbLY+YjKZxvJura
	j6hlMUy3W/S0pNrUqiMR3+1vNQtmbvxx6JDVa6prZmRUhgk8W7h9BJCBJ2k2n5IX
	EMzVZaH12jxym0NiOY3U5rhWYFmmeCGwJunnQXo+FGKnPq0Mbrx5OkXxQyeH/o78
	TZVkMZCM/uaFduxNJc07fs83k8g4dHGV4NtUGZ/0cRPz42+UsDvSvSdcLOdjq7VU
	WvK0UENrpca53rvXXB98fW1Ow9Jh+3aue/w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj7wv1ksg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:38:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so113258505ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776271092; x=1776875892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNZ/v3NxZKAuF3eNKvyKwSqm5h6AnrZ9kVl5yNZO1w4=;
        b=hxgOP2Ow97QIJTVXA3/W+0LKOFJfNakO0DSh8VxlvWXFLoBTEL1T6GmtOwd6D+myX5
         23UHeZclFIba2KP73T4uTG94rZ+plRiuk65JK69LMfOJnAPB7P54xfNJzHedmsk8JvP4
         1lDUTlmTE4lh4QidiGM7qSkt6oLeyugVxWQAMXMmhu5CZpin0a/Ckg+jLf0GjLwTRwdt
         ydOsivrmy3tIpxROcz8GoeHz8UCVQoieFqHp9sV2L/J56OYEoa7Hw7anSKZlWNrjdjBq
         0IdZ3iBz7jJZtMNgLsmWP1dcbpMw6R/zsmtlWYYWRSM55jErQ7sj5t6GsO5kOX8Lh1uT
         RUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776271092; x=1776875892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNZ/v3NxZKAuF3eNKvyKwSqm5h6AnrZ9kVl5yNZO1w4=;
        b=rkWMgkTct2SD/tk7C6T5TcPqlhoZpltTUR4F+H6fbQQdsNMpe7hbxkc+xqnIZy9Hdb
         8q1I1Fm4qjEQJ0g8D2qAFhJ3i8CLk+I3tbe+d3u3z5OHq9qGMpl04xdyQ2evuPeQBx63
         rWTj/EVy7FXEsFsW/uYV2G3+PcclqQmyvaRxKtfkFQBKQ9SABEfvHoPH8UPQWQwm3jc1
         0pU3ZaxTPo/zdrZRYdhYA9HIdf8ZpKWHGrRqkxEw/0hjU5Dex+nzjBBalsi+cn79ahPS
         wOdWOTyRFfXnKnGTZMKYliYH2UidIdAoTXfhOoIj+TRieIEmC4vIEp9dS1vdn0QiBgDe
         HCZA==
X-Gm-Message-State: AOJu0Yx2mGKiD/ijrAWUm7YYtJFpZKAZcS/6S3QaOrWD1CE30g1d4Vqb
	iFTyjdggQ5a1fKm+5WYS50IkshOtY58w46HaMOOYvgGuri3TgqN8rpzb8ofyfNp4hiYfoyBRc2u
	ji6i6xdENg4zUfacTwJjIAn+1cDdlkOrmJ2q+lmm78avFinIpeJj0K0VQYgldJ8iqEjBiwkGOBk
	BgFGQ=
X-Gm-Gg: AeBDies5W2B/viB485TTjvACT1jzOc9eHn/mKmR+myjP7PTlKPOjb35Ts1eX8aMXGtT
	5NM8T8e+xeaOA+hRyus/8diMe7xbtjLk5hB1Go7drRC7Z3tIN2XeIMx1nSCGdubw9PWyPOKf2/8
	DZYWOjqjOL0vs1/968hwMX9V7AhHb1PzCZFeHJr4icbkjdBNPFo6R89H2JOeP9E6Ir9J6crs4A8
	EbFc/0wy423HPlswQT/rzjqr9LdF/z59zMtv2Gfp06egLjLAp5KLnKRPpmGfPG89g/XhzYcVGtu
	WMg3+QyyxEyL/sWNb6jqilpo8qILekQCZsFZd7CgZkmPxSOUojilqa7nh91cDtBNOZz5a/g6DIn
	2iqo46CMiaXxveWTbrdjOFCd0lEhsca2qg2ltmo4/mLAMjoTZ8V0=
X-Received: by 2002:a17:902:8211:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b2d5975bdfmr158767815ad.11.1776271091805;
        Wed, 15 Apr 2026 09:38:11 -0700 (PDT)
X-Received: by 2002:a17:902:8211:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b2d5975bdfmr158767575ad.11.1776271091316;
        Wed, 15 Apr 2026 09:38:11 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e110sm34941035ad.43.2026.04.15.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:38:10 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v8 0/3] Add initial Channel Sounding support -
Date: Wed, 15 Apr 2026 22:08:02 +0530
Message-Id: <20260415163805.564395-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: knbinItXzGYW0VAZtz7apVCR4Ufu2L11
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1NCBTYWx0ZWRfX5EEr6hhIShz9
 Q5zPrONqteAOrU0j2guvrccB71pfb3bDHkO/7Yv1duFiddd55jbNp5NLGgxLJFiXwSxcL3oLfVz
 eIIXCD7+b3tJBa8JP0AhENV7WxT0HI5SWzaoCgL7ckCg7InrZdME2lf1ucr3IVI1+SsI18nZtc+
 NF12Ve/ol70XEQ8X+PQK208CFQNwBKE/SuQB07wjZ/DGu2tpDDEGjSbxSuQ3fHCaKEyNBEC3qGK
 0nM+Gss360Lnq5kg/UQYqgaPxOBeZ9lJYT81Yrkcac3a+4fPZTfuka0KKRfXxX8iSE0mDQb47wQ
 sc1Mw3kPmI2WufBPtxlRlllo9uqOKyyhcAgdMjenPwXYW8mxKwSpCyXT6SQ3YVR4cNtW3AZNkI+
 19v66h6LKLKsFWrv00rGSCs3MHLql10EArVGrAB+LUy6iUAnSH4D5aYYH6hUxmw8pMG4VPY4AU/
 kzvQrDrUXJuvB1rkGyg==
X-Authority-Analysis: v=2.4 cv=GYgnWwXL c=1 sm=1 tr=0 ts=69dfbef5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=yE--P-Ky-lm8XdBANnsA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: knbinItXzGYW0VAZtz7apVCR4Ufu2L11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150154

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

Changes in v8:
- Add static for cs_state_machine_init,
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
  profiles: ranging: Add HCI LE Event Handling in Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   52 ++
 profiles/ranging/rap_hci.c | 1268 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  132 +++-
 src/main.conf              |   24 +
 src/shared/hci.c           |   89 ++-
 src/shared/hci.h           |   15 +
 src/shared/rap.c           |   50 +-
 src/shared/rap.h           |  176 +++++
 11 files changed, 1796 insertions(+), 22 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

