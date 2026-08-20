Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4F47F2C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248161; cv=none; b=RJc/Hejy+deD8dJR3bLJvS8J9KeM5G2Wo5eBr75bkctMbIIBJFcXCJ8rjct3FAfDR5Ce7OOjdi5F3IDyhndLY+JSPW/DgO2Yn+FN3LBotp+QbjpyeidCLkoSoWj8rlS0UVgp7oNBOnSpa0zwvRwcjJj76c73gSZVOIDNRlnFMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248161; c=relaxed/simple;
	bh=G+GUWZsP2SSvlFvryliQEFOSsZFWgOfWHLHp+0lc9fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2zsN7f+cyp99Q/k9nmQXLVbefvG0RWJAGCiWUV8jDS9+MpQCDXffzX2rVjTS9RUXggS+7X8fJII3AJWhlIa4yaR5vwfIe/CdY9kSnfQjByFDp4eljWOGFnTx/F784TlEvfE2PapRgJD7H19BXy597GO6l5isdHnyz7uxpJLmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mxHbXLza; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EOg6Yo+S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mxHbXLza";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOg6Yo+S"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KG6pVY3415074
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VheDXSGWAdEUyWfskzZJPclzNFlUteJiJta
	XmDVdZPc=; b=mxHbXLzaHoTOwP+IA0wdl5EU+Omz1uRDBJdAr+DDcwkJowinZY7
	gFB6T9Ayj6wGQYdBwb/DyLbnlShkKkrpNWQbQa8fp14xT6UnzuFZwmqF7PlDANZJ
	WOS6/82gpdKcAYgMyUAjsyO/gDO/BNqezZOB94JKvdtinFk7L+YI+3f9/Z9XD48Q
	TVSkfquyL/Mt5eAqjk691MvWgzxA5TBbSw/kc+BphVHG1jRgcbiM777zMdhd+WQ5
	TzI7DACXgkbfxmdy2EZd0vITJWYwewPifhB1I2EMAUx01FCwoQ9icpkJG5LhkFrQ
	ltZ0PF8kLWIgKuHPV4nBoaffyQH0X8bioeQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7tuuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc73f47bdcso1574095ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787248158; x=1787852958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VheDXSGWAdEUyWfskzZJPclzNFlUteJiJtaXmDVdZPc=;
        b=EOg6Yo+S1ta5m88RAWnishxLbXi9tK1+rW/+XFWVLWdTgP/ihV3Dg1Mb1CTcxzstwN
         y2GxebhmSdABF7aOtzxI1Q709meCwbYk67IoyePd/8h+5LxGKKEjqEyivX05peeLjYoF
         +lwP6yoRJiAzjRKj5LeRofYMkjGYlVWry04bxAqXcCwB/XEn3sC5Ub5ljwCvF9N6rpoG
         ee8Fg3AwTKkWMi2lWiT1qELj/UEMYirI+MxPbiu4ErvXE8bktEeYmSwYYQZo3jGSIa/I
         L7Rm2KXYdNfe721fNpssuS3rw8W1dLEdeKcUrnHdNwz0ZxIF6+VLXFseGPJmj1wH4mMr
         2mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248158; x=1787852958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VheDXSGWAdEUyWfskzZJPclzNFlUteJiJtaXmDVdZPc=;
        b=ilYMV5FJ2ZOLbSriLxAD3RLLUnzXXtBvn7l1BWh0x5gpZF//iLh7GDY9uVcRYr7e95
         9kvTYzefP8PsM+ugBYYufNaPOjZpOHEgbszFPFfVvhEqr6S+c3VuX4i2JOyW6KB/1G3H
         oZs63QiFNe8lEavI4gezwuJtOSx09mIFxHKjofcKuIZsAUd9GBfFYc9mpdD8uDg5WzXN
         jTcJ50g6wNRTewa0v+PJdgBuGvimog9K3gUD5ol26nXNRBpzdvVvAq7i+dYplLL/+V76
         9r0uvte0wOGp61vRP+vBa1F90YhHsKeNaT5CwqduUPGL96hnpHHxA68sPa8Mlk/vlW6N
         M66A==
X-Gm-Message-State: AFuF++nnEoPONAK2f15ksClI5kFJIyR+X+1UlL5sn4ITVVtvM2DnI1KL
	n2GBX3xfOxmzSwK4h7lICUK2h6+MnoWEudCYCwfJY5AbZ1uokyJr9EaNGQpIm/IoMH15+MOog8Z
	AMEgAEIZIvk9swvyPucjE9smPb4jL5XyT8JnQePyETTnQ5Fxaa2iS9a+dhvpQnZHsBkNJzyYlnu
	C7r6o=
