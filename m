Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCC207A32
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788152650; cv=none; b=QIlq6EWTUWgt2PIfDQswvx2CbgSrqoe7ljE6kRzJ5mnQIaFMrAfE5+8YKO6j7s/ldpxNLptvTAta6TAVUPPKpfpTsobUnnMcgLeGS/NswVbE1QzZxPoBo/TrRr2Xnc3XhQ7nMo1oA44Nsk5PDf/TOJeIvrXTi10WKEqR79h1KpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788152650; c=relaxed/simple;
	bh=dMqfHbqeByd+EohTzin5vWpPtDe9rTjAsekqHlLwCXA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=csQW30wC5SJV//t1LW+/7r5HxnBEUl9LNf8CLCn9XhVhqbR51h6JTDVbea5Hk9mGkbXTtX7hUxAjpzwveYk9ybBk3Mua/NmEc7Dlj0zOSEoMvDk/qgii3CUnz3iC9Ic1AD2pzfO8TkKKgiUgkKL8om7kHKe62RjT54GwgKyDz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kdRL2jIv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BOR3ZID5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kdRL2jIv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BOR3ZID5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52bos2764511
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w2fb21A2KYHUakY5chruxN
	aS++ck/8P1K0Q3T1Lno/0=; b=kdRL2jIv95TF+piBdBl+M9/niR+vLFO4+jWZEi
	2xGhXtT5wAEnIAXesDgYC9Q2XQt+hgGr4ID3GLQUbui53FzN5bV81gwROhqzRWy8
	uhnrHvm55HeMEadOvapgqfCp1z3a0BOWhhZtAjIcTjK68YzyDXe/3OTbevEfTg5W
	yNU1caGE5e8/bNoPow52b24zospcWrdGcCfLV7dCUB4khm4CFM5sqmV9B/GvPOMl
	FcOgDviRp+DIe+d+yeXe5xhmNT/prmqAXNutrJEVPvNpdWdjtl57LX8UWFO/TyqD
	yYTjOlbFRkFuUHb93ak0vo0H3VtHhTmIFPduZOTvFPpvniYQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqgymnc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398d3a12589so369430a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788152647; x=1788757447; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w2fb21A2KYHUakY5chruxNaS++ck/8P1K0Q3T1Lno/0=;
        b=BOR3ZID5BZAxTm+PkbuVl/ni0Xf5KpYUkrHTisY/UKcyfopWF33U9weawtMm0ZpTsD
         l60TO9JpCuaB+bFkWTQkVBEOoXggTbWemjwtjcVti4lc4178H0kP0rBqrjUcnx4DqIGU
         CYy7Ilxdsag02aDnMnRa1l50jqtODFFOoaGx60EIx32KQf1nyn7jVk6i8w0qQ8YJYOlH
         w91M6J1NDBd+VJvEmbDVVDtHYxdJJWcCAURQzAojIZFjLIrWR7sfoqk7SHwVYZEiilgG
         PmlWY8IV5dq08blLXiE7wNBJrRWxzNOYuegHQplwi44Ar940VAThmOwSGUZDVsodxPnB
         CNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788152647; x=1788757447;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w2fb21A2KYHUakY5chruxNaS++ck/8P1K0Q3T1Lno/0=;
        b=rBtymFoGDj6yQtt/MvFWwHc7niud04G+Onz0z4NKEzzFuUkP/6AYTRYVDXeVnATnP8
         1oZvLfoLGGVoVXson3ut4BPZhRxiFSktcqUkS2QTa0rV9zyZmNJ4wQGQYz8QOjJYuCvR
         tz+deW9lHV5nz2MldKtVZHkO8Ysr2i0egjaMVXyIGHDJUoWydh1wqF2nj/uTxfVxV1MJ
         FQG+FaZBgmyY2u6/yhJWGp6A9+djX9QnqxNhWl9WCCn3Xynp8A9xT3ch0ZYmJVYC/9iD
         b/EpSUilSgpxLQY1cpC3mG+vIHPNhq8bDvFeNVGyqHptMcsG7zd6ZofzeGJIrBcqEd0W
         zcFg==
X-Forwarded-Encrypted: i=1; AKwUvBzmBOrDaBMjlZoxkD6td5uIZp7nc2GHJwHr3B3hFz90ZNApj64E/dl+BH9BARKes57qhqV96shldXuc1Nf9iGw=@vger.kernel.org
X-Gm-Message-State: AFuF++kgvdSeDoiVkCMPVg3+qZIdsSMHugA/1JDAFrfRx81iJMoxOqG+
	lRm0YXp+8k3V9XI7N6JcvWfPwI+AhtSy+BXKjENhKH93/CTyor+axio/A9LfyDKjvAdepw1LiJX
	F0GqnMIteobWUWuz19nEGFJ9hwTAJAXJJiGR8vaVp0HnE8u53EV5ki1SMIlDwKKexaq8l7bA=
