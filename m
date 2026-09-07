Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D744248BB
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770758; cv=none; b=CyEOD4K+aFlp3KgZuOFcbCgtMEHj7yPwC6fxZYuoFxcCFuorwu5jqUbAOb3XyAuElOUt9eFojyJv+y1ilASnRF2PKDgIyIRDRdP9FmQx6Y/CulzrN1nKDYlX7a6GlE779tQSfmwzHz4yQ3R/2CWSShe8AbV3ZMDLkmbisC5EY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770758; c=relaxed/simple;
	bh=1YVuQIRYSqkNtX77g8NT7j+E7lFkBcy3hwqxZOroS0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RHVz5MzoYsfgbvhWe4qvbo9fQOgFSafSkl3ap4k+2vaQj3JTtqwUvieH7LJ3tP2Xmnw4oBLX0OnpNatbhFxb1y3SgQbdYBBwnbgBnZbwnpC4pxDAxfzAzB3+MbayCA9FzBaetq0QDGtZNPwMM7VKHxH1eV1cC35yUQiOzWF2LWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kTe8eMD/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jMZAP5Jj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kTe8eMD/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMZAP5Jj"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777fgC2146300
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 08:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NzkvIz4E8Bn94zq8Ipxaeb
	3rY0VkEU4sbNM/KCYhWbw=; b=kTe8eMD/VwQniEkZyPEVf3PxaSUvVj7+v/mJHW
	VTjfq+13qU3IIFTUGmCSiPsNWLmwHaCPU5J4KpHU1vzbOWkpsdyJhKDckUsOxIQ4
	Lp75wd7x66qLcPMSW99XxSVZj9fSxlMfFFT8Tmcvlmzc+3qSofpwEgk1PRA7xlc+
	agJGfnd121ZvnNUEJQzgJKRyf2Fg0dvngOa4+RPyxEg2OCEFS0EO3GeIYa7fe6O1
	jsNb5koSoWRjw+p3x+stGRCFHgFMrY0eT7UQVFvQJ8QIq9Hbz4X7Dh49f44Y7O5F
	iH5FLPmWqQTdT3U1vCSvgt3usZDy9YA7SmLIqwwYT6bdu8rg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8jdwsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 08:45:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39924189378so1094967a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788770755; x=1789375555; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NzkvIz4E8Bn94zq8Ipxaeb3rY0VkEU4sbNM/KCYhWbw=;
        b=jMZAP5JjzD3clZd6euRVlweINPMf3qCSmf4OeNB0Bl9Xh3HaMGyNr0E0OQWPPmYrOB
         CRVlmcp4SkdvEit4orL2j0K5sC3olIFJkx7Mj46UiEr67F19re/ytbWsorCkABExXLBR
         p6sTv3xtK5CPpnNKAR18sfC5RL3GaHTqr3NzUmV4xcteTZ1AXMyi5D+DL7sWkX5fHvWK
         51fxZgN/FoymCjWs/gu6HTScGu2uuA0CTQhQXTKSZgQu+Cdzi3LBSsRHMQvOeUUz9DO3
         Afp4tGkwxJ6LWyA5rkGRcBWrPxBUPDnEZ6RIb3MMGRz/U0u1P22lut0sfK4YKV3VlRxF
         /Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770755; x=1789375555;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NzkvIz4E8Bn94zq8Ipxaeb3rY0VkEU4sbNM/KCYhWbw=;
        b=oxu5dVVNSoqzFFCt2LoM8XHzFE7VWTaRoL1ZIfTacAiDp7fxCO1YmWuKXiwQ+a7DzX
         QBtX3yhyqYOspOqGZsTffPQVFKrlcJzohDAEmq9HKDovqhDXMNT2n5yLgbEIbfGhnHhC
         C539GUHjQv06MOefKZVZY2aA1mllWPBQopeFX53U9MwJnMfDKBPVHXgKD+P7Tps6STMU
         1WaCHNJn6aiv8isz8znL2tghGG4ErLaQLplEykMEPy/RPwvGk1gEIuXQcdypuECSizc1
         d3r+LsjOwK7A+HjWZUAH3blgfC4dmQGENew06LmxB9pNlk9hSt2nD738nLgfBQVhze66
         RbGg==
X-Forwarded-Encrypted: i=1; AKwUvByhODA3AQCljLQ6XF/vbZxPDlvihWmqGnWfEA0ucKtuuBadjBo1cPYL32Iqkzj9zjbt8A87NCjMMNNfipj8S+I=@vger.kernel.org
X-Gm-Message-State: AFuF++mjFZK/XuLKidr0RGNUf48GA9r8jcHbZrpXoNPk/5eESA1ScyVf
	pB9yAbbE1BPbe/B9VyUqAyIYmFFkUqzTZns69Pq80FCRn5H3+l5ocUEwJHnPYyt0Qz+tKgyMRK1
	SSpwVTNvKikRA0OgJY5+0Y+mJ8djWXK8Taosa6wFIgo/B+2+M2xS2B9F+2493U0iFcvI9OvmJPy
	fDLiM=
X-Gm-Gg: AYBFou0oq97fS2wVPCIGhg+ch6Ux374it5gvGeo+c7Gc1bAMJxMu/afMPmMSh7uAhsY
	bcSaIzEv0/tANWrGehVYMJywNA+HaDO7Wuz6E/+YsZOMCRmubnSbWuuwUsXLACdfn6JeMkU2q/p
	b1emvDAUYqrdmtrQMxDFEWGEbPjyEt3+seBam+sd8i0xTR7jkX8Pa5XT0sTpoxUGbssfSnkWw1n
	9VqMSd7BddS/ouCG4l85DubGbz7SgelToQNfkXbr8oP+38sjhI4g0h1Tv9QAb/XnRLs6yy1Lpaj
	tFbPA2pGy4l8v9k/1Lj53Sh6p9ZH/lcsR2c4dP68DIR+RxNx0q+/8sBIdB/gabR8Y7RiZmIdIVO
	o0ar7blVfXkxpBx1oY3ZdaDrr7fhGLBE0MvCJPahWC2SoB/w=
