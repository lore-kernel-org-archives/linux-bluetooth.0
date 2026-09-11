Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD83B4E9F
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113619; cv=none; b=pvydgq1tQVs0fz2RW2i8o5/zbD0YCa37nsQrK9+5Hh9Bbnm8FxeoOAO1BBtn+gnwfwRjVC8IsMA0Db+Duvi5DoAGnpj+kkyRJ3CAFoH/2bJO9sbBEr+EtXzB/BB+jNklc0CHM4XwgTnbn1zJWMcjeFYGzbwaC+DPpxXrycdGfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113619; c=relaxed/simple;
	bh=3QuQQakF3Zi22G3iYl7aYfWmFHhSS6FeB684lImThr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JulxBZDFM2/dSDrKXZcajsKgLZO5Ec8EPESo5ovvHK4gvROKKVwzKw2TTtuKNZYB2HxigfyfzLpK2+hd4TgCJxIQUijQQ2K2naQHRGNGF08OrgrkeKV+1Kiw1B1HuejOypVApIzmEkNe+hXQb9ezUmSViAohJAYayzM888y7aPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9ZcKIIz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B3qXjWUc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9ZcKIIz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B3qXjWUc"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kf6O3366283
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=; b=L9ZcKIIzT679hoaG
	oQr9TBNGi49c5ulNXEACFjFIbhARSDk+DJXp2fMPkM2WVt32eAriYTMh0F6TcZyW
	WRPUIeKM2eB39cKXB1K3oETEGlK7Fnr+Axn4JPLiFQTg8QPmLghpngZfPhTRY1dC
	V+wppBXeWax9rhN+dvVoyJLJANF3MBDW8/uBUR3eIZ5eIWJyy0cL39jfIyIpDW1g
	mwIalZkIe4ZnGm3Rds/UT+dRL65vIPdCavGaNtojWu1BdxYkaRdRPGOQY+tUQ8HN
	tf0kNJyU7Sn6Gb58QBfGlCGoxoeR3RRnN975WorC952+PwxqscmonVdwgWdVwsNa
	awz8UQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k2arpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39924189378so205089a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789113615; x=1789718415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=B3qXjWUcph/6PxJLYjC+04q4uU7Vv0HtRqIpbCQ0Ch49sUNcZQNZURf+6oL1QorEwS
         q+pV4FZyuGTFAYToeDik0yoRWqvJNJawR7XnsfzWE1MPykzNwqEe+UAIr9uHNsDn9OvU
         qoqznmzzHSOzoUfHhDi8N51gfRsDFik4A1R6wLoBaKr0CbO+8R3hs12LHshUWwsnz1AJ
         Ww90Yh4Y/mTp8Q8X9s0mYd9zbJVdM5aQIKf/qZSEtcTRlcI+PCrWDp5E9Z4G9Ms6whTr
         6bL8y983rIgl8lLVgJQI+uLGvi2l3pGVs6XWmP0M7vk+dR/xOVNIPFQ5w/14MfTOJOq/
         9Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789113615; x=1789718415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=R93S4qVPU+WyCYBzpHC2fPvrPV2lsmy7m2la+ccE2M8vBQqOqQZ8rupJ8nI9vSJlJh
         jhwd8XvGXnePognACgbgqAH4g13kmRtuMF12biY/yVYr9BYlMXvocnphIfLRjvE3WsAF
         Tc4p91f85+0lZoxGDtZY8lxYu8io+aZCDYwOFcdDeCYpCSZaPAOer8QXgKA6bmZuNCxg
         TgVCfcyX1EIniFs7PrX5kHBVOFEuXf+tPjPZWbKuwJyA1//KXiw7mXkLZ6HRyOlaWjBE
         K1dbne1g4LI7rfQKF5X1Grue3dc+OopF0d0BRo92RAgCb0hd9nMdc7s3cy63LCmIl4NP
         MUlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxU/RZr3w3zVpEDGyrcYlaWUDuoTg2Lzo1xLWR9AoesdRGyGfBuQutICGKFzRco30szgwPCcGvrhbBj0vtvMU0=@vger.kernel.org
