Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C65477983
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628897; cv=none; b=ODXinRlcttcC04p7jlm0nJdcAE2WxuYD5jp3oBJZE0x82txUiUvjNaE0Eh4iQT7gc9pwbl0VlzUO6NA3vfydnt4lzbo19YVE158aU+551lGR0VPaLPziM99Bd7jYxUkYCMp3r/QVzb85iayHdoX590DtBzHxWZ0HOeRFqzgasWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628897; c=relaxed/simple;
	bh=AtofScJ2X8wM4sopKDEEOLqzXEdRIKA+OE6Kub/tWXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZpWk7/TnTmTaDVFPvRTaSvhuBOHhjjdfseuwvZTjEq3Q60ITbBsr0gIFCNnhD+6tegb/EFpPdR8jLOAcXTFThmt55y7f/Mc+aK8cumCqMItvTin8G1BZ0kTl43bjn27ESq2B57xItViLFLfjWelqsqrkvMcsQs7y+iR9SvaRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bj0zckGN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jP47GjE/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bj0zckGN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jP47GjE/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LA7E6Z1564201
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHZqt2fWjXPHPXcHtsaD71amy7pw+6jum6wX0ZmCt1I=; b=bj0zckGNDvjN264q
	dyAcUFf6Z60JE0tmXx3wE7SgRVXT5TMbpCsXSLdlqtc82rZo9Yi8eXPp24pFQkCp
	s4Re3zHYWPXLIGnjNjFMVJ/U5cMkmZ1WTzCij5AFuTUciz42Vk8QZSGRsXzSnFtB
	fYVweziBrkJLA4oaxXYOh1pwUvXOneaOnfIYuQoXC61WCxv/xLLxbAaMmWTEmAHi
	M6BbAnJ/UFE9VvjdtBXtjPxr7R+ty1re+t3zzKLtVcx8GuwKZSLeJHy1Zpon77rF
	CibSn6csXZQbTRHx5sUpHCxdK9CQwBSGseU3YiRPshrB0F+8ooS3Z69TwKYniIe7
	aYOTBQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3g12n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc98d6a88bso37343495ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784628893; x=1785233693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHZqt2fWjXPHPXcHtsaD71amy7pw+6jum6wX0ZmCt1I=;
        b=jP47GjE/MeMVmZuq4jJdankupNBCUveDpxAICcBUIJXzeNtiodm+FWI8UoqcDihKDV
         x9e/oSOFBDNGqeqpEpJ/1KTz22C2mZ933bhRkAK5KGdFTCi0I+yVwpJzIUSXVlmN1MlX
         bRXu4U2CN4ydT2Nh0VT+5ioTvOm/OQYSgCe2j2KXohSFue6kbjlVkjgPqGwkjCDvf1M8
         JvVHDIFlGXwiXTDDvWZuTmi6Hz3c3fnCsk7WzZnK1ep99fpjS8Cvuqg1x+FRux8pcXnw
         kNBK2fI2gSXGnBxhE1JAgAw2mOe4D9uanjNkQ2dJTBkvHBb5rdB63sKoeW0WO0K5/Ebj
         wJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628893; x=1785233693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHZqt2fWjXPHPXcHtsaD71amy7pw+6jum6wX0ZmCt1I=;
        b=gH/xCaA0nap6ghsOdzfdpJRy/aVMnXcTsggztu/7PzxX4uA01WJ07p4MebAKKfc2TR
         5KduQMgOE2kB5C+WGhezKX/t8/yKbY2U6sdNiUuw+qVgQrGQMj6AjfBpSAdri5bMxuOZ
         ZeXLWlwKITf5/hxEpehTb0mYCcvAPXrctcy2v+Rn3FBd7tEXN40UvfNElveghGskwtOu
         3HZTO3IbktJXd55Ap9fdFDOwgPtC1oNCy2RcQXQTscEouQly3RD1UOf9xK912LiNT80C
         f7WpKU1m8FfQyzGe+nAFdXC3xG/UAbGGNV9byTI7ywiodsKVUvTafVlPsffOV+/Bqie+
         dptw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0QH3c2rUece5IHY9ydrXfz1r+ve4o06DT8D3Bx/gX55XdF8o/beTMq3MKsPgzzbfcwN89lqVz/NfsQqXC/+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BqXEVO/16le1+xHNJE857H2/B7X/HtjufbTFp9TJ1PK/YyWE
	uEnTlamN0Lr5b8wnM0aUD6CwmacArgRYyvTtnSCk4FLT3BS13FEDex4ZoygdvZmU4wwdnVnPSL9
	Ze4Prqu6enAECqq+2HjbibWlRVGjoA8l+G1Pw/Ad8FHjv+PC4Htz2+QmiJ1wtVSJHGfYsvyE=
