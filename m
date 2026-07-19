Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE22F851
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784492964; cv=none; b=OW0TG0TSEBobgOXgNfIkHakg44dPdPZJCmCo7WjZCMdcwDuSno4V51Z+FJrXlFAGUh/a8TYMRn0YGh5omyFx8EYLHDam9CzuXaVmIyrFfY5t3DZMg+YsIA/5BEASj0KeYb85YTBbtzzHb8RR7ycd+1Y6NqG9Tzu9zM4TFMmCo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784492964; c=relaxed/simple;
	bh=R7AT8adOvT4/AH3JICLJV6MltSIZYnP7VUK8JG3GdPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gTYuZi2ldqD6IEBBPew4wacYGGjK8V64Ag7nvbWPcoAGm8f93VTeHUUoRKp2GinkmOTVGyAi3ySxI/9LrqryYvt3CqBffnFVjZfz1/4SrQsOFlOUaSNOWiGFMOmaP78jo7paP1ye6HjzKTJE7amF5KX3OGolLLKKOIlqRU/jarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=avkA48eG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eEbK/wPD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="avkA48eG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eEbK/wPD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKR3GA4184872
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 20:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vyJ+vPMAWzCgV2xdQvJUUb
	61M5Tx5kuqql1lltVsoNs=; b=avkA48eGLhy4cN3cjD374tT8BQSU1EcE/FehgJ
	oQPY/PrEB6Ff5ulybGQ4OLJ4Gh0iXR7Arah28JFSZ/g0TWRXtDeUolPHjg5Iaoza
	bgrRhac06QWts9PxRr+/lsKGLG3aOw1tcAeEUaHupXQD8iAXToJGU+kQatF8jmD0
	lnWuf7sIY/1yEqtJHOuGPQlQ5iq5AIYXflTaApmdaxN9D3OSrPh2SxoEhCKiasM1
	hVCCyZBIe2XSQyrLWcChVXekqg5d+xfvleg+pD9lqVScpu8R1P8/Fz2lVRa8cQQu
	9e0Kf+X0T2GPwrgdALqSKwi2YEb+xYj5IPLfCIPnIHG8ZDUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhkdr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 20:29:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c6a72d672aso30486145ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784492962; x=1785097762; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vyJ+vPMAWzCgV2xdQvJUUb61M5Tx5kuqql1lltVsoNs=;
        b=eEbK/wPDlHYE0Qhm9SdEgsIo/FNY22M0ql/Xwfh6erwFUdtUf6pqwaHFz5xlz0n3rb
         ukrtUKe5U3XSAzJKBMEr0Pky+KVWxYYrwR1sIdshGY1rlKW1GP95e6sYtn7tB+ggsggE
         0NiMQzDhv0ohkrfqB3udp4/xTHsktOux6zOM1sZbQJT70HtfRNVIlKa7mFQGPAlPf3Qx
         qffTjxB6H1kNx54mEUyPDNaT/Rhb91lI4MFBvVhSzhXqwoDpYm5h6Kqmjnl65lmi2Jlt
         6MJpOVsj4RA55GpFd4WqRD9lUV/YAJ8PsrBjfDjuShSoJ2LthW29LKneOF3YuFJkIv+X
         HMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784492962; x=1785097762;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vyJ+vPMAWzCgV2xdQvJUUb61M5Tx5kuqql1lltVsoNs=;
        b=HHK5b27Ok4VYCMU7mPdzQfYQWDI8G9QwopTyLUY1e8FwpryAAt68XhArskB7xTC/Nl
         64B9IdW6qjtsd42ivC7YiL0U3BrYQxLx5PCR09LLonAPMiFGwnCTum5xvJpSZvjzkw1d
         JhT7h/7QwEq1b+8WoTVEgfn2Q54uknbu9CLp0XEMx3NcH5qcvRs/cInkm6Gr9iIoUqLE
         mOcfyltCU1G38j1u8jkl7iYtIVkzD1z0WcFDn6mStOyhsi9/glbh8KLBT7etlJ0QIkEA
         9RC5yfFm7Sx3vM1TkS+h1i1+rVmv6iPWi2i3b7h30pANJugc84lA9lgLsDQCqNbJBYYA
         W0Xg==
X-Forwarded-Encrypted: i=1; AHgh+RoE1fe3vGfolrEI7Z1ouco8AyoHusLH6REAqq1gGrKVooFJaD5o8q5jNtdwasGU4Zexh8lyRMid/b2aM0XZVms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbu/f/0n35MuCGzgDHkw5PqMv1jLRrhbJx1VvkoOjg7DeldgAt
	2RhZkxgWTJUMWgfYdcOjd3g/nStp7nQ4SQJnDx95EJX3PIafl/PLMcDThq5t76J7CFXSI57GhLQ
	56xuRAgrI+pGk68VJENlx4fEHCeBNY/VSupLoeDL7VxW33VKOUJ0WJs9dcVdP96dHA6nBWbk=
