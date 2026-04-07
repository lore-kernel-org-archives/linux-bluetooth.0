Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E23A9637
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558129; cv=none; b=k76qEGtv3jza1gOrDwhWGHx1cKXUtxX+4HCcumONjzpd7D74wPdmuhdD4AVO1/B8eQu5N5Hd/u2eKRDSygfTBoJi3FGWfEfzs5FZUxEY/pWF7y5foQ5r7Id9Me8Dqs9uvNHkM5WpsL5rLVq4q2GuEZ2oas71HAVJPJY+OQcTHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558129; c=relaxed/simple;
	bh=uQzVW1roPikBeMA/njTJC5FPstkUhtm91Dl5DlgDevk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usTq9AIhQ6kOWsLmX+EsdvUeqMSOI/HHFaqhiZXtQAvzIebf6Cz7FeP28H9v07BLZZERlMmqkduvBCg1L5D+xfY3GaZkz16NBweV+Sk5oS+ttY3mTQlQJw3xHuFt4pA0ELyjfHAjdCKPCOO88ri+/iAvv8DJ8BheSUEYs2qt8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nqSj7uT/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yv3n7wQ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nqSj7uT/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yv3n7wQ6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376pfHe4009589
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Apr 2026 10:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=F9sQiOwHJX/Qk2LJeim2Fo1+N6N9qaSRbw1
	KOvcX49o=; b=nqSj7uT/ZhL+zRkLq8TM2vzCMdj+p4j9zLFtYqprvfNH8zPUOxh
	xUaUWj9O8rqIm4mlSwdC1fgW66gXhFCg9VSu+559x7JSoZK3AYxJb0n/+4U+P6UQ
	O35N+hR2r/YvUxv4R7myU1oISvuXCnebgWp7s/79vgwWGZaDF+wKHU2+3ML3UCaf
	ZRI/Ld+6MnkRpeTv3IuWH9MPJYL49xevyzR8M1yswOBraXLxIaC43O6jpZBntrKq
	Eii2iDvQbEZ11RETOKfdEnro+7NyK8jvRP5Hruw0z0MpR9DVtc/L7QnherDp5bk2
	eHnjOQAspIjIl72tNm+8KEyZNyGKCEmlgcg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrkt96m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 10:35:27 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82ce0a9e125so2961576b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775558126; x=1776162926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9sQiOwHJX/Qk2LJeim2Fo1+N6N9qaSRbw1KOvcX49o=;
        b=Yv3n7wQ6WzMH/56iz+uXqzaIK5N64qLH8j1PM9lEp/3Ra4O0DJ3XxP+nHoJBE8vlwi
         oGyZ29OfT1ww3gzuSblUwod/OniJMXUoV69s5kRcmFaiyCYQlDia6iG+FsyFaittmGkD
         fzLedeiUUxrCdFmeyRLO9noqYpLaB1PWcrYg3jMUAEiTQX5WWiBexvgfh3Jf3VcGSjVc
         92YeIU33bRM3yqFM1lEFkA8BnsSxAkD8QCCCmLkndZkiCTlI8vBgwhmjzuMDh+gttb8o
         S39NdLLmiVoELW9D3lEpaeuqUQp3en2OvlFzCC/Eq4CfELl7VB40uvgc01/fzVky2KwQ
         nhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775558126; x=1776162926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9sQiOwHJX/Qk2LJeim2Fo1+N6N9qaSRbw1KOvcX49o=;
        b=VUI2CQwmLEn9vGMIPMQHzAVule8y3pXyYN1aPm0o5sZniLMuX2WBQntST1O4oiel5y
         PBTWa7DusZALmLij7ko5Md/QWptGVl6EyVePTC92zizCB2WBA77HBEauG4BGoz+lG6DQ
         rw7WqOWr+qDYMz5ed2g8l3WpOVqwCFjE78Cx/9b8iVhHLQExovG5XegIrSFG0KHiyVTz
         hWIph+kLvDoSAHmflqAvugssgFY7s/A9der1qQCY7F4FAUMLRVVqGseQfTnD7/tG57iH
         XBQYQ4fqoxf4fMHa6Bw0PZ2bmJtXnv43DTkdraYGaumSr7wdK5hPXS8jo30MImejTrOx
         gH+g==
X-Gm-Message-State: AOJu0Yy06GQMYiaWCRP+he15aYaZCY5XFIKqmPDNtazJira+MkyBxWZs
	K/3d7psXrxCbssyBFMaAA6gBedatt6oolWRVFkkb4saWdNyEHb5ezfVlGzhTsOBB6Lcce/GH0na
	n/8CjFO87Owwf8XuEHFdcjQy6z/n7CP2fFZkqfWzZfTFNRYLyZ0Pl8ulGxYACfFCNFag7H27B+6
	mnxNQ=
