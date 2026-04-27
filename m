Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F43BC696
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309216; cv=none; b=HWhsgjm3xGC6vlMn6Z2LH5sUSSxvTNLrecGskdRwBCIIzIJdsNRcZew9J0E64IFQScjdMzzxVRn3BtV+mpf3DihemX7XRjKDabZt5TSbQpVM6jH/7Y2tqfJ2Dt+8qBUuFU3FoPWWifBEr2GfJ0aPBLVlQ+6jIrn0z+byTi96qqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309216; c=relaxed/simple;
	bh=EHRSUnImH5SdWDf339fXtY7L7IEEXKgwKi/yZz9fwxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AN6cq8o38WNuFimKVGBOMsHH5qNF94251TiFFsvAMqqMPwRbEBxn9bEsgDK2O3KV49UcGfQQ8tVgSIO3txF2YNqa2xTnQNNhpaelNDuMYW1zNBJwqz35W1fxvynTEMJRNVuU7uLrBVpXUBRm5qNKTNVse+pXDl8EeJHbPDEXbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MetdSqP7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JtqT5eoc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MetdSqP7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JtqT5eoc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDtvtR665792
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0ymOXogkDm08I0wukOkqYbYQkLFjJ/sMjzM
	UdFpVTOM=; b=MetdSqP7BxbrFE5MYk0hy4p8sfJoGtbPbESpPtxErCBstGDIxHo
	OnRg8D9ITceAnKDVZRtiD4bK93naUYeJsgmSMdvrz2ALfp7piCqJmQPhgs9azveV
	JSs9HhsGr+FkJEU2J/8euY4zcnDMnPOHmreWUX0qnS8u0XftGNyghncEhU7UN3TL
	VA18eLuyBRo3LM//2dSds+gzzMKOS8/IrGtF7msdnbyxsnA3bKhILldYvUXAQWxg
	Md7kJxMXKQ2Gk1h8Q2G1bwEY/mkt7I/+bpDShVjBDbna/0DemEcjnj9uJe9cXAhq
	q4S94GaVq2CCWDSt2utLpA4o3SqPs+THmmw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n2d3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:00:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so13825124b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777309212; x=1777914012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ymOXogkDm08I0wukOkqYbYQkLFjJ/sMjzMUdFpVTOM=;
        b=JtqT5eoc3V4Prvqvv7nK1NCdf12CZ/XW6lkr226SaMugd8kd2od7mCamCtQGHxpL9X
         z/9+zYgnOUHYPqqdvYjfs7A9GfGRLx35cj/pzySiPL4G2V1FkN19vGIXJMuhN38vQY6M
         1E3K9cAzZPF2nL/++JKG3HB+/W2EW+awMoBgDyXgBtZUZDNei3epzsknZZvm9KS8okYf
         0dCUWmTI8lkRkD8/SsEVyORTS6f/CkjcHp9DZ+RrtJWFUnYQ/VBvG7XoupN8XdeExHy5
         FJ5RO3tq95xq45UNDFjRWzlOK9sRZJxYSWoWNiDP4FoCGprSKww1jxkf4H675hJkknb+
         AQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309212; x=1777914012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ymOXogkDm08I0wukOkqYbYQkLFjJ/sMjzMUdFpVTOM=;
        b=dvrCupaOT62+VXspImkqo7BhEBkU6ErP8EweDNe796gI8gJr8vKYxT5luDJOxHc2tM
         w7GM/OxpizFYJ8MJTWorgzFVOMhWFU0sRKPktgmJK/BGCSqzvgJNcD3UayTYoQpip3jg
         h/ldHQ2ZFlvBGvq1biAsnqUqGOMRjgVa6S9Kg+X7k3ty2/LaThEdhCFPk73BATWDOA3P
         xwdOBLadiNJJy+MhlbYU6FBv40tzGdp/Taz7rXL4RmggCmsmAaqYwsKBFB3Ak7W12xLD
         U10bk1YOfmN4q3NYd6FrV0PuFcTORdsRKGXBd3I0fhQSUggKFrY0eiEkZx85WpFruqLe
         V4Uw==
