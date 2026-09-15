Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020A3F9F28
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450871; cv=none; b=hzhrntgSwZOKl54m7Jq3WYtVBSaJn5CDlBTgXEdOgEbqiovK78whO9NyI1jedvpRaskRiHXxmEUUyPiTzxtdTlzsx/8wxZq0MkTPpsvt45oe/Sg5Kn0p7DQ0ttmu74Oe4edARjEOKYmHY7F/iBfnFuL2MS7+Cp8g32YhuanKu5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450871; c=relaxed/simple;
	bh=PhAMGANz7MkUBW5ysjeXPGKUMHHQxXQzswMnWBzcuwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EENsFxzr1apoEwnc2NHjxwK6yTuKHtcv6Zu23SwKg5t5h8NgEFjjF9f/MvUcb+9W0fem1/4Mdcyze8yzI7ePtzwuhf2iv0pI7JkGbtpfg9wp9bZg1SjNTq9Xpo/Uv+ZBT/Y6VpeVzZn2EubJNjdM67cVAZ9kNf15ZiwBf5dA8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O25HQT07; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OKymeJ+D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O25HQT07";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKymeJ+D"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F5PNsm3160618
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	demnwsDRacp7YkAOkxM3KDcVI0hv/Hsw5qIhskdy3c8=; b=O25HQT07wIjDAb5a
	HETERkQbDPKgib2Tm9AYKFm1FvPDPE2SKNbebTUk/PMCszclmQu8cyYfWEYKI9Rp
	9B1Jaw3WMpOwQ3CQBmuPyFFJR/THy63LlWfsyJ2vnfmcjuflaDQBflc3dt5UEstg
	nqQkjAjDSbpLfF7bJL3AZ2nZwxY2h+8tV79MQInFp4jcK/NjwVLVb+uRDqo6HzOQ
	gB9V2HpKnrXnUlWVogzTPzBhyxGrNsgrGdE/cvVjOWLDuxU8ooNc4IM/mOz0qSEq
	LbiadTeN+6bfgXcEgIiQhXeuIo0ZbYi/wJRUwDeYCftH5OCu2ylMGB8F30nK6Vo1
	ZC7xIQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux01np-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af306c795so996258a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789450869; x=1790055669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=demnwsDRacp7YkAOkxM3KDcVI0hv/Hsw5qIhskdy3c8=;
        b=OKymeJ+DXvAsuJcMHlUCRrV0Ynf5MPl1GPa2Ai38tYvLVFxGHz8toJh+5wfh5gfxNR
         C8FQ4kze5BRUoRC4IrHuM/aZ8Gx+Gloprt1LLGSYCfLosk0qhf3o2iJU3NYZwG8y+9xU
         lBIZdZ3PFBnVNvLKu8XXfOH3ZUVon2kfRE7+oyggKbq2S+N2dwuff+8WzbNIafstjEgZ
         IZkiWBBbqf/QhFQ9+iP8gVif6HYmh1RUIjbmUaRmQxmLUjTc2jCXkFCHyqo7XYFOOuTB
         MC7QCiirUupeCkonkiTfvIwPWppAgreWFGSNKqWL4QqlX76EyE+3QD11RZYWUUCPeBzF
         1lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789450869; x=1790055669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=demnwsDRacp7YkAOkxM3KDcVI0hv/Hsw5qIhskdy3c8=;
        b=YPOCd6wGsV3iYtHmiwXqVbjPdWtR9pSnGhIZrIK1PuLhz8L1CIL5McDbMTB7qbmzcg
         jOEbeH80mCfWINwwJvJod9SXDHqkn72VM4FwY39SP12UvzQa2oTS5nTc8ZSN61OU9dGl
         y2ptENG3YzpL5NdMT2kafYQm/RdclVCYCasAHNX0GtK2wRV2clYXgwdoWPuz/vghXH64
         7lvZi8vtbKySePhbVT80EyRTi+rYrDhMKyiMcAkvxyguoBAxF1f0obIoVMjvMI9pMnH4
         BJW5TF1OjOo9uD4tlp5CqPusRWWBse5FvP50sif1c+0k8ADzOY+RB/Hr52NXpJVBjjHU
         GiNQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5UaSiZ9XUSJSTp377k8mxPZHA2CGP8GsDzZ3TiKrMZi/vnFPoy54pvWPAsaB8rnZkqd9i7mQGwoL9thlKrBs=@vger.kernel.org
X-Gm-Message-State: AFuF++kWJoXQCHQAQI90cnlzxdlv3aJYAQLrQFQOtdkS1pqrpLmgU9eC
	IdvsbMV7i9XpjnGcdfng8987NuRwjv+lzUGghEOpLzNdYCnuoeBsGwUSXOvDO5+Oi3SVEfIfkHP
	N36/CZaXt8UlpGoW2oEB5JrtXniy6ekQVEInGUVehzrPo8oE7YIPlmQKAbO6BHKBAMkbpnII=
