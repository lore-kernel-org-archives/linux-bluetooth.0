Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507B3C8700
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788152653; cv=none; b=p6xQIwW2lbHf8K4rRFi/QuTeaKJ4fOEjY3KMoriAB/ATGfa0gDhyvPh7XVJNK2YXfZQfxSsWFAwp2/vh5LzVBXebLMjMylNLuy27Vnuzn0cV9mFniQqM0hRhRWu2ATVswcab+nmYJo20QUyTj4dGuqc6vYvmCL46FPKIJMPv224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788152653; c=relaxed/simple;
	bh=uj9ZUydfehOQKuz+gsUAVme2z8VoDIogLFBKWMwrTMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBxbk773eMCN1KToEeDIeDST4IoA2qY6P4ntJwxseqaC/ONX/dUCQz3LrrsKIZaQbKy3hOY795aOsHd65ewtKSLpzKGnIbvCNhyI8b9Ma4dZ8/iioeE+tcoQrx9E67dwvJTlk/Oq2cReFJ/nw8c/UU2OLYXxKxKIojE3yzbFOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VIfMfd5T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GUVeBUWF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VIfMfd5T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GUVeBUWF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52TtR2617663
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ddfJOz5sSb0oO3jKcFpnIY8t7Xqi8+ah7tn0Hg5wYEA=; b=VIfMfd5TIKzaWFLG
	XCdRGDG88hLGEwTLWyikHn8eMvYkIqSMRg2N1CUBvhjRjFxYtgKoA12QngL5iujA
	sMHdPLFjOTI5lT1aKHiuUVkIkEMvDrZWn+fcZnHT5DnL13xRp7t9IcrmQfyNZdp8
	8XKQEgiEbFkx02zfuLq4wdYZSF4b8ypi8LX62D1hlB0AmKBelzGgyJpj3LPaze3J
	hBCc821DeIH6o7IijOoprUFO5iU/+Q5PuGAHgwWPfzZCa55gUONuUlbwr4na4G0/
	CVr67YR51H1lZ9f98H43P4dn14PyhsI4KxOKfQ4MlqXUucBWTuklQ/4bwug85E+4
	bRGTnw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqn2mm32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f005ae3d1so556971a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788152650; x=1788757450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddfJOz5sSb0oO3jKcFpnIY8t7Xqi8+ah7tn0Hg5wYEA=;
        b=GUVeBUWFqCUuFLUxP+b1uSYxAXaYWjaR7FqZAMIJcFITCkX2uNIZjrJ5BoYLf8PTD1
         901sTgUsSQPvAJqs5k9COeXswzfRdObZcn2GcT0hsIFZa4+DYYE7dDcSb0kUvVeQ+tkq
         6pccZsyyz5IJN6YDNCgslKQizEQwJIgbXo24paW0ldTV+ny7yB3/SEc/U+8D7XS+z4a7
         FLf6l00tpt1FXSyGteX3YGxXygZrwsQevWdentRBTM9cVMutfhzTzDP2SmYLhfmJegvd
         DREZehUw+gUU6kWIu4gR79riyVhjyuKbEajTp/m16xf3a1plYzIgCkrgvtl9NNOPf1eR
         rykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788152650; x=1788757450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddfJOz5sSb0oO3jKcFpnIY8t7Xqi8+ah7tn0Hg5wYEA=;
        b=cZlWU3GoIZ3OrHIyN+LxVXHC4jIh83gBouerY6RDkIgTrTqOz3Ofcz3FimBINYsbT/
         jLTzfzV1uvqrKv/qGHznWbVMamJQJeVNcRunTBQN6W/c8Waw0/mj4yQkFtBT8IB1JE+R
         UTNNeI8ZQdrFeLJwpGS0phpd6C4+36rd0L1WkjcbvzgTW+EsdpkC4zBecmXfepvudMTn
         RNQTErz9aFl7Y+EEmtneT3dXKTg5h+NeEnYN5+AL7noqH3hgjOLS7iDOYH4ZicRDeKvx
         AvQQNZZ6JpaP3pQmoscQNX2wWMzmEV3nnTmtkD4txzN0hy4q5Mzrc5R+IK88TDy6aFTJ
         TJiA==
