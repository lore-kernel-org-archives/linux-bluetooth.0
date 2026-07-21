Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D0445AF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628896; cv=none; b=nXn4MIH4LhKY3KjBP3EKnFDbIaMCbVulbXO+UWJ2BHZqPYJYXI7cqpSTeolzfVLHm5rwqVSo9w3GjpIL0u+lPv7xJYeldzA90PAXt3HbcNxOPMgspcHHGcabgzhO+eSiUXtEnwGjmbTqjCC4rkhx4wjI9bKYXqRKsP2XIgb89KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628896; c=relaxed/simple;
	bh=o9EVa6Ayl99uU/W5Td/prtqNZfPm6oKB3CMaxwDUV74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEyLp/KNPhntlPi6yv6c80rYiecnZciqphzcnoKhSpHb/K74IhRu6f9a8QR99GOQUbrKz5j3uJsk4hpE4fDlJ+ADglYRrcwWw9tQfQJkJWx1qW1aGuXM7evvX1NVXyh+F005ubgMBHSCuSmIq3ZWeaRIufizhWkiTuNt/FY3ofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AZvdIn/f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GzaTUW7c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AZvdIn/f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GzaTUW7c"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L8rrEh527891
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9OKr/yW5NmookCdWgxyMj6JQ3VShNHBjGxnFEyAh0ws=; b=AZvdIn/fAGaDQsjw
	AXJj+XcacJcHuKNAg+dXi+eUMwRQ4BUuz78pUYZgDj2cFXeJ9gYDfDzl8M2u6Oyb
	8eCQMZgNYlLU/HHWcf3XzZt+GxfrK5La1z1U8zo+xjo7IMvhrgLOZGvoSG63/3Gf
	ResvXFnQh2cRnf/frjaLyMItujoFqTOkOc9EpUFxvA5cb80tCwdfTnHb5fQMWsbN
	AnTpEaD95LlVviVyRhr2VTdhUyMBESQ26cx9bNu6aGfio/qwrvQw2q/VjFOg/9KM
	tZsaRnA5NnYS27p+24KNKIzK7ttkzka5AtfRNDkWY3Cy4eAafnm9DvU/lJhGt6jJ
	Ui/xaQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se1hwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc98d6a88bso37343445ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784628892; x=1785233692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9OKr/yW5NmookCdWgxyMj6JQ3VShNHBjGxnFEyAh0ws=;
        b=GzaTUW7cTFNvVySpiWYqWh5jKAy0ywbv2oqiNN0TQ37SoWq7OJ7HIg8XrWeNWh5oEj
         02F/Y8Kl6ulgsC4+sow2wE3OYtFft6NlhkwE3Ci4BX5qkG7ca4tCYB0N/CWWyYWmZK6b
         2sk+3xAnrnuwXgK+mFyWLZZqhKu5Pwe0mRed+HMEfh2p9qvjtHuTImhPmgJ/OSq/NKm+
         9j8RdLBi/w4NXhGqq6jkd1vjQ2VVZiiuIrFWvZXjMQdf2icGNo2BnvEulEZTn6Hik6IB
         qOhzu98IJCN5Mjr09E4wH6F3f3repwWFCGfR2f22CueYz8BFYkDccwJepOLXHFWi3ACp
         Acug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628892; x=1785233692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OKr/yW5NmookCdWgxyMj6JQ3VShNHBjGxnFEyAh0ws=;
        b=RDI6jovCqzwNixxrb+vz/ha2BTMXx2YJTJmQMTRhY/Bjbw9R5CmrJmYp+FY9y1AU3w
         wT5UUoNgltP/klFSFH4b1lUZ8OEci6GAwJazdDklpNLDu7YsLldItQU2Q5RcXe3uODLt
         mRLUmA1OLO7m9JY9XbRjaBnY/YZTyLH+tUKHBfvSlbmrDion3rWy71uG2nkMYfueh/91
         u5Y90Segy+JJKL+BYYSLoR6oTqpk7KPfsOLVAokDwr+KR0G6YGE1DmUlCq6jF3v3plS/
         99Vi2rAh8O4e29U+jFCIKr2QQ1wtwIMZy+JeT3rpOp8L1NjbqR2w7zSF3HIsoBPcGozj
         wh6w==
X-Forwarded-Encrypted: i=1; AHgh+RrLacvfTiLC6Sr5Ujpm7phUo1GK4q7CyT0kNK16Cch1INZ9nlqJr3cksIqAgGQX9iWNudYYvWVvvt/xnCx9ebY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAj4qziWZazEgLqbF3EFyHr+hcmfKvYyru8QwcVU42eSNZjPMW
	bdSZ0eJv0fJzlqJEzCWxrhIw58aK6ClG21DNmamS8HNzvjbggcphtBIlqJB4s4Zq02xz2fWdnNn
	xglyD0P5WkOYBmtohDaYtO1C/nnIErLg+5RtTjBtLZGFL2KG/B8Mn9bLD/aYvZhOmQ7AE8Qw=