X-Gm-Message-State: AFuF++nRFdXHjuVlx4wfqcEd4aWzFuynQwm4rlHOmuIUDSS5txrzsnsk
	GDBw/esX9nHmlApgIOESTVXl8pNrzLk8bh/V3rOhCdjeR+QOBEclURVp/xOoVgdxmEPgYMnSTDR
	nnwdGgKEuU+GOfeNBY2FqS4qEtGKmGuBIdT662dFxiI5qwTV2D1jEg1s+n3/hipXn26Y07AM=
X-Gm-Gg: AYBFou2n4SGuLWSNW/3GaDQhmdp0sbW/02qwlttMiRsfu6Xj/ae4IRTQerJ2vU/KKQf
	W12IFCvggobDW/EgHb4/Jbrc30UqcRDkwku7pXYERqwysmHeFZsVRhi+INQdMqIrszdkxvCaVcz
	xz8dfBCcTO4rI5y194Brk352Na8Stt9jTo97o6WtF5okJuR5Bh0hGLNEiXKJzOA/Cb8TmIV3386
	4HLpQko9ls8hgyS5WklpbcueDljfPaTNgzQHWrmjkcqL11uIRqbY+Cb8ACsJEPfcyOdnlxG14rm
	y/wtD6/7M9eUoP4Dw6bKBZGHGKHHkNe5jzX8O3asSy7vxnyCd3yW709fmnMhA0k3xzdcVUKT6eS
	TjnQEqhCaOwKEJG+XjG1w9nCPDhV/IjY4K7rxl2YkXa3PrNc=
X-Received: by 2002:a17:90b:48cf:b0:396:d28e:b52 with SMTP id 98e67ed59e1d1-39d9c359923mr3078367a91.3.1789113614788;
        Fri, 11 Sep 2026 01:00:14 -0700 (PDT)
X-Received: by 2002:a17:90b:48cf:b0:396:d28e:b52 with SMTP id 98e67ed59e1d1-39d9c359923mr3078327a91.3.1789113614348;
        Fri, 11 Sep 2026 01:00:14 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf31c1sm4422328eec.1.2026.09.11.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:00:13 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 01:00:03 -0700
Subject: [PATCH v5 3/4] Bluetooth: btusb: Build the driver from multiple
 source files
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-btusb_qcc2072-v5-3-422754f4e938@oss.qualcomm.com>
References: <20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com>
In-Reply-To: <20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa3b50f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4J4qWk0Wo-fRNhQ-KTgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 1PqjJ44AmeislFLDjeIQJ4-Vw-s6pD6X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDExMCBTYWx0ZWRfX+KBScARR6Moc
 e655wBvB/+5JQKUI/bx8q0YMKEJSk/3/Le//b6vDY/YnlMIQuqo+ZYAkAaeltGauzubHc1TPRIv
 Pr4sVjdG14enYYlI7xk2ia78Grgt6R4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDExMCBTYWx0ZWRfXz/FUoIlyvYzI
 L/h2TbZCu05RqdIbwROBgDuBbW25hc+POOZ4L7bVtZxI6iX6uu0u6DPva2xyLjlJ1B7doNV1Wyq
 Xhtg8+iTRPOfunQA3jHFibPk7pBTNTPDi41M8S9OrXNMdCLuIXkvvSfVaxNofbFDdGA5Czs5yF6
 HPx0ogPwJBuSticv0PmU3cMzQ4ymnTuCq7+KX1kEIV+dMbq4mMMXTCRy5+3IF49k/nqZY48bj7x
 OO1SH5bfiXunx5obnS7W/0J3zuw7DMfws6cYOtF5QjMayztlTZn5goxrLjQWdFyySCeBKOHZWCA
 wymMu2IMYHMPKx1IKYYU85DQHXGlzy42XIvxl0tt+X/zm4AHqnt9ulOmT4f7GLLOtwPP+LkuEg6
 U8vagb3Xz/qpLL32TtK7iLUYhrlGvB6rfkuWYC5gqTMN9e2YxPnI+eCd9pWPDqy7c9uNHVZPwiP
 wJLezirUwX+4Fy1u2GQ==
X-Proofpoint-ORIG-GUID: 1PqjJ44AmeislFLDjeIQJ4-Vw-s6pD6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110110

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

