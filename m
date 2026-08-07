Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716B38E8AD
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118633; cv=none; b=YW0MRA2CgkwMpUgaaPWpC14nXODQ2ubKGhcbspuDWcjX4jD1J07TiAQGjTr2CFLWTP80GbLkU/ac7/QK8GpzQt9qYF5KS7IbGTFrCWxF4r1LVK5RTKq5kdN+mjcsagdvKNRwf9HKEaDiHeFD87kSXAGRvyK6IFQN8HsJMz6s8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118633; c=relaxed/simple;
	bh=VJC+axUEzaBSoO0VtJxO/+rwIcuV7Eh3fVzKu6++viw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2Se4K1TtmrNbUzKpZ11SDAzE/vxLU9aF/2FhX/fsUtVy5m13woCObTWHj1tNKcW339K384PgXDSNs3JSDNLa/nViisIV+p7mcQxrKZPFxaQcOFG6rvcfrvuTLWPX9dAohV43OafM1BjKtVGWiI5iKhx0VJfOII0aG648S1RVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hZScoCv+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fzRx6wjk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZScoCv+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fzRx6wjk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRg4i1380120
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Aug 2026 16:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5UjAnZ9ViRt
	33rjDZPE280PLOd5WIz0gWwcOlJyBbfE=; b=hZScoCv+kqropJ9YR5uFkdQdHHc
	PGlwkQPcp/uolFoSgQoRj/lFDjN/NyWuAvQDHBx9JhO68mT5UB5lbCQNDJYsErJY
	C3YioFGco/NwibPi48EQadGH4xHHgISIoTykwXUCjFi+ACMoxA91JmcZ0Vs+t7t+
	cpJndKxtI8ZzM5DQOLZpSsznzPM9hF7j/vr8oEdkMiqohQW4Dz/DhX12C0jHdUzl
	Xc7+k4hzWsbRNnjkKAshXKs4+pRgvd61Wr7ZQNTEZBHZpLqeAPXQ0zp/jrRT1K1W
	REwj5ENW0fYDv4RSxTYC9KmVEBbIrOPrN89Gws2QZj84Cqj+djKGzcK4NPg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6fvvbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 16:03:51 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c3a85f5d4eso811496e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786118630; x=1786723430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UjAnZ9ViRt33rjDZPE280PLOd5WIz0gWwcOlJyBbfE=;
        b=fzRx6wjksov0rIUtqm0rLAnawe8wnlkBf4CCFoGxoBvzW1c5vZyCwfE3dqodSmRefi
         ZSneFpeqrAE5n9QtdnrZGClGWQCO3x30+yuyKQICbZbQa7WW1kQ2b3Gv/DZ0Fcp8Xoqf
         vDA04uLDukx0dFQxvtSG4O3/VtLtxrRQAGWSf91SiCEFfrv8JefQ7WhZMJY0SxG2innx
         uiu9EPZpnAIIQLO/QexLrv6tWfwE4aXNyreMbeoSYP/2Itt3oR5H53ASLhwbutFK6JJK
         jjQ6wRbNIrgAeM2SeLNS5hRRimU4aJvM99M1510PWgT1EEf4DCwXfA33VXgC7+akjMKp
         1QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118630; x=1786723430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5UjAnZ9ViRt33rjDZPE280PLOd5WIz0gWwcOlJyBbfE=;
        b=JUIq9cXJ6o+5TP9RZkPwGXDJAXixyb1tnnl/1sQBmzI/HZOaKnnZCnJFlzgdmTcf+K
         oUBe6nSQBTOf6HfN7MSLgZ0gTGwlsQ8x3l6foUlsAJLWohfV7Ed5HptQSWrLi3pSGY7z
         lseXMEuO/K8GC9748fYNpKL7aq6SXDMlb9TM9KusTvENV48dSXBLXh81RtmWkMcImwjo
         om/+hDWZ2L3mIBx3CPw7eXfwQ7FrGDCTxyfddISgvV9ELGv+jvVbst6+BzRv9lCURXJ6
         li+jP1T6PWGOlzNpCLPYilA2hmZPYfMrcC5rSMkCjT7QNNUiuKefJSWAhwFNBeXKsJMl
         fJSg==
X-Gm-Message-State: AOJu0YznEyC2fLoY777/R4O3SWdvx5n2rGA1gi6RcxEtR/F4bD8WfrXB
	wB9P6VuuCw+/ToOgxg8W8br3AGt9zlNy1tIwYF45OUcbkihgYPk22Gaky82N6aDMiA4Avds3WKJ
	advUGT6iiGhBAMcrSRyP5lJTa09lE4HH0RDvV83z43lq7pNd46s25P24dJ6SzitZ4Ua9lb0Y=