X-Gm-Gg: AfdE7cnUKjIDrPybvbV2A6eVxbSO1579SK9pxDrJKGmhNwsJzuEN+RIzSJnp0aPdgeK
	X0OukGQ5vpfbNMa3D1Ed2yqAOYTUyq0Ua0SZdWTd/2yQMAaRWcUA4MqQ1niF3aiCb7FMSLL7D9A
	Ond9U9g54611EnwC/PJSwjItaqYPTMjL4R0XNq8xXnDL5ivcmkYPEJMEYiBbL+A6Aj4DtdOgt0q
	TmpzEvgaM84d7zqHnFh8sqMu641q35unJAl+FQbw988q0K4N+IEv2V56j8zYh3V+GL3FwqV41ZF
	5pik+8sTJRObIir1JOud2SxUYPZpXNQbAw37DKvoBU2CLiqNbjuD1jmCkSzR4oXjEgyncvslmBK
	gYdASLyxNmxi4h6BwvTZEwaojUrTU4FAY6+TUQxncPWlmHg0=
X-Received: by 2002:a17:90b:2685:b0:381:28e0:6248 with SMTP id 98e67ed59e1d1-38e4b3e368dmr9445028a91.1.1784492961863;
        Sun, 19 Jul 2026 13:29:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2685:b0:381:28e0:6248 with SMTP id 98e67ed59e1d1-38e4b3e368dmr9445016a91.1.1784492961430;
        Sun, 19 Jul 2026 13:29:21 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm30974167eec.30.2026.07.19.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 13:29:20 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 13:29:13 -0700
Subject: [PATCH] Bluetooth: hci_core: Explicitly kfree_skb() HCI_DRV_PKT
 and HCI_DIAG_PKT frames
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-fix_hci_rx_work-v1-1-2d7fdeed3640@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJgzXWoC/x2MQQqAIBAAvyJ7TjCLsr4SIaFrLkHFChWEf086D
 szMCwmZMMEoXmC8KNGxF6grAS4u+4qSfGHQSneqrwcZ6LHRkeXH3gdvMqjG+3bwBoOBUp2MRfm
 P05zzB5mtXWZhAAAA
X-Change-ID: 20260719-fix_hci_rx_work-f03dd49d8ef8
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5d33a2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=BoZhy_moxsucmNqAxV8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: _5ESPHC1oyh0KJ2wh2dNJ2uqkts_thq4
X-Proofpoint-ORIG-GUID: _5ESPHC1oyh0KJ2wh2dNJ2uqkts_thq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDIyOCBTYWx0ZWRfX2qIvLJCoVYZH
 s09V61JNS7HBkaIlFHZgnltKfSUo08WXyLLD9/nZaIDFTNSOygL3UThHrPWvrQwKOXtH6uNUEUb
 wTdc5LO+gXKABkr7/7Hvuj/icvI4Wxp+Zt67gXL267g5eiKK5vI+zKJtfiEWu8g/pL5d01I3D9H
 BzC2mDCOBMsZZeBwUtkM8LHO1b50Mpw7xeJ3F4AwRDmlJLF19OHHRHwfdmaVlJjdruUlKw4Ypyt
 6F+LupX9ySe4PLzCf9ijnoFNYOSibd7Ks+vifodEKb2m3xggPc2+QtnuJev4K4Y0nwsYZHgeRTm
 N6/djh1bX3/1EXnWHaWW4AsYoy6heqAVGuRosMz3Wh36oXNZdFNWumvIhp4Al79HEkVnpU8Rz0J
 chuE8epH4pYYXAD5Ooeosb9SeVGVlACn+vKov+jGSK6300tuYxBY02YyWp0kPUA/zXvjSYlVIEP
 oZAwiE9XKTEO+y/YMpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDIyOCBTYWx0ZWRfX+lnmw8r4BsCf
 t7TEnGL706X6SrkXmf8WVWAUmCoFJyeLHuLzMdlyH2bSrLxslcSkAzoKTjkAtB7UMKFCuC8Oh5R
 7yPC4nYt2HAwdK9wWbsBFBfzVkoN2HI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190228

In hci_rx_work(), HCI_DRV_PKT and HCI_DIAG_PKT rely on the default
case to free them, and cause:

- They get mixed in with unknown packet types (default case).
- It is not clear which packet types the function is handling.

Fix by giving both their own case that kfree_skb()s explicitly.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d1e78ae7728e..1e324c05af24 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4057,6 +4057,14 @@ static void hci_rx_work(struct work_struct *work)
 			hci_isodata_packet(hdev, skb);
 			break;
 
+		case HCI_DRV_PKT:
+			kfree_skb(skb);
+			break;
+
+		case HCI_DIAG_PKT:
+			kfree_skb(skb);
+			break;
+
 		default:
 			kfree_skb(skb);
 			break;

---
base-commit: bd8bee79e1fa8db2d587733f8b6fd9597b04d6e3
change-id: 20260719-fix_hci_rx_work-f03dd49d8ef8

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

