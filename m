Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873103E6DF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053182; cv=none; b=KXWTIjedgJYtNpkvXlwNqQJEK9VzBoP172kThs9bbB4I6MNyXGtqrObP8IAJJ2+nfROBlpe4U0OYaWM03KsWhGCeorAVFNNfseXnTIbPJ0eSuNRd+HZzzHIpJ30nZ6GfSOd83j9ice9e7ATKMkK/GfoJb28S+yxMLjVNAtBTjFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053182; c=relaxed/simple;
	bh=oW9WWYXQc+NwTD/DekiSp23YkYRs/tKoOsp08mL5CDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qTnh6wlHVGQQE0n3sP3nT8HaMgIMbTBpicWmk+FTFysUNvh7zRcjEyaQ5zhTexG3FBALqV1dG//e7Z7qNdp76/wiNCHK2Uyhwu+LhzVfh/AjMBmJwDVt/IlpmWZlYlwUHfk25qZI7eeqRN49aFeIlB8MOuRZo5x6OEFYo+uhwDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5JC+nbY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JZhFIcgv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5JC+nbY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZhFIcgv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OGv1em1046032
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 17:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SZrBxgm6kE/5Lipnb/MXtjXyLu60D/Z9PMm
	SWFdz9AM=; b=F5JC+nbYF26U276Owu3RpSA8U5yZvqgQb2f/JiUcEEYBguRbV/8
	Mfok+2m1wLeAampJU0A300x0L99bwfyK/XK0OnTxOP8918O2mN0cXtCZXHnzrOHh
	v5zpOYMiEeQvpn4Ch7D6UKDbcbhVPM378Oubp+wtacMjO68ogWM7y/7mt2v/sgDk
	ONRLHWBcGzuNMA5oqwUaVT4vNCXTSLn0sy64qyUexFa+ByGQn2meiKkUxC07vS4P
	oGnmHMT3U6mF7A6Y4z6S6Qnszlt7DgvqLljDe+dK8idVb+pGI1MuP5DysEMw8gLn
	2Ln09GAumKMkc5RPBF6bf827oZGTYY1wW0Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drbr58fxp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 17:53:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24611696eso56807965ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777053179; x=1777657979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZrBxgm6kE/5Lipnb/MXtjXyLu60D/Z9PMmSWFdz9AM=;
        b=JZhFIcgvqlQkbEMvwEEJvy3kKhYFgDr5v4sFbC3VIKz53lMGIfOR0YU0Oc0Ra97t+e
         W+preVbbUDSCtAETj0GXHSK+uAKIo9PPh/0JeL9et5IIWZRh/32s+kAjd7//4IN8L4pQ
         WPPDffJfxOAw4Te4EUf1GI6PIOLFvPUFWKswp0BOW1Yq/Qtc9LtZjF0vPYAB8IMdA5wC
         pqvC1y5KLJ1wWn2kTvPIsHJtnkmppjHWiJnQ5SgHHVgw2yhGL8q+U+3nlTSioCMhEZ+s
         4TqCYiZiJko17L3MQlQiqcmaPvMZuG3Uw/ZI6jdU+eP9+KiwqYoIMVr7szDwGmPi6v6k
         D87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777053179; x=1777657979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZrBxgm6kE/5Lipnb/MXtjXyLu60D/Z9PMmSWFdz9AM=;
        b=eychavMHduRkgbUHnJKns/PrdOwfl4lPoVtgKMlx8HcegMO/9BnNrOfleAStO5M6bG
         +91R/BFXz/tgZR/HoLTWbGDqriyQhq/AoykW27BagGsbirrLm8tYx/Ut+CuYe9jbJ4jz
         Kzx5R62sGBVwkB2NeGmduQkfyLa5zstf9x3gQhiz9hR2W3uwFKZoe0vgWqoCbniNc0kU
         L2XDTAaZgfESmTgvRgSflYGfHNsTe/OVeqpgYIO+3+rP0YdtOMhmFsiBaQeii7kKHv7s
         7rPsjUC7vS56NKm0gEKs3MoRadNWOpCFhNjeZVJ7QhmRUMWgYzaWLuR+ju2MfcXcWOsE
         m1rA==
