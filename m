Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169966;
	b=SwhVBHk5arM7ZhONRey0VISy1N119KQ+RTsLQhZCXZlQboGRIDeUt9qjfg7nPwEjfmF+
	 RP1GNEKwPcb4CYn+X9Z6ktxqXjr6ZRHmDo+Jf6g28AkqMUHPImsmkcdMQn2DP6Rpzk2TO
	 6azRj+ZCk3F8b1beypd4donz7ZhvfwI9yNCj1TyBDqpmvn7GK18Zz42YcdWYL2jdTD4vr
	 HLnYzGK4NCjV9JdiVg8+869uTl6KYvaxwD1zNlVuAEw+KZEZsG1E3gs4EnFOXRdX7M9Lq
	 wf6RqzKixaS1OCqRoxmWZ+b0ZB9ap5MxWjpWgvM8AZBGX308gepP0IPC+lQJx+pyYtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169966;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=k8F8cGTvmMsFshCRhL1fra8RRiVCEztXuR4FcSJSdGU=;
	b=Ddld2l0aJBhyYd/dPyNw1mgYkW7d+YuXy1m3ZSOppa0uIDIPItN5emBkyzkugj2ZwYP2
	 w2I1s66blCJvd5QhckDP+HngPKZIyrnsgeSPBpJL0EH2pKFYHmaLWE3QZYnPYjOBlerBh
	 Jvr+TTXR849DJiUCpqDONcWN0Ue43flgd68Nj7XwrxV/vgxWbO9Z9npqKY14cGidfZOFD
	 isBX6paGOxuL9XKarsE5q18L7mRTfQUS6UMCbbV/2EaTXK8LpEJ0qVL1Ss3uMIPA/doPh
	 09hVKJXf9ddwFtjlOKQ/Wy5s00K36IdfwVxODxbTAYeCCB/3IzgWB3OfJs2p+T0e5Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QaPLEgUH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VDJMddY8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701F606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8701F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QaPLEgUH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VDJMddY8
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4PQ8M655215
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=k8F8cGTvmMsFshCRhL1fra
	8RRiVCEztXuR4FcSJSdGU=; b=QaPLEgUHqeClGkbiu3FAAAKY2ZbhSe8vWQereQ
	U7RNb4oqnekJ+HEGJx8u+gSBRvKh5LaXJwCAmE+sLvtdZYIWgm7gT0lxpYi/cvBE
	5Ch2Z4LieDjeQZ7rAS6wkS7mQXB9Ob+5Jo/fMvSfN09SiSGib3hFEqRsP48fxgJT
	sCYc/EbyvryJQ8mPRCtLXSlVtkga8wKDZs5osSAJmEGtJnU4OhLWKZEQtkIGUt48
	35N1U73zg2SQ7d+4Tsh415CHbTcY7XqoD+KoT7/TrRYlW+y5wddy9FTSjXlUataL
	5aXB0AJHX+9Su7ZOie/4WdaMB9lAAsg0lpcpgPa76N2prKIQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk7g7gxmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:46:04 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-84cac522117so127597a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793169964; x=1793774764; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k8F8cGTvmMsFshCRhL1fra8RRiVCEztXuR4FcSJSdGU=;
        b=VDJMddY89UrzLe9HfaRvtB4iNB0zze1OPn40cjVIdU/zt9FP/vwIv29ytMJ3YvIomz
         7t8NAvsAot2O0Hcz81KxLbItjlR4bttHB2+EgsUdiHA4zOJAQIv0kONwptQOEm/4oZMH
         4byIS/8+TxZDg1qibwsD81O7JGAcpkGJ84WzPUSGCO1HMdJMsQygPPvFBHtKxh0NPYU1
         V2AfsioEc7llqkpVih7402fJe5KtriX1EHXKkt4YQaTqXFlghM+wPvJEOmc/jC3e1elM
         Jh+jcgF4Nfc5P/iercTfxGfRAQ1gXeVLzPMm51NQxMB99u1hqiQL8pjLC4CcVAMSXFyy
         s1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793169964; x=1793774764;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k8F8cGTvmMsFshCRhL1fra8RRiVCEztXuR4FcSJSdGU=;
        b=gBLbcmiMLY5V804+QrJRw9xsKztYVClKqLWm0csvmdvMN/Wj/ufU/wM0o3o9m3Bdut
         glfNArBnlvlgNIptVaSFRyLAYc/Qj8ZRC9nGosPZ/J8IbezUlZFnonCrmzThig9bRNOy
         K7rVv7ODwwjkd6GlWhnT5oJDTwulWNa+wgQUvzg6P/TAk11G8BB9ew4s9vbXaW6jzBuV
         LO95d4hdIvDYHJEK1Pli09X/AjzVC0b/ielbD8RFpvgsrk7pBJdK9LhTh06H0t4EDO0K
         N3a90q4fJUufphMS9i077kCDiKYRAeNENSZDEl9bnwsoxN0A946mwf+EXW6h/gRo8K2D
         fkmg==
