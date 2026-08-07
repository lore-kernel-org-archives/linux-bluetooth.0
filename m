Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD911332EBD
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118632; cv=none; b=IxWhIVmKamL5VTICbfyq8xC41muVj4hzkA0fJdNYRJ4WIuxDKDj6UEWnJTEtKvCl9TZl3EBlw7r6ukJOeC4sXHip/G30NJtB3IeUO7C61OhHCbaUIFbXWMoAov/QHro09EyCCqiGqqsYpZqOM/Jm0mARRU3860oRUyPlPjrtTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118632; c=relaxed/simple;
	bh=Vy446md0FZzsKSLHSGCqFgq0JPhczbhlwqwjtp+O7OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feyiYBZ6ZIvbDLJdgnN9WOBnDjKaLxYQX3ux0lX2Mnaj+aKVHRSeZmr05FKkFglg/R6dqU7GinwqERllMGNnuUyeURxG8oEZCQ2V38oyj28PKzvvVa4QfNl1gueprwzmimVPyHrSEAFK37U+twoA4x4x/E46ESieAVJJq8Ckq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oz/U1/nP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YlpEwh3w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oz/U1/nP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YlpEwh3w"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRcbp1062581
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Aug 2026 16:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7BmL2BHvYb4YWV/79EEHtp6QAQua8TdbwCq
	5iLYygT4=; b=Oz/U1/nPDgKb1bRZXrA8FBH64sPIbaDWbpRfbxLEHiqdhQZckSr
	iFm8G3k1WtBqRlV+vTzIgeC3uO37AGodvdAJ+JEeebXw29gDaCg7GvJXVi9Ww5cc
	OZKyJpMSh4tJOy5lHbKSEJPqiVR3VZIa/SvcyGfi7cznT+9o/jO71dzZpRHExe/y
	tsI3rf0MjPmjak2tzIcngpud62OXasGGWGqgjPYWMbO8qhdgJnt6srXPNsTTAmoV
	NL9ZDeunA4QJ8DQoJRect1a95CMSG1Z5zRH4XObaBLWf5ZmvtnmWDx1rQvfiS6ck
	JZnEnORuf1Q1Rgyi7Ql0HBerH2nH8k1SqYQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcujhj0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 16:03:50 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c0fc9b4f43so3361601e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786118629; x=1786723429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7BmL2BHvYb4YWV/79EEHtp6QAQua8TdbwCq5iLYygT4=;
        b=YlpEwh3wr4oaoeFnJyYNprmJkvoDoIxH7bsYXHeqXygl9roKlwh/YgLOjWglNVNU3W
         OVj2HFmy8e0Dq2UZhdLT8gGhT/bsbUKUuPR+1To/oAlgf+/KDGCB/nia2BxQwKHBVrF1
         Y7MJRGHpKrJWUg9pjE7ESFaCH1ExB51xGwkBJqfZmV++EwkleHWUySeyfYVN5gP015lr
         pW58z6sMkiMSVMJagWJj9Lij11czw2F1QPJNUbdYy9Bx5cDvIRbPrf3rYLxQO0hpO+st
         qGfYc2ZA5r+gQHBC0kO/UU3ELKE7o8w+CcL2pz5HOJaaoViJpCRZB7piZFstyi6eRKwS
         Ye/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118629; x=1786723429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7BmL2BHvYb4YWV/79EEHtp6QAQua8TdbwCq5iLYygT4=;
        b=MQkT4+G2GhIK2++HqZfjEerY8mfc1htT99ycoyGNTXp9ZTVNhLo7RBSHEqOAKZ8oi3
         eMdrurTgSmd15qcf2TMQJUhsDcrUqRdvEtJLrlyFtI6ThoCWFLrDEnNYVYMp8+4MEkQ1
         iP/hmDpcIyx33KhvthljR+oUOOs+YdsAen3cA8Sc0qq1s6kH95aP01ZGB6jZkSoroqrt
         uLZDrgvNLkTpJZpd1D5ZKGfeG/TEIv2pFYT7CC1dcPmywywSXm3N2EO6D/MmQNzEcrfZ
         stPvLF+Ydi+a3Pl9xGjVhpFrD+ww39sf+wlXZP6PV6BdjySgm2IjqvQ1KxJrdNEslcUn
         uVrQ==
X-Gm-Message-State: AOJu0Yyale96beO66fnu+rmPHQS11zQZ8ieWEIyts3yVsWAtI9zEYWQJ
	Rh3n74wX8jYY2omIrmcRuJrqzvtPVxDAazrxSP1pu4Uy6HL6SrTv+wXN/UYfn9/Wh/1ZWbPNa9H
	w91DANX7MH8s8Olt/xZISOi2WCyE8PPWha4E7UA4OjzQDfqr/JIVbJWH3jGBlfE4YzQaXwmc=