X-Gm-Gg: AYBFou1j1NjaUp33bSZ9jTxXbdEv6z8ujubNsgZ8lNphVaeZpa4Hx2nX+Sw3tZ06l5G
	x53fp2ozkPfum2SBa301NFgH1gC4FuxeytJiT/F190XrEweTeT1Og+BBbYhNVsRT/HKxUtNQNwG
	K6SIZXB/qPQRnQIBqbx4gqim1jC4O7aOPeI3Te0mqwl4WRzC6zcznkMdZv0SE2P9QHds6c5ZlPr
	1fKYt+nIRy4oGJTwQ9dVtfm0N5ezhybBeUyW//m/Y1FTkL9/bJWX1/OR7DqSl19FAIJkejfEKu6
	Tv0KFBFVmles7x0HVb5d/zI/zNpzfo8ZPCKpN7toFchmb1gOv/+NDZDdYzcAuRXgj/CEB/r8aa4
	D/qtcNuMoXdyVYOUb9XUjS5ICV0s3c5zsctCRsWNcGMxuzKE=
X-Received: by 2002:a17:90b:2709:b0:39d:fcef:e241 with SMTP id 98e67ed59e1d1-39dfcefe940mr4015317a91.2.1789450868537;
        Mon, 14 Sep 2026 22:41:08 -0700 (PDT)
X-Received: by 2002:a17:90b:2709:b0:39d:fcef:e241 with SMTP id 98e67ed59e1d1-39dfcefe940mr4015282a91.2.1789450868135;
        Mon, 14 Sep 2026 22:41:08 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14390c0be29sm1589960c88.9.2026.09.14.22.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:41:07 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 22:40:51 -0700
Subject: [PATCH v2 1/2] Bluetooth: btnxpuart: Simplify nxp_recv_acl_pkt()
 by hci_acl_handle()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-misc_fix-v2-1-6178d838c946@oss.qualcomm.com>
References: <20260914-misc_fix-v2-0-6178d838c946@oss.qualcomm.com>
In-Reply-To: <20260914-misc_fix-v2-0-6178d838c946@oss.qualcomm.com>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfXxS7oZqjrxy8M
 ilqoMlAJXue9a2xlxgb0ijEwITi0AEUNWro8k0+dhBTJF9LCYFTHUCKJ2v49V+CKk4HMm4uRStp
 kDTLWW4+ETd8QOkw2LcFaswzfYSC474P72pRHmONKkv3Z6v6US73YjMyfTbn5fCXcGiHwLYtOWE
 iLPy4xxzQ8iWgGkVD2Qh/wMWXFj3lPHfdE/jAkIQhiPdbcTm7u8yx0re2ZBY4d0u7pj+WpD5F5k
 IYA6EAsXuvWeaE4/0wHz13Pf8hU534JpzlAVvpNk4LMohT4VmLB5UR6A3SJ0CyKEhl6IDgjEB08
 cc8SXWQu/+KEQDXeWFSxX6Y06gznMZmUYCs6wOJhlPg8Cuah4GV4cuq1kBf5GbxbolDV2mUPkMf
 YwQ7Y/e1caaEJdsnnvg7cZVU/5UI8bh63vQZGNcb4o0NuzEh1zz/ALpN8cVbKGNHbs1A0Dd9Cqr
 x0mv9XqSSwTMwsKlxCg==
X-Proofpoint-ORIG-GUID: 0UQhyCV_ExEafFo20A-qwM07TMXHy5XN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX8Avyskx1XL2Y
 AE2NXD/3WlYswW/xoeFddHuSnRHBr2zlxvE01u8fR6u/PszS8xRu1tHB2vWhvspa1wYUS//UZqM
 eJc1VRQ9H+ttoufjgN7XV4YvT/mMq4c=
X-Proofpoint-GUID: 0UQhyCV_ExEafFo20A-qwM07TMXHy5XN
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa8da75 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=k-9T60deko6e8epjNngA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150079

Simplify nxp_recv_acl_pkt() by using hci_acl_handle() instead of:

__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
... (handle & 0x0FFF) ...

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btnxpuart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index f2bbe6e462aa..69e897444112 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1400,20 +1400,18 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 
 free_skb:
 	kfree_skb(skb);
 	return 0;
 }
 
 static int nxp_recv_acl_pkt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
-
 	/* FW dump chunks are ACL packets with conn handle 0xfff */
-	if ((handle & 0x0FFF) == 0xFFF)
+	if (hci_acl_handle(skb) == 0xFFF)
 		return nxp_process_fw_dump(hdev, skb);
 	else
 		return hci_recv_frame(hdev, skb);
 }
 
 static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
 	union nxp_set_bd_addr_payload pcmd;

-- 
2.34.1

