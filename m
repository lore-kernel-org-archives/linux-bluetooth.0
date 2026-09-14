Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CA282F17
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354061; cv=none; b=M6VSh1ZxwK5ytRwh5XOFnyfC8ZLL6gl1SaRAdWglNOK/XINcLz6nBIuY4bRdSJ+O1iBT+SxKtVIK7bf1BjiO8lNsw3DsiP3Vb+nEF5bL/ytVGIyFtiWRRM7UYul5yYX2KTK/CrpftqMLrqOy8tjpGyJykBLWbPUjJIpUacSkuAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354061; c=relaxed/simple;
	bh=a6Yno54nqHU7cYDlu6Q0S8ox9MzBTtsgFRIu4xEYyqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I9VL9GtgYoOg1iUMEboS3v6Qr9e8f1QXiZubbe7MDJE3j2iRRMpoLbRBnkzRnXGGCiARddKJSDDK+tllkoZ6z0dn9jhb11PB3oKKnAeiNOkLATRy1nIUhtV6WH6jJZkRRvU8W4vVs1CPgzIVm2YoscoEzI8wdBeK8jaUKoV/zWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1AHyY3w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FB7cEFd1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1AHyY3w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FB7cEFd1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eZi1404295
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fXIWh2otWlZ1HqNX2hTmG3
	Ruod79Zf3T797/xBE0vMk=; b=Q1AHyY3wsr1nJmTuT6T4Rv9xsHj/s0kApSncWb
	leAZy2rXrQLLVDL8v7az2DJtgUYTNmNSrHKXfuaNcZgNpHuve0rZcrZzJ3P2GNLy
	z+AEWnZoVnp9uniLlT5UjE/ysBgRy4P4O8fJVTLK0ZnSg3VpLjYvqn4CwCi/15+M
	ssuUGdIsBYgWwi55rhKOXpbSeaThHayw15kydc+2ms6euwqyFv73eNFQtIo9EjkP
	5XrWl0rw/m5FajhXp7HwQC3r0bNwwsKYHeFH1fW9TzEn+m2y+dGTtUs/tI80twzH
	u/4d+PenReG6OER2uBcJXi8QwPjo3zA8gjvOM6S26V0hh0Pw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cmqx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398d3a12589so1005700a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789354059; x=1789958859; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fXIWh2otWlZ1HqNX2hTmG3Ruod79Zf3T797/xBE0vMk=;
        b=FB7cEFd172IA+PJIntxLCqVl8jckMA8Ek9+PYL1glRc+8ZNEWm+Od2OYVrmyM7IXur
         h9Hc0bimYL16+AfbR45H16XOFdm0XmYFrCZ3nq+c9z2QRfXSIF9EPCCVZItIAn872bT3
         C5sM6AGzKLl4QTv7iDyz24hEKsNmux0qKio/hNaI0CqlozutK5nKXMC2kG7x23xGvUON
         +wa1azT2C3QB1WGD6uu2a2xXijp3S/IBcqBiKq3TbzvMGAy4uybZeGWSm8k0qbiBRPTa
         sT6d0xIXg/WwnQKdBVVZYXmE4Tx7SBU0fT96CteJejXkCfx6DMJuUz0dFL+yOSfqowzW
         ziNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354059; x=1789958859;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fXIWh2otWlZ1HqNX2hTmG3Ruod79Zf3T797/xBE0vMk=;
        b=qNqnKvj9F9QBcrtgYMdN5fMUuS0r78jnQ49KAzAPEoqXRH4EylWihsvzrrslipNlA3
         kwfRDvo1XgKWR1Qd7A6/U4+/6hP3SsioZWcU4k72XnVM38O26mwKWWr/U9/XGUhNe7lh
         ecJA8Pgeb6ky+GcnXtIPVBNLM8wR4lh0eXcgDt9Oz/zxtHDYxqgPRi7B8EFkfjIZ6YGV
         rs6E99s03GrsVRzkWLGLJ5FVM2FO681kJU7uiw/FivP0u1mmPqN0xAJqDt8CQQe0ATKT
         gef3Sggnma/rj43CzasNDo7seUip+2Rzcc5CKEjvkZUHOXLPLQXedzUIlySk58hxag+h
         +azA==
X-Forwarded-Encrypted: i=1; AKwUvBwxuBF56I3i5SSz8VbWO5bhQ6l2LSLLrqpVKbxreIz/3PMNwGSuWKLCrigwunGF4Wclam4Gxlcy2shYon+wrnI=@vger.kernel.org
X-Gm-Message-State: AFuF++nYnKCu32K2Io1syzr2JFpRd8OsMstlooE4F0Z4MGLe3wMxg1B4
	SK0uMowOJmsCoVTJTzkbsNAIz+xNMtSF8xBoP3y5RaJR4tSImKDRMmY2wzCKV2YDwaTHiE7V4qB
	jX7UWM4OZ+iP6WU0MneSQH9CY1xQNzHKeA1AqPhaeyr44eygbGEZadxpf7SWSRI7/rTL2BwQ=