X-Gm-Message-State: AOJu0Yx/9COKQUO6EwCMROSe/7r6FkNMvHmsc2vXQJ9QzqEA0g3uEu96
	pXDQszJ8fl2ZsXbxBwJH3jAvyPfiE3ovgkgv4EaImRTA6nn+oX3NrS8U6EaiE7leri1xD04mT+3
	lxqqxDblMCF8PgTY1PwDoAYM6MpevZGc+MhEBnkL6SeKZHekqfPkYX1SEcsQ8MhQrkleRXuQp6p
	JTK3I=
X-Gm-Gg: AeBDietBuzbXr7GYZtN9gTy1WSSWJdS2vUVd6vQOUL2ZPl2MUUX0iqd8RbFHYd7UW8W
	M78T/DHHR2+0eqYs4VEnyWTPBfr0tpKFCNfsfXCW6CSjPubZoWtTf8M2RsMTqv/ZEqZPaYCQ1je
	cNsskm9OoiLK5Z4ldDjKa4cGWmK/bYtpu7aCHYhITXoEAPxbLEmL+deCkV4BTvAcYmX/fy86iCi
	HFeDPQ/xEQxR269yOB9gflOlUbXPIfF3B/l5HNB6tOb/2xwdldz2O4QMoB80Dk8XY5VPtSf5qw5
	x9wolyjndLba0sFFcf+sKDi0Ni3VavQ09GnBpwKxa0m/BBY6Knfahe60ppR7TipNl+p6cV5MrG4
	/qkE77rFEYSQsBqZlj4ZfMUwPhk+HN6RluFlvAYxjrfyGiO1UNLLyEw==
X-Received: by 2002:a05:6a20:3d96:b0:398:7df5:2dae with SMTP id adf61e73a8af0-3a08d692f88mr37894236637.9.1777053179213;
        Fri, 24 Apr 2026 10:52:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d96:b0:398:7df5:2dae with SMTP id adf61e73a8af0-3a08d692f88mr37894207637.9.1777053178672;
        Fri, 24 Apr 2026 10:52:58 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797702fbfcsm18593820a12.22.2026.04.24.10.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:52:58 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 0/2] Add RAS Packet format and Notification support 
Date: Fri, 24 Apr 2026 23:22:52 +0530
Message-Id: <20260424175254.2905834-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NCBTYWx0ZWRfXxSoA1oEqDLKy
 0abJkjyLprfihMUeAj4ROQfHHmvpUM7CoyIZzSxC3RJld1YtogimIactTcedK1KHx6bcaVI6nTL
 M8m1DSgevxbLH0mv77jWY9lq4ll3CFtljCdFlVKhCTjazQNUBrLRAJK4WrDdn5huOXw7QJbg3qb
 DwyKilcl82VSA7LQDBWNkvrdJe2vDmvLX4B7E5TRMFw8PFe6L9hAo/dWF6Wtc7pxej/aJLhEpTN
 Wgn7Xo+VLj5S7ojBNS3x05TAiyTmP/V8wDcehDsDViSGuMLDdEmVvpicrgzczaQxKk0nP71zMCQ
 /lo7Ea2WZluNGax6KuTUA61+V8OEM6CIqFw60m4rBIVHV//AHOuV6G2Wr0CL7LoEKR0Z0nDVPFI
 ZFqsqpCfPVGdEN8f8BPRex7d5RbUm04b2OFIZdxSHf4SfIcqSUcJzu1ZswAQz3MwtG1GvitbRQh
 MM+ETHlpQYKlHCyAePA==
X-Authority-Analysis: v=2.4 cv=bftbluPB c=1 sm=1 tr=0 ts=69ebadfc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=s8PT3rPj7hFzI-f2jtwA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7d_oqoEEKlrxLlqkJLYemNaifUF9IgLo
X-Proofpoint-GUID: 7d_oqoEEKlrxLlqkJLYemNaifUF9IgLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240174

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Patch overview:
  1/2 src/shared: Add RAS packet format and sending notifications to client
  2/2 uint/test-rap : Add PTS tests for CS reflector

 src/shared/rap.c | 1142 +++++++++++++++++++++++++++++++++++++++++++++-
 unit/test-rap.c  |  264 ++++++++++-
 2 files changed, 1390 insertions(+), 16 deletions(-)

-- 
2.34.1

