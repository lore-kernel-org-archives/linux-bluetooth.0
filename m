Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DF360EFF
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357399; cv=none; b=nKkXW+d24zps/eBVowWEqUqpUK6pJwP7hpywzGVrraMHiW8YE9nTZAm55UnBCA6JZlroaS2LL/NQEDVhQvDeMHqGArX+62D/xlTips2hKCwh7ktbzlILeSqFPqx9L/DdNNeLlQTdDWJtiknx1fs76XOoqRSm/SuEx9FSB/wVBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357399; c=relaxed/simple;
	bh=FkIlebPOtqjPXe0NxeAv7oYEzvGnfqdHE/A9PUZv0D4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IlnGJzOHEVRvs/UwAjMQ7oLYouuOEgaoH6J3hssa7R1MzLERDarOAfZT6xZg9fJqhk5UtHH8DTVHfCNQys8uVTE7npsB602zur0HGFRof6Sf9HOdp+8X92LZnIif6IF0+VPrgelyijBsnZigMTyOyR69QLKJnZ+YmfMBrWceKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zvq7wvYe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gctbXOx2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zvq7wvYe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gctbXOx2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2ePHa151697
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nvwPupuwonT7utdv/iXpbi
	VODuC6GmAN3Ebul6jSPqE=; b=Zvq7wvYes4xhzcrQyTvBYYJ+MIGo3ipd8qmqq6
	WgBddTdZqC16SGewz70QUuINsk88LlHjAnJtB44JjI9/9EuMSdK/mL/wsLMUcZNo
	I4zSNgNSh9AmUshqnKSnmOM/pSFk6nSKGHbosLTmtH4itmfoSvWO19MDk+pEJgd+
	rioc1uyGPRFWxicHDMx8aLqOd9PIdPgc0anJVWSlpnvdWNrGNhWlGQ6IVMTQtBr0
	ezcTUswsZ6CqDcIlTSW44SNPc9JxDMA35IZkQ0rg3sMIuPEBUhycWOLmFt0j53s6
	10aLpc/CPzEQzynw8JqI1mVATM6YZEKL2GWFBoNZQoynBZRg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k08qxh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b8eb84685so985047a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789357397; x=1789962197; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nvwPupuwonT7utdv/iXpbiVODuC6GmAN3Ebul6jSPqE=;
        b=gctbXOx2BoKzqhUS8VRGwB1CXcl0X5Ri8L+xWrLYzKYPIjsgmSxY4pC+3nEOLggRhD
         nDGN8HhUYa61QhL2uLrITg1jxRph8sXQJMbHltvTfVykiktqhAtlEN8G7m28ZBxBQ+gR
         st/pkuPJTjn8mYMdQGOUnH7KEE3X/Dr3SDSrsYUn+yGZkowzWzQDovJYmfchU06gcGwT
         CxckOeEjGvfXXyAoKOzfGnZYe0eNs9LTQ7JuydNIDp+Tssc0xwhMtz1bioDIK1czW7j0
         YrKuW0hi/GZ5axOhiL490cZlUCpGNTo8/w8CHnbEIMzAGpqUoV7qKHMSf9KoO6TuO8nX
         DAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357397; x=1789962197;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nvwPupuwonT7utdv/iXpbiVODuC6GmAN3Ebul6jSPqE=;
        b=cJhVzBEY7cNVxTH+oSWbVzNwY9HtO039O8oUjx+onY9DQmJxMFpzGqOCBVMJs2qKj2
         TVIC+B8tRpELEQQogCel3brBSB3+qlMuVTFdqHIeLQLbYRa037WOsPEADsHiG43rBFit
         HwgkUCqv7ihqEuKC7wcFz02Mt3ahrgWy8yok5au9DVKbYP5jfWc7e8VIoZgj1+33vJUo
         Vp6m+X8v6EjtCa+/MalS7cUh9WjYakCssLBwa/qIgYMykwI/upM05fH1ZJkbGL/kltXQ
         LtusQQcFz59I2Eu4qMcgpfgGZcuT+1yWmxf8zjMv1c17a2i3sL5ZhaWuYhq4kERBaj8V
         6FJA==
X-Forwarded-Encrypted: i=1; AKwUvBwFPe5sko0Hrkkcvcz2Te+kSUgR/Amj5X/38crNmQXkO+w/BJAgfhqSIsj51UusBNTOU4/B/YncU3nTxioPeoU=@vger.kernel.org
X-Gm-Message-State: AFuF++md0/n6IzS6GG8j6oXS2vvtn2uh0HxkOeB0qVpqqhdWlQcuxTMh
	0QaLTaFv0Wp6GFm+SPFgproRqIRw1U2njow5zvZI/uR6y/BV+rUbfLjoQAh/NOAm/pW4Qsllucz
	qAyO3SgT3ISU2sHHEJbQDRzef39Qw0dAioYbp3o+lajBv3hjUXtG0V7pqMJ3BUPQ5nw+bHCeX8j
	bcm1/xkA==