X-Forwarded-Encrypted: i=1; AKwUvBxu/qwVewK06ZODc+/MzNWZmh6qVbmwL/N8b4OVV8332g9mhveHP2D3NwG+Bgdp+3dligK3RzddpdQAbBv/9f8=@vger.kernel.org
X-Gm-Message-State: AFuF++nGL2OvDQDUOiKctzkX95qEw+iXPpT+gpyECS33lpicoaGN7JXd
	aYSYXWiMy9ave38ZK5ZEEqYts/0wnbG0GjbvSH0kLRTPCrssM80xyxBdr+IBJ2WWgJ1zeBQ/TAO
	EQOD1TbwiraZ6SasXVIKDr93LbuS+yziyOcz+TruGLBQT1FV63wnLxwS/WPxeUnQLP5Ta4K7oz/
	/ApSo=
X-Gm-Gg: AYBFou1I3cP8gcHMz2cUbvqUzV6koCTqAlnUTi+ScRVIbiIIx7ZxCbza9nzEP+/0vKi
	iyLE2oRUNXjoWd+DjDHFJECxV8cJu5QicWYpdsDjeOaQ0kRap8lZzNN+7YkA46UY0x6+u4ZdQ5p
	9fmDSKFxK9+6hzJyXNoZnFeLsHv7nNTewNl2/c4jYfFTDGeKTlpZg9x34H2q+KqXE9kVfcKph5k
	XtOcXOvorAFn6thCE+HgnMcf/D/E5X+NfWppwkjeKIBIC5/3fWG+/7B9NH560/Tr2h9y1nJt050
	/bObPuS7hdERDXluLjc6llj/+PklvF2wHQE6NY64EDkUkBW7IjCQ29DvRd/ptAywJMOfbJLBUkT
	c+2A+oOhD7psLYJhbGA55wsq9tEvSf84sEcA4JvV3kzExsog=
X-Received: by 2002:a17:90a:d2c3:b0:398:cee0:67dc with SMTP id 98e67ed59e1d1-398cee06896mr4490176a91.5.1788152650207;
        Sun, 30 Aug 2026 22:04:10 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c3:b0:398:cee0:67dc with SMTP id 98e67ed59e1d1-398cee06896mr4490154a91.5.1788152649794;
        Sun, 30 Aug 2026 22:04:09 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm43017912c88.14.2026.08.30.22.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:04:08 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 30 Aug 2026 22:03:52 -0700
Subject: [PATCH v2 3/4] Bluetooth: btusb: Build the driver from multiple
 source files
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-btusb_qcc2072-v2-3-5c0e0c9dd98b@oss.qualcomm.com>
References: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
In-Reply-To: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: Q1oPqvKcGxM87qWIBIOjCKRNmle2eicT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX/CYnkOZRycBW
 ohB9PYNU2yCPa8wh7vbCV+Oby5HNZdLKlthmxbuBx9AEyUZyETeCHRdI33xnZEhqhyfCJF5u2zo
 FtkRQnQlhhwhsXTUfxDj2PlqZvvvbcofE2oVeG8KxTb4x3T56JJtgidteGCRrIgdxffWvCBfb1U
 QQWkfgAka+OqEivFpA3Fa2+GDYj9afEXsept4EyIEwHlsneYNkD/+6U/sYdxzmXEOqvaPh8qZwY
 NVl+Fs+31idBIYRMviC0bqVUrt9/0faSEd+WTh3Da7c/WgaJmFt4iqTLYy1pqbTy6WpcZQd4/q5
 mK/DgtwZ6PtQYNS2+b478L3m+frUkiszNekRRwlRWc9qKWoEWqgreShengW5n36tb2omZZsSOPj
 lVdtyMODfhrDpopaFX0Adx/4oZx24S+BzJ5zI5xWMQsZgH4fz1+BA47EIcw+LKPT5AHHC4cBQ4m
 yLn5mxtKBv8mjJgI7Mg==
X-Proofpoint-GUID: Q1oPqvKcGxM87qWIBIOjCKRNmle2eicT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfXyl+fk0CV/oqn
 bBlfgE6k1tQ6SS1m3HoD/CyS4NP7M3GDytu1ZMq9+b1Eun5pSowKjiygYhf1piy5XAj5jE8KQHV
 8qEzSvPUx/A4qmb4GXszAl0lrTMDV2s=
X-Authority-Analysis: v=2.4 cv=a5kAM0SF c=1 sm=1 tr=0 ts=6a950b4a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4J4qWk0Wo-fRNhQ-KTgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310041

Allow the driver to include vendor USB-transport-specific source files by:
- renaming btusb.c to btusb_main.c
- making btusb.o a composite object

Used by Qualcomm QCC2072 support.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260714-btusb_main-v2-1-fd32cf15c26e@oss.qualcomm.com

Changes since previous version:
- Improve commit message
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

