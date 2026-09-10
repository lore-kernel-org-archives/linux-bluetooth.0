Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2262931CD
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050949; cv=none; b=mBtghAqnONz1yecx0hI/AbmETlIgV0RmE1g22TqpPMb6Azb3ThkusIQwcMb+rDVte361lv9CyvUn/Zt2TBAtIm7NCqgYHsEvD48X0SO7nzEgCL/cSfAps2li5UI9sZqfNXYxldnMWbkUqiGorsnpDw3lKGLr09p8TUe3KasCEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050949; c=relaxed/simple;
	bh=gyIjtai3FPdjNhwgiTWZ85vEZ87YqCCs99cbS7IrqwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gpBeQ2ES8IKYtr8uY2LfjQukS3PkUV0+MDc8+qYACaZhpIAewgd7hjjKu5xcy6DHfcHl+ZIq+Plz9m+LghJdE3NukM9RRqCwglL+xpY1WhH+hM93qqn5AiOrUemuUani04sjvbFOEQEtZl4u5ezRmqwEW6xfBccg88ewWGVJoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPOpHo9M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=da1vizNc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPOpHo9M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="da1vizNc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7je01242004
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iI/I1Y90k3wTNupunWuPwY
	ZhHEdHNfgMTHLTvCVK+nM=; b=iPOpHo9MjgpwY7ZsfnyDy8PwJF68rcPF6TDQmr
	NwnBWSAad4HGCrUQIt0OxD3ScypAbAPt3tE+nlVXjahepzyABPQSiAU0OyLkjKZw
	Q1ZGW0uC+LA8ui/5Z2Sv0M1Kn3dUsHxdl0jkY5uIfpYNQsmvFcLxzqtFmNJRg5my
	9qDBYqhpKmCbVcl+ZIQNXNAkeHTVcIEaJr5Nkx4CNPUWj0UmIi9Gu7nXhvT2r1ox
	HsC9z03ksNKIvYu/hoHE2BNHFOpJVCR7hPHX/yp63rynNGWV2dgoFLWx6geow5O6
	h/zbE4yrC7sxhrAPUd7OrKzv84/124/UUl7R2bkY9CcK/NNw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrcjst45-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:45 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b37f6353c3so485652b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789050944; x=1789655744; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iI/I1Y90k3wTNupunWuPwYZhHEdHNfgMTHLTvCVK+nM=;
        b=da1vizNc/kvdHRFSu0GU26vxGJF+ghldPM1SVCww5aTgyRUCppEWAnxCn3EMtHPea2
         ya8efhXWZYELuQD/DZryiPuWj8nWZt7+SzyHfVcgRGfsIJwpbTsLWulo341ztG3/4wgQ
         nE0FvBWfIva9Bkx1XXCp8QFIpu5+4nKcV1pKM97GiOffb7gIzOQH22YlOsJfb5ZQLrfm
         kB5BrSbJnYZV75SJzB+xM/fafR/2JpaPR1pNEE5awtOtEA0CJi3ftPfUZ2nN8esscezi
         8lGrmPeDH11upuiX4dnyGLnPj0fcXLvzPA1x7Vuzbjd4Up7BKnPbD6tcnYJBrWgOeoRX
         vbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050944; x=1789655744;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iI/I1Y90k3wTNupunWuPwYZhHEdHNfgMTHLTvCVK+nM=;
        b=jkAHGsiXrqa7JO/J0oujZrjL/9b7aPC0yuSq05Tzs40DOOy7t4w7oDBgtipDFcMQsf
         j5mkRGvy/ZJcRXQyyuZeLM/a9marb0DGiJO0KgQy4qZP7msKZ/0QeTJ9e2ka2evw0Y7y
         ueRnwJN6JlqsIpbc6/KKdLcm61sijdkdYe0GRmrUxnoYrf6h65PI0AU8p/RYZ70jbPJA
         LPwhJo+ZxvqPo3Px6VdZFHQ0kADaMx3kjXIkHFhwL5CQLlCgHyZ4HqplRszAikox9DpX
         5UCeWXgt8h+UvOZ2xuOPv1LEDjLhfp/vkEL1zA75tmEBW6s9JPvPzVb7hBQE3D4rQrVp
         h50A==
X-Forwarded-Encrypted: i=1; AKwUvByoNNeaUCsufBum1MUj1F9afKAbyIia3fZJ/kmBq35oKJpdGbnz70DRZotTFHEiZkB2dnO0emIM3HCQuUKZ4JQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mREEDbV8pyY+id9DlsT9WR767gNi5JqIx0gC+c42QrlvHBM2gy
	CPmlBV8+9He+k1BX4+r2Q28tYmnL/kj0TnqI/7g57kPBVprTI0GlGw8CwHZ4hB3IVqGv3w243Tw
	TZiJsiqlGPqI/VOvbzNfzFh7TPv+qXpS75cfbv7AaSCNdvq2r3KfjTavIfr5lmT+8GLRSFtTN7N
	25uJ4=
X-Gm-Gg: AYBFou37wkxFk6tw6A+2te4/GE+zZwYzJlVwKG2Iq1rSL83CyR+C5mtTsKIfYwytdpU
	Pzd7EQwRumgt1Dm9Ar5mlfKRhtD4Ycs+1uyYSPIdpymOZQLIY0mv3MshbPxmgkqxWVp+XRjzq6W
	M50zv5Ug0VHfjaVJr13vagqXvpRvOcTsBSXTNmN8x2y8t6MVVtd/boG6Hprt9zXXc0lQsixUzJX
	djh3nUApeDIM5sDu7uqsevF5p8Obsp1WEVs86pEFV2p2cwpXD8oeRJ8jv+htXm6ErM6yl9GbOtm
	xSwadZXSrKmsNDvBuR3kVz1062luEWFSLlLZvht2HjHvEl95mmGgrxlkGEmXf0wMDV27jLOP33V
	rHEqflB1IM0qHLphakgdia8r+S/lHmhvB2QlSfUJrejulix4=