X-Gm-Gg: AYBFou15GYXveFp3ir5YQD2U48/pw6t7YZr0w4SNeiPHvzGbc2NXGxfFOV1sYOLZAUr
	J5++mox3yVFfo3HMfM2sJuY9iw49PZLqyDujeBIuEPmiXn6sEMF8AkTzSyswMWLsG8oqK351C3k
	JcOjGZ3+lPSRVkzQ/ot1nx8uPw2/Y6IpjKAZR/JKjufSYKVSFwFCOrwwYjSWwYNciMrGRIYlDYs
	thUTAelb2JEHnWOOpXYgnbq85EZRDsHCt3xx38wCin1hZhGiSJS01H3tZkfNMBDWRd5AjLfkEL4
	NleF6rA4rKxy+HtseCs7/zcipWLVOIOd2XeNz74/g8SgRZ/uSJXZQaTWUiwZvuswkYnQwceDTvv
	Ni10IrRELA844EOpkVV/r+aGL0ACtOVjJRW68dn4TeO8cvxA=
X-Received: by 2002:a17:90b:3944:b0:39d:edfc:26a1 with SMTP id 98e67ed59e1d1-39dedfc3ba4mr686103a91.6.1789357396770;
        Sun, 13 Sep 2026 20:43:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3944:b0:39d:edfc:26a1 with SMTP id 98e67ed59e1d1-39dedfc3ba4mr686072a91.6.1789357396315;
        Sun, 13 Sep 2026 20:43:16 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ee07f2sm21250894eec.18.2026.09.13.20.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:43:15 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH 0/4] Bluetooth: Fix 2 devcoredump bugs and improve event
 length checks
Date: Sun, 13 Sep 2026 20:42:55 -0700
Message-Id: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD9tp2oC/yXM4QpAMBQF4FfR/W21kYVXkcTccZXRLlLy7oaf3
 +mccwGjJ2Qoows8HsS0uAAVR2DG1g0oqA+GRCZaFioVM7FpLJ1CW20zlVvUXQahvnoM8XdV1b9
 57yY027uH+34Atwvx7WwAAAA=
X-Change-ID: 20260913-misc_fix-6f6f518fe6b5
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA0OSBTYWx0ZWRfX3k1tv6ggcG3T
 xKuyOspf1+Mcx01x5TQS5bCJtAko+dDWd9QAWwMZqDg8GzTxRUlX5GIdVL9aEBbH6jQNudn/ilH
 bdIc9qd48rS6VYphP1PEKWckgMJEGDk=
X-Proofpoint-GUID: fHqaZM-x-8fXBx42ob6HWTygU-i59MWN
X-Proofpoint-ORIG-GUID: fHqaZM-x-8fXBx42ob6HWTygU-i59MWN
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa76d55 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=PimEVOJaLDa5rcmy7b0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA0OSBTYWx0ZWRfXy3bV6WYdz+2J
 uLZ4YEow4L0SK08W2eavmG+Vap+LV0LYhSudYH3Si+iropBD3BcovkW9r0wUja8TY+vvLfBrQJa
 +FNwq/scWvPolNgWD3u7THBWEHj4MRwTLmo1TfYI0bBeB7L3TJOyQAzh8E3s/XvZtezCJY1Xoym
 yI4kfJTBO4a4tY9FcQX3AQH/PYYVTFUG3MBNznnxyYMl8+WSnet5U7ItmxFHjdtuuPeOyZzRfDe
 ppufkeddIQFzS1Xj257WQvWpuMjNGL7bqIzAErlZHWSaqKUjb0bascIDjc604Hs2BEUJlbFRLYh
 +ldyslxX98lCDS0z1u/SXwTu3YkrhXz6HFu2TTsNMiyNPtOEXvmHWnjjPjAfVmCumQm27AJOLAc
 JWmhHDjldZH4yCdPV2q51GEI+v62ouMsOYSPJAMAX33oMAAM4k3MqSqtC+z0IVxwxDUjRVqLCnp
 AiCkMAVH18Hy8XF8Xqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140049

This series fixes two devcoredump issues and improves the payload
length limits used to validate HCI events, — all simple.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (4):
      Bluetooth: coredump: Fix skb leak in hci_devcd_append() stub
      Bluetooth: coredump: Fix btmon heap-buffer-overflow
      Bluetooth: hci_event: Use 254 as max LE Meta subevent payload length in hci_le_ev_table[]
      Bluetooth: hci_event: Use 252 as max CC event payload length in hci_cc_table[]

 include/net/bluetooth/coredump.h |  1 +
 net/bluetooth/coredump.c         | 17 ++++++++++++-----
 net/bluetooth/hci_event.c        | 28 +++++++++++++++++-----------
 3 files changed, 30 insertions(+), 16 deletions(-)
---
base-commit: e40edfa049b967f0b9379bf549c59431302ad181
change-id: 20260913-misc_fix-6f6f518fe6b5

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

