Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91B43E069
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789450873; cv=none; b=bQ3GM+GuHbyrgFPw2P5sI6XwG4qETC1NKafZz0y3gBYVYsMgc3/9evM975WdsRj3f8UXs611vsga9USoeeqH+KPmmvVRoCn50l0QNk3Gl2u0YjrR/gbvNhIZ6HPCvGrhQZiGQHnTnowHTpdICHYAtgV6dcmrADo0Lah0SVKcAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789450873; c=relaxed/simple;
	bh=Hd3h8KPjaxfbpke901lpJ+9XzRU8B7Mv4K1p6Nk11uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zkm0DyYaxh+W0C2hi9J7P/p0afyzic/i410MJPIxWH1JAM1OKtavFzw95onqBLVmzyY6VYKPUqI/bb1rYL9podWNFrGaocnZiE/YJDVJ79vekRJxTa7OUvADu74OdiyXVmDD42fmRrO4hSx+9Vz8gafzW0xX6d33ALQ/j1T45N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXcFcsVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HK3c4lTw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXcFcsVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HK3c4lTw"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F5PHDk3160497
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sHGp4VACy/9bz2acd/gwrvXj8b44/OpCnLoTqNtuD0U=; b=OXcFcsVjq9hpKEAg
	lm+Y5zg/MRW0XA2sI4RiAGQV2jrQtErfpBEVW563AD6P17g+xKaddbAkt6pqd5Dy
	/JMg/rLQhJMThAgbShtGJUDFiFcZyxBquLhXtcYd1a0AP095G7Ry5DKG/g9q4U/R
	BKK7TpWuMRb6BwWryBz6PMawSsqB43LjeUxykcm8j3PmP539SgkczD+sSxAqgEJa
	Cc+qAE+m0ij1lIR2ev5N6B/hnL0ojfA9OYiklUMn0xFs6O/b9S92ufFu4OIi4OYJ
	CKMYTqnaI7OiZZ5FEGaj7jvx3PJ+SsiTbqRBxAN96m7lOtC4e3AiIWSeWfD1HHeO
	h/WpAQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux01nq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:41:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af306c795so996261a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789450870; x=1790055670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sHGp4VACy/9bz2acd/gwrvXj8b44/OpCnLoTqNtuD0U=;
        b=HK3c4lTwHkqVDy37ucfOFLCqKqUSLEVuAnq0aJQM1fpiU+tFIfImhpQDqOYmFl/aNv
         +ozS51wAgxtma/shdcvw9ayAEkNHpWQMkkT4hM8WjhzHrlkD2PjWsTvgs47Z6kJDAnHU
         EMArRbc0UE3DRC2S1v6riufi3+BkmfKQ1THijtQNzyV9A+6qWzrkgJNcEpNnrkxD3d79
         tQZwdOn2piy0oAyazSsND3r1geDYHBNP1OX5JHL41Zc7ktstOg1F+3GspSNQhrRU9RlK
         0+KGuUIWST6+WkakfOtEZfsq7sgnTYDi8dDA7iiClenm1UEXzdoHx/GdIGO8KDcHtqvQ
         jhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789450870; x=1790055670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHGp4VACy/9bz2acd/gwrvXj8b44/OpCnLoTqNtuD0U=;
        b=Nc8xoCv9V4twruCDd30bJYqzUee6YAl5Tmhhnx4A/WS9fWKzGrnEzrWCZ4KpB689Zb
         hnWnJKlxzvhbypUt2JO11A/p+QMwLVrjvuPGbL6eUwTageCCDj57yyFxG6YXWE4fv7ED
         mISGPrz7aFCsV8ao8vUr10J+sSD/JCSuuKVq0cS9EJRr49Of6UGHmLCqIP9It0M7Xj+D
         KgEC7WkJ2PosnBwezu1UcIjcutuPrBfGK2BLD3bgzTqcNgLz9SvjRiMs8kqT2SyUUMON
         2DyVA4pbhflp0B6hpqNusKn2MTJMsAkiQkpZKzYVcOII1NnVrsW+FPHEE3JBlZniiCqe
         WLGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFJSLMJcWi8aBQanTDzdukDS3Vmr8WX/WlYUoWzFYEegjkmp49k3LGSrsViGlGxORr1eXhLbqChqEPcxGUXNk=@vger.kernel.org
X-Gm-Message-State: AFuF++lTktcFhgTQB71xKq62bt9Pp28crM5NsN3Gi43AQ37+kLs7kDfW
	iRCIoEubRzvBWZKTJkqExpqYS/QTJy7yKrFowfEDWSE1uQrMPdqlkI6Ov7PjBoSqde4vTtFB2m6
	iQ9IYL+XtOtL4XYRFdHe/OjrpV/iD+rbjp8G2/H6iFy4cL4RhaP35oNE/5AmsFsQIWfwNxB0=