X-Gm-Gg: AR+sD12Jni391h4ErOeeb4KDPQ3E0iNo/xTgiaQGOADvKfIHoteVmN0FE3hEUv7we3C
	ht9upJBnB6brqn0GbAPF2XErQPCSNCe4Hgb3E4OQMwV2coxM/Gm2CjCCfFUyhNZGF18f9Wq+0KL
	aajof+ZeddsCcphJnPcrEs53vP581gVar1Ax1u3qVIw5suuU4WM/3VZNeF8qu1QYNUaCD1TAPmY
	LhjTBifOK3zloowtBqCeczAQ3BVEuZwtfg6aRkK0RFe5L9wEy3c9GDRQ61JFqbftYsgINl79Xp0
	l/3VOsrlecCNQB2RHl2mK2djdFRuVCIWMxwqtDfe5+FJTYUh8T2fjxAZdmvIeVMLHCyBECgn5MU
	R4lUL49wGDBEL3kwHznuOid1s4oVCbvA=
X-Received: by 2002:a05:6123:ac:b0:5c1:3ed2:fd48 with SMTP id 71dfb90a1353d-5c3d9281eabmr3027534e0c.14.1786118630571;
        Fri, 07 Aug 2026 09:03:50 -0700 (PDT)
X-Received: by 2002:a05:6123:ac:b0:5c1:3ed2:fd48 with SMTP id 71dfb90a1353d-5c3d9281eabmr3027524e0c.14.1786118630171;
        Fri, 07 Aug 2026 09:03:50 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a2b1f1sm71367466b.12.2026.08.07.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:03:49 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 1/2] Bluetooth: virtio: fix RX buffer size
Date: Fri,  7 Aug 2026 18:03:24 +0200
Message-ID: <20260807160325.1921-2-igor.skalkin@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807160325.1921-1-igor.skalkin@oss.qualcomm.com>
References: <20260807160325.1921-1-igor.skalkin@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX0o6STv1dHTgG
 fx+BI1T2VPcRlCfmyJH+LNOh/e32r4EATpSBdzaIniOExB1VWJ4bVlDu2ZuAPXBvoC6B5OEH1UZ
 vNR7FBFgZyyenI6/7DZ1tn8hL3jvkm/Xik0D7Bw/2cEtIG/ALKiQJtSw0CYAPw1h6AvYXOuLtw1
 kqb+k1Y9cVPrbLbbEwUi0x1tICCtBWhFA7Xq61lsBt7HXNAR4aznjqfG8YuhZpnSDArka+HUF9b
 GSWgk9IDqqb47vMvhX9D4RKbE+mU+7GuEIyubho1LIc/OF2lrpZWALEIYValxfHvdHZmxtaC6q5
 vBTlP/RDWOSYUF0rAM81H1dhGfZIUUeAc85F4eXagB1DR2L8BbjlsZ18YNsZu9PmawcMaJjgFv7
 SLNi8s53K5i1UYe72Ut1tHfB154X9ZYsmmEVs7dpGQjQLO33JS5P3dNtT61N5QHy6E0TZ5hTvjA
 v5pOrrLdBQAQAzLAyIQ==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a7601e7 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ZAI0rBDq9e1UAK1rQ-kA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: b-SAjakCpMbBwGNBlrcSFf-P0X6z3hMy
X-Proofpoint-GUID: b-SAjakCpMbBwGNBlrcSFf-P0X6z3hMy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX58iLfEsCmV5f
 oHuZyqU/+bi6AfnSqV84pDGNbjmeziIjHuruSQdgR5W6KQOP83K7kydEezd5ueXyBUD/SDCmU6q
 JpppaNZeBqv+EH4u1/Mg3lDitcxkzsM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070125

The fixed 1000-byte RX buffer is too small for an HCI frame at the
advertised ACL MTU. Size the buffer for HCI_MAX_FRAME_SIZE and one HCI
packet-type byte instead.

Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
---
 drivers/bluetooth/virtio_bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9..96f21501e 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -12,7 +12,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #define VERSION "0.1"
-#define VIRTBT_RX_BUF_SIZE 1000
+#define VIRTBT_RX_BUF_SIZE	(HCI_MAX_FRAME_SIZE + 1)
 
 enum {
 	VIRTBT_VQ_TX,
-- 
2.53.0