X-Gm-Message-State: AOJu0Yysh+Ztto0cFM5Bg+URNPfDV9ce8cQuw3YpxQvHN+fA9vr/MKHZ
	E605Sfb81C9YUO3CFn4NXgdkgBD9ZRkdywMJa9TWjPOD9qwM7pzpIbkRY2YKMB6JGwD1lhTBLAl
	/IXoBUpzeHBfbqpBkEodGWYBFWmKnW5IhW/6G+VcCCI+eZuKacuzZEKBvviADRTZzd1ujPc/9aO
	MJZW8=
X-Gm-Gg: AeBDiettvE05yT43eA2KCrGWJc17+d/6VCHLZGladk4ETa6A5OIq1eJ4too4yTxz54+
	sm3eW31Wl9zCRkqZPM3mO6x9q9+19NXt9Y1mqk2bk6Ld+mVIwxbLRBdmBT9FcOsnegahpvusE5e
	8SHc8q1tu2C5NeVSOSUJr5OaD2zKdq3WtIuSnTNajRiBFLke2uZ/OqSDuUJpog+y6kmjUo/Xa2q
	2xynu9AUI6rZDQzIYRxgiiomuKa7mLVMaK0HZqxuBDZxGYBxoni071dLA7Sd5hm5T6RYtoZabSk
	QKJpcqEaAtRJ7dh2IexX4BTjXUUtAqt2d5GbxH+r40ajhDScBwpao0XndgYsQ1YikiChw+qR0pd
	e/dX++4nnDNLYHfFF69S2rQjGbGTGS+SqqU5+1Xf7mLvBnSWGs8GnQw==
X-Received: by 2002:a05:6a00:6505:b0:82f:9de6:3b2a with SMTP id d2e1a72fcca58-82f9de63dadmr26484525b3a.8.1777309211780;
        Mon, 27 Apr 2026 10:00:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:6505:b0:82f:9de6:3b2a with SMTP id d2e1a72fcca58-82f9de63dadmr26484502b3a.8.1777309211226;
        Mon, 27 Apr 2026 10:00:11 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb33fcsm31540597b3a.33.2026.04.27.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:00:10 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v4 0/3] Add RAS Packet format and Notification support
Date: Mon, 27 Apr 2026 22:30:04 +0530
Message-Id: <20260427170007.1282289-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4MCBTYWx0ZWRfXxFwXYz+j5VCa
 ywToHNaWymctJ6KeVoZ9NAP/P/UzgqnDxX/xakC3YxQJ0YBHb549rHr3790XLGQSwc8vdbkSo7K
 hYiU1mIEeltJNhTalxdhxxzzjTxIs6qUxG/Y7m2V8yHT+UEKJ7wAtxZxT/HRAvl/h8MjAtZCPt3
 /pi79dySMUkqPtnHVimuCVOeFQqWb/jnCFjV3Rt3yPNtmIYBoCFhKQ1D0CgSTBqAQcnDXVPTuIq
 ylxoOTKVwIU5/hiFA6S0OUVMEt8NRKUEG7gvII1tL80UqkWLRTDTRZ+/Vu4WdJnbZboCqJ66RPJ
 2qXd1YgpI2CUTygh8nQxu0zv43SmGnLhtp6vTOrieubPtL6G4Q4YemkTtzfLJYjhtYe5TEoGuvI
 v+5SLX0FJ/ZmUi+PNiMJ4c5N18TgAT9aXtXG2lT624E7LiCCvpzzI6mfUecyy7rPGLETI+oTSez
 fALxdio1CgKHIHUsgag==
X-Proofpoint-GUID: uDvDlGuNeyxaEK7cmBqgoH0JBgxJYjaX
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef961c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=uroqZWPkk4z-oJcJK0MA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: uDvDlGuNeyxaEK7cmBqgoH0JBgxJYjaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270180

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

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