X-Gm-Gg: AYBFou3AwX5MMhAcNMzlo4IlBXJ7HQdLKCj0udhkRe961yrYInj2eAkexjJ7heSSjhy
	pwrOplJsSTn9l8Wf9hgQmASdjuUVXKRYZdhROKYcAeZ8Tn95Aj8/NkXDZ9dJPbhs6Tz8G3CTlSm
	FKmKIwRC2o9oeh6qugafTxgr8f0vhwReE5qKLbnUzVGwU+b8stJbBE0X981gHr+6OSCQmh6enQ+
	TCMvBw3jlFi0w5H9Wqau8MNMD27OQRtFHvrCctdvS/lECfnkZ54E3snArvru58+TvYgwEWm50pg
	/xI3eTa188rHvPPOnvMgAOGjSKKfvfzPj9fRJF7gyGY380GlirG/SEa9BJEGc66dDXY5MHB4MJd
	7f9D+tp1rls8YuAPIP9Lslf/stDWMQUoZCj4QqpwbdVpn788=
X-Received: by 2002:a17:90b:5288:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-398babbaa1bmr11245048a91.3.1788152646992;
        Sun, 30 Aug 2026 22:04:06 -0700 (PDT)
X-Received: by 2002:a17:90b:5288:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-398babbaa1bmr11245003a91.3.1788152646514;
        Sun, 30 Aug 2026 22:04:06 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm43017912c88.14.2026.08.30.22.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:04:05 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem
 QCC2072
Date: Sun, 30 Aug 2026 22:03:49 -0700
Message-Id: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADULlWoC/0WM2w6CMBBEf4XssyXtQrj45H8YY9qySI1Q6QIxI
 fy7RRN9meRkZs4KTMERwzFZIdDi2PkhAh4SsJ0ebiRcExlQYiErzIWZZjbX0VqUJQptTK0qbXJ
 ECfHzDNS618d3vnyZZ3MnO+2SfdEG34upC6T/3lJlP29sFyWUyGqrjZVNU0h18szpOOtHbPs0B
 mzbG0u2vBS6AAAA
X-Change-ID: 20260824-btusb_qcc2072-abb918ab4220
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX5IH8Sc3GtA8Y
 XTkQ5vhExSTfHiOj2cBBaFHvnlzNotcynkbRtJtmqAbg6pyaWDdE0yD9k4G6tl1JkMaxAJBGjl/
 uqKp3R1CHrQMKZVFc/W1QNlWmAqbj6U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX2f51Oqk2237+
 Yif18nM8QMJS59H2mk5eUa5YhAPOuLPACtVE5Kq8d3bHdimF1W5spg7wfLuo+SKBWc2oNJrGuwc
 eGB1RhXkwnChJjtT7o5/wZfKUbBOhUD7NvgjvlxSMvGrQQ5UJamc7/l/baFsdrLrCjpPqsVJFGw
 M7EfQcmesEsCIxrWHUadfa4brLba53op745hz7L8SBB7wNg4R5Hop1DN677BfUMiWsBVi+KZ0wR
 fp6eIP0NAgt6FPlje7XgzG6pgpmZrDhWYP9GX4/2oxXljmgMKgLJPOtyjroFeqNvlgS/HgyDySs
 vE77h48eaq8eDcDmTFA2WSOuNS4ogvj0TmLoSAilv+8LJl4nPXdzSA8ccWMBxnj5J0WRx+MBgjV
 iL0vhsGhxAYIEV/Hg9+C9Ad+OYjtBWjOxOymiWSAP71s76JdVWADV6/vnQy1IlPi1uGe0iLdmjD
 5j7QIis4xCD47c7Bi5w==
X-Proofpoint-ORIG-GUID: s9IIb_1HQoH8MW2tQ7Yv4NUXrtWWH5Az
X-Authority-Analysis: v=2.4 cv=R5Ez39RX c=1 sm=1 tr=0 ts=6a950b48 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xa2G615rChn3jUNm5UUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: s9IIb_1HQoH8MW2tQ7Yv4NUXrtWWH5Az
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310041

Hi Luiz,

This revision addresses issues below you raised in our previous discussion.
Could you take a look at this new revision when you get a chance, and let
me know if you have any further comments?

- Pre-process the PERI frame
- Don't hci_send_to_monitor() for PERI frame
- Don't use the safer skb_pull_data() helper

A malformed PERI frame, once identified for what it is, is sometimes still
valuable, so don't drop it early via a min_len/max_len check.
For example, a malformed memdump frame needs to reach its final handler to
abort an in-progress memdump procedure.

This patch series is to support Qualcomm multi-subsystem QCC2072, the
first 3 commits are simple dependencies of the last one, previously
sent separately but now combined into this series, each commit includes
its own changelog below the commit message.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (4):
      Bluetooth: btusb: Add recv_intr() hook to btusb_data
      Bluetooth: Add generic support for vendor HCI packets
      Bluetooth: btusb: Build the driver from multiple source files
      Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

 drivers/bluetooth/Kconfig                   |   14 +
 drivers/bluetooth/Makefile                  |    3 +
 drivers/bluetooth/{btusb.c => btusb_main.c} |   77 +-
 drivers/bluetooth/btusb_qcom.c              | 4513 +++++++++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h              |   91 +
 include/net/bluetooth/bluetooth.h           |    6 +
 include/net/bluetooth/hci.h                 |    1 +
 include/net/bluetooth/hci_core.h            |    5 +
 include/net/bluetooth/hci_mon.h             |    2 +
 net/bluetooth/hci_core.c                    |   44 +
 net/bluetooth/hci_sock.c                    |   53 +-
 11 files changed, 4802 insertions(+), 7 deletions(-)
---
base-commit: bcb621272aa04a116a74ab5fcc9324231ffa3acb
change-id: 20260824-btusb_qcc2072-abb918ab4220

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

