Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194756;
	b=wMK5NEXTMiX1XL2TgewnZkpwCZrWGC5lKE6VhmT7cFEFwcEcjJA4jrqujYAJwYx+Em61
	 QjZW9Vr5llBz/gMgJVXrOXFpWCTKHAMLAODNKr3MKlIFSOQP9SgXeKzJIpCjodgzZjrTk
	 j2hs9ZBtr9PkzZYBPQQJA4w63PoxfNWE0SzxWkgw9bXgIwTAvgterUAZfUgncXGtgQyIf
	 5+bB9G9Ypj+gQy/7Cu5f5x3J6vEKWeRMTymNQE4NbIEbppg4TKxAirDYMN2Zp2zbZsg53
	 tsxV/Qm+ZWThiVPmb5QYqeNyqWS7lzMi9/bWjxUVOXeE5OaFhlxNWReB6T4Y71fF4hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194756;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=m+Ne4+mem7clbk7diUwLgzqxNtPillBEGVAT9SSEH4U=;
	b=Ae/CsMTWY0CbWEsqOvKRnVzh6XYyVakJeTkBU5QjYdXMhvZ0EDGrm1e52sv98GafxXyK
	 xVDptZpn4HjlDbFUtMqtyO9t5ydqj5Apku+6mYte2OZv354ovcimORSr9BDE6BZzA6y+m
	 ySopBcl0BvH0S+FBAYc++x5CZXcneEHPqkRxQXVf7MSdyE7yF/DgVAh1MaIv+SuIjPDvQ
	 QlY2786cefejfWq4rfgFamy9YxQOy9Z3THFA82n9ZyFAywIPr7dHCImdh/uFeHa1D8UBx
	 3rG/0bAKg8Jd8E2u9HZFOPvKP0TqQ3Sn+gySlI3b5cgB2ds33E2MwKeyhfkwVlUdXIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=di2j29zY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XWxQ6PMN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EA606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 987EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=di2j29zY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XWxQ6PMN
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBdtmF137566
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m+Ne4+mem7clbk7diUwLgz
	qxNtPillBEGVAT9SSEH4U=; b=di2j29zYseF2kVmIw9AQuqgbb83seqjgGCS0rE
	93NcV2yt+nM8bkTMmUnT7w+xLKFIb7vIZ61Rk7MrF0NFxJMneICNpGe4eJEXb+6S
	Op9um7CxhQeyBtbHcDMw24+lRSTCbHHovfp7K1tjtYDdbI3oK204pygbY2/nMqd/
	9y19Z7wMIwdDO8Zs0bIBD9BZ+217o1oHyG9tMBfbkwqKprZsLS3FjcyoR8EIwT0M
	n63CgS5fVAC3TLCp1rrpfRHA8HNgmg7XcRad9LdUr5O4r7PDEmACoYyl3nsh0gEE
	l88Y0W0IyLOk4wN3Ixv7h2keQF889jm5Ukjw5CexK+zo5Trw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6f92nvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:39:14 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0f5e7cc16so1096807b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793194754; x=1793799554; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m+Ne4+mem7clbk7diUwLgzqxNtPillBEGVAT9SSEH4U=;
        b=XWxQ6PMNKGJ+IuDt7DI6eAAJduV8gd4a0ZjWRVdLSiz9ogH6wgsJoJ7cGEbo9z5UDj
         FziMeK5auMnlVbOcyrNEE0rD9FywGvMTWeTQtCdFk4mNK6bUB94BNcQzK2BaZGlM4dLD
         HYs1ffKyQrZhNRq7l2xnSrXYX6mi/RYYxe1lV3S0762NOt6le3+MWBMG5E4ZVDZH2nw6
         /K/jnC/7phIfOlIPsYm7vyc5pRsnfk6D9tUrnZF8Hi2vC2UNgcmTI9zgJAg+a0zzbj50
         b/KT6Pz6tLwOgtXlJBsiBG5ZnG07j1z7jfT0agStDf5xIrL0b8vwpWKpKEPIE8e8kFxP
         W+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194754; x=1793799554;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m+Ne4+mem7clbk7diUwLgzqxNtPillBEGVAT9SSEH4U=;
        b=g/DnZIWjRSqwAAbZ1OTMTbBn6cYgxdbFciXEFpAnY7hhpmaODTqnsmiAtKJofci3qP
         jY45YmeGXeVLGPOKbfa7XnohP2+78Q/iZOkTTktw8yAqWj8pPWj/zUMhAKvf8in8yfsp
         kma7BF2uMrzXLccTZwbeKwmyUglpJW6fJtBrKkkqOXzfDbN+z25v6AuHcC/4C9f2cL93
         vhSZb/9EcdC/+aurxO2d5tqydLzOQ3R/d23aFSyx5WohNy4iR5c9qabxCjplYTbeQsof
         OYpingWEvexpQta9lHXNDM3tzH0biI2LlFUX63mrhMmaRVvr7/qcftw2TGf0MaiXJdWS
         ATyg==
X-Forwarded-Encrypted: i=1; AKwUvBxIYkMLfaA578ejiQ1+Auucyh2hv+oGAExmiS5AdbLrBXft7VRjTbDy3Z2Bn5aGzubA6CKETAot5trtejdd0CE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg1HDJ+CrugoGfOZGCYFKvlaKGP7gawV0Wok4WG3KMnOJoI2O6
	6GOy2aTrP+fr7rj/PZcV7bgWvoahG/WsoB1uZxq/SX5sL86sSq2sny/beQvV7VQUgtjGtNb5x4g
	Po/L1OdUcj8LKzRvpCcsLuZZKIXXX0hAnGLmNDJq4kpmFeHyZpsJ+JHgYAENHWnTahEnmMUY=