X-Gm-Gg: AR+sD12urK2ndnrxdncmsvLJ/GnfaSUNY2dcW+jrmceYXxG/kRCXA6zsZrbUSGO8aV8
	MPdSWtzJ0d+JM+5p2WnzKBVl3bfr4sjntl/rwD4uQHL2DmQXlPFlz+Jvl+bn4Z8WeRt3A5FAY6x
	3X5wwjovKGb6c2V7zCU3ddKBEEYx18A5Is5Ji602LavBgJ8GCqy8LNt07wVIXw/EiF0Cy75mEf9
	avRwPDWxF43UgsI8t2eGytEcCooMiJRKn9AKNP27q8iOQOdw6uKYXTFVz3AHjVZ+7cVyrKBUCTI
	BUbN8CLift9XgLzBGY1kdj745AV9p3Zt7tzHwLyXJW2k0Y9T+7h0ouiWmccRz7qOIQX9GfVzDdJ
	cgaapzby4DVTRtU9WSo27Y8fgc0bfw65Y/3I9qvUayAbHmFY=
X-Received: by 2002:a17:903:324d:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2cf802b7fcamr18691665ad.2.1784628891816;
        Tue, 21 Jul 2026 03:14:51 -0700 (PDT)
X-Received: by 2002:a17:903:324d:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2cf802b7fcamr18691465ad.2.1784628891414;
        Tue, 21 Jul 2026 03:14:51 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf342e3a8esm73812555ad.0.2026.07.21.03.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:14:50 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 03:14:41 -0700
Subject: [PATCH v2 2/3] Bluetooth: btusb: QCA: Replace HCI_VENDOR_PKT
 usages with HCI_EV_VENDOR
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-fix_vendor-v2-2-1977a8c39708@oss.qualcomm.com>
References: <20260721-fix_vendor-v2-0-1977a8c39708@oss.qualcomm.com>
In-Reply-To: <20260721-fix_vendor-v2-0-1977a8c39708@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: TBGeQhJ6caUV6g3-u3vu7tfbesJOmZsX
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f469c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_0CnrhXH5lyLv-Mul2kA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX1pM/PJLHycFr
 vAxIYkbw8ZEC0sPoI2ALPazxqIA5FKXosT4a6PAQzMuC98eYLzktXipQm0LAt+kOVJ27n1CfoVc
 2V5IZlUTZynHfWF1TUiqnp1vFi7NrSM=
X-Proofpoint-GUID: TBGeQhJ6caUV6g3-u3vu7tfbesJOmZsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX1kGoO5zXMw8q
 92YVx578Fj0d/hevdQOVr40d68PEn88VW+N7/Tchmw0z0P9+DfhELMgPt4s3c77g5De1XmRluoE
 t/m4uS+J+5fBRoicSAA8uYWmlrKtQ1HE/nrgC5WDbJ5/u9z1O50B2kkxUJmREK2mY0N1OAT8GXJ
 MFBSD50KHFw0U6RULgKhJHKnAkl1hBVmejz6ESnvEylamdY7OrEwElkc82PjWw2DvQILmrpXuXS
 AGmLCD3bZlfio2h/IUs8eCbtLaIQp8IpoYdpxXbMwm35qAfPRlZxu8DOx9L2LC1z0jlIcTM5zgz
 45TIHlJd8XHr/99jVyCuxRmyhzNuunN7fcV0Gxcs08IiOwwbY9IURSl1lZ0nQs80bcXvFHNbSMH
 oWd1LlJOfDM0tTzxQ3VyqnZek+KXUNjIB/jdY1qp6mtW3y3Xs9GMHNMfmlV2npCEMbnAssehgMC
 uGoNDPHIOrBWEkZE8/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210108

The macros below have different meanings even though they share the
same value 0xff:

  HCI_VENDOR_PKT: HCI packet indicator or type
  HCI_EV_VENDOR:  event code of a VSE

These usages of HCI_VENDOR_PKT are wrongly checking an event code.

Fix by using HCI_EV_VENDOR for event code.
Also fix warning "CHECK: Unnecessary parentheses around comparison"
given by checkpatch.pl.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f7cce0cf472e..3847a0f6d096 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3278,7 +3278,7 @@ static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		goto out;
 
 	event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
-	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+	if (!event_hdr || event_hdr->evt != HCI_EV_VENDOR)
 		goto out;
 
 	dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));
@@ -3304,7 +3304,7 @@ static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		return false;
 
 	event_hdr = skb_pull_data(clone, sizeof(*event_hdr));
-	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+	if (!event_hdr || event_hdr->evt != HCI_EV_VENDOR)
 		goto out;
 
 	dump_hdr = skb_pull_data(clone, sizeof(*dump_hdr));

-- 
2.34.1

