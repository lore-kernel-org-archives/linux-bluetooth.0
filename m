Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD23BB69D
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221686; cv=none; b=UiNPwHv77DIh6ipvwpVSk9TxfTqtgPaQLuB97/CrHo3AYsM79dfhbWpUM9HM/Jp3D7Fr9ueKkNUpdd6aihEfpQjKfmkbhvZ7FKzZTD68Uwy0z3V/jdB1spapcBOvKI5cdYh7J+pQosNbSx4ItT63VUQh1bbCn25PlKdD0IMw7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221686; c=relaxed/simple;
	bh=/frp0MwkwCV63s3lv+Ho2nCbMR4RUWEbkv97HQWVxIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KZB4ANixnTYr9x90/+T3V5f48B/aQaQpzJl9ht4md4IKXWNuoqObh//Gwu2oFtU0Hezge2bfneV5+fCde3oAKpqq3+fNkIqNmjZWp/AyfuQTDVb/YmFSXFVwyXzJj8fW1zlUl1mbjzdRLKjqXGa/NZYXkB73j4Ngh0uanIAbCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rr4ElTjb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UEyp3KKg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rr4ElTjb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UEyp3KKg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3ar6o1701602
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Vrhi6fH8D9Hx6ZGqEqHCzh
	118EkOji9yFJNhnZii3hk=; b=Rr4ElTjbHvLDkZ/IjeZ7Fg7II92CeUsAufnrLx
	3WW231IkAOJGWiw0z9JdJqPZhg8YP0m+AE/b+XZym8QpcPOPP9jE4wpkhie2O+3w
	zW6eZzQf4VO4j7pmP2DPf+Pn2BYboQM0s73UYitoY2LV34pADudcsBu0OdBNsRuR
	zKndKg80YKvpLRdVwrg4WXVebO7jc56mAF60/oHNUa8ncQTnqNI2hBjAKQdvmUt6
	cxkPRYixrhoPoJB4JR7IoXu8O0K3CTbpWeelORAHo7SBN6SVuo9Uws7+4THm4BLn
	5BPI4lFfCm2vfeBcO/lFHDyCUWsYblyVG3wB/664kErbPQZg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7hcsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce756aa72eso15046935ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785221683; x=1785826483; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vrhi6fH8D9Hx6ZGqEqHCzh118EkOji9yFJNhnZii3hk=;
        b=UEyp3KKgGGwC906mwZWO9ErWqFqM9eZCuWKCWAa7BUsul4pohzqrB6P7WW4KYOugFq
         +aocBbIjTLQuyzZ47/diCw7veDUGlwiEVvHbpnelxU8CMS4nBb+fZqWMtAWLFmaa9fS/
         QLf8p0EW8hYsP2l2k+h+9Ohoa2/2Jd5MYB/s5jiC00uWJsU8nHoEoyfXxJKgZnM12JzD
         5479aStZL/XIiEYaDqJ6Ll9KlH69pbQbGox3YAsw3WQY+1rmYqvLEhzSpyH6xT/ZySKJ
         RSz8tbfWFV05MSqxGpC2U+QrtVskvL+0PEeMAB2QN/hOkftryw7RBut8f6YjMzM9Nq1b
         UGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785221683; x=1785826483;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vrhi6fH8D9Hx6ZGqEqHCzh118EkOji9yFJNhnZii3hk=;
        b=SVPdRAWL49e64bj1XiplJuZlu/uVq716w1R5JJ9zXDkby5T3BYcKa+jUH4Hr/v2xwD
         mf908G8I8wUDRuRNvyLPpXGQLRdRLSxDM9Fe90GsM+AmNsXGgZWFqEvjNf5aCsLxNvbg
         5b2OfZmtjlPDCw8V9quOERuUzHqd0RrRwFNbKeBbynDFk1R/rN5P4dsMX90I2j2JarKB
         6kWTzS2wZsSD8NjXsH44mtGNA1P7Ben6ZMeeC+rt9NJ3P6yJ4IU/J9wpI5EiCOutn7ah
         GZgCCxPDhPraJ1Z1Nj/8XPrZBXnn0f/CV6Rg6TNaVBgQ7sn1uZnp2q9jXJ0Pf4eKJz+N
         WYBg==
X-Forwarded-Encrypted: i=1; AHgh+RqyWThnFLg9TY8QfDSShonhTy7VAnaGQ26C/O+pw037kqidWubmxypWrv1JGiX1KkLQ7o0bRDdFdMt3RG4lF7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd8LlYXBWNklkq/NaO0CVZs5JDV5p+2MKZqMz8GnmdB9ThqUsv
	z6HX4qshnr1mg1tRywtoQQSERRPquQpE9v2blqOH+RKV5m7T6Qhp5d40cxAoMU8PCFcdlFuf1DA
	2eGD4oIsPoUf07Sp17TbmsGZaYPRpwnQeP7+5E5w1eSsQYJZqkrCRa0BsHCqgoxN9kFGCe3E=
