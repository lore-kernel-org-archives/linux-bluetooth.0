Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01A439F66
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737477; cv=none; b=qFx8N88lVCMM+SEx+ekXlt9SKB8JkLvGCCu8uY9WIRP6iXt32Y/kyUnS+kY/2HBExFTSp1PRjATwB9Fnxlp4g2JbrRHbGR2Dy7ckAO2/mz7FzQ/nBUYmny0EK47EH/wWrqIQ7sqPWM7AdhLzWS2M/kJRe9VpXQ30Vzn2M0jASWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737477; c=relaxed/simple;
	bh=ujINoWvFEXQOINBn9QUqo3F10YVyvQ7B5C1H6UXMOyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6gffDGNm71vZ8EwR5e4o3GYs0+ph9vUGBEDI5EH/vdsvpWMs75h/Z5//LnYlrobLceZO2NIrgbtwHrugjC3urdSo0P6pHeSsR41nX9pglAMcbmq1GZyLieMmVld1kT60cJHJR6hIXPcEyTSdwvqW4pTRsZp+4JFrkQHWkMGRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fTtZUVBe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HlMVsPRm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fTtZUVBe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HlMVsPRm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFXwsN1176086
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iLzLuBwgWRJMznJIT1I87yw1WV7Wr0u9MEqd4UADguI=; b=fTtZUVBeofZFUkJg
	pGfIW2N+M+tddGsnrnMh84rnZBTokb/YvPaZNaJ8WSHyeSm618q94VO15fRpL5Ay
	Zv8Ol+m8YiJDGk3oyWOEApVoWY7TXAPmbjrRHiy6u8aQi2DnH/gNRM7hH33SV9XL
	muB9ZffZyMEYaoQDUoxRf/GzCIWxZ0VdO9qLYsMFB1GjKi8mFj8hA1HHWKaIMRaO
	Z8oNXkfIHEVJYOizPHc1CWqiUTz3aWPUyRGdAzCA/hBR1OAYa4a/42fYc1aTH1A8
	ZS4/ZJn0YRv4ZDpcE6K6hCux0ZfXwaj9+J8C1jdRCRDAsccCuEYxGBbKsspjET4B
	QIDbrw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm10ved-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc4c126cf0so48495ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784737474; x=1785342274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLzLuBwgWRJMznJIT1I87yw1WV7Wr0u9MEqd4UADguI=;
        b=HlMVsPRmW2IA6hL9MQmkMcdAEJloFt1YdNY3BIlACcXcG4QwyWs/TWGigjQgagP/gk
         hKJa2bfEBIdtt3TJU3Rg5cM5/tZ7F2d18Gk0ygR3U05f/AsAqFf8R67F/purws29flSA
         r4t0DDENShFjWvx3DjbjEqDFaVMkWfMOob0cQiR9nszJ83CSl6ZJe612qmaKGhSlgH9O
         7ClUtdwlpPjTkdkRj3+eIFzyd454VQ0L1ypBXzO69XroQyV42FwTiVCFkuKQvhuaflnb
         qyLLTgzyI3G6g+/+xKKI+hMuAxrjxjrlR9fMmGmEWhNewM6karo50gRdCnMJ+1Xg/Fnh
         Gzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737474; x=1785342274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLzLuBwgWRJMznJIT1I87yw1WV7Wr0u9MEqd4UADguI=;
        b=FxtsrcSHfv7H0zO9p4cKTqw/QjugIKPZnMR8SmAldAFlu1MB3AvnpWpLy5fmiumqkn
         NEx0fj82T/KzBumKeZtZbGgoGOXnk1xWXjPehZiA86DvMU8EnE7FoL/lfRmtjfm0i39K
         Ndicbp9rvgHuXNIKTxDppC1aDcbffYgiT3pcYVjnjfpalrlMKZ4zS788Yd2u/09+JOkf
         Y3dpTI36YKmtPYtQXvA/wVaZA2/JncksgEhetPoOsxmj35wfSpzKpwQ3p+d4oiNPj88j
         ymMRxSWlJSHHb8mZ/z6wOpizvIJuTkQ9sdYZ4k6Sv0HD2NiaErckOd4mz1NLLVQWuGKx
         4wew==
