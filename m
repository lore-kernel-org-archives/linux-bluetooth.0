Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4130FF1D
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354065; cv=none; b=c/iZk6eGVXEwqqjrGHuNp0dvAp5SpEen1hHYySr98G2WdvJrIJaIn/jnVNQFU4KiQnfrcyjy/GRCEwwzRdO2Aogqgmp0zICpLuoEdZw7YKii8VdoBYpzTCvZ9M608Mw8uvPU7Ap1iuu27I6vOinAq+FUkIkZEtCGptNl40QHP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354065; c=relaxed/simple;
	bh=3QuQQakF3Zi22G3iYl7aYfWmFHhSS6FeB684lImThr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXUZkp7h9XMhsVtwyskoYG9RIRZD2ecFRAmwyhJ6NiLLITFXc5jSla+uAD02gWrNqq4UuWSJpHJXM5K3HJuFX9deBUhWmdsFR27L31o3vwdefZaOohz01CvvN6zq2OThAhshsHY4KrcMLURxtnTEhO4JTcTiyrhPmKxsqiDqSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ilELR7Qo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EVRu/BKV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ilELR7Qo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EVRu/BKV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eNJm3670973
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=; b=ilELR7QoBtWmhACI
	z+k4LYQ7h+N3oD/TRwLnOTDOhTtrnwm9qlhRqnjO02jr4dNZZWWn2T1fkJFcXx5A
	7itXooZXVpoaKUJHpyiwtZ4PctluAfISd7i1XU+zCN31le5fiqeEh6qb06fwta8n
	3Pp9eIuw1eXdB6k4nEFdZHWqazn01/yjPjViJGx5u6LLzarJWPEC3B7c/QNwDv89
	C0/amaa6Cyc2H8tX8QklzcyJ/1X2p3nruQqhDTA6+t2ZIYMlqH8JNv8OkzOujLyM
	kEdOWGxHzrPexbwcUGeukszsAI2vPVPADpklL00ENLcCr+90Kvxe9zUbsdY3qmyZ
	6n4tdg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsrjx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39af306c795so729219a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789354062; x=1789958862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=EVRu/BKVZQrCdhCFI90Bmhr5BdzouuMwPExSgexS7uctG0D8SI8BlcceZoDyDVd8Kf
         /7Q16vZOwt4I+b2u02bKOMzxFs9ycXP/MqDAgR8AClvOg3udBsDutm87sTeu6ZC4d6Ru
         lMzm1+0o8IZm22863dbiKevwPhVmHRTyoUjwkckA4CnCkN7VSoHu+c8Qo3ZzrJGc5wrh
         WLxT6f7NuM9XzsW7vuoC5rX8C+1CJzYDsQrQbcfaVnKPZRkomobP99k/c4Zl4D6TnYqK
         irkwTEzvMmgFc5kBEtGO/lVJGY8iTbkD+MakqGDRxNVq+9THXVj53JyV8pDhiqDwVLFo
         6vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354062; x=1789958862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=USimHM5r8/V+YYbyOlqfCoRdqIEKkEfzSJ1GA2WY6V8UQDUhboXQsyx0xvc+1HR4Mv
         K4DSYUgModpGETKwCVabLxBIGn613mrRJy6vIfolM0FFaaUEVsgDWRdLI5SkBUFnv4c3
         GPhF8aflLHKFLNmg7enJzuiYLV1ZiYdhZxIQzwszNos+VO30UBwI/VMHIv2zPPAaqLb8
         yFXbly+V/oE0BYz7hgEIY2SSDPg/KlVTdSPV3uaLoub78xLSJeVaHwT83fSQF9JxyoAT
         9/gticAfgW4krW5pxVS0IqRixgsisN56cTcW+5OIvBH9UrAWd+8ToMSALlwpt1VY2ITq
         mKUA==
X-Forwarded-Encrypted: i=1; AKwUvByxBbmVDatWeWuvHS39eAJuEiWKzPo5OlVek7sRBwUs7X07gxgsMovLmgH9OIpnroTIFkcYVyLlw0orIb/2Zn0=@vger.kernel.org
X-Gm-Message-State: AFuF++m9OJRB0vIsIXMXkj32IRUxriVwc3E0DZBYq2pmxIS60wM5YFky
	Q4dtGxPHDIIkTdUYGspXSA8W91m1Ru5lYV0UyrH6oRDksUMPU6UEVZhs9/bsVLePiESGHpLLsnu
	3aJAUi1WTuxt90CoV9LJ9EgegkE64e2FPjBo5fFUi2MqOsOMwpKoME58LyHaqESLIyyKQz3LYHM
	ISlpM=
