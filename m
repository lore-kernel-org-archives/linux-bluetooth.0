Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661154;
	b=1Lw0r9vjhztfs3pEwiWAABL+cC8FYfrSCbzZViVWlnJqLxrdKNeNeayPN6nI68x+peUw
	 96KxVaB0NHYb0Po0jPiET2WZgi+4/33P+tXlBVamQDUjGo+/ecXW1vXZ/0z1A5srxabWP
	 pZGfyFfZg+PkVCnRF8R6rEfyxn4MZ5J4781roIVbS2FbbpIgO/p+3IeYN9Zjx2yOhAC0E
	 eWIGDu548sLwDM+gUeIwVmNU1h048q90JdqtMcyZmM99prYVJS06vrNEp7YBiVui5tUfg
	 94GyXuo32QZVPtAnyoERtIhQffy67QK4ivD8mHykfEiJ6EXKQcwxJXsNxTybZwLwnjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661154;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TklxDO/8vuxIwyKbLePVne0Mzbleao5xmkDHCXOwI7g=;
	b=bJZ53ehKn+mMbcumslRfUDDY3xUjQtq2t1jEb9IkZA8CSNvM3szgHbmC4tbE+eDcNTfa
	 On3QxMrmMfV893LzJLqW7+x3wy2JYexU1wA21U0Dtq1X8W8tJxy9PaS4iMgda8MOxCqYv
	 wIlcvzOSOfuSKH5LZwP5aQ4zip9dgoM6SlIqfh5wceweKvHg4ilLVBTbS+GhBb8VJy5hC
	 5/NNpPszS7V1AK2j0oOap5sLfO6426wEHC47BJBaklfe0mmDhtUCy/hHkBNGyDnmzfNLp
	 E98hWtum7DbGMAA2D3hXCrXIuGPmVzPrOeUhhUW/EPDiNspqohGSqQv00u7ysRnvYVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gAtXxwHe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="cRxDp/6G";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BE606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F6BE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gAtXxwHe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cRxDp/6G
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJB1Qv1358012
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TklxDO/8vuxIwyKbLePVne
	0Mzbleao5xmkDHCXOwI7g=; b=gAtXxwHehVeum9vsRWPQl4HEobDfTOtN6U5InX
	CwaFjCIfxPr91dTbjGvMaoc+lEoHiiTJUdktQShyu2Hkw0W8z5Stq0a4Re7nHMLu
	VG0SgZx5rCeLtz+b5nv86Elvpbh8woex8/1/EPWYnD/eamlk+DKo/4qIT3S9CP2X
	RmEywq7TNNzarlAjDluDA38CGbNZJeA9YGwiFxXwDUtnwC0pG6C65ybf7B9dZ1rm
	N/0Y602uXUaTv8oEMi9J2LtQJgFxmnap/TLrtV2Vz+TgZte+3Tjr4bR3wwk1THmZ
	iQoPutv3UzaUVraGyRFJrIHoGqVgTYlSUZMtBeLCodNeF8Rw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5yaxtw0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 02:45:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-384b6a33735so749675eec.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 18:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795661153; x=1796265953; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TklxDO/8vuxIwyKbLePVne0Mzbleao5xmkDHCXOwI7g=;
        b=cRxDp/6GMSHWRup7cuHSpGpIsUPZeo8UeuFAFSBBw5WNrfLK6W9TON1WEwCaJeC6w7
         fmNuPwiI0mVMcTjzkC+I9mzIdq8knFU0gPiMBkWVsQ2r506zBp0HGwweATdss8MtxsVF
         XY3RAwi+QYFq8jLC0lg4ND8JEumS2tsqR1U9PEiAH8LsjN0xQiavNtR7ek/V/Uhcqo3v
         yqcvmhv5vScU0mSljYu/kzZWKRgdAYT1jCng686/2f6GzyzIonBeMTIyE6LZgGyHUDQP
         UXskPnO0SJ7ILOOnYnw1bmYo9fI9e40viHgtYMc4l7ogxJHkxDiFLi7p5h+wUM4L9pVT
         bTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661153; x=1796265953;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TklxDO/8vuxIwyKbLePVne0Mzbleao5xmkDHCXOwI7g=;
        b=V3zEGDTLO8oqpZq5oKMxY38t77TZIPNSOvoUhY/bn4p99Q42B52Ymfu5wXT22z0Jub
         gNy4Y5UjG5klWk4qQrijYtv9xjJwTxlK8J6V82TfXBST+6coA/mWGkvm0pJWTanfxvxR
         R0E03MQyD6sFbLtRMy2kWTC8N1YXF8XsBA7yZ2VAqCx5DF/P6Zacs2PlirQInA9Woz7k
         IQZuNsqlR9sXLaRGfhz26xA2prxUHz1Q06biS9bf4U0waTaA1wCnqe56m+G5dHgckIIP
         DkT+whkbi5TFTfp59CXPCIDEMi6Z44yED+p5cFPJWtLwoTEUIJ/ckiC/hUSoM2QEfn8A
         qtrA==
X-Gm-Message-State: APuU4Z9cn1MJfzvJV5qQqQMqXJxjPxups+actSM4pjDVm1s8qwveO5K0
	qpwFBplLvNhpc7bITPnfubA01xvK1amJfF1lKarGPzuHj6yyj79OWvEkeg12zzbqusAZwshWDOx
	jXFLffBfmIcgdXaJDDHenWjTerAQnJ5cB8BZLCe2TqEyjKcVjvUjfz1UhMClptSqnuLM3mjSl+J
	GilED+Pg==
