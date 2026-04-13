Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8503370FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076896; cv=none; b=BgdCDJewpBXH4wWl3XFANQX0UF9bN12MdXb9nRqVOgr8oIYd3VZBo57EGT39H0Hdo1Lp8Ne4ELz0baVod9QSTitrYg89IJmlXXCwo3+424pzfj6PcF6Xnxt9YXv7/+utEl1eNYvttpzcuK5fFG1JUQcUoGDOTwOb0+JkyzR+6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076896; c=relaxed/simple;
	bh=zCGk9b7JybZdYIWcjgeGv4lQZ56mwe36db21m2haWbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijygn16wb9Un5c/S3EUlSmRw/0cObOvHLfPRHHCCzUb4hiyu/Qtp8XiYI3IvZIOIO2jw8ZKUOc492XU/IotTVfAi5nvp7DLL70p8DgiMw8TKnU/z9ZLlGcx2QxGJBVv/D1vxusYGhH5fI70ttrpYJUGvpUlouaLEFjt7XplFOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DkJo0WbP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jvNr4z2G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DkJo0WbP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jvNr4z2G"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D5MtO7531190
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=d18daCGlqX+8Vl1EAiWIkoSeijAZx9lNHMh
	UGDmzvzc=; b=DkJo0WbPkmyUzEIUe8QaywW9fJbw5K1NWlMVdoIginlmlI12xrm
	UGPQHQ8rvXWf8w5oG1mYcERCNwK84gL/h5IF3UCwy1tQkQw6Ddzy0k3lIFCwyvwJ
	5oDwegQ2FEdu2qpYwvGPSv079ojYqHOieseh0fB/uUDvOZUkdN13dJ4qZpn1YzVs
	gAmitOszR4kBE8I+e9Tfi7Y4rQbj47zustpjkH4flhuz58nPacCgje0sMK+pZCGj
	KZ5zUbiN75SNtzGRJnhsARPPaiYkiqrqz79S0aBmgXkkHI49KkXOe947El/Dt1hH
	tmovEv56akx+k/sNLdajLVQxyUoZP3iTjJQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2bcx53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b242b9359aso39305455ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776076894; x=1776681694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d18daCGlqX+8Vl1EAiWIkoSeijAZx9lNHMhUGDmzvzc=;
        b=jvNr4z2GC55VaVL6B7j0lCziioQqhX/nCx5I8/k1qF5et1DtjUh/24/p5q79nQnmN4
         N/lQ43idrZPLK+uH2YvGybzPnJ+xtmHeSs6TvDJDPo8ZHOJpPRr7WPPZfx+JC4Rys1eb
         wyPlYZIwYz3LUYWQOeH1BJn6qrXCZpP9qDiid+HhFfjEfkQplLM4+0A57UTIa5DfhFrl
         qZOBeR/SKr4AnadjFOoet1Q58aF1/FccfOn66vxtcdjnY7pOVLYi0TDUf/aF+MPBRBPa
         OIoe3OPldMpQNjITKNiYLYET5nLsyzPYgHtTXdng3/qasgv1TcnYiTUhgZWb5ac3xUVw
         Fy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776076894; x=1776681694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d18daCGlqX+8Vl1EAiWIkoSeijAZx9lNHMhUGDmzvzc=;
        b=VrcsDpJcYCzcMEabfCp4hno3e4+PebqsjliFqCYBwZbgaSdopMlOacSy9J+5RRB5h1
         9fQR7CwDwHTSd2XYbJbkj5/EvhCHxT6ueZvxeTBKCHYWmlaIt3xGecbwwTfQKXkL/vz9
         BeZJ+GBeg6am++WFdwVVf8OE8MijqSXcD/16OCp9nu9f+rIx3J7MVYf1gFPps/rlhg65
         1GUkC8hEbqF8LtuBkYLu49wm1lYjl3Xa7mVJCaUs+lYEhYAFHo96fXewliUga+7usz08
         a5QmsC+O0TXPWkGTGPNc10DGo9JCZpEtVw/1+Anhn4L1WmB8J7MHD0ogEN/W6IRqMvQE
         7WEw==
