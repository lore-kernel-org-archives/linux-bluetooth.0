Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766E23ABA7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295317; cv=none; b=fwEPULLlivcaKF7SNvB4x3p0w+DvCXA0pMkU5FHTt4ZjAN1sV8qWX7mzxad5Ap8zLPj3e/Lb7SSscZ7MCQm9D6MNzuYhD3f154AFlqypwzLXg3ZN9otkR3WKGDmJeuM3021ifB6XZq2mtu3O7kv8qTp5Z50g1AKFTxIJdTIBg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295317; c=relaxed/simple;
	bh=EAR8lsPUIJ2FRZQNarDdpt0qJopu6RP2sAgVYeqH2wY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDHw1WQds0AWgrngW6Crr64CQVUqFdvUiV2EW+L5fAJIcAefhlg5NW7DAExDWZRaDbDZQwNxs2mvhXTdJo/OAoOEXJQunKYsD7BoJCvW3ggCuzQEP1fJGrDN0ZkBEI4XpbLpgUwCGFkWLGWqS9kZ5JRWKC1xbp0ApCi62+Y5xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ba/8PBHb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DACVZoiN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ba/8PBHb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DACVZoiN"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCTOWR1885245
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=AkfC+DxTkohpS1fMZjQMPuWQr4/uu937aVM
	PpnHILRw=; b=ba/8PBHbxNHMS2zT5m3kgyyhgEh56NlMsbXA4RgZv78M7ttBwQh
	hi73awZnnbexKrRaMvt8WPgOv9V2e2h6ifBVEds9S5A9983NBIHFzsD8m7FB14ud
	ArJVeC/9oFXDKx+Qi1ocg+WXkVo3vUINssxUEFuodDuZY6v/kdAwnTkjIpdHAYCX
	GwSMTu4M03B5lLFRXH5x9zsIXiZaLiH6qKegQxVS8oLHdlhsg2SawTLifV8arU1L
	M0vkfO02KxOv/nDhzzEufK42ThgpW99esP6hlu4FXTsiKlMdl/CbDegtfA4kazlv
	vBeINejRZkXhmz5ofImXi36OLsDNLhHejtw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfgwjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 13:35:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so11081492a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784295314; x=1784900114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkfC+DxTkohpS1fMZjQMPuWQr4/uu937aVMPpnHILRw=;
        b=DACVZoiN9BcGR6utrvI1LyoEfCDBVQcotYwxWmDgakPH2qBtq13br6Muh559eQUhl7
         HEU5nN+eSLT5SJLAHVZx7BhKST9+pJL57e4IJSp70QMKAfTX4csz0Jna5EY6gVucLvcH
         TdqcQkujFCLliHkXH/S8/qTVYyozQ9Tpqpk9QXlxE+Z0/ikosjDEzyvQ747KKFicGZ/I
         VlEFR9C9KcObW7+1Ob3plEVQgVk5LIf4cxaOiX++Z8Vy00DoNoVUHz+E8hReYmZYr5ZD
         w3EZy2UY9OXsG0effgVRqTilYbHAEZbtow3rAYFb3WzHS7rYPv+thg7TOOofKInBrFrq
         Yh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295314; x=1784900114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkfC+DxTkohpS1fMZjQMPuWQr4/uu937aVMPpnHILRw=;
        b=avJIGlzixvMkjycujjcFUURQHmkgxZz/f8vB8F9aIXAJCuWS4IlEo/HpucybAnkZaX
         xGVxZBflo8GHmgjNfVT+Dd66d9J3ofSwtFJDfUZsxujgw57JPcuRCdckUwlTfNYLudBm
         Hj5u0Xr2vIgF5Dig+DCwUER/66Ld+MWpDgyrWMQ7TSzbzK7GDs69SqWeWIB4vnIVoxJY
         tTfnAV31XmW/deSWQPUIRNgGruHWCtJro5gc+OWAFtMoHWyJtxIN1da3xTOPoZ1+gRZZ
         Nndv4dSQtrxIzuvigY4HvTYFi0Ohq1B1E2u3Ye3Cuv9AIDqc7PiFSGrkg65HHXrzb+9d
         edKA==
X-Gm-Message-State: AOJu0YwnE7SR1uop2MYJ1Y8H+9CZB//hmPAXCVMAozT85oYSokbPMQJI
	7/9xeKoCIg4Uvi0LxNGduvytrJoBTaFgc+NK0JHScuDsNUd5eM7LKanxYTa5OgOyzxkXxuYak4X
	nGjArM0WMnKkbdxpYKMJwWeG0jZiesDbU4Rcc/blNgKFawM4v51SM/BOr6CHkck9ReKbCVNzbDb
	qbctw=