X-Gm-Gg: AR+sD125X0JIUTeKv8C0MkJu21SZ8R4lZaVBWcTZ5fHm7kG5biEjPKfhstGdIS08C9U
	YTccFo5Nr+o74E03Bv/jW7wnBh090c2yTk5EQIJUK+JiPcrSRCoQkpLzaTERLZWezGUDM0hQ3hV
	wVq5BqYVGRRswQ+EOIQuT1OcG8hjvhg+l/f24t8a7mjC19mBeP9LU52lWbUGwCiq4qkBI8gEyC9
	e6rTko2J7UHpt2siCc9Dswx3VQbfOpilU0UVHBRwI2q6kAq+sUR/G/+LzLv+TODQWCqzPP17Xc+
	APyRT6Pr6KCwZKuLBNup7zswlgAH/7v5cnScPQfQLFYmu2LgnUlBEdXdKIZUEWRUbqfywwoyd/M
	uHGMNuu0e3qSh3ge9Gdy3MlcOaLNgfY8r1flQg4EEtFvb7BQ=
X-Received: by 2002:a17:903:285:b0:2cc:df15:91e2 with SMTP id d9443c01a7336-2d015d7d732mr10513055ad.7.1785221682556;
        Mon, 27 Jul 2026 23:54:42 -0700 (PDT)
X-Received: by 2002:a17:903:285:b0:2cc:df15:91e2 with SMTP id d9443c01a7336-2d015d7d732mr10512885ad.7.1785221682101;
        Mon, 27 Jul 2026 23:54:42 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2881sm46260245ad.25.2026.07.27.23.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 23:54:41 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Bluetooth: Miscellaneous fixes and cleanups
Date: Mon, 27 Jul 2026 23:54:30 -0700
Message-Id: <20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZSaGoC/1WNQQ6CMBBFr0JmbUlbBIIr7mGIKXWAGqHagUZDu
 LstxoWbSd7P/29WIHQGCU7JCg69IWOnAPKQgB7U1CMz18AguSx4KY+sxyks9KUzL1Z0IisFbyu
 JCsLi4TDEu+3cfJmW9oZ6jorYGAzN1r33d17E3s+c/5m9YJxlPFeoZSGUqGpLlD4Xddd2HNNwo
 Nm27QN/bBezvwAAAA==
X-Change-ID: 20260724-generic_fix-6f13710b92ea
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX8+/F0xGy0iPW
 Eb3x8cuJ2+E5PmVaGskFgkGQ0Y/5EiNGVN4MaXIe0nYrOTd6G9BmVmSZ+Zk1Ex99JAKYiDkbL4R
 KM2pAQtVOK2K5pVroL1FuJQ0gOT3QuvQKLmg8WZH9v5jRRRz3FcGefedOq1H8jZ3C4bBDuklzi7
 goOJSHQn8nnoLFdHGBGAl+h3Je6oyV5vFjRQTWTRGG+zT6xwSancr/LBe78eo6qEanCMxb+zafC
 LLKZYaS6S7L6hEJ6T4nm7+DRjTOXd5LpBXtQmZz/Ae1KMhpv3QUZgtau0mpnXOPYXvrmiGsO+MC
 VmAS6Usw7zmGtxUxwS0oBNwEMkIsQNU5BGDlRzyXyAtWwLfb/SZPLWGfUcb6MYRCXEtB9PGaqTs
 Bm8u6Opo76ATiD4DhWZKDtlf423tijrRn0CyV/Va71flbNtyYAcNV/oQ0IU4rfxk9v0NTLJtdsM
 9TFQ7aCeAffS77f2CAw==
X-Proofpoint-ORIG-GUID: 2RQCObXhksejTM9UlIKAi0kjSAhb7y0m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX+2f+0DJg4tu2
 oieq5zmKgQNwTPSm1hj5Xt06w7zTGynp+7pJa/I2ZNmyEr2WgnBIEZXOX6Lcy27kKO4WG0gwbu5
 6wKrA0KFo2liHe0WKFijgErRm7p3S7w=
X-Proofpoint-GUID: 2RQCObXhksejTM9UlIKAi0kjSAhb7y0m
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a685233 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=0sECVGXVUIJmN2u-BiQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280060

This series has one bug fix and two cleanups, all very simple.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- Rework patch 1: guard with (@len + 1) against skb->len, per Luiz.
- Add two more btintel/coredump cleanups.
- Drop "hci_core: Don't treat HCI_DRV_PKT/HCI_DIAG_PKT as unknown type".
- Link to v1: https://patch.msgid.link/20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com

---
Zijun Hu (3):
      Bluetooth: btintel: Fix diagnostics event detection
      Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()
      Bluetooth: coredump: Expose header size and end marker to drivers

 drivers/bluetooth/btintel.c      | 5 ++---
 include/net/bluetooth/coredump.h | 7 +++++++
 net/bluetooth/coredump.c         | 7 ++-----
 3 files changed, 11 insertions(+), 8 deletions(-)
---
base-commit: a7ef68421906a8b1c4204dda9b2e52b90f6fd2ba
change-id: 20260724-generic_fix-6f13710b92ea

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

