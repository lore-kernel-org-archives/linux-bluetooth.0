Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897D49BD6D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050951; cv=none; b=PbFnQrY6qKz/UnGMWQDEafiIs3t95MpJ3PGG/uE8fBlyb56/u+0D331jOytyKWuVX9hLxr48PosP4d6amPS3gp7cl1eRVUGYFlf+ObOExt4DR16gOjat5HAqghPmkwoDsdN87u4y2UupTKkRBXZJNt2mcmwA2upDLsF2xRcKodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050951; c=relaxed/simple;
	bh=3QuQQakF3Zi22G3iYl7aYfWmFHhSS6FeB684lImThr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP2Ij1r23k0XUpWv6mhMX4XO7CSqdn0IHQWPL/Ayn1bgic/6SbCi/kxLf0vjk/v9o3qGx0WuTMcOI3wj3Arq7K634FRlF+hAdMP7bvN27ne0DwowNff36dpq6zyU0TCBRcL53u3NbbiKey7XzhWVgTguybAKFueQAHeOPUlEF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SNF8LgqM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XqaO/ULA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SNF8LgqM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqaO/ULA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ADc4Fi1067914
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=; b=SNF8LgqMTTS7i5vi
	OMhUdQSVbLmHTEThGhFnpUk+5oCzpcsUcBkRj824tQYn4p2OCEj+yaXQnvtsTzxY
	SMQdygBlT5Ata5Oj0bJbmx9v0VuthEazQrLK/tFfc+0AEwoDjlJ2mysf6b6NeKv1
	YlwI1lvbx55iJ6UngdUOvjgZFdizIeF9zNkv2ttvEe48r+XFSEaZ/7Q+o2/Yl216
	iKXwG4VtJ1mg1S15Zy7USy2wXSR4ShNIK9pg0kKqopf4KNMtWGXkj0OJMEPj5rAf
	dNpt3Mh/5FAdZHRRGXPHYhtCSa17j2spC2B/ndPVnTcNRMt/UPEhysTaptcrX4/r
	fTRHwA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwkw8cba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:48 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4bfc545818fso307027b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789050948; x=1789655748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=XqaO/ULAkL39tJT4R70E2KcpHI5a9KrvpY/oRzT0X1H/ka0AF0eRO72/9btG6UI97L
         f6yrS6PbH+4jXVvD4BBV6hbK2wNmv3qwYD8kKWN/DBuA0zkUTrXST3vHUHQeJy97p74l
         3ldrqOlq5r3rxVg3uz9RcDQerbm0ZFtE0zf9B18j7VwUuREPbNYe93UvObLvnZzYMfY3
         hc/hp9c0NDpaxSAQds7Ok2EEFbXEnpDxQUMQ5kJdYrXrvyH8cxafzXECLooLlr8npNn1
         RJqQ3ackvxQghTgJDbXqBctcTrPFlRdLml8mj8oJrxIEk+LT0DeSqA/bnSmO6cDIdc4D
         jmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050948; x=1789655748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Brs4thZkb+ADUJ9KGOCW0Dja/RM97Wj6zvjTE185qk=;
        b=lIoRMN638Xl9PuWneHX+nzDy/YBcXaEiPWWuGHopKk5qmL4dnmT6bg+UIIMRGoAjMO
         09TY/Rsv/sWQlbUq6Ubm7JamFxQMZgptJ8bMUaFGO5fQAUlnhz+5Egof/dBvAIoMpC09
         IKjhSOkp9drDxdilvyM87B9pvF1gmx/+I038mayaimgnOgSlOtWU2Wz3n3VakWBzUoqK
         xOrGfQXeWeiOwum9oUg7kdfQP1TuvlRjTIgPQTOSzcHOTaXYHL0xBm9GPvQbzAP6Egkl
         66Fud4W6uwur4KurXjuwhJInVoHRRxDofv7pIZe3PBQ1DTLDSXEckrlkObt5n85h64ne
         qFwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmGBMOB7JU3O6xsBqxvaQfj6WsZ5F9I1cIg2TXX6LPDgkf3IQr+3jrDU0eYMjvF8PNoA5zW2kkN79IpkQFZ0Y=@vger.kernel.org