X-Received: by 2002:a17:90b:17c5:b0:396:d28e:b52 with SMTP id 98e67ed59e1d1-39b3d7595b4mr14416456a91.3.1788770755219;
        Mon, 07 Sep 2026 01:45:55 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:396:d28e:b52 with SMTP id 98e67ed59e1d1-39b3d7595b4mr14416414a91.3.1788770754682;
        Mon, 07 Sep 2026 01:45:54 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm23622117c88.13.2026.09.07.01.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:45:54 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v3 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem
 QCC2072
Date: Mon, 07 Sep 2026 01:45:37 -0700
Message-Id: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALF5nmoC/2WOyw6CMBBFf4V0bcl0QARX/ochpi+kRkBaaDSEf
 7eg0UQ3k9zcmTNnIk5box3ZRxOx2htnujaEZBMRWfP2rKlRIRMEzCDHlIphdOLUS4mwQ8qFKFj
 ORYoIJNzcrK7MfeUdy1d2o7hoOSyQZaOyXUOH2mr+5e5Y8uGG1jPKaFJILiQolQE7dM7F/civo
 W3iMBZQbdzQ2cdq7nF5+JZM4EfSIwW6laBBFkoVufjnlfM8PwHBd6nXDAEAAA==
X-Change-ID: 20260824-btusb_qcc2072-abb918ab4220
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 5PSX4LMWsqV7Qz2pMLIOSto4N6ajuKyE
X-Proofpoint-ORIG-GUID: 5PSX4LMWsqV7Qz2pMLIOSto4N6ajuKyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX+txSbNUEe4OV
 1CDkbjbwSViAv7QA8yJ9o4Ci63zWVSwvWmRyJ76grIAcn+WgHqTVNeC1p/sQwOR0yH38qTeqzbd
 sv6h8qCFcr8UIkXPiZ9YD4lUPFVqFauXcVdu3TqvksQz2/VvNs4WL9oDJp/FY+LIFPzsJcMpfMS
 wlC39GqyN5qBE6nzZrCqN3QtlY7H71NQDVDw2gwJLwWEm1Uh3qDZTZOhngCKjueJx8cp/1D4LwM
 AQTfnLdE+UJhSN4hdx4Yv1dB5lWTWMyGjfxqG6BkZaqfsK2fqmyOcxrvS4KFdb5iurlHjsFccXo
 jAq/DpF9jl5yCJSB7T1vk6huVFbB1J4AuPxhZb8Hc+SZ61gUg7qXR2A1Et1L9qiTMdnHVObHYfk
 /GgXqH3yImXkz4jDHxbhovqFdtvIsjjmnFCaBt8A8s2UVPYA64wU0wnRvCOTolB8aLeq8wKsPR8
 dvQEgX2HJcMtZoQ0DLg==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9e79c4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=wiGumk0A3tkkXcSz67AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX85rFrjPrmaMi
 kz3bwSFU2vVr8qBERrQPgjd4TjaBeU3XGiTUylonjKpVXw9hKkHauBaNFuVZ3Xk54auOBulgAt9
 HlcXzKk99vkqtv25dWoOW9uYQQUUIM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070094

Hi Luiz,

This revision addresses issues reported by Sashiko. Fixes are listed in
the changelog below; false positives are addressed as Q&A further down.

Could you take a look at this new revision when you get a chance, and let
me know if you have any further comments?

False positives (no code change):

Q: Does this explicit padding with null bytes break userspace crash dump
analysis for btqcom_submit_memdump()?

A: No — this header is internal and appended as dump data. Its fixed
512-byte size is enough to delimit it from the dump data, so it doesn't
need the text end marking like the external file header.

Q: Does mixing goto statements with guard() declarations in
qperi_try_wakeup() violate the scope-based cleanup guidelines?

A: No — all the gotos happen after guard(spinlock)() is taken, at
function scope. Since every goto stays inside that same scope, it
doesn't violate cleanup.h's guidance.

Q: Could this cause a kernel panic if a zero-length packet is received
for btqcom_recv_vendor_pkt()?

A: No — not reachable from a socket write, recv_vendor_pkt() only runs
on the RX side. And skb->len can't be 0 anyway: btusb_upward_frame()
pushes 1 byte onto the skb right before tagging it HCI_VENDOR_PKT.

Q: Can this lead to a null pointer dereference on the transmit path
for btusb_qcom_send_frame()?

A: No — skb->len can't be 0 here. Both producers of a HCI_VENDOR_PKT
skb already reject zero length before reaching hdev->send():
hci_sock_sendmsg's "len < 4" check for userspace writes, and
hci_send_vendor_frame's own "!len" check for kernel-internal senders.

This patch series supports Qualcomm multi-subsystem QCC2072. The first
3 commits are simple dependencies of the last one.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
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
 drivers/bluetooth/{btusb.c => btusb_main.c} |  126 +-
 drivers/bluetooth/btusb_qcom.c              | 4514 +++++++++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h              |   99 +
 include/net/bluetooth/hci_core.h            |    5 +
 include/net/bluetooth/hci_mon.h             |    2 +
 net/bluetooth/hci_core.c                    |   45 +
 net/bluetooth/hci_sock.c                    |    8 +
 9 files changed, 4814 insertions(+), 2 deletions(-)
---
base-commit: 755cf7adf8dd2d12627cb7de223d35b12228e2f5
change-id: 20260824-btusb_qcc2072-abb918ab4220

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