X-Gm-Gg: AeBDietTtb7oEVkgUChdlvNwPb0uCKdeR0m1D9CJ/87uSvBuFiQe9zRln3fZs82hBez
	zUBn1E+thLd+Y44FAdC/xSAApdsTxKOusvIOQbHFRomljNEA2wA7be3Hn3FWIq4OROvXr3vCuCU
	C2rwS3ZwmajZWS88W8eFxU2WqaCIgo257RE5G+7nmdzICGU/KYHYOIJbwpGtzQGBc4yLjSDe1AD
	tKOCi5J4aTtlzn9wRv8kJvN9pjN9vKa1urjQTfRnPR4c/QR4zs5q2dE3PbUN3A5hcNoezs9P/Ay
	Tiz4ZM+QjfrrxEB2q83I5kwk2jtT7zooScGXr5Y4TuOfm8mMVkpS9hONd/3FUnuOQ/axueWF3bA
	EvWyNHEKkWT3qIOT4Br8quBcvNCOXQyj1xnCbFI+vKZsdhYwJH7I=
X-Received: by 2002:a05:6a00:301f:b0:824:a1c9:8a30 with SMTP id d2e1a72fcca58-82d0da8f3f1mr16442511b3a.23.1775558125661;
        Tue, 07 Apr 2026 03:35:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:301f:b0:824:a1c9:8a30 with SMTP id d2e1a72fcca58-82d0da8f3f1mr16442468b3a.23.1775558124976;
        Tue, 07 Apr 2026 03:35:24 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca14b3sm19575136b3a.54.2026.04.07.03.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:35:24 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 0/3] Bluetooth: Add initial Channel Sounding
Date: Tue,  7 Apr 2026 16:05:13 +0530
Message-Id: <20260407103516.2371804-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rrz16imK c=1 sm=1 tr=0 ts=69d4ddef cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=JxoTkb2ISLZPhhTfFPgA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: TESfGQahFwidtbaNAAgQJpX28G76ZYbY
X-Proofpoint-GUID: TESfGQahFwidtbaNAAgQJpX28G76ZYbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5NyBTYWx0ZWRfXyCp/mOK+eFAE
 25ofDLINTeaia5tbuJpxkAhE6Vk/gWmAD1zDdia5X8kQEa59tokwp1a9syf+JEbBInWBXD695fn
 /kEWDnu0+g/GEFq53rF2yGY+KkkzrsF0hWwm9dHrsG41hvBc8pfYzlOn/fxSlyqQYXzl5wMIjAi
 2g3rtM9mZk1ZXrftI9nyCM38ZfFU80041J4521djDymg0WII2iKVmQOyd8FM2FALw3b7fkZqGJ+
 1PQ3NVkof6+LuHas7mbAfaUtRo9FPd3tO8qL93VAD2wF7hACpabVggPUFv/x9x7c1Qi5Ly6CnT2
 pc8buQCMqO0eYndtjU5PnGPspOVFumg7yy4SeODVxqbmBf5Gut0m9WwE5BJIQKNwKIcF1SX8l0N
 Xow4bQSodIlm+Np61fy/BNJZQAwiSVreFVC7PiNcf+9HwMyxAV5TIK56DTFykmD+3Za3nXz17w+
 tF++uW4CrL7aRwcnlgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070097

This patch series introduces initial support for Bluetooth Channel Sounding
(CS) using the raw HCI interface.
This series lays the groundwork for CS support by adding commonly
required protocol definitions, configuration parsing, and event handling
for the reflector role.

The changes include:

  1) Introduction of raw HCI support structures and callbacks for Channel
     Sounding procedures and events. This provides the foundational data
     definitions and HCI subevent handling needed by higher-level profiles.

  2) Addition of Channel Sounding configuration parsing from the BlueZ
     configuration file.This patch also updates the systemd
     service capability bounding set to include CAP_NET_RAW, which is
     required for bluetoothd to receive and process LE Channel Sounding
     events when running under a constrained systemd environment.

  3) Implementation of HCI LE Channel Sounding event handling in the Ranging
     profile for the reflector role. This includes opening a raw HCI channel,
     parsing relevant CS LE events, routing them to the RAP profile

Patch overview:
 1/3 shared: rap: introduce Channel Sounding HCI raw interface support
 2/3 bluetooth: add Channel Sounding config parsing support
 3/3 profiles: ranging: add HCI LE Channel Sounding event handling (reflector)


Naga Bhavani Akella (3):
  shared: rap: Introduce Channel Sounding HCI raw  interface support
  bluetooth: Add Channel Sounding config parsing  support
  profiles: ranging: Add HCI LE Event Handling in  Reflector role

 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   71 ++
 profiles/ranging/rap_hci.c | 1288 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  129 ++++
 src/main.conf              |   24 +
 src/shared/hci.c           |   67 +-
 src/shared/hci.h           |   12 +
 src/shared/rap.c           |   46 ++
 src/shared/rap.h           |  174 +++++
 11 files changed, 1805 insertions(+), 18 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 