X-Gm-Gg: AfdE7cnJUFKgRu2F+I8966/Bl+6E2Yoa3o3Ny3hpZG4rP5sd/iue9MhSX8N1OJgd9ej
	MMGOcbPRONoiq44y+X15qcdGjkrEXSorXmQZAOuvG3/dR2jwtA33R5Eat4gpqLyMjVdzCoIrcZT
	B1OAAqP/mGxSNqfG6QodU1iIm+BEHTCShmfAOrEZVABeuVazbw9RMA3CzAeVHuV0bD2cl/LVoY1
	byGhPQy2aiUsffWDmt4Wz1AS73SzYwCqk4lxedebY/wdxnqnmbogAYDBlimrQ/55ESeYJFgyjsh
	hcJdqb9yGqUXQ2pFFKbw88nNqbb0USU8iiz0VUcF3WaSebpK03etKnBxE1tHIo+3rQH9I1eELx8
	SilmZQNKBitQuoO3Zl5UN+8A1da6jnw==
X-Received: by 2002:a17:90b:558d:b0:38d:dc13:6f94 with SMTP id 98e67ed59e1d1-38e4b586170mr2741651a91.37.1784295313924;
        Fri, 17 Jul 2026 06:35:13 -0700 (PDT)
X-Received: by 2002:a17:90b:558d:b0:38d:dc13:6f94 with SMTP id 98e67ed59e1d1-38e4b586170mr2741605a91.37.1784295313324;
        Fri, 17 Jul 2026 06:35:13 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fe4677sm6648774eec.11.2026.07.17.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:12 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/4] CS: Add create_context support
Date: Fri, 17 Jul 2026 19:04:59 +0530
Message-Id: <20260717133503.3711396-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfXzbRoNH0Xy7vT
 KTpigwGJEjRktc8r+GFJwuizEzboDl6sA1R91uRPJBhHjp3Gmnuxk9mb38Kkzuzt17gB4xHKrem
 U50vQyWDhw263mn6LAEJpO58v1Ttc2CN3Ke6uKBz8EClypKJ4fdrrzEhTSyj8Snt0AVAVZc5Sam
 ljxIPsgb6/VHYES0hAbXX7ibHVqSFkPD8rdWvohg1tlkyv97A+lYAc5/2fQyP57uXWSFOmGHWM+
 /PIHcGpqkol1Jvxy6cPmGHetx0hxi7PmF0h3at0d+AYhQHDanZTRDwf45S7tf9LJM9Azso7aDqn
 HEEQpb4KTBsvkYmAXEoJz3DYk4/ucL7tyIb+D8pz9eieXKmnlPFuXpvcjLCjsujOONPG1DV1Ogk
 f+q8RVvBqs8jtwBoNrO/Lu8gj0ia6bVBhbH5NfkdLev4pJdqrfx8hyGUj2h0NNfHQGeujRzFLDk
 401cqNqxw/tXg4ZNOzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEzOCBTYWx0ZWRfX7V/QRUlemmJV
 DK+ITPhBmaByonKAl3kpCxpIYZ+Rr+kgogt405SrrT4zKFB696BCWPa2EMP56ujo4RDRed27ygL
 LSz60s3B+5XW6QxYIHynt1anVlfGKDw=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a2f93 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=vAoIKEjTJQpbYhjlxfEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: O6rH4bOMDSp4sJ7YON67xGc55ScgaZOG
X-Proofpoint-ORIG-GUID: O6rH4bOMDSp4sJ7YON67xGc55ScgaZOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170138

This series adds end-to-end support for the create_context parameter
across the shared, profile, and bluetoothctl layers, allowing users to
control the Create_Context behavior from bluetoothctl and propagating
the setting down to the HCI command.

In addition, the series improves CS state handling by transitioning to
CS_STATE_HOLD on HCI command transmission failures and non-zero command
completion statuses, reserving CS_STATE_STOPPED for the expected
procedure termination indicated by a Procedure Enable Complete event
with state == 0x00.

Finally, the series updates the license headers in cs.c and cs.h and
removes the RangingInterface-related code for now, as the interface is
still under discussion.

Naga Bhavani Akella (4):
  shared: Add create_context CS config parameter
  profiles: Add create_context param as part of CS Create Config cmd
  client: Add create_context CS config parameter
  doc: Document create_context in bluetoothctl-cs.rst

 client/cs.c                | 109 ++++++-------------------------------
 client/cs.h                |   2 +-
 doc/bluetoothctl-cs.rst    |  18 ++++++
 profiles/ranging/rap.c     |   1 +
 profiles/ranging/rap_hci.c |  42 ++++++++------
 src/shared/cs-types.h      |   1 +
 6 files changed, 64 insertions(+), 109 deletions(-)

-- 