X-Gm-Gg: AYBFou2rbGRm1wzb8h3kB6KcBjX2KWaoocCi1guOQ36fc/CxBQJT/l8dq5lLbtm2byo
	I2NmtN5sk2F+awHOsVqeIkGkxB4gVgJCkEm9J3pjuRa4wYif46ZiwcF5kqj+Y6E0SGi5WBlkIkE
	jjmfiNKFscrkqFT3eghVweiZxvk8ZOwZ67JPNx7wvjmDAgiIP0lzD8HSjsCdnE76y4URg5pT0MD
	Bl+LZ4b8kOcOycbm7wr4qRM/mHikvikIrLx+KPlw8qiRUyNelXC4RvnnHSUItP3WLFzxqZ45RYX
	9qGPNdZEywcWsMyZ3hwaTrE9dciE7xiBpn/O0uiz5mB9SFdvGVBZPcIDvptoFUbQFg5BqRIra9B
	LuGCu2CHnfskGBJnIUypL+UvmDPxnEO0q8NcdGrPISILBe8rfRJ+FKrIdUM/UvbiQWBqV6yVM2n
	b0BZyZL71hs3giAm6ZDn0z
X-Received: by 2002:a05:690c:a083:10b0:8b1:a4b1:7abd with SMTP id 00721157ae682-8b1b595b3femr22089437b3.1.1793194753956;
        Wed, 28 Oct 2026 06:39:13 -0700 (PDT)
X-Received: by 2002:a05:690c:a083:10b0:8b1:a4b1:7abd with SMTP id 00721157ae682-8b1b595b3femr22089197b3.1.1793194753373;
        Wed, 28 Oct 2026 06:39:13 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e6365b6sm28184207b3.41.2026.10.28.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:39:12 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 06:39:09 -0700
Subject: [PATCH] Bluetooth: hci_uart: Remove redundant NVMEM dependency
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
Message-Id: <20261028-fix_kconf-v1-1-624788921368@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPz64WoC/yXM4QpAMBSG4VvR+W01S4xbkWRzxqFGG1LavRt+P
 n1f7w0eHaGHOrnB4UmeVhuRpQnoqbcjMhqiQXBRZFxIZujqFr1aw/JBoixzqVRlIP43h3H8Wk3
 72x9qRr2/AQjhAeK8BzhtAAAA
X-Change-ID: 20261028-fix_kconf-4d8e8748bb9f
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=frhJ914f c=1 sm=1 tr=0 ts=6ae1fb02 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4keN-7vRS7seC8qMJf0A:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NCBTYWx0ZWRfX1C4Y3yf2RR70
 S3TI2HlpR8PCyuBEGEAfyJxDPTLmSlNnx4d9NHzuCHUIbVdYcrGtM/5iJGwmVWmKyleID4kUIuM
 7+mswhNcL16hX81Pv4qWbYRlHnEpVUs=
X-Proofpoint-GUID: U4A9rL1otmYuONwVZok1a9qokodbRe5R
X-Proofpoint-ORIG-GUID: U4A9rL1otmYuONwVZok1a9qokodbRe5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NCBTYWx0ZWRfXzlyLsqPYIHDH
 +6jmKT0i6VillS08BMZjFriXy8K4A6yjoAmK3h3sOT6y7kpFVv3r3k27+KZQqNZtjjjxKmqmzf7
 DybZ7wLfcsbkYsTjuCS75uF5bLWX+SQZ+p+uP7UQux3oc59kEDLghD/2Ae6z/YZntX1nCQdML/w
 ZGcW7oQ36cNwfI8R5Cvw1RT2/ImPeUUwDiyVw961Eg6WcQYaaC1ZWjXWmR5yYNICCJyKjkDiUm/
 ALM2d1CjegBYukMkGNPiI1d07saTtS/QUKxhmzQCiV5LRc4INSUMDSuwPN6EcG+y7VbVh+x20s1
 1coGkJ8bP/P6KyUBSiTZ3JAHEALLujJAm32BpQzIroDk70ZTglDHCLDdqyOsLJlauO3mZq1YeJc
 bN+MZWujjDpzyuBYDrqDHiNyhV5uQnYO2IOvCV7EXkVNYlvbbA4SAKciafkr/Y8do68JgtVsJnc
 x/NNyDw0MXNqIfpEKKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280054

The dependency always evaluates to y since the following commit changed
NVMEM type from tristate to bool:

Commit 2a37ce25d9f2 ("nvmem: disallow modular CONFIG_NVMEM")

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 68929d12f608..fd4525255dd6 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -113,17 +113,16 @@ config BT_HCIBTSDIO
 	  SDIO interface.
 
 	  Say Y here to compile support for Bluetooth SDIO devices into the
 	  kernel or say M to compile it as module (btsdio).
 
 config BT_HCIUART
 	tristate "HCI UART driver"
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
-	depends on NVMEM || !NVMEM
 	depends on POWER_SEQUENCING || !POWER_SEQUENCING
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
 	  This driver is required if you want to use Bluetooth devices with
 	  serial port interface. You will also need this driver if you have
 	  UART based Bluetooth PCMCIA and CF devices like Xircom Credit Card
 	  adapter and BrainBoxes Bluetooth PC Card.

---
base-commit: 47d4d9f67e92d56ef3965f2727f9c98a5a611368
change-id: 20261028-fix_kconf-4d8e8748bb9f

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

