Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C04248BB
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770760; cv=none; b=j7BMa61OtnA1+h6xBpQjHWHGB+vjz1FFT8yHANQ5dbvIGZ4Lsc06fGGX1LCumZcBICvRiIEt56kYGoQAiX9sPABYzrW4VGP5/pD01fVvOjDn3mTkEfDKeJdc/NvwPF3g1PS7CfhbEH3hAGK+ZbPALiPo1Jexhtoa8h4QplhnjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770760; c=relaxed/simple;
	bh=3QuQQakF3Zi22G3iYl7aYfWmFHhSS6FeB684lImThr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJxIdfNxvHSU4tEQmdyQGHcAKVCyvhsMLgGzGhQIM/6cFziS6CGu+ss2Ov+iK9/XbFPbVTCF2xQNM7RcZe71XxQTyhqi7rufk2vaGSy8mano0Ir9xH0AovtrAh3+soq1wzc2e4JLD/JPyXRJ6tO1BLJKP9UBrbWWqetGSfj5Wts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvMlEuna; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W7Avl9Ee; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvMlEuna";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W7Avl9Ee"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777Mbr2838813
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 08:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=; b=FvMlEunaU7Qa1/ad
	n8TQ150Cpe4L9m7E94E6cR0IW9BqaL2AvWiKfd8EiWoLzTMDP1FNLxmkCEhp6zRu
	6sc23q35brr5mn5luYp9AezkVST9w60CfcfCK7mlrA4bxHuGYOwx8EhyaNNVjNEt
	DQ+IXsjtyjnI/9JFSL41OsofUdITzxWlS70eakjqiri9pzvEW2lUnd4yyCUtAPOT
	YFlXzmBEcqNzUUKq3U47GcKuNCvl0bm9OmPxMTRtXcV4XXgIyQ+cQpILVwdAU/Kv
	3bFHC+Povb0uU4Bip7RB4qJDRA990i2UlmtFcWrbGdeV1cTRNpSRvSBlns8wJ/JO
	kxRpjA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuep1ps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 08:45:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39924189378so1094971a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 01:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788770758; x=1789375558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=W7Avl9EeiUE9t9CWvsdSRJ9haJJ4PS7QpTLNDuzEiuaMjUDv+aKXI9JmbxDiN4/pp9
         hik6MgsGy4Bsp4LVHbx/1T+NQA1fYzfcFv2gZ5hIgB7Kvcn8fjQzPwWGxek7V3x66xJv
         ZMAe1l/RSsTPIJOXh1ukCX+isGaT2VcAzk+ZJOOEz4u8o2+tI+uia68cilVqDo49jI0m
         LfAKuL/yFuNDMFrj78aMgvJPzbzwJIZwGMjqRtROOnDck03Pclsef30oTJR28DanwErv
         iikq8KxUHgDrhJ1rqYYpHvFh2EBkVsZ4bQUCkQg9ANHEBK+pstTQ2r4PrFIavzf2/dxh
         pEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770758; x=1789375558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=sshdWGtmd6CWudkaaZkn5IniQ/rY9GJvHe36UZu0q63/E8KgHUe+f6kJKfxEN47xk/
         hEsRjDWW5tIcP7HNAZ7cQfFL2C72ajdBo5DmEVMy4QtQkE11zQ+5GwDVPatJUVt0YV0c
         rb3mcpUwYibr72sPKgS7+mKI/u9TOFQjk1gOInf9XKw3pJwCdWCd0UIRySc7uIDq4sW3
         1bN0U2Y3oZE1nibcpTFjDOwku8+1dRS9skxtSdGea4iJIbxyRgwbzeiP41eLWdCjHqCh
         vuePMoJjtwJlF1ZCu0EyqSwMlGhEJ4yImqo+yJ//+RC5twbP+ueIRKTKVx/pSeIEbQ8y
         Azhw==