X-Gm-Gg: AYBFou1pLmQcO+WnUXhEmUuNwWa82sBHo9mtMOAxYBxaxN6oQIvv3lSqXaE8sk6odfe
	LyX1N4Lnuyl0SbW5dAfADszEHll72sIvIwLS5IRkZ4kWSyDm9qmsBxw1JJgc0yWHEUlecKDxS8N
	hvH1g+AszimTCrZNU6sYLDe7/nDslZvEzMv6jNti6ncEuw9DOrE/WppfcEticvRlBK9/4Sq6N2i
	yedlgqKagl6DZ5XQv7Plmi6VnJYIIhuC8ae4FRfkJWcX8PkJQpqWtsiOjQuaSGtGYW6oUEPKUyN
	lrdvJMiHDsAoOfOPOvafmZ5gEpQ+MqSsLxo/B+3w8tHPswRp36oJ1ZVQzR6gZfJMywAdGWbI3+A
	dAadDbl7MI3fGS1fbE5liRokbTPJzhVFS9LXJ0JuDwumrZdg=
X-Received: by 2002:a17:90a:1690:b0:39d:f137:db60 with SMTP id 98e67ed59e1d1-39df137dd30mr4614808a91.0.1789450869774;
        Mon, 14 Sep 2026 22:41:09 -0700 (PDT)
X-Received: by 2002:a17:90a:1690:b0:39d:f137:db60 with SMTP id 98e67ed59e1d1-39df137dd30mr4614784a91.0.1789450869337;
        Mon, 14 Sep 2026 22:41:09 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14390c0be29sm1589960c88.9.2026.09.14.22.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:41:08 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 22:40:52 -0700
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Fix skb leak in
 nxp_process_fw_dump()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-misc_fix-v2-2-6178d838c946@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX8wzoIfl4+fEb
 VQb/FAhmATY0xYGryzm4IDwskyLksm8q5MZcmPE9Sma7NofCWmghMi+8qdQw16fB+0h9RiLXI0X
 Qa2+SywcWM6qJpJ+uTobCoadN4L+v4kP0DrJQXuO4wcGdp2qRv2yknnHZA8c2zEgFOx8qO4U+mx
 sbgvhWzCiicqvUwux6+8+XftGTCJvhytrXscW1GoTR9FOay32A2p6WVXLiBTarc5ru5c+/7/wqt
 HauGftIVjZq0Vs4MZG1hmZj7rUZii+H4+844f+LTK3yvPW35WsHijccG4Hs5m97+FrOMozlHamv
 sn2S9llI8lu57k8R0deeh0aBSKjQTbawXgahnlIOtEwHj6LFKN6tAiEZVE+162Z8oHxkYUpKb+S
 F+CZc/J7HlLj1GE0r+s1hDzLNjHiglc1IR+/33p7IGMJ0fcgHF4fN7OptMi5nc47LziXOmVHKFl
 b4PHo8TtQaI1QwbMq7Q==
X-Proofpoint-ORIG-GUID: aeLmkavtwsTBA49tXyaH4DmVGD0ifjwD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX1sMsZGEgHIDC
 ayxua6oUoRYt2hbd74cC+TgPkoNajBv20Ls2z39okcLr7ZY3T7dnooT1FUrOiuWC+Dj/H/aY17B
 RL/Yg2ZYt3XobPVGEoL76wVfVlz/UEg=
X-Proofpoint-GUID: aeLmkavtwsTBA49tXyaH4DmVGD0ifjwD
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa8da76 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ts5nViFRsRHbD-iAU4sA:9 a=QEXdDO2ut3YA:10
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

When CONFIG_DEV_COREDUMP=n, hci_devcd_append() returns -EOPNOTSUPP
without freeing its skb argument. This leaks the cloned skb and also
prevents nxp_set_ind_reset() from being called to perform recovery.

Fix by guarding hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC)) with
CONFIG_DEV_COREDUMP.

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btnxpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 69e897444112..a0b64fdcbcc1 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1383,19 +1383,21 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 		err = hci_devcd_init(hdev, NXP_FW_DUMP_SIZE);
 		if (err < 0)
 			goto free_skb;
 
 		schedule_delayed_work(&hdev->dump.dump_timeout,
 				      msecs_to_jiffies(20000));
 	}
 
+#ifdef CONFIG_DEV_COREDUMP
 	err = hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
 	if (err < 0)
 		goto free_skb;
+#endif
 
 	if (buf_len == 0) {
 		bt_dev_warn(hdev, "==== FW dump complete ===");
 		hci_devcd_complete(hdev);
 		nxp_set_ind_reset(hdev, NULL);
 	}
 
 free_skb:

-- 
2.34.1

