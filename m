Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11F363083
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357400; cv=none; b=thYNPtiLyVgasMvDQBfK4q+EegHI3RgaBJoUj4s4LsvMKe657YaoDvfXKCc/bzUK7od/zOD0804qH0E/YWLf0DpyoTnQuE19FKtV4NEnxVX3Cu+ZDxvgPhhS+1k+IeCHEpbV4WHyEcmOELyW5mQ90K/t1vTfkvy4472qAiG7ILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357400; c=relaxed/simple;
	bh=a5tHGTQShG2w+WKWXO+i1nzfM89k+Y3Nf27mhlT4GlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m34Q/xj8+05zp4FADO0fLtd+hU+D5/uuhXmHAiLnLc0421p6mH2blcjQbjrhTvgaXSqfEbKq8ZtA3PfRP44mK6I+pt55C3y/qe3nUr8dXZRvFuwab8m0Oq3M3SqXs/YTr+MyZJSF0T2Na/Z9kd/YzEhdwrMJQT7J4hvBE3nW9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V44TGmif; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R9alZy+H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V44TGmif";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R9alZy+H"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2efYN2241394
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FLXqIO4EZyno+kGY0hlJ6AQH1Bxjk8Rbfc2b3Iql1sc=; b=V44TGmifzFV8XnT1
	S2atvIZsWHVrnv6wPl9uakSAZ1Q94SUgFEZHVF7q6/pNqGZwDgoGxXiiFJVJ1C7E
	hOXxgas6JMgXatqszZpQeavHMAvhwNFHz5dwX1fLU45zSS/A4bVN3YA5pBzG3Fgi
	c5ZvJfiKVKWnuDcIeXS67iXwRDWcsCKWC/vJYqzxm/aJsYkdOFicnyVsn1C1zc7p
	22ATEPaXGJkRmFi/PGiWe0/p3ru66U4PZVF5YtO1GoNXaWyorHjCcjmnYYXVzlVL
	OwzdX6Gl6zXby38WKpMSpzTb+te+nP3Sx5YfM32b/3OP3wjHMC6YQUZ0xVUS21CH
	u6Fdtw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh4rnq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 03:43:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dc0eee75dso1223988a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 20:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789357398; x=1789962198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLXqIO4EZyno+kGY0hlJ6AQH1Bxjk8Rbfc2b3Iql1sc=;
        b=R9alZy+HismUCRf1eIBmqkBq8RE0CT/EZIG4ReQNmSbivuVHTA4Vffl7iM0cbBGgR2
         bQW//m5lmV1hdVqtkUfQ+opg/cgneSgL428oQjFhVh/mVLJDtnZ7Lb0scfKjhvvETBvT
         TlERuKgYL1Qyncco5O05TmXOYTUgPp7RQYfhuEeadKPrFVvHoLBl5xpSb4BEkLzl0X5q
         /Koe5BsKBhGf1KoRREDGHSMv6LYFgOZ31ZbMKG6THJmGcNSLwwJAVg6yb7nrkFnO/i6m
         hvcOwanJoPLlSnx9IyEqp7/DBJ6ya/xsEzzkNriY3OvR1Mt56v4x4nhX8nqbTlbC52gS
         NUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357398; x=1789962198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLXqIO4EZyno+kGY0hlJ6AQH1Bxjk8Rbfc2b3Iql1sc=;
        b=FINawOTn5GUdp/bq/F4/Siodv9S9xND3j7vNGSWqPmbKu6vurYqtQ3PQ/Ewf06yUMV
         ZXtK5smbU9cehoYzd2j/pgZmHrmaZBC/REDmnl31rYDcsDSXwbAa5i+ar5E72a2j7npt
         Ve9xpE8goaSQcX6ddMR3mStcFoCwAfkVtuS5Lpvpv8yaxjJcsTITC/ClOBNEtKBrK1K9
         wv4kLatHJZYr3w2ld19/cbO4nUdjdM4hQHzaSA1DM2nC/B4IwgN+CcuJ1+GvRoM2YK2t
         wIHs25q1KXRPcdWPZjCVyULr/Res9fvrM2ElZLBtABHeqh4m9SAbIJ0f0XJIa6PyQhZQ
         k73Q==
X-Forwarded-Encrypted: i=1; AKwUvBzJy1ljxVFhgUrYUuzXzQ8zlZAT2j2echSjRDbuQ45GYo4l4gtj5x+3e4ymhNARXxf5VHy1g+aEPjKv0ySAQ+A=@vger.kernel.org
X-Gm-Message-State: AFuF++nFnjqkGeekx9fHlyldAQ0ffz3A3dADwKQBFFyAY11vPaKBbGD6
	oyDVVhxietTnVbvCRXpJpFceUuQKlgBsFNSnSsoxhbSUcSVpZAOCYMVtwTziDK/l/nipkiTOPgR
	+65Pcrvk3y1xBd+FMVBJRL4fME6USpVM4Ph+DlY+93XkOvUIc4kTywoL0VSMly9Uu7NBfx60=