X-Forwarded-Encrypted: i=1; AHgh+RpXt6gLG7lj2sneC1C307CKoi4ZqvTOCUFXSvPfHZUAU6KmC6M+yBMxRPAhI822ws5crCJPcax6wWwGwd7elM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAgfcdlhnilNEyFJkmSIDqzrOid9HdAs3q+QU30b9p7of3fgr
	Sv3BJca2ElHcH97QpFBhFiYymyCuiM4NHEY7ADVvJgZ7yeIXFasavZ1YYonDoUluvEzmwRtGb4b
	mXvSaq/WFs1XNa2Zr0uX2froDW0KIHlt08yTIKqMpRqy/vmGvSosdPi7VsY96s5tn+pmIzX8=
X-Gm-Gg: AR+sD11Z2aKG/IK4v+qwN3ZUlNZ383y+lItxsKpDhg9jCWyU2PeCYBh/nyiNeKGcrET
	4fyzvpV08e675YpjHrpdP9ootEEIPPN/DCQQ35MP3eN/j+8zbB40S6Umd/3x6V/oSuMrLUFOiYr
	qXGzPEvzrQixgSLBs4PrWZefkrVD6gvqvdJ24gQ3ZZTyzeO33sSBBXBTyihHc/DXrhxtQXiCRTT
	6HnAcl43i52SMy4efyJp7Py7djM56dUuGUvVstMd80kG505qHCeZ3NAYctthpuUvGQJgHehbox2
	UJ6v3g3vLTdYEU4uW+pYN6AeY4BV3sNQInbDBIf/aOMcoWZ4/nBxdFGWWPIBG3/TIauPR9stm/1
	ZVA87aH3YUmaIyRfq4hkl/koC6s5eD7EkRusPTF4soWgwye0=
X-Received: by 2002:a17:903:1905:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2cf80472f4amr72977405ad.4.1784737473642;
        Wed, 22 Jul 2026 09:24:33 -0700 (PDT)
X-Received: by 2002:a17:903:1905:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2cf80472f4amr72977155ad.4.1784737473121;
        Wed, 22 Jul 2026 09:24:33 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9d932sm10569970eec.12.2026.07.22.09.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:24:32 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:24:20 -0700
Subject: [PATCH RFC v2 1/3] Bluetooth: btmrvl_sdio: Do not free
 HCI_VENDOR_PKT frame by hci_recv_frame()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-support_vendor_hci-v2-1-132b506460a4@oss.qualcomm.com>
References: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
In-Reply-To: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX9IH54AuZi6t3
 ZJkiaaZZck/CCbeZeRFIDS9Xer47b1JKlvUQpBL3ZGRc4XZF0y0DkBTF8riJXQ5N9wOR5DbZj3q
 73VuSUA8Jf041nUAqHYlSJI5LEYEQxM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfXyxggD2MyWzln
 W0svMWwWe6/X1oRElQv+BEI+VKk4mhtz3zKGJ8aUumXylFiI/IOUPljwWv4tGtSKuVUDtfwS1HR
 5mGJYWfYtBHitAfA1ATs+rqznPm8SstlE+QVsi5QoTriPD2CfezBXZknwXapCNK4OaZ9/HYFU06
 6HvzUvuukWArvlIHwslXAiEFT5Hq+S/diJKNRiZUC4OPHI+HEHfY3WIrhCIRLewMPl4eMm/S8nO
 y4lb6dp1ZsLyymdyrFXcidulQr6sOdU0GrtQmLMz7yRsdSIx3HeT+VccyAK+tQyJz455NO0mIXj
 yvt1bRBOIVg2PvgMtr6rlL+BmfvrGGaCv61KtFl5S+pRbmTAM8LuRDq1izYqTkzHwoTq1zampbR
 X3ONFqCBxUdqVHaJQnqJhA7UYWqGeYtw8d4gpBaOZUrWqEii2p0V0l6tEXVNVCpEpwVcnaTFb6X
 yjnWx1yZV9tChhAMmGQ==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a60eec2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=DZz0kYWpbZunJ_XR1fEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: PYhEdjJ0Ann8x6iQz5J1y0rNJPpIZjox
X-Proofpoint-ORIG-GUID: PYhEdjJ0Ann8x6iQz5J1y0rNJPpIZjox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220161

For a HCI_VENDOR_PKT frame, hci_recv_frame() does not accept it and
will kfree_skb() it directly.

But btmrvl_sdio_card_to_host() is still calling hci_recv_frame() for
the frame.

Fix by freeing it with kfree_skb() directly.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 93932a0d8625..b91fc63bc9fe 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -799,7 +799,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 		skb_pull(skb, SDIO_HEADER_LEN);
 
 		if (btmrvl_process_event(priv, skb))
-			hci_recv_frame(hdev, skb);
+			kfree_skb(skb);
 
 		hdev->stat.byte_rx += buf_len;
 		break;

-- 
2.34.1

