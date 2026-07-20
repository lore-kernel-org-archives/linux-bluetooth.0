Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80C3A8759
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784526077; cv=none; b=P33A92isaK2sE2OkiDv7ZZF1UYShTM7ysKId9nsOefeSyqlZIaI3QBKA3ooePiTjZJz5BmflVjwY+jg8mQ6Kl2+tVNzThgwo8dp050298W4Y4FP74+msZprU+AXx18ABM5emt3nJ6MiWqvzey+ur5JvcC3/yg6Gyg6CbPPZPK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784526077; c=relaxed/simple;
	bh=YOnaiOagPfShEjtSXw5KVKNYSJGYps/dGLs0r4Tym3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V6rDh914031IIhUAJoA0Dye7odXSy0cTNwruIS39dzwjLALOdy0r7TVcjc6ADS2NSd3RBSLIUEfEwY8mpvvx4D5tl5J0GOM9oNUuGKBuaPSSN9LNHfV1DBxTj9qF/22ZvmDigTSfcsZHjDJA2PSa/C5dIWwkMeaKagR+ZKfNOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hbNOLx5B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Exb2dnq3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hbNOLx5B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Exb2dnq3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsZZA912274
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Or30RXGGgTC3fjQ3VM6Bd7
	QUOu4YbZqS4uUcUf4DV54=; b=hbNOLx5BQ0HrZruOnj+cO8eIQsyxDBn8b/5CXa
	qnR39pEHaPcA0kwKMYckChzl/7doFPC99jVJr0om0v/Cryhzjo2HHBoZPb3XMYHe
	AcP+uVLTzTZw3Gkuiur6FO8kj7rdtgWkXw5eFwVkxDh4aeDKLjkP9hcv4qvYvqPN
	rZnyJD+SuP5bTADlfwlcUtPznC+R7wdT9WdtQy/YrXpbDf8sR7XQrAL6L3JW9Y7v
	/UTs3LGLH3Twd/ewOKU93ZRsKyuPf05LSaLyS65A/XecNNqqiP/+j2U4rQcWpGFE
	pyUxB2jzQJDAMHFhoN+RBOj0+H3wNLYRbYox9WYVnCewLGiA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af4h66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ced1ed870fso21170175ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 22:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784526074; x=1785130874; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Or30RXGGgTC3fjQ3VM6Bd7QUOu4YbZqS4uUcUf4DV54=;
        b=Exb2dnq3RIxxb5O40FJ0CXrcALuYGDjKZwPA6+93wa19Y3BVHt9ydohIqlMic80trr
         EkvspdyiR2xsyb6YArQEyPj/0vxOLnXICjT17UeyZ+EZJOjLp2Xvdyje3gDaLdTuZhhj
         sUkMJnnJpQe72KQKh2hlG8Z6K2vrbuc7J4Bn9GmvfZniH4Mzi2HaObON/Uv6DiWUON3r
         +gGPcAfLBgzGBDVv8dNTN/RoAkVAKmLUuDutAv5022HTY6+JKZiGG0FS7UYJBukJhnqk
         PzY8F0mN7h1mmT7L3hn2FTIIU0cEAM8AX5CS9+A9lFe1nR8Sg7U9kX5x8G0aogZ+Voba
         OgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784526074; x=1785130874;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Or30RXGGgTC3fjQ3VM6Bd7QUOu4YbZqS4uUcUf4DV54=;
        b=eCbx4EqBnI3RjKbwTDFQXI/d+5j+j8xPPbGx57/iDclfD7ewkgMsiQYzwK6HM7UruD
         K2cD8z3IU7F11TJoWRUxdw5dEJBnZqAixZ6GYjW/KK1eUx5cTlJj8xG+9WCD3Xm7C7sJ
         ZUBv1allsytc8dJiAxej+xPjAkjMkLwJq7Oy62dyrSxLFmwDIgkcUw7KJinC3ZBg9Knc
         2um4oBlBqF/gV9dXVLVBea9xkUpOf4Lus7yp23zzu/bjLXF6EpRTtprx2+ZHFL3BFDYY
         C+m6Th8GIYyQA/dZ/OKZlai/VGz9YrWwjFsFAvOh4xcVLkaXqz8sSoNVE0AcCVCw7atR
         aP9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpF3OaQZOWyfWa8qKQlzfR6PkNUW0Of3OHh/By9wIgIIWjxNL+j9gPG516TkDWnJOydi91NXEWG98r1rC6So9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xKzQoq0e4yBpsK0xnemJwbZbYM+lOzd3g2Wagagq5haOgq1D
	l1oU4VzyoHPnqW0EtdaBhUWL2SLRxWNI0poQ4MkuGEa6LuC6ZZ1Es7sp/KMurl4wjrl1WBFqKFW
	roAwNQVeanH8oFm215ijBGj/qEeut4hJCl2n/I++5fTEREIhpMhI8g5+cGRciB3BYpxVrLQA=
