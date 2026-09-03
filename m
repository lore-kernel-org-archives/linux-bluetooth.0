Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3F4BB806
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446861; cv=none; b=cBGTn0wKGH2wyDh5AbPUauv4biHxmPWs55h0qSwJAGYJSpQtkcNuK1UVmF5p2C4+z08ygOFHQ70/fCH0chocsIK35X3ZzuX0ZBEU6jXlLTAWtMrw3gLVq46qHp8gEzFtDsWTjGAxTVBNaOUbuOoeUiO7nMpA6PegBK4BqifdvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446861; c=relaxed/simple;
	bh=nGZreA1amTgzCPBA3pk9j3iYkm570B956O1G7sPHObE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWBxQs3gX468dK1j9TGXc0R9nrDE8UhmyFg5V3mHlZT9/0NXEOKo/FZ6GtjIk0IHN9BCIVWxW+o1T5Bg9FOuUzJVvLqR4bJdaFjW7oxTOOaxN5yFUDvkrbaZ7rn/VZ/rvRvQmmLw05bKPuKBXeK/x95KodM/YM3scyqIBaZ1kTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UH/o7e8T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIeI5AfD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UH/o7e8T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIeI5AfD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAeGB822720
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 14:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KgjPny+eSGIgNXcSG5I6onSrjp3K5wwDfeW3fNEHLX0=; b=UH/o7e8TT7WSEeBu
	yXxd7Qwik4TQOL7RkBwiEfoZ1A6pauzmnQ0TfC9iGM59oDf9vSH1kqV2Woi9vUz0
	QSB5kjHdAIYSri/hvfYGUQQkwaBuwfJr7j7ogH+MDJM2mlTOI1675Ps3PMkvKdrB
	2DKDuve2U4rzP8I0VX6nAN5WiN4ktex8L2kgBUr8TbinBuFFs3hfByFLqMbWSi/W
	Wfr1NKIXmPEkuLAQIhzY6cIdbRSB1Mq61oXQntn2T+BOMRJiusDawa6zZxoID8we
	TOmxepY8bmgjqHJI0VPT3/rljhjMocISD7Qt/vYyAkaTnUlyL+jZNWlZBhpiG9ct
	fNk5FA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p71684-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:47:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-399271df9d8so518147a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788446858; x=1789051658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgjPny+eSGIgNXcSG5I6onSrjp3K5wwDfeW3fNEHLX0=;
        b=eIeI5AfDPef50j+uqSbr689abAm6SI3SZ+iUidOp/1RJZb6QHcxL1Y0gUlZSxiTvYQ
         pyur+Yp/eBz8beNqdMNk9CpFthsOj0Opy2c9ejxAsQBbqbGAQ1nnfSRUOA4qvRTgtGCH
         K8yhAHBrLM1Pl9Xy2AFbhOSVa9huSd6g6k5tQr6WkonIqnXW9VFLjX95Gj5rMVGSOLfh
         IiVwfNpbghNRPEW14fRj+I5G8O6ELuqLW6U11n9O82jHV8hhcZ23riNXYtqMPd+dV6EL
         lfiWioqMQkI7Be5Kw6racXEjHXaWDm/MMnTohYdSDBurCPX2x2tqgnwoE5QB/Vw1y1nf
         G67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446858; x=1789051658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgjPny+eSGIgNXcSG5I6onSrjp3K5wwDfeW3fNEHLX0=;
        b=MtpuqSFan60iZowHHynQtyWkGPnC8JyFTjZOyip9PcCfvQ0VsxV++hFCPHTrvMmFzy
         gagUDgrTZ89yHcs7C8hxZR09rzzlb/NMpPCk9lAXgICVQBSFIZ8VmY0osLrLg6tQ/9dK
         tMEUC9BQXT5RFS5OL+t/95yeBSKa+CyS4+jRUFdi0y4VYInyOY3mRehHG+y2D/SeuLe3
         HRhO6o796CwW7ibQrj04eAPedICMejPwewngQ8XDk2h/h2OwtIIV6XBjn6QoBP7z/xew
         +xV06MyTBjoUiIoEC/ypoqxG5RrBkIXHe3I9ZGS8H5w3nPc8GdHNR9nFJq3lOQoROlf0
         0Z6A==