X-Forwarded-Encrypted: i=1; AKwUvBxVz0aj+FhUpO+l2pe0dYa79z51zQwZbhzd4fLoaO58JmkfSQJLX4766CMMtta5DgUHDNCrl9ZBu9BNTZGzhoo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ9wPSW3CBPqbtOdDbwRwtF8wGpeZbbj7+1lyuv2KwUNGxvpVm
	5o89axPU6I7NKHBomYpk3ec2FpxlE6d9n2LHVgwzQ5WPzCRBcCA6/fiYz/fyUMxlwMGsNlo2TCs
	aPTVqPIK5wLTitmK7dkslwPw4vwdP5iCu+uXu2PNYfHhE5Kzma4UGNT/3ztrI2pHJHjHe92TReq
	B6irI=
X-Gm-Gg: AYBFou2ru9gL7yo305W6On6CsuyZ0ZZvxdiXgUN00aEZNNB1yLGnf3KEbD4cDv+xi0k
	653chsEvnpwsru2oaA6nXBvn3YzCUWSAnKGWGa5t1vVQIHURFjYcOXvcBVk5WDt/rGln3Yxlq1L
	rTHLLpSZSUYyWotG3D9Ec5mEesMeuxbGrdSPuT/EWPupHnqluX0H3/NHsde6f8ERjQRThRU7CwK
	ueiWjY9JYcZYIp+qO7tP320hhYkY+sfGxTZHVhfisBYHIOxbUS4Y4cJJmGBsrxdYLYkwMMnAWnj
	KGgJW7SQBjVuX84UKEc5b8Q7pxv21EgGBWNWcs6NZoNP7rFHlVIZ15eQFgINja6FpsmUcFiXURO
	3/pPAdrzVg6aae6fDAkSWqPBnf9+jryedgiE7TWN6e6Xr8LplsCShrKKSaMzZsqfmNUBSwuPUSL
	fXMEklItMFwGjRrUGujoVg
X-Received: by 2002:a05:6830:1292:b0:828:f53c:92f8 with SMTP id 46e09a7af769-85ab743f9e5mr1656615a34.2.1793169963595;
        Tue, 27 Oct 2026 23:46:03 -0700 (PDT)
X-Received: by 2002:a05:6830:1292:b0:828:f53c:92f8 with SMTP id 46e09a7af769-85ab743f9e5mr1656601a34.2.1793169963264;
        Tue, 27 Oct 2026 23:46:03 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1fd30d98sm860727a34.14.2026.10.27.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:46:02 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH bluez 0/2] obexd/bluetooth: Fix profile registration race
 and clean up
Date: Tue, 27 Oct 2026 23:45:49 -0700
Message-Id: <20261027-fix_obex-v1-0-3d91aed181b6@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAB6a4WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3bTMivj8pNQK3WRLQ6NEM4tUc+NEUyWg8oKiVKAc2KhopaSc0tQ
 qpViIcHFpUlZqcgnIGKXaWgBTn3VvcwAAAA==
X-Change-ID: 20261027-fix_obex-c912a68e73a5
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfX4Fwu0ECYv2jD
 VvtkqDOMqMqkDJ92IHrWpfie/eYRYzpiHNgt64VK+tgqSf7OytRegWulm58q6/TiqT0plzCDMX1
 3CNFQp/uUXhX7fAJ5IL+xCEzGUcy7lk=
X-Authority-Analysis: v=2.4 cv=SoIFe/O0 c=1 sm=1 tr=0 ts=6ae19a2c cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=XgosEfYsB3rBOOHaGfUA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: OF74u-FJ8fxFZ0zESLmw4OPeQ0yEx9w1
X-Proofpoint-ORIG-GUID: OF74u-FJ8fxFZ0zESLmw4OPeQ0yEx9w1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNiBTYWx0ZWRfX/MmeIvL8asUL
 gbLSHvQDbZsae6eu5QnFoLtgNr5wWDw1nTgzzsoJj4RCppjNFuO6lZ+yizm7pfHZRIawqATlEwi
 oN+TdZTts3fHAiRyLw/J/Jq0V+BaidgybSkGjXV5r9Ejy7qpw3ezF7i8nZ5Z7AKQ/+5Q1R03NzR
 DC6bNI9afBRGYjTo5pM032lRmLuyXDIBrHjOh77HLXX4uGJ5XUn1/qOyovE/rs3zAXiS1dPAMZ+
 p3wf/I4ZXw87to7ON9Mzp9voq0UV2NtGDT5kpJWlTkpG8GnhEYoYNAH9LNN66qmn6+cV4GphbzV
 JxGMyK6xuY4hgrN0+UN6z/XLFFHoEll+0MORZixzSQI1S2U4hsRzz1JHHJOcjWhiIaeX1v2k91k
 SF5EGXp8ZKmgXtDu5tiD56sBZN7YuxbGazC96hSxdYJnMC/T1TFL1LWI+2ypRSkk9n2MTX9RMoT
 UobEIdcv4zC+7DBkt/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280026

This series is to fix below profile registration issue and do clean up:

After boot on Debian, bluetoothd and obexd are both running but none of
the obexd server profiles (OPP, FTP, PBAP, ...) is registered.

obexd registers profiles from name_acquired(), but only adds them to its
list later in bluetooth_start(). If org.bluez appears first, nothing is
registered.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (2):
      obexd/bluetooth: Register profiles added after org.bluez appeared
      obexd/bluetooth: Clean up redundant code

 obexd/plugins/bluetooth.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)
---
base-commit: b0bf49270d445da0852851f393cd67a0a1e5f05e
change-id: 20261027-fix_obex-c912a68e73a5

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

