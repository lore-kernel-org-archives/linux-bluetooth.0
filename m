Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197144;
	b=0nzzIz1k3nCYQ4OLY8fzmHMznbG5wtITEr5EBybFRhK2AuuqfBcdKjMqS7gftC/34r3B
	 +F/RTdXqienFlszlopEphBZ8kaOyZ5Nogff8658Vr9YXhOmLkx89NNRudTj+MeJHHu9C0
	 CZnxHQ3AtAGUcp50RU+cN4We3ItZffKxFDxt9yp/t7mB9J0U0W1xx8cC8Dg7o4zGChLwP
	 naHc0dbEVedb0Thsgv6IMb/zF8N0BhCvdn5lRxW4pmV/1Q0xK1hR2r3xEXY1KzR9DqoaL
	 CzF5htfG+9/69hqxdX6amtfH+47lSoA2/DBHDA0ROIlBuaZA0g2FYhrE6Hmqwyrgf5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197144;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vJcqemAVLZEHHjqG5FdeoT2RuY6git3ZTy8KuOQKtb4=;
	b=RQuZg9S1DSM3yI/hgmZIJUW3FPkg7YG3HMLw4ERpmD7JDBHMTEurO+390BHG4sEF4gX5
	 660nckZ4fs2j56YTzK2jAt2Na6DeOqS0RF6Tt9qtiLleBgIIo0G4lv+Gd6b6BCk7TiJrW
	 KUAOJntvw2tUkCt2WQyOsfmsDZnMCLt2sResNmqpLkfox9kUdjUkzSBIWiDR/PUlRiZjZ
	 mNxP5eAqaMfe6Jouhl7kV3kbHEZve/Kk5lnoF+4x46orROf1SNnZbpiBXTmWwil+rxazd
	 j/wUmVJyeAEvRmnsFiIzvqy+SfrQ+Npap+nm04zKJ+dvhvwZVpsW/j8vUG8FyVrPYdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAbfw0vn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sg3pJ29J;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D41606A322
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D41606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DAbfw0vn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sg3pJ29J
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBdsVt1011769
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vJcqemAVLZEHHjqG5FdeoT
	2RuY6git3ZTy8KuOQKtb4=; b=DAbfw0vnINYnAreMLLbRIdLi5J/Htmu9L5hFbS
	Afatuj0XQ9NMh/ZYWe/O6er9r8kqZgjWW160Yci8+G3Q+stYOWMZc1e7pGizQNdb
	wTmSty91xH8hm/+xVc+BxqN7d0oJi2VUCf7Urqd/CjdlY8w0FijIfdIcNgdIbKo0
	KBDGvGaeLqI55BcOrMkPVLaq4yoPr5LVRqZQ7wtFWBVdKW5zHqpQRNzpUvqwScV1
	ujsk15dSxB5ajAKcCkjYAnQJ4SlFP52+OWB90oBBRV6XztDbiJpVsfdlW0P9SU/q
	wNDBA2iF00ED3ekcadE3mWuKAnWakhQhmE46pQie1JPnv1fA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkfehgtxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:19:02 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-82339aac413so234136a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793197142; x=1793801942; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vJcqemAVLZEHHjqG5FdeoT2RuY6git3ZTy8KuOQKtb4=;
        b=Sg3pJ29JpUA7YO3pzRmjQ1iCPlhUOWoYtreYuczxhnTG/jw6Dq2BFumeNOtIUFBB6N
         VknmNSWkvJWLHeuZLcViTfY/qQB2hPD56EKxyhvgZb5A4+WJ2CMWbGivMl/t0RW+BJCQ
         yitivjsSweJjmOXuug0qdOGfYT4ZYdP+XHykKqN7jeC0B14hEEtsikXHbWZ56rJTDju9
         MT5XCtD/6bC5+mL3RxUxeA1qf9lVt680Sdi6dP8JdMP6LZxUfWn7MMnZ+dMMifPKahJj
         jcp3LTKgQr/84RjtwzKtBaG9ghogXucH55hOMwrYe3++B8zp2V2FPWrP0YpG4FedFCa4
         lPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197142; x=1793801942;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vJcqemAVLZEHHjqG5FdeoT2RuY6git3ZTy8KuOQKtb4=;
        b=gQvC/HCP+bWZRcBMHyMc65GNYNAk+ROiz0IVIJHcZ9U2Qgnc2UchFuHRRBvLPO9oIf
         cr9ZO0ZENx1foFyRueVbrff8siTtWRmYhoBaHSAj/DOfi/ZQkyDsmfK9vVojrNRTtuBj
         JI3zr8MUOBA1Ef/tnKFaLdAQEzCZwn2Q3sMSVD+lgrRP5K6c4EM4qBLiKvx7LpoZi3PY
         0d+Y6JcYRzcRedkcATGn8/Ojr05zGaVM0Sr2cDBQeKPzXrj+Vp2RTvJ4xdwCjA/E0uYy
         rXxGXGyor2T0+eH9/JDv0Ot+qBfZkIGSRbQ+deyj2ecA5kb6v+5gmYjZStJocX7jbWl8
         fTCA==
