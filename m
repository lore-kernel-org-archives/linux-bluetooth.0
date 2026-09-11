Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AE45C6EE
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113615; cv=none; b=pyJxw9OJBLAwq3sEyUr/qHm95zbk971QqpsQKd6HRgP3d7P1mOfyJmvT8oF+BXgIjKsv3WTZWk9A2dTDW2Y5axZRg5KpuGX2sojvqdddXF+kZjj/qBXN4Jh+HmlL7iOJEQHNsVWYtgfS8wp7l1hZZbUfvxURJo72XZFipCv8OnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113615; c=relaxed/simple;
	bh=EwPXUXC2fxq0JNrsRaQREfqrrUxJtknUPG9TiMgkmXc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SDg5SUt8h0vkPS5ofG43w63kx6l9sE8lsEdfIvuwJ1+W9UvUiGYH5JvNrqDE2Ij/npDrKIzodAs7UKSpc0jRYrJzEnl70IX0D3nWHudf7GmpYM0QNK3odbDoQiLNyrQWO6N8yoGOJrLzoFVBk7TW/udV/jTrtlz0Z05/z2zIDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lxya2oAW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B58b2dnT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lxya2oAW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B58b2dnT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kt0l4046297
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wd7TRScq0brNDLdWzIpBoW
	yob9b2z27qxmbTlJFvVOM=; b=lxya2oAWAMwb9IGqhVCpGl5YotZ6dbj5JJWVQ9
	6C8uRwnOgK3EDUoVdfIA3U0LvcNJSZSQk9iUWMgzKPulRE459dhNiuP0ufcZM+wt
	xi9N29bgMiq8fx+cNvVqADbM80Sid/oEaC3CsWQi+W083232Jg+jWKERAxnBWaAI
	MxXi0U4BokpyqW98nAvU32AFw7HN8I40dllA+i/JLnuGaUdQDRMIm6xCM7XsBTvC
	Qze1Enfxc2F4q63MyVIojs8P+9iZVTKHtzXWia3mjIqeJqVvq18ciJ+KvHlaJ/6G
	T0TQVc/UXNfwR50lFeyy9D3fs88lP9RDJ6PUN+06EC1zum3w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm2q12e0x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4b4f00f43so16810a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789113611; x=1789718411; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wd7TRScq0brNDLdWzIpBoWyob9b2z27qxmbTlJFvVOM=;
        b=B58b2dnTf7Nk08tRQrlE51p892GdnuE7FA34y+h3O151jMJtzHJ8E11ItkOZyWg6xk
         0+p9JNDBgOriovc9yV2QA9Qifdj7f3/7o+51AY/+/umj0i7WN1ZnpXaUjjWz0ByDTtxa
         kYv6oI9uxTB9rHIDtElPYOVD1CWP11swAV/svOdkQEnzSWp0Rnnq+DZRd1bDfXelkeV1
         5zI01OMwqWQH1Lpj7cdyPXm5z5Peh0zVzMUtUyRx5OsMd17olWHfNyNaqlxHCm1Jspo9
         oG/0kLX/QpFqFhs5MZ8mpIf8pJKP2r6aFbaY8QFSj0UiaDnaJrM2gs/kXHJ7VT98mzCb
         cEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789113611; x=1789718411;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wd7TRScq0brNDLdWzIpBoWyob9b2z27qxmbTlJFvVOM=;
        b=J3nAqPQeACyJvQ2Wz7xyRuGk4mmhvETN7mXKXVW8sSugo7ugyx6YKjPwxnu+JJQ+j3
         wU2GLQfCNoPSqEP2AOfRHw16bZ5mpVShK/r7kjQDOQJPGp+6e6SdNaLg42nH2lZoplZw
         2APjSaR3SFFxu6QWh5CQnZhK95UZ2rYZ+DADC4xHJwkcLnaP5r6l/j2K0B8euvzXYBc7
         ZDiUK8GSZhUgV18MWIwc4yxmz1LyhvcnRWKu21th2EyHw7Wr2sC6hO4fMoXTw0hKo0Yd
         YeXQIGD5pdUDegYffnMCmsUa2VL/amRpJAP2z3Nx4pJwUkL7Z+S2u84oEgzmLtyfwAe/
         oI0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzOU0ns3TgFf86cmR53AdWrSysdcYEGRkHpCpbEmIo3k/K4E1nqOQMBA7u92Or8pYv70TVQYz1Po/InhbEdrRo=@vger.kernel.org
X-Gm-Message-State: AFuF++nO81OjZGa6sxShyYVCQjdnnzlcQeTcQYYHvs8OMBbonkM7NloV
	n2n0wlMIM3Wnax6W/8/thrhrD+ETrVWa5oP/nXEUe8EITKFeZUADL2FhZfZ9eEqiveMEdxMNzlK
	0LrHVQjgAj6/ZGlmR2LHEvRoSytbiOFqGQYMUQSibMTNqQaR+rSOwTJ3hWyiQOKUs8Nu/+NtmZ7
	nuRO56vHcE
X-Gm-Gg: AYBFou3Gecqeo5EfEuLJISslnc6KctkKwRvhMn9cXJVrWmxJCgzmeB4ell/gf+xFkho
	+jDqZifnlUaDI9wfbtERk4QTB48wMXQ9XmyC6oWiTN8c5Clc0UBUGgfWpet9SOdhpYywqw+8lG0
	YYm1evbKkwqJ5zDUH44aFjOZH8GdFps8v4Cr45mAbB+T+2mb68T80Okj9B0q76u5nQ5rBzWTflu
	PgQEoP4dLIzqvv6bzosZBjbb3GGZ1rtfsgx37GlX2HwgaUw8fi+KUMjI3ZO0yAVfc+LCPRMaZOW
	pyzlnESVtySsURre7+0iv59/cVW1bY4qIBGb4xsXf2c+hz+XoWKM240DSEcXXYK+jE4/pLe7PHr
	/kdeHBFsTqV4qbAtJX9ZCNh8fz36vjlAbNn67ny4SU3euIw4=