X-Gm-Gg: AZFdTZcTZMe6VYWhdpZvMACuHl+0Eezftn1hnqq8Gxr3PLqaw2JgYS1UdNKV+r3rGwN
	dca+mwy5c/HZGgpuVt1D5LsmMRIivnxxgC6s15p08S457FuTxwKJ6gdnFxwYs6fMLHkKbYuH8M3
	dDIaK8DZ2FiXykka981byyXqVBNX+XpZQcq2v7QzO6XVaThTSqEuFWW+u2uGYA19RGbU2k/5x3e
	PRIwEUXMaZbktRMhFIq9CSg4RkrtrmEXYAQ1p+3Ta37U4vq4kHXniqBME0RtY3RI5Vc6/8lgh8m
	bYLoOCnx9SXOw3mcmkbBdsD1SC+TkKNSAGwmMRKvMZwGMVSauqCcgALDGAv0x5hosGQp3i8nn4E
	trLR+3aDAqmegS8/67ZgEKbp1RPA4SxjFyvwqysGEfBicyVCbNFux9dpWfD9px4vt/cmiXEDE6j
	uri1VB3hl7PKsovQWcm9+4
X-Received: by 2002:a05:693c:8211:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-3856e74909fmr31097392eec.2.1795661152456;
        Wed, 25 Nov 2026 18:45:52 -0800 (PST)
X-Received: by 2002:a05:693c:8211:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-3856e74909fmr31097354eec.2.1795661151861;
        Wed, 25 Nov 2026 18:45:51 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm16253220eec.17.2026.11.25.18.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:45:51 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH bluez v2 0/7] tools/test-runner: Add arm64 host support
Date: Wed, 25 Nov 2026 18:45:39 -0800
Message-Id: <20261125-tr_arm64-v2-0-4f02989f17ba@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOdB2sC/2WNwQ6CMBBEf4Xs2RJaKSae/A9DTFkWqQGKXWhUw
 r9b8Ohlkpm8vFmAyVtiOCcLeAqWrRtiUYcEsDXDnYStYweVqUJKpcTkb8b3RS6wOGlpNDaZkhD
 x0VNjX7vqClU30wfK38xz9SCcNs0GtpYn59/7ZZA7/m8PUmQiJ8TmqGtDaC6OOX3OpkPX92kMK
 Nd1/QKV1zV0wAAAAA==
X-Change-ID: 20261122-tr_arm64-c6751a5cf021
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>, Bastien Nocera <hadess@hadess.net>,
        Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: b_22fzSw1m6CSP5jgnWRqwWaT6wXbiDM
X-Proofpoint-ORIG-GUID: b_22fzSw1m6CSP5jgnWRqwWaT6wXbiDM
X-Authority-Analysis: v=2.4 cv=ULpIjyfy c=1 sm=1 tr=0 ts=6b079d61 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=4msuwhVRkFD0mJCEQhAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX1tVEfWEu+yQJ
 zbvlLlTkEcGQsUoZW3ElsLvvCEKtEYEmr9d8xoFRMJVJvmq9WiFMwaM6LfTzbsb134Bop9s88FE
 H5qKdHzflkXpp+Ki0SRpmBjhFL2Ud/WyDD4X/KGKqZ+sMoLrmO+yWnSvw4xhqowsdUkT0j0rbk3
 g9tUaX+L8soqWtmrjkzSN2aEYCTRJ2yTNoNUepIhq+fm6L3Ui8tqIDJXDaoXftyrMsv2ST4Z9Ut
 +u1uL5aFu7foKZZkTAFV/ioLSWSzvD4hBZF9rPo355AmL9QouevRPilM+EnD7yqo8oND9oatrai
 LaLVcVeSKOP2NxPcjdgXbiO9qjcKdUTo8ExTqXGF/Kw1cczvXcckl4YB4d4NOwkQcu5d203JN60
 jdpXk1u3qwPNqCgXg0D9PD8Hva2lVyFHSFubBpVyKuyO6iGuXUfkjO8JHyYwPjFnpPxHPToTSla
 6DuMbahnFQ/iwjZ9+mQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOSBTYWx0ZWRfX9a6k2Cu7jhnv
 L8gXC61elY+6DNdodTxusgBv2MG41a74zi4/pIlJCpJNToTQ74x23cyYl28Ko6hB6jNXBSOTEMs
 3boAFiJy1JlkLLJJWvVWBQHqUGDgaCo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260009

This series mainly:
- Fixes two bugs
- Adds support for running on arm64 hosts
- Allows starting bluetoothd without debug output
- Fixes two minor issues

---
Changes in v2:
- Add two test-runner fixes previously sent separately
- Add two minor test-runner fixes
- Document the architecture requirement in doc/test-runner.rst
- Print an error if QEMU fails to start
- Link to v1: https://patch.msgid.link/20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com

---
Zijun Hu (7):
      tools/test-runner: Fix TESTHOME parsing for short paths
      tools/test-runner: Fix termination of the emulator
      doc/test-runner: s/CONFIG_BT_HCIBTINTEL_PCIE/CONFIG_BT_INTEL_PCIE/
      tools/test-runner: Add arm64 support with QEMU
      tools/test-runner: Allow suppressing noisy bluetoothd debug output
      tools/test-runner: Fix snprintf(..., "%s", NULL) with -a
      tools/test-runner: Fix spurious 9p root mount error

 doc/test-runner.rst |  41 +++++++++++-----
 tools/test-runner.c | 131 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 129 insertions(+), 43 deletions(-)
---
base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
change-id: 20261122-tr_arm64-c6751a5cf021

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