X-Forwarded-Encrypted: i=1; AKwUvBxuWZVZk55byYCN8ER/K5CRkm60Ho44BNN5UghPPK3ykPutcXT/ZMgMsWmSSy58pWPwEhlU22ntSPHBtEqMhLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUaJSXGFULIcPBNtOZuiSnRFA3mphwPspo1UVbpFrgCh+MkF1K
	dZxcufBjB1LRRmhvLjWhdVKsXTAX0IMckCpIKGxPcbs09Ub6Gux1rWHiQEIVDqq6MNYC3/BVlVs
	RWosTr7VVYgqfGSVirtFKxWdbP6WiK99dkeadXiMsOZYm7qQmPoN+ag0PXhzlEAqtcnW+0is=
X-Gm-Gg: AYBFou1xYdszFS6jWHhPjtmjh6HbxQb6MaIJq+IHtgtg9ltyKqSJzOTp4ZRAmXqbe5A
	Jtfw5cDPggD10ZCsdLlf2V0UcUN4cF1LcE6gwGHYlpJykvQXTfjggCKvN3oITeAGh51TCGlNQTq
	E7tEaUubDM8W27cHmglr9nyFC7UHojRFAafNdgA3qi6+vxYgnGOUp65V7gsjnlXERlm6Gyi6S7z
	iROnRgNiU5ZJrHU6/eDtud+yNoaji9uKxht/DIk1IUlyV6gaeC9+Zswm4lzZzqgfnmfL88jWt3F
	dur2PiJTq8n7thtNfcoiyHJjCD2FB6Q0nF3XiebPSDGda8DIAI2QMNqquN2nBb6/GqtfNv67kSP
	DAqDi+NlmE7Z+1jLDuKxojwH3JSVyp0hh79uezbe9CU+HaAWynpHk0O/pTNWlS+/GA6BlQtRLax
	ulSdU0+csnD4JzHgVprBFE
X-Received: by 2002:a05:6820:6204:b0:6f6:5595:915e with SMTP id 006d021491bc7-713ee85fbbemr1936299eaf.1.1793197141937;
        Wed, 28 Oct 2026 07:19:01 -0700 (PDT)
X-Received: by 2002:a05:6820:6204:b0:6f6:5595:915e with SMTP id 006d021491bc7-713ee85fbbemr1936261eaf.1.1793197141306;
        Wed, 28 Oct 2026 07:19:01 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71429e7b7basm1330411eaf.1.2026.10.28.07.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:19:00 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 07:18:52 -0700