X-Gm-Message-State: AFuF++ms5SivUElH9pQws3wdz7CBdZSguTXk0JFku6MGO9Azbf0h387e
	iSXOlbSd+REVDl6VD1Ndx6lFahNznv5JsUFgqfQ5DyevRo3jA/fFelTEG6gIEARubDl8NxvcTjm
	2iPgQKHP7+dM0rCvBx1IIipl3XkFx4M7ofoSkPTT5N5KbkFe4STyZeb/zS0Jva6KVd7njMliqAf
	f1lsE=
X-Gm-Gg: AYBFou0coTfAsc7xKUhu5GrO2YWUULWrx97lqA9kOgpqHXE0Qzr1QGgCyCYsWOkWmSs
	7KM7rwgDZzZoF3JuCByf+gIzbMCi11t+lV6aoyhHtHJjKqKpC6Cp2jR/Gwl32fStfqH/o6HDyp2
	ypfGeXdaU/hZdf1H6ZOtGm7YruZ+xHEvjDD+RuSzXm39eqLx/SI1QYMpavzp2gW8/uJ0d9oDHLj
	cBW+J5/lZB/LleoskZjgtfsDasSjnhYJVNS5oWoD32IOd75XwmnhAU5LU0Y0LvzKuHkaddYKAWt
	UairdSA4Oz8ytCVJHfbl75JyQyDV8yy5qcokmSmfmub37Hl26J8Av3x32/s8ZzKOeY+PG9VRRPY
	MvFnKB8/XibYeZRoJCyw72TMxDbIhX0lEjCyVgHgZ+WC0TLc=
X-Received: by 2002:a05:6808:318b:b0:4b3:749e:3299 with SMTP id 5614622812f47-4c1b88b9ce7mr2916444b6e.4.1789050947671;
        Thu, 10 Sep 2026 07:35:47 -0700 (PDT)
X-Received: by 2002:a05:6808:318b:b0:4b3:749e:3299 with SMTP id 5614622812f47-4c1b88b9ce7mr2916426b6e.4.1789050947248;
        Thu, 10 Sep 2026 07:35:47 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971246d9csm19056119b6e.7.2026.09.10.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:35:46 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 07:35:37 -0700
Subject: [PATCH v4 3/4] Bluetooth: btusb: Build the driver from multiple
 source files
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-btusb_qcc2072-v4-3-e78f04b7675e@oss.qualcomm.com>
References: <20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com>
In-Reply-To: <20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=EZNd0/mC c=1 sm=1 tr=0 ts=6aa2c044 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=4J4qWk0Wo-fRNhQ-KTgA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfXwErB8sHOxnSo
 Jw+fpczzknC3agnQwPV0n1UViq271QNa+kL7dm2wfFsCC7yEjDw9Y85S6EuI09z2V20HyZuE0em
 fzF6JjNJXYaghL0IT2I/GiT4ODGzIMA=
X-Proofpoint-ORIG-GUID: t6LqPUIKRTJRoVg5jZo7nejEZrNFjQZQ
X-Proofpoint-GUID: t6LqPUIKRTJRoVg5jZo7nejEZrNFjQZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfX3pPCiANckWBr
 pgs2H2sgs246m5n4u2LSgb6JNfG5Ubbf8DQiPgcSSopXn+I8dfob9LP/1kTlODsIRAWYnho/t0e
 P6KPhWcPT7YUI67k4TYiUl0XClpGYzHBIGvWNDSaiHRc2C5Vy5V/XjdFNPbbp8hR6UIls9X1SMV
 XVBrfNV8eIqfEjWV7PG/UCMthQbDg7QZqMbpIJgPyDp8sexs/6GkuM2ok/FnwUN/E6qvDcBiWKf
 US/i2c/pPSNnJhQGwfnEAW516OENQxi2acs8fkxRNJeFjbXuMkUnrLSp9O1zI1ImUm+g6MzuPMR
 ge+gLKEoHvGn0+GQ+E3T7Z7+2MfVHH+j5ecJSx9sc0LF7rDBdYQrcwpzyfWqHty05Hhds266U3D
 kS7Oh41ktzTBHaUrAE+NERSY6XzRWqqesxp0qZ4tZa96QIXQfLJzUfMW2UbIm91iBT53ZGocglg
 e56QoGl2f2jyOPAuFyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100176

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