X-Gm-Gg: AYBFou11MwWjyXi1/KJ11uVJrS46odhYFsfJnw2+dBRdnlQqP8AA7uRx4OSIKbfKdk2
	nWkQnihgkGn4cCgZIa+lQ1pYJsZWK279wrlEtRnrVhz71jPg2a43YpzotKE20QG2Ciie2D4bocb
	QD897g94wQfTFdP4x+0hwXeX/3DINwleJn8plzqt/Wvl322gcfM1uMjYitOlX1SulbVLbYDyyxp
	7iiECGfcUYszPNu3SB72C+FL5V3WhqDBVHBXjtdeH22JVamtnQ/Y5JBk1j+LwtWXZdcfVpObDMK
	oDKtw2/89dWBSs3VAqn3mR8P5F18OQuNqr5OfU63ffVNPNveRbdgAyOrfbjhBdWcIX4S5ghpoMZ
	Vwm1NZ26tzelLCn/B3WPbqOdfOuK4pij8zG8MQRReoZuJHUI=
X-Received: by 2002:a17:90b:390f:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39dec1aa1cbmr1094578a91.4.1789357397924;
        Sun, 13 Sep 2026 20:43:17 -0700 (PDT)
X-Received: by 2002:a17:90b:390f:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39dec1aa1cbmr1094545a91.4.1789357397450;
        Sun, 13 Sep 2026 20:43:17 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ee07f2sm21250894eec.18.2026.09.13.20.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:43:16 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 20:42:56 -0700
Subject: [PATCH 1/4] Bluetooth: coredump: Fix skb leak in
 hci_devcd_append() stub
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-misc_fix-v1-1-558c1e4028b9@oss.qualcomm.com>
References: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com>
In-Reply-To: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: wmgf04G0VDFW-I1zgFOIyLbx7zi8R1W7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA0OSBTYWx0ZWRfX54etoX5eljJY
 moX1t4E2I3NG5zVj+OIFXYFJbiim4BnjpRQxLId/0hzbqC+FRXNWgsalZQMbnDBLt63mvdUzHZB
 hHgcUAXBmuDpqvJ8iVbWAdL1/DkS0BD7LaIzq0e+HCIaYoLAToLv8qNY8e7f9PiGfaJKMKWFc9A
 0IhYWLHRfG5tv+SnLBXjuwZ8f5p9/XvrH3gbR+hapGugZfewnLtWOb5ee5WhCUEdxhJ2WrK0HgP
 Rn8jfVWTAX9Am8Gx8LYimefjSNCaoj3hTzino9A7eJpPVdGphMcxx7adT47xzZNhU4pAc8yooS+
 8UUIslajrI0zoybpeNHx8hpOlTRyexVQnQmRweYZ4Z975QKMsB+b8+zIDWgt5/Cs2+Wdxmahxsl
 9Tp7WMYjab6PlDmvIbLxNI6fV7FxcWOWv/BV/4AWu0VL3kdaHZ6ysZcfD4ClA/NDnjuNwAEsPSd
 m+wwTI4R/k1Wfnuqfwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA0OSBTYWx0ZWRfXy+m8kiZESUWw
 7SsUHB2gdHL7qIeEvKAOqUyKM9OAhFiUExvtcV3hL8tUaa1vSf1GQEW0oY/zemH8B21SnMEY7tj
 NSa/CMavxJx8Ufhjxus5LZ5cSuKuHL0=
X-Proofpoint-ORIG-GUID: wmgf04G0VDFW-I1zgFOIyLbx7zi8R1W7
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa76d56 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=K11JH97qNKem9avEOwIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140049

For hci_devcd_append(hdev, skb):
it consumes the skb when CONFIG_DEV_COREDUMP=y, but its stub does not free
the skb. this inconsistency causes skb leak when CONFIG_DEV_COREDUMP=n.

NXP btuart device driver encounters this leak:

btnxpuart.c:
nxp_process_fw_dump(hdev, skb)
{
	...
	// the skb_clone() is leaked.
	err = hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
	if (err < 0)
		goto free_skb;
	...
free_skb:
	kfree_skb(skb);		/* frees the original, not the clone */
	return 0;
}

Fix by freeing the skb in the stub to keep consistent behavior.

Fixes: 9695ef876fd1 ("Bluetooth: Add support for hci devcoredump")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/coredump.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index acc1849f66c0..07940a1d5dd4 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -103,16 +103,17 @@ static inline int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
 
 static inline int hci_devcd_init(struct hci_dev *hdev, u32 dump_size)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline int hci_devcd_append(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	kfree_skb(skb);
 	return -EOPNOTSUPP;
 }
 
 static inline int hci_devcd_append_pattern(struct hci_dev *hdev,
 					   u8 pattern, u32 len)
 {
 	return -EOPNOTSUPP;
 }

-- 
2.34.1