X-Forwarded-Encrypted: i=1; AKwUvBzMkE/BNUEA/p6LK1rWKuijQlstVNp/IJn+bSu2S2bvmDptH9T1Tfd1wV9E+pSnkycWqg7rWsPxN/j+56muOvo=@vger.kernel.org
X-Gm-Message-State: AFuF++m8D1m8YDjkK1dNZ25Tl3UhRKBRKWWXiIDzXPle9r24qWyXCXt9
	vJAyN9oHCqB4hi0tzGEtL8KmDSBtwYAa2Ui3Ho2cQ/EsZp8xgvqWsj7VJf0Vm9+U2q4w0SiwRWz
	8XOSid/zJJT5s7Roc4YV9kK8v7ZQK8juUxzzsqumZn1M8m1JdWf53CJh4DyAAHh12vJwxdlHWT7
	qXiBU=
X-Gm-Gg: AYBFou3/h7DR0mJI0fCpXM9Zd7Ve2oCjgdgyet7F0wSYiKKE9XeLko0Tk3boXbAbME2
	V0snpNKe9nYE3QmF41pMgr5yfllzla1VDWP1Cb0xxBroqTXeSpahE09eL0bkEYFJyVzQ2fJmJgB
	Fpi7ASiHtKG7muyNoJVt2U5YKMVpST/a6+r4VAWQ6+bQZrRexqBh0lKoFlUaQUY/7HpklG/t7U3
	3KGts14e2WwPMKg0MKD+IUt+sgTk0Nbyj385hCEhXBAGsGe2I2Ql9xzJfd6oZFg585cg5s0Abxm
	6lhxehhS/KyzHHH4xBc4HuxTqTDnHhXCD2NXhlY9eoCYMjyBwAWLATkNnCxOZqrOXfiXBG8Hwou
	l+8RLWLFX0gamiADpJym4xrlyo2LMO7Iz2cE+/d3li59L+sE=
X-Received: by 2002:a17:90a:2cc5:b0:39b:64e9:2510 with SMTP id 98e67ed59e1d1-39b64e9607amr3833186a91.4.1788770758048;
        Mon, 07 Sep 2026 01:45:58 -0700 (PDT)
X-Received: by 2002:a17:90a:2cc5:b0:39b:64e9:2510 with SMTP id 98e67ed59e1d1-39b64e9607amr3833159a91.4.1788770757610;
        Mon, 07 Sep 2026 01:45:57 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm23622117c88.13.2026.09.07.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:45:56 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 01:45:40 -0700
Subject: [PATCH v3 3/4] Bluetooth: btusb: Build the driver from multiple
 source files
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-btusb_qcc2072-v3-3-1f65350b03b8@oss.qualcomm.com>
References: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
In-Reply-To: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX7urikecGZp65
 rhS9+J7oz0d1kgLeXUTaVbLjP4bJ0i2HFmMEXU0ZxUEBgsinVUfXWa0+4Ncu5QxLSCq2lPCmfKP
 fS/GBrFPBvpiw4650DpIwT2Jqdu0F+wqfU1lTHqrbaaNizsORdITrfmF/R9CbbLmBbAVOO4FITJ
 LIhbmdtbrUs/7Xo7W2ep5OvBU/Z7dgUbo8jj/Dyx8ECd8wX7gSgfDkldLTNxD2RmbSvcCh6o9bg
 ha4sa+bxaimxM2vZGhB+gglkLwUK05mjEchww/AgVbuWAyoHrUu0okL0GSpVhdJBCNB+td1SsHl
 0nP5JuwAuSflN+tGwduh2UO94r9n5pKp8PRGTdJNrrKDEhouUtUryvGKqaVMcSqNZE9Cf6vjcKH
 COrZ3xXHSsm9fZEpxBjdot0WSjPtq1avCESe4O4PW/JWtPT8o9srGO7RcfasPKsypk+VE9AtgSF
 vzcpeo8oqRPit9dTxzQ==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9e79c6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=4J4qWk0Wo-fRNhQ-KTgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: ym1RzDqg4L4-qhuBqhUZxRQcgpJDIY4w
X-Proofpoint-ORIG-GUID: ym1RzDqg4L4-qhuBqhUZxRQcgpJDIY4w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX+ZGBaqwL/Qqz
 RoIT+uPTgT7Lr2lOCihYSznUIvCzw0xyXXAzAWtxQktjaWnusr/JnkJ3F91ZeKsHFDMgvEMZ+3F
 XLeePwSMLKc+GO3J4gZdKwjcI8BjwD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070094

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