X-Gm-Gg: AYBFou33tOOtPry0avgFdO+YGDuWEUBgfr+Qt6zbwAQlcc+hKOHI+pLsl5inXJQ6Yrr
	5Z1g42qgeWbNo8Bih2jEot7lDQ06xG8OJqIpDUqrW9Vki5f3F0or3B16BTJhEviwB9SS3XKBoyX
	wwnjodzivNeSMm/YT3kvnmf0DxeRg6pTR2m3eXrIXoOXJvPzbnb0bpjM2iE4akUr52DCVy2rtCA
	wy7flukoCBD1hjkGRd0R4+16y4adTW88fAbbwmk/ShbEBfFk6Nnt3H1oU2HJXO4XriREpYrIo2K
	U3Snow9m8VdTwRTPYMGrXGh9yImDZQEhMMV9PyyIpVX46YXqjTodDlUr+WsCM+g7VORTv+3osPa
	JvV4gYMgikbaxUEizdGuaKKjtkbKT94MOs1sWQrWCL8HI1gQ=
X-Received: by 2002:a17:90b:440c:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-39dec137c0emr909945a91.3.1789354058911;
        Sun, 13 Sep 2026 19:47:38 -0700 (PDT)
X-Received: by 2002:a17:90b:440c:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-39dec137c0emr909916a91.3.1789354058403;
        Sun, 13 Sep 2026 19:47:38 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed295esm25945014eec.15.2026.09.13.19.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:47:37 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v6 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem
 QCC2072
Date: Sun, 13 Sep 2026 19:46:42 -0700
Message-Id: <20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJgp2oC/3XNTQ6CMBAF4KuYri0ptT/gynsYY0oZpEaotNBoC
 He3xY0xupnkJW++NyMPzoBH+82MHATjje1jENsN0q3qL4BNHTOihApS5gRX4+Sr86A1JZJiqWo
 hODAuiELx5+6gMY/VO57e2U/VFfSYkNRojR+te66DgaXePzswTDDIoiGskkJyOFjvs2FSN227L
 osHpYnAP5H8G+ERYZRKzhoG5a74gSzL8gJzqYVCCAEAAA==
X-Change-ID: 20260910-btusb_qcc2072-7ad665e4560a
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfX/5z3wjLuEo5D
 1SJCFTDW6ayUQ3MTmi8HsDWgtMkXtrJlSDvtEB2PYjm7Xt8GrD2hutNjxTI0GqIFnxiL5py9whO
 rhUwDI1/PTfB2H/56yKdb3L1LYdBPH9n2kqEmaH1KNjt6mzHrjgI/Qo+D1TAg3L+xqzi7sHdovP
 4wV9jbY+dM1aim4k6z8VFaQfnIS/jUQUDZAAluP3mnkcrLaAW7wfZPpKgbJfdkWwb2oeg5oULJe
 +RJajx2wXdcX9N+Vu3pzRCHflj8WhQrM2Na75jBxW1BN0mXUiKlMUrtakNrd386KhINuo+KxKz+
 LODP0xZwYW0Av4wKET5yY6+q39YqVRELlQSTyjoHwezLNkR63EVO2qtuAgnrfmz2l1JCr4s+Dcz
 JBALK1PKauNR2bMmOVbdKtPO3lBAhShc4f/KBTCXF7ykSQavj0ucPIhG8BvEX19kmM/0Sh3Kg7o
 kRzPc/I6akEuBHdpFGA==
X-Authority-Analysis: v=2.4 cv=EMyTQFZC c=1 sm=1 tr=0 ts=6aa7604b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=GzXLaGhZt5Xyy9u-jrcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfX93jTUe4vM4VI
 sVwGAQXsHwSPK2mt4+n7DtO05maVRqw7Cf2YXqH2JRrCDxaCsk8AAbPLl0svs4KNXHBh8oYxzA/
 OOJDx2D59GYwLqwt0KQ3hTfGkxbdn8A=
X-Proofpoint-GUID: -hCJa6nlQws_NDHgXzx7a74gAhP3CbBy
X-Proofpoint-ORIG-GUID: -hCJa6nlQws_NDHgXzx7a74gAhP3CbBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140035

Hi Luiz,

Thanks for the several rounds of review.

This revision only adds a minor annotation to avoid LLVM 23 warnings.

Could you take a look at this new revision when you get a chance, and
let me know if you have any further comments?

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v6:
- Add a __context_unsafe() annotation to avoid LLVM 23 warnings
- Link to v5: https://patch.msgid.link/20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com

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
 drivers/bluetooth/btusb_qcom.c              | 4557 +++++++++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h              |   99 +
 include/net/bluetooth/hci_core.h            |    5 +
 include/net/bluetooth/hci_mon.h             |    2 +
 net/bluetooth/hci_core.c                    |   45 +
 net/bluetooth/hci_sock.c                    |    8 +
 9 files changed, 4858 insertions(+), 2 deletions(-)
---
base-commit: e40edfa049b967f0b9379bf549c59431302ad181
change-id: 20260910-btusb_qcc2072-7ad665e4560a

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