X-Forwarded-Encrypted: i=1; AKwUvBwWq7bxDv9XLWgJ76LhSMY9C3Mvhm6wIEskf3iTtjBWTjfcpPzso9D66Sm7kBq1AwAFcw8e9d20+dCTAXpMhck=@vger.kernel.org
X-Gm-Message-State: AFuF++knDwGRTupfkbbrcUVHPgg1rQTTSOwXDZ80G1jBmHBPWcHjcnTU
	MLPGy6Fesc0eLn5wOEiPTmPZsn4Q4y9poS9scHqi+/XUI0FrbiCwyLGXnRZwI7QTsuiWYVN3ypv
	fepmaGVZ43bf/VbGy3EEahQaHhqdCvsD19knR0n4iVFqJSlDTJjX7G4hkaQ8d+Ta3pxH3uUc=
X-Gm-Gg: AYBFou10Jc+8WNWA+1xlgVOikTEVY+g1muxqOWoXRLXlrmbENNrkJ2WzdbGFbkGW3Jf
	9U+uuUaI+6MkO9dHDaOJWPpd+nvQE0Cm5Fw75j0mhXgt/9eL/y2mqAGjUpY12tVUyEZ9xL/0N0e
	uI3iiM1bsqbNSwS4kj7OqHk0uKyzWgNm42k0x/ryF9Q00Sq/x/Dy3iNYiA3zRZVe3dGktYw9zov
	7aJ9alyHRmU2a6kyzEXF6Uo8TI6X6IZJz6TYMYxWebN6GU098QoPLAXUy/b5rraXfFCmJS84Wt9
	oNreRG4wtmpyA8ctM14i6KMtocg3m78dFxJCo+U3oXRTanExb9Eln8GeYDMvpoCKVKaBPkxAKxa
	avclYNvYl5SCdS44zXTG4UvBT3wV0DzFpejezbAw1p5xbo9o=
X-Received: by 2002:a17:90b:4b8b:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39aee1c6d08mr11873147a91.4.1788446857053;
        Thu, 03 Sep 2026 07:47:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4b8b:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39aee1c6d08mr11873100a91.4.1788446856524;
        Thu, 03 Sep 2026 07:47:36 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm25794c88.11.2026.09.03.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:47:35 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 07:47:13 -0700
Subject: [PATCH BlueZ v3 1/4] doc/hci-protocol: Fix missing & on mtu
 argument in BT_RCVMTU example
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vendor_hci-v3-1-015d62a57c91@oss.qualcomm.com>
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
In-Reply-To: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: iDl4ueBK62CH4j9ybBsCWniuYOjICsJ7
X-Proofpoint-ORIG-GUID: iDl4ueBK62CH4j9ybBsCWniuYOjICsJ7
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a99888a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=wa7QpaTpAAAA:8 a=zpTOe8WlNf4vmfFp-y0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfX3nnCrAJ8iHlh
 7bUz5MVqBigei/wjKir8u5+EoAQMzn4h7qkTxxp78d7KWd3C1evDb4OohERNxLJeKrtkCbiOGH1
 3jEmDuSTZ2VYi8RiKZg4qalO02t5AX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfX1K2Go8CgGmZM
 c3A13kesxYxPjmFVin2zFPc3ByXoOgenl5aKSp1ULS4fNmjxj/JDmmO3ZpvV+skpgra2ZmCYBUL
 NpLL+iyAzIRpM8yNGfy9asnOnOWy7flEDmtmqZIo3u+slo0HkfcCgQXz8TYQQYT7sIHClqweIeO
 kMgvWsDz9G2B6IqqKQkjANk1uoF33OxESP5HruDY6DRkT/su/vfFwVWqwgAXKDVz014zDp/mSWq
 LXpM58XnoKuH4WJEIm/6oaLW6ZIPse9wjA86p0GmGl2D5sUgpzUgwjJ5NGgc98wN+o9SjlkI84g
 BXnMGdZXPwVphGF1BeMqB6C7Pd0w8bo62tpyAFbfLIsewh3KnC4SveovhvD1IHmJfClkTshh/+B
 luQJA6S0owUvsTrzvw3jazDhq2i1V4tk9yPKoHolChZG7oTrMUYRPCcyK2S++2GizaH5mFW3KPc
 x1xGifIW9JrRWla5ldA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030128

getsockopt() requires a pointer argument, but mtu was passed by value.

Fix by using &mtu instead of mtu.
---
 doc/hci-protocol.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
index f28684655842..db10b35df736 100644
--- a/doc/hci-protocol.rst
+++ b/doc/hci-protocol.rst
@@ -129,17 +129,17 @@ Example:
 
 .. code-block::
 
     uint16_t mtu;
     socklen_t len;
     int err;
 
     len = sizeof(mtu);
-    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, mtu, &len);
+    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
 
 RESOURCES
 =========
 
 http://www.bluez.org
 
 REPORTING BUGS
 ==============

-- 
2.34.1