X-Received: by 2002:a17:90b:3904:b0:396:d27c:8696 with SMTP id 98e67ed59e1d1-39d9c392a75mr3323420a91.4.1789113610999;
        Fri, 11 Sep 2026 01:00:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3904:b0:396:d27c:8696 with SMTP id 98e67ed59e1d1-39d9c392a75mr3323377a91.4.1789113610507;
        Fri, 11 Sep 2026 01:00:10 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf31c1sm4422328eec.1.2026.09.11.01.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:00:09 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v5 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem
 QCC2072
Date: Fri, 11 Sep 2026 01:00:00 -0700
Message-Id: <20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAC1o2oC/3WNyw6CMBREf4XctSW16UNd+R+GmLZcpEap9ALRE
 P7dgms3k5xk5swMhCkgwamYIeEUKMQug9oV4Fvb3ZCFOjMILjQ/7jlzw0ju2nsvuBHM2FprhVJ
 pbiFvXgmb8N58l+rHNLo7+mGVrI020BDTZzuc5Nr7554k4wzNoeHSGW0UniNR2Y/24ePzWeaAa
 lmWL1WahCbDAAAA
X-Change-ID: 20260910-btusb_qcc2072-7ad665e4560a
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=d6lgWhjE c=1 sm=1 tr=0 ts=6aa3b50c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=JizU6EzbmIgXdcvBHewA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDExMCBTYWx0ZWRfXzEjobL5MYQMK
 aRfDkDQGoAobqtd+ve5AKVBvQC5YE5PTwSpps/5m8+07MnFfGHOmmfIePNpnvSiWx5VbF263i+D
 UOyt9wGixhIvjDzYVDhHv4dReVASCJTfBof60NWUNBAXipkbnwxZyD2+Nanwg1UPA7X+je9KbZF
 sivpbFaofcej8pXK7lXpm6hkdJ85e/cZHXXVfzhyHzSev2u04RvdE42NiDjcPVyWIK2w80AH2iF
 Y6CEfVBnag72GrSoUjXRuXjdvXPoOPDPy6meAizY/Icz+Y7qzCz2/82JQqZLcVoYKwv7uZJMdRz
 3VC8Wg9SBlWNQGBZInTaBXzEo02500UJwXs552Z1m0yb39Gu8ygg2bGfiRnM9+G1WOZbu56KbXi
 ADG4rI4mgD/r5NQrZfZ6nuad18YsL4XrRq6ex0jgLZVI9u/eOVrM0AF6l+bt0wxG3vr8L43g7Ls
 jPDq8BSQdm2qVua8t8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDExMCBTYWx0ZWRfX+vpHMwjzST12
 YZDlX0HHT4lN9iB8GBTnp5wPAiB0dg+1C8Y/uFSTNhOFbrbCKRekiwc/6bnO4AHLTcFxqZDGwOn
 yCsmn4LxDBXsFIYJbN8zhD6UzxjIGFo=
X-Proofpoint-GUID: 0oNzQCmQ5b8EG-5TwBE4QNf6NlH-nVbI
X-Proofpoint-ORIG-GUID: 0oNzQCmQ5b8EG-5TwBE4QNf6NlH-nVbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110110

Hi Luiz,

Thanks for the several rounds of review.

This revision has one minor fix plus a few inline comments addressing
false positives from the latest Sashiko review [1].

[1] https://sashiko.dev/#/patchset/20260910-btusb_qcc2072-v4-0-e78f04b7675e%40oss.qualcomm.com

Could you take a look at this new revision when you get a chance, and
let me know if you have any further comments?

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v5:
- Fix status masking in qperi_get_subsys_build_info()
- Add inline comments addressing Sashiko false positives
- Link to v4: https://patch.msgid.link/20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com

Changes in v4:
- Fix memdump timeout blocking btusb_qcom_reset()
- Fix missing build information on driver rebind or resume
- Link to v3: https://patch.msgid.link/20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com

Changes in v3:
- Remove socket option BT_RECV_VENDOR_PKT
- Fix heap overflow in hci_send_vendor_frame()
- Fix a stray NUL byte in the memdump file header
- Fix PM reference leak in btusb_do_reset_work()
- Don't mix goto with scoped_guard() in __qperi_tx_sync_evt()
- Don't mix goto with scoped_guard() in qperi_handle_evt()
- Prepare btusb_qcom for bulk serialization mode support.
- Link to v2: https://patch.msgid.link/20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com

---
Zijun Hu (4):
      Bluetooth: btusb: Add recv_intr() hook to btusb_data
      Bluetooth: Add generic support for vendor packets
      Bluetooth: btusb: Build the driver from multiple source files
      Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

 drivers/bluetooth/Kconfig                   |   14 +
 drivers/bluetooth/Makefile                  |    3 +
 drivers/bluetooth/{btusb.c => btusb_main.c} |  127 +-
 drivers/bluetooth/btusb_qcom.c              | 4556 +++++++++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h              |   99 +
 include/net/bluetooth/hci_core.h            |    5 +
 include/net/bluetooth/hci_mon.h             |    2 +
 net/bluetooth/hci_core.c                    |   45 +
 net/bluetooth/hci_sock.c                    |    8 +
 9 files changed, 4857 insertions(+), 2 deletions(-)
---
base-commit: e40edfa049b967f0b9379bf549c59431302ad181
change-id: 20260910-btusb_qcc2072-7ad665e4560a

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