X-Gm-Message-State: AOJu0YxQLpz3/dLiQpO0EnBRiTqNiUZ/6TP58RCI+Qo4gxxpo0d0ukDY
	Dl+XCOCPc7lgPUuZDFBgx1GZo86xV2c45dMRHwNa2ogCZBETQ4vrjg67WBhuECWFZLAn4lelsQf
	1YXw6Plx2JJxI4mFx/lu7jmZalYTKJOF6ei69AUQ0Tg6lvLfcGsvZoD2WR4NHHEihJEQUTpaSDi
	/538w=
X-Gm-Gg: AeBDiesbQBGgj4Uf6vVrnI7vnlo7OM0mhscHpSzRxZSoCKzeppXKExMvKTvYXlcofZ6
	V6Htu3bHjVhm36SO9aeBRyvlqH1jgzqYGU8JvBkhIHdOeXkk1l15G764G2ctp6QPbIlXTNU8pIN
	aC5pWu26rCikomfS0QApmhmKxSIYgeRz/tXvH0IGM8jJ5bgAewol01gjolOOkARS/2eFYEHjh1Q
	BAfL+N7xNqP9REMx4yCQiYiDkbH6G4E1eg6NM4OAByDMCDDEatwStro5BETDskCDtb9VV+/5J4T
	0yl3KuuxYoawxyF8ALcNyBiYS35H45diJlca2ktYyZBxMZ0n4//RyLLvtrwH4IXy+jer4phj4j1
	4m8uOoLkRIjRiTokztTpKeMSad3fq+q4l1+u87biT1XOTMA3Foqc=
X-Received: by 2002:a17:903:1b66:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2b2d5a18e13mr125262695ad.22.1776076893782;
        Mon, 13 Apr 2026 03:41:33 -0700 (PDT)
X-Received: by 2002:a17:903:1b66:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2b2d5a18e13mr125262425ad.22.1776076893321;
        Mon, 13 Apr 2026 03:41:33 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4e0f909sm144495055ad.35.2026.04.13.03.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:41:32 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 0/3] Bluetooth: Add initial Channel Sounding
Date: Mon, 13 Apr 2026 16:11:13 +0530
Message-Id: <20260413104116.1605357-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwMyBTYWx0ZWRfXyq8yfkCFSVjq
 jlv5xX4gOkVBoX8yXJpTwjVhrMuFOiUEEXH1Z/0vww5abG37rcphxJzjTr7WSJTchCik0RACXmA
 ggwq2TqciI99mhPE8u53wsVIDI6S4LoFNdxY9BgV1KvXQ1425Uz1Fcftq7FJEilXx770V5sD6bQ
 KTLUoziynYlP26V4DMwD5z/SdRWdM6aWRfhdo5tZpceF2A/ksAXO7fOoNIrYrNz/2HadGSwO8pV
 taf9iFC9SQC+LfMYHZqaMBlWoWRZaTcvqD2ZqJ4qPKoZ3OqQhYihOm6LjvFHd3o1245tLhQuH9K
 2F5bKyDu9ZRsJ3yUlsAiDJ76ee3UlGIivL2KtX/QQzIf3k+OC4sw8nqCMy72UOWKQ2c+JMy9964
 c7unvQGscR7yEvfcTuGlwxyr0lI9NZjmviES8wBbYFB2yKFN8DSFIrAlNlxYC5+SJgxix4VONRr
 MAHEl93wf9aaSTileOw==
X-Proofpoint-GUID: KcW6Rtb68EhAfYqO9z6dWIvGraADnii-
X-Proofpoint-ORIG-GUID: KcW6Rtb68EhAfYqO9z6dWIvGraADnii-
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69dcc85e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=JxoTkb2ISLZPhhTfFPgA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130103

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
 profiles/ranging/rap.c     |   83 ++-
 profiles/ranging/rap_hci.c | 1288 ++++++++++++++++++++++++++++++++++++
 src/bluetooth.service.in   |    2 +-
 src/btd.h                  |    7 +
 src/main.c                 |  129 ++++
 src/main.conf              |   24 +
 src/shared/hci.c           |   67 +-
 src/shared/hci.h           |   12 +
 src/shared/rap.c           |   50 +-
 src/shared/rap.h           |  174 +++++
 11 files changed, 1813 insertions(+), 26 deletions(-)
 create mode 100644 profiles/ranging/rap_hci.c

-- 