Subject: [PATCH bluez] doc: Add CONFIG_POWER_SEQUENCING to tester.config
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
Message-Id: <20261028-fix_tester_cfg-v1-1-e965db9c3c09@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEsE4moC/yWMUQqDMBAFryL73UCy0CpepRQx8UVXii3ZKKXi3
 Zu2n/N4MzspkkCprXZK2ETlsRRwp4rC1C8jjAyFiS1fnOXGRHl1GZqRuhBH0w9NbXFmxz5SkZ4
 J5fELXsnfV7zp9p919TNC/sboOD6o7ttoeQAAAA==
X-Change-ID: 20261028-fix_tester_cfg-ad870e5212bf
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NiBTYWx0ZWRfX8hMntTpST2QV
 En6GbWnFIMNfpTo2R4w7i+e1qiKGT2frMNo7ye3RkYDuOsP17sPU+JnA4u75EKAa0UBl/O7V07V
 C5QbCVULmGcIgMW9KDFIqLDoaaiDgxU2jis2rkaPYPaUTAQbTIZOo3zKyj2aDLN/zTIt6YbC3Ir
 ati3Ctr9XHvbHGf4qsOQOJZcTaF8ETitgb20wm/E5P1LjuWfiPqHSqAOdNCVFBegcWdS0/lnhir
 dnGgepBCKVQiNuk9DQWArr5v/MYYAoIKfOhYoExFaNfkJ5/clQQNNu6CfP4KwzViafEILQd7vBR
 5b2TrLkavpxw5jYnD0+GLBqp3yNVYH5+Xfn9U5kyBpL2dXKAszX+FUrj4jxzL2k96QGa7hcC/Jx
 ZDINSMD5qRPN2/wRhKGgnrWyui3AfwKEjTWBBlzNuS8HpPmZOFk6Hjz7azAkq03tlBQ2+AIJGnB
 x8j49uwQHy+BMg2rnLw==
X-Authority-Analysis: v=2.4 cv=A/T5rKWG c=1 sm=1 tr=0 ts=6ae20456 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gn8PFS6gxBoOce5iwNIA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: 3Q8xVM71oUb6e2Kn2D1b3S1IaD-woEE0
X-Proofpoint-GUID: 3Q8xVM71oUb6e2Kn2D1b3S1IaD-woEE0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NiBTYWx0ZWRfXxXynPl3PT+6L
 ONStaDIwTVE3rn1740u5YfmaBqhc8pQ0K8F0zgw+5C4mUlhpIJc/te9b6CooG89c53v6BK/PnA2
 ByFAPuO0U0RSueeICjh+Ky/C2v7U89M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280056

Some x86 /boot/config-$(uname -r) have CONFIG_POWER_SEQUENCING=m,
which prevents hci_uart from being built-in due to the kernel Kconfig
dependency:

  config BT_HCIUART
          depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
          depends on POWER_SEQUENCING || !POWER_SEQUENCING

This causes the following error in the guest:

  Attaching BR/EDR controller to /dev/hvc1
  Failed set serial line discipline: Invalid argument

Fix by setting CONFIG_POWER_SEQUENCING=y, as is already done for
CONFIG_SERIAL_DEV_BUS.

Assisted-by: Claude:claude-opus-5-5
---
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 doc/tester.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/tester.config b/doc/tester.config
index a9d8de22173f..bb0627c216a1 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -69,16 +69,17 @@ CONFIG_LOCKDEP=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_KASAN=y
 
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PLATFORM=y
 
 CONFIG_SERIAL_DEV_BUS=y
+CONFIG_POWER_SEQUENCING=y
 
 CONFIG_6LOWPAN=y
 CONFIG_6LOWPAN_DEBUGFS=y
 CONFIG_BT_6LOWPAN=y
 CONFIG_PACKET=y
 
 #
 # Bluetooth device drivers

---
base-commit: b0bf49270d445da0852851f393cd67a0a1e5f05e
change-id: 20261028-fix_tester_cfg-ad870e5212bf

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