X-Gm-Gg: AR+sD11E+OLJyi7gAl1E0RofLEuHzPu5CaMoBAQqxxjT9byEi2qWoT7mImiBKY2db/Z
	tSwE1w3pX9Hex24owPY2Z0yqnd4ifXrIE5V9jkxWx0EYd+DNgXrq2QmTBrT9YIx3g8yKl4ZkydK
	Vzu1L5YlEWlk19lb7lYkGmZEquC7jhXJezRsgurmVqPmFS9ua3eRq7MuxPPf1BgjXsArgC+bc/9
	367ibVnsF0P8nqOUC1KAhOt+cJyXYjCofw3K6QkNf3K3i/pF+lj1s8Mn6BMRyUxYrR/p7yEoctS
	XxTKK340FcioMJHyYrSIKt4EfbX+JxEG9TFPRvbzXUGScCZ/0sUHdZ/xkM/FJ6xlEX0J915OTqA
	zZm4xSDielYRpgm+0wzx9v8/O/opcSiYmXzb2xa91Id6w/qA=
X-Received: by 2002:a17:903:910:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cf802b31e1mr23684555ad.1.1784628892776;
        Tue, 21 Jul 2026 03:14:52 -0700 (PDT)
X-Received: by 2002:a17:903:910:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cf802b31e1mr23684375ad.1.1784628892356;
        Tue, 21 Jul 2026 03:14:52 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf342e3a8esm73812555ad.0.2026.07.21.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:14:51 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 03:14:42 -0700
Subject: [PATCH v2 3/3] Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT
 usage with HCI_EV_VENDOR
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-fix_vendor-v2-3-1977a8c39708@oss.qualcomm.com>
References: <20260721-fix_vendor-v2-0-1977a8c39708@oss.qualcomm.com>
In-Reply-To: <20260721-fix_vendor-v2-0-1977a8c39708@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX5QpaQywgIgeK
 dSfATWRGbETghy6SgS1/jH883t2iuuhCuvt6am3OvoSVidKCQSWNcWd9YWbo45JswZ+b5KHpgk7
 KlKXj+xuMwCfrxxe7xFJWr4FXWAR6Y7z4ActAL4k4IHPULtH53D2J3j5YvFIuE1mmvXXqU97gyr
 hRd8W5gDNbpPEuG5BRmTqI/fFl0uVdOIUR1NJvlCT5MJMbyYbMzf8g/pLSHKudr4Xx42J8ZsGB/
 wsCrO187EsCPtBsjDfrLK+7Fa8lHvdp1RYdDNHnmqT6gF3nsuqkLA64q1DEo4MFIRGehr2T0b1F
 A77sVPZpUP27K6FkrhfduulHBGWcTXAzeCOMsX+ZqyBfn1X3Jvly5EgOt4iIWe1ObrqxZuSsJel
 9bMqb1Ccr2uZXP/VceHubCG6niNiARUHrZD0DCyIdVQn9uyQDHDLiv/xBdFl8TriLufq7U0nwAJ
 5w1sPv+zj4Ia5FpZ+yA==
X-Proofpoint-ORIG-GUID: 8exQQlVAGjNx2imzluIC9Oecmbqf-9SU
X-Proofpoint-GUID: 8exQQlVAGjNx2imzluIC9Oecmbqf-9SU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX1igGeEilxquJ
 YuyYKNajaVtfoJLyv92KI31wOene9PPgvYmTsnQlsTsY2ekGetGRXvVkw/kLP7ZW13e+K6WHCUR
 121AR6NOKkWlA4zAQSo9lu9XZO3hqyQ=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5f469d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=x96CrpYRk5hthMOPTrkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210108

The macros below have different meanings even though they share the
same value 0xff:

  HCI_VENDOR_PKT: HCI packet indicator or type
  HCI_EV_VENDOR:  event code of a VSE

This usage of HCI_VENDOR_PKT is wrongly checking an event code.

Fix by using HCI_EV_VENDOR for event code.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3847a0f6d096..4d59b28ab30f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2800,7 +2800,7 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	if (skb->len >= HCI_EVENT_HDR_SIZE + 1 &&
-	    skb->data[0] == HCI_VENDOR_PKT &&
+	    skb->data[0] == HCI_EV_VENDOR &&
 	    skb->data[2] == RTK_SUB_EVENT_CODE_COREDUMP) {
 		struct rtk_dev_coredump_hdr hdr = {
 			.code = RTK_DEVCOREDUMP_CODE_MEMDUMP,

-- 
2.34.1