X-Gm-Gg: AYBFou2khBCEvfjBV1jurOwqLm2/LhuOHGKsV+7Y6eRyydhAOdGIfPZk3F7hy+MYinP
	NJJSypnIOF61KSj2ZIBH7An0syJg6KYq0yI86e+jdsif1Hll1lh0F3tAFDlcamjC3YYbix8baxL
	7LqqUANnFcL+vRj9rmmFSoxbymQ+sAE3CDkhNYI/1Rh9af0C27jAXnkDQzzsSs9d98GxqoO6Ar4
	M+lvf+kwT+4gHxHYdERGp4vdO/JoJ5xDvIZaADp8EPeYTenK6axtZ35cwayw7kbM1mcOy9/e9y1
	laXQUtcEg+ZVg+JAde8cOjMhCNWqlUle5LXeRKqp06+VpjrOdivqfJoPuROEQGbGZKRzNl95uzQ
	FFRtenw6P8BEjtnMVTGBJ4vbhFyIpm+4BCTjLDY28KVD8NEs=
X-Received: by 2002:a17:90b:2885:b0:39d:e75d:97ee with SMTP id 98e67ed59e1d1-39dec20812bmr943301a91.5.1789354061731;
        Sun, 13 Sep 2026 19:47:41 -0700 (PDT)
X-Received: by 2002:a17:90b:2885:b0:39d:e75d:97ee with SMTP id 98e67ed59e1d1-39dec20812bmr943262a91.5.1789354061241;
        Sun, 13 Sep 2026 19:47:41 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed295esm25945014eec.15.2026.09.13.19.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:47:40 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 19:46:45 -0700
Subject: [PATCH v6 3/4] Bluetooth: btusb: Build the driver from multiple
 source files
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-btusb_qcc2072-v6-3-137898715844@oss.qualcomm.com>
References: <20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com>
In-Reply-To: <20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfXxp+K4tyMx7mh
 BZQbYdmx6SbzBkDvositOrlQSdiMjzbJRa08kabSsdI3fCY69YpYIZGsz45BQJw9n8ZgH1xD6p6
 3OwLwEBuYXTRQuk5X9PNl8hFmNdH9MPnX4m22/hnl2pi4k4nLL1npLXbgaY0utUBtJASXMdTnrr
 6KWk8uY84SbL23DKUn8Nl+zOeFQ3cSigwKtBbUEw8Dp8FN3+b9IdmUAj62Ra+WTidj1cTCKp0SO
 kQwQO5KhhPxrFVmQC09+BsQfkDyva3obeia4EhY10T89owc6ntpndspgYoQgU0DGEHXWx1PNs55
 7HR2iTAFbSkhY94IsqkXQsI5IYK+kYqOs6hmdeAryOiS2T01ESNMRBu7Fqf9b7o5uUpdkXLS/5N
 Uj9yoTIGvISTrAOJqjQY2B4R0gO01rvzz2L2b6kgBH8koyU3Nq3fvvDGEj2+PxgPZ+yYLxGVv3K
 taCRQEHet7Znsitao6A==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa7604e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=4J4qWk0Wo-fRNhQ-KTgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: _FAXXBMLNL5AGtlNG7xMTujXmClT43Xz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfX0d5rqCPHc9n/
 NSr8ayXbm+DVwwss4YO7ghbLwA0CYsrdoZizZ5ru0kTstJBHX5XIMSaxjHrrBIQXMHSehdn5ud9
 YFS2aR91UqVYMAmIem+wkQmsO20WREQ=
X-Proofpoint-ORIG-GUID: _FAXXBMLNL5AGtlNG7xMTujXmClT43Xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140035

Allow the driver to include vendor USB-transport-specific source files by:
- renaming btusb.c to btusb_main.c
- making btusb.o a composite object

Used by Qualcomm QCC2072 support.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/Makefile                  | 2 ++
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index e6b1c1180d1d..8b436c6de8b7 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -46,9 +46,11 @@ hci_uart-$(CONFIG_BT_HCIUART_3WIRE)	+= hci_h5.o
 hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
 hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
 hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
 hci_uart-objs				:= $(hci_uart-y)
 
+btusb-y				:= btusb_main.o
+
 CONTEXT_ANALYSIS := y
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb_main.c
similarity index 100%
rename from drivers/bluetooth/btusb.c
rename to drivers/bluetooth/btusb_main.c

-- 
2.34.1