X-Gm-Gg: AR+sD11gtT9OXTW5ZKvsw58f3w0JazOFWqZQr/yth/HASI9adE2scZ55xlTsDZs+cDe
	cVNqA7WG9eqE36UlO3OD8IpWBtlUBznQgz4vq/ZZyRot221wEwzCkoUBklGs+2JAqjZZr/NKKw0
	I2RK8wyFW/DuuNbIxL1CiWQzoQZ2NMs/3FZDDSBUA88OrnbXZ7LX8PznnUIUEy4C74YR/0PWjHb
	JYjkxLgWmATFp07avAUAongvVEcICKD88O4ymI9UjR7TZI+6v6uG4fkPYRNZhezVVqZbtIpVDOM
	D4LgIlV9axjgozSeWXEDfLOuJPnz5NyE4ZHhQD+j7YRgm6gCN++HvSo8q1au+QYdicnc22ARZK5
	3RgNVaCoqLq83aslOLA4RkTSo6lCSgJE=
X-Received: by 2002:a05:6122:9002:b0:5bd:ecad:8f9c with SMTP id 71dfb90a1353d-5c411359706mr356457e0c.6.1786118629082;
        Fri, 07 Aug 2026 09:03:49 -0700 (PDT)
X-Received: by 2002:a05:6122:9002:b0:5bd:ecad:8f9c with SMTP id 71dfb90a1353d-5c411359706mr356416e0c.6.1786118628612;
        Fri, 07 Aug 2026 09:03:48 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a2b1f1sm71367466b.12.2026.08.07.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:03:47 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 0/2] Bluetooth: virtio: improve RX handling
Date: Fri,  7 Aug 2026 18:03:23 +0200
Message-ID: <20260807160325.1921-1-igor.skalkin@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX1Q3zjfLd5daj
 wbubOkyCh9HLs/H+fLW5y8gSRVgzH3sC++7fd/dPuIEayQPEj9VMPS05xX86f5rd5/s/QLijM1m
 y/JxjsnfZmZPzgHxYJMWEyIiDo/vGWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX9n53eXplcWEQ
 P2Pes/Mjnv2e3FLMSVTnkphso8NtJ3zPDNJtucUHGyTul8CumSHQ0TiwubJwah+RzzfSu87RzDm
 cWWOeqOR40unI9qOyU713Q2ff9zABmIJAvFi8FE7Fh6MuMbkPiTW0lsjWKyDgnWLtpxUk5maCWY
 qyLOwCsEALRyjJYUH86LfYtA1jcpjWlnf8jyb1PkV6Ur/BHGDS/67QacN93w/mZCuETO8D9ZCPQ
 XYQCwU3xtuId7AtpG+3Eb8d9UpWRGXtOySAQxrbm5Qk7A3R8BAaLUAq3qcJ/vKdJx8mQjgijaj/
 bsKEnZlT+A/XdPv+icUQqPHnygb5iynKAqBxCPO1aBlVYgpUsSnIe7v1zBGukbVyY5qZfCSsQTn
 a8FckEMwflc9bH4nIKGFFsGwGN0XJt+d88iLTt7nmvUKCuDFrqVnID89YGKDin5GEJQ/xFbXHv9
 WVALP1MmN7xzVb4cKBA==
X-Proofpoint-ORIG-GUID: GnWXYkkPp1MYqV6nHMrgrDDa1yM-VxMm
X-Proofpoint-GUID: GnWXYkkPp1MYqV6nHMrgrDDa1yM-VxMm
X-Authority-Analysis: v=2.4 cv=Wssb99fv c=1 sm=1 tr=0 ts=6a7601e6 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=qT4t1duR93UmWgVtNGwA:9
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070125

This series fixes virtio Bluetooth RX buffer sizing, then reworks RX
processing to drain completed buffers directly from the virtqueue
callback and keep the RX ring populated.

Both patches were tested together against real Bluetooth hardware: a
host MediaTek USB controller exposed to a Linux guest through QEMU's
virtio-bt-pci device via HCI_CHANNEL_USER, not a stub or loopback
transport. The guest paired and bonded with a phone, ran SDP over
L2CAP to resolve its services, and exchanged the resulting HCI/ACL
traffic through the resized and reworked RX path with no drops,
crashes, or warnings observed.

The driver object builds with this series, and each patch passes
scripts/checkpatch.pl --strict independently.

Igor Skalkin (2):
  Bluetooth: virtio: fix RX buffer size
  Bluetooth: virtio: process RX buffers in virtqueue callback

 drivers/bluetooth/virtio_bt.c | 139 ++++++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 31 deletions(-)

-- 
2.53.0