X-Received: by 2002:a05:6808:3089:b0:4b5:8402:958d with SMTP id 5614622812f47-4bab05475d2mr21914807b6e.5.1789050944376;
        Thu, 10 Sep 2026 07:35:44 -0700 (PDT)
X-Received: by 2002:a05:6808:3089:b0:4b5:8402:958d with SMTP id 5614622812f47-4bab05475d2mr21914780b6e.5.1789050943915;
        Thu, 10 Sep 2026 07:35:43 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971246d9csm19056119b6e.7.2026.09.10.07.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:35:43 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v4 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem
 QCC2072
Date: Thu, 10 Sep 2026 07:35:34 -0700
Message-Id: <20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADbAomoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MD3aSS0uKk+MLkZCMDcyNd88QUMzPTVBNTM4NEJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAO4kSCJxAAAA
X-Change-ID: 20260910-btusb_qcc2072-7ad665e4560a
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfX78Xt43E5vyXB
 j2sqwzPGx55azYsad09UVhSFsVeyX2htVNIRE11iMQ0RrmA7LqHFPsPOKlPmUQ+tr5dtRUYPQIB
 ynK6tujJBHdroTgsJAmY2uiZivP6FY0=
X-Proofpoint-GUID: CigHbgRNNJHRif5XnzqOO66pqYCnvKnO
X-Authority-Analysis: v=2.4 cv=aef0Dhot c=1 sm=1 tr=0 ts=6aa2c041 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=wiGumk0A3tkkXcSz67AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfXxwzMd1YUpr9d
 i9AsyDrqqBmWCkFVGv+7DZva7bmYhssrPeYsvWkxthG/aNSI/A0zviltYCigoH5CNN5I3/KdBZh
 BPJwDYRcZwJKrDvPWJsJZcZ/DU/rkDY+iflDtJUjTTa2DSdOWXyQ1BSLbykpXelc9LoNYKpX0Dp
 xeS8FtSB5z/FpmsZ1PYm0zmMEF42IovGByu93cpCQX+pCbdTTsJs1clrvmHWcwg9xSphoY3XtMU
 kDIVZegFavsVIDFCE3WGH6ugrT7AlGhroVfWuFnq17GSh5sMzA5FXLnZiaBDYpscliJLiNxNvul
 7TkJUgKDQfQpnhMMMtQ4zV1pzpJYs0eBRh+lluwDTskX9PZuHn6PspPrOJSMPhQyyJkUQvRcQsi
 u0XuXyN+ZxbpckAYIqHgwlMfBaSZR7qBdyJmGBPKJb91jHA9UZkLAdQP9FrN/6peC9cbexbA8Rz
 HyEBrFOvYA0/tJ1PbeA==
X-Proofpoint-ORIG-GUID: CigHbgRNNJHRif5XnzqOO66pqYCnvKnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100176

Hi Luiz,

This revision addresses issues reported by Sashiko [1]. Fixes are listed
in the changelog below; false positives are addressed as Q&A further down.

[1] https://sashiko.dev/#/patchset/20260907-btusb_qcc2072-v3-0-1f65350b03b8%40oss.qualcomm.com

Could you take a look at this new revision when you get a chance, and let
me know if you have any further comments?

False positives (no code change):

Q: Can an empty vendor packet cause a NULL pointer dereference in
btusb_qcom_send_frame()?

A: No — vendor packet's skb->len can't be 0 here. Both producers of
a HCI_VENDOR_PKT skb already reject zero length before reaching
hdev->send(): hci_sock_sendmsg's "len < 4" check for userspace writes,
and hci_send_vendor_frame's own "!len" check for kernel-internal senders.

This patch series supports Qualcomm multi-subsystem QCC2072. The first
3 commits are simple dependencies of the last one.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
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
 drivers/bluetooth/btusb_qcom.c              | 4542 +++++++++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h              |   99 +
 include/net/bluetooth/hci_core.h            |    5 +
 include/net/bluetooth/hci_mon.h             |    2 +
 net/bluetooth/hci_core.c                    |   45 +
 net/bluetooth/hci_sock.c                    |    8 +
 9 files changed, 4843 insertions(+), 2 deletions(-)
---
base-commit: 755cf7adf8dd2d12627cb7de223d35b12228e2f5
change-id: 20260824-btusb_qcc2072-abb918ab4220

Best regards,
--
Zijun Hu <zijun.hu@oss.qualcomm.com>

---
Zijun Hu (4):
      Bluetooth: btusb: Add recv_intr() hook to btusb_data
      Bluetooth: Add generic support for vendor packets
      Bluetooth: btusb: Build the driver from multiple source files
      Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

 drivers/bluetooth/Kconfig                   |   14 +
 drivers/bluetooth/Makefile                  |    3 +
 drivers/bluetooth/{btusb.c => btusb_main.c} |  127 +-
 drivers/bluetooth/btusb_qcom.c              | 4542 +++++++++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h              |   99 +
 include/net/bluetooth/hci_core.h            |    5 +
 include/net/bluetooth/hci_mon.h             |    2 +
 net/bluetooth/hci_core.c                    |   45 +
 net/bluetooth/hci_sock.c                    |    8 +
 9 files changed, 4843 insertions(+), 2 deletions(-)
---
base-commit: 1b737f2ef1686d0e5a7661eaeb097aad53ea7040
change-id: 20260910-btusb_qcc2072-7ad665e4560a

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