X-Gm-Gg: AR+sD11gYGTg3iFSJeqMnDXbVhkANKMdz5BXkEjIERBhJgkVH6xjMiilhYue2vZH9LB
	k84xxyOFDhixi+QL8p17lIY2+zMtmuiECrz0vuLMbly4Ad1HbzwKQH7hKwskf3RfhZudWh2Avut
	smkK7kak9lhtuaZ0G7RsG1alDBJNsQai/1WwwlaUXU+xFf+gZZmoWOKMKb4VjifStGiejCHKSsO
	FAWd9KNK2pu7RjviIeXdkD0RBJS5SwD9UlnNlzB79tqMvqHviHD5rgKG4RK//iWlT3cYrHznIEe
	fPnvMCbZ8kdA5rFgSB0sTz1rq50VVeZEU96R2TQ9s+keov+emvMmpholgF+x9q+askxfKBXu0sW
	usb64MxrOMQilP42R8whx5W4sG9NBVw==
X-Received: by 2002:a17:902:fd8c:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d64addb782mr8157505ad.6.1787248158330;
        Thu, 20 Aug 2026 10:49:18 -0700 (PDT)
X-Received: by 2002:a17:902:fd8c:b0:2cc:864b:539 with SMTP id d9443c01a7336-2d64addb782mr8156425ad.6.1787248157793;
        Thu, 20 Aug 2026 10:49:17 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm18641072eec.25.2026.08.20.10.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:49:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 0/2] ranging: mode validation and
Date: Thu, 20 Aug 2026 23:19:08 +0530
Message-Id: <20260820174910.559116-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzNCBTYWx0ZWRfX7YCUH5EPEOBC
 pS0KtUXs2Xt3MgbY6wIK8eUP/qsxmIgxw5ZQahvEwwkyD/ZTTQcVcgkzzgLyCNaZJhl3RqsvzlK
 qaOde0EUjaTBf1TjujF17FihxtaUfT5xYueWnIOZb583tYu6oHtxrME0HwJRtEEpwfNJuLy1Lea
 HnugXNxQG/uW1g3spo2mz9tJU3oEW+nucmdSybldBHHiHDsJuUEnoi7O5dyrvyh+v6RpJJdZYMS
 519Oy512/jEK5vEc+9GbIZi5YIGxRORTD1p1lmAvqanvC7KFX4pUtG4JvgQqSYln4tAsja/Ea8G
 Z1OymmAuxo97lrIr1lYazVCRT9pt/KPOxIFfULVszGiMgP7HfLAN/M7jRLWVJqu9L5+KXREm0vG
 gflgqV5OOK1qSg1feHbZ0Min5nne3BclOpO/1Z011rnAQGZHIIcMjUHcMROzK9G5ImAmT/iZtRK
 bmW1+L4553M+8rgmk5A==
X-Proofpoint-ORIG-GUID: 0owapqEAAjBsPiDCcev2wBbSon13vKyg
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a873e1e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=kXjM_ZC17K1YYUI2TMkA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzNCBTYWx0ZWRfXxc0cT2nm74Ru
 yskrr7opk/WTggGl9xjqtD3xSXHhJEZl8SVkP3exorf7ILiJyItJgYltRLHv5SIHxD2+TFPYo8F
 mfEEXT1W+5/jfljePnTJZe9tG25+vRg=
X-Proofpoint-GUID: 0owapqEAAjBsPiDCcev2wBbSon13vKyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200134

This patch series introduces validation for Main Mode and Sub Mode
combinations in Channel Sounding configuration and updates the
MaxTxPower option documentation to reflect the supported value range.

Patch 1 adds validation to ensure that only specification compliant
main_mode_type and sub_mode_type combinations are accepted. Invalid
combinations are rejected, and the user is informed of the supported
mode pairings.

Patch 2 updates the MaxTxPower configuration option documentation to
clarify that decimal values are supported within the range of
-127 dBm to 20 dBm. The documentation also notes that the default
value is 20 dBm, corresponding to the maximum transmit power.


Naga Bhavani Akella (2):
  src: Modify MaxTxPower option documentation for ChannelSounding
  client: Enforce Valid Main Mode and Sub Mode Combinations

 client/cs.c   | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/main.conf |  6 ++--
 2 files changed, 78 insertions(+), 4 deletions(-)

-- 