X-Gm-Gg: AfdE7clwH8sNl3dx7ZCOIzGdNr1f4A1otHAFh6fAe13h5y2kAz4J4+2PQ7xdhmeTDQo
	f9Bg8a4fRe9qg7oenNgQDzh1B4yViHj9SkMkkqoAEa18c6Ef7mGlX3VCbWNcjpyh7HjLAPgqAi/
	5zuYD/YLqghHkYiO/JA6Tmul29FIVGQxS/NPn7APBZkDlB+RbGE4w429mb9ey3u3uKn7HCh3LL3
	ECmjax2WeOxR+nhHgrQy5bktFo1/UhF1y21Q/JzJOonAdCZggDhUMCdJVrFidfdPEDO1dfkUxpV
	oRkZ65kOKUJffWuQWOruruVclKwTql+27VDVI1/pysjyFqKB3FB+3xKGHNwqUjzigNYwi+43t+7
	hz2XepAckvBPs8BKCw2gVsS4UMHr0dGpQFgfr7qo2LT1u3LU=
X-Received: by 2002:a17:903:2ec5:b0:2cc:d6de:d58e with SMTP id d9443c01a7336-2cf3493b326mr122073685ad.4.1784526073640;
        Sun, 19 Jul 2026 22:41:13 -0700 (PDT)
X-Received: by 2002:a17:903:2ec5:b0:2cc:d6de:d58e with SMTP id d9443c01a7336-2cf3493b326mr122073505ad.4.1784526073242;
        Sun, 19 Jul 2026 22:41:13 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de301sm31907340eec.24.2026.07.19.22.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:41:12 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH bluez RFC 0/3] BlueZ: Add generic support for vendor HCI
 frames
Date: Sun, 19 Jul 2026 22:40:49 -0700
Message-Id: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOG0XWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NL3bLUvJT8oviM5ExdQwuLtGRTY8sU80QLJaCGgqLUtMwKsGHRSkk
 5palVINEgN2elWIhscWlSVmpyCcg8pdpaAAdhLLp8AAAA
X-Change-ID: 20260719-vendor_hci-188fc539d7a8
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfX4tc9alhBUzCN
 V4hG5S23CgwW3aEkwDiaI23rb6fa79Zd/4Wz74YllSuHyJCrOfVA4KL740SO81dPpYV/Q6mM8iK
 6dpyKNtUpFWt6m2W94Fqvn3pWinWTIo=
X-Proofpoint-GUID: z9X2ZFZJNVGVtuHw3jR6VGsPHnYulUZ6
X-Proofpoint-ORIG-GUID: z9X2ZFZJNVGVtuHw3jR6VGsPHnYulUZ6
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5db4fa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oUXKLYVmuaQ47iviHu0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfX2naI+orUavLC
 YEfFTQyy7mzygog2m86FQOPk0eSS2o2qtgb9CSo8HMEVYB3tY6cvMhv/eSJ9JMLl6vdGk5XXeU2
 Cp08HLWKfEK9/WdtyLxwTZuR8VnndlG1lb5/2j0S9gKVvIHB7MmUgub5Pk6z9QY+obodG/L6frX
 4lXhPv3wYr0LjSS9P0AKLGimX+OsjFK4bv9HDUl61LIOeLcu1rxKl6+kob3EPJ0xN+D/Ybm6f2W
 /89VRNpEpIKeUO5YlOaY8synXUbN8Rt4STmt2yDXJHIAYmBfOl+Mhbk/FSvTlAJqgG33jNAyOnO
 9EdOkwKcC4eLYbNzJ4B1noxMxm8i1trUkr/7+BLyV3Eb6yuf3uiOzvS3A9EXqSTbKocXhqLTSQ3
 7DDI6F0ConBvksIHmoCoov/TAElVCq4gWryvsybX9zW39EpotprhCO7o5ZL7idN/C9Usng/1Wpm
 4x+S4OXV03O0viw3L5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200060

Kernel change link:
https://lore.kernel.org/all/20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com

---
Zijun Hu (3):
      doc: hci-protocol: Correct mtu to &mtu for getsockopt BT_RCVMTU
      doc: hci-protocol: Add sock option BT_RCV_VENDOR_PKT for HCI_CHANNEL_USER
      monitor: Add generic support for vendor HCI frames

 doc/btsnoop-protocol.rst |  8 ++++++++
 doc/hci-protocol.rst     | 20 +++++++++++++++++++-
 monitor/analyze.c        | 23 +++++++++++++++++++++++
 monitor/packet.c         | 26 ++++++++++++++++++++++++++
 monitor/packet.h         |  2 ++
 src/shared/btsnoop.h     |  2 ++
 6 files changed, 80 insertions(+), 1 deletion(-)
---
base-commit: efd216fe280ba5dd38d1b6084f64784bf1328731
change-id: 20260719-vendor_hci-188fc539d7a8

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

