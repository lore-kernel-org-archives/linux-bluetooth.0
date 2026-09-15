Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B2441619
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463628; cv=none; b=ugw7fS9gG20fMrdaEw1g9fCwN/yXUWAGWQHBYQptg5awgZsaUFEk1iqFH2RpWuDN8VPedmwPerEGVQWh3N3pu/wP/UV1YlrftnGrnQwIPnZMEGWBwkMscjie0lSZbyiQB9CipBeiXpwmStBg9/ap91mKRH7WTgkCEDuwqvnCals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463628; c=relaxed/simple;
	bh=sFxi2PMQBGmj2gAwvOG3Vv4w+1qE9j2cg89SuV9ziBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bm+lrUx4FLjE1FgdOruaH2BR1TdrFAZxlQbRnQl9TrfQUHrX9am6j6EOxWLoVkQf60od/y90Ek27gd7fTofGknFT+wjMjj+YQADIUefXi0gAE55xDuIfO3PSZfiWiOGeY5dvAtP4YewB/HegLBSSrnhZoydbmYPSl+/kNq7QRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MSDoXLJX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AYj7x8Is; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSDoXLJX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AYj7x8Is"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZGG12892609
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9dwifGImnX4dM8K8VZM7oe
	H8+hHXIPklVooVtSjSum8=; b=MSDoXLJXtfHD95LFbdeuC65BOxXc7vVXiwlUVF
	FnHQpX1S2gAXO2gSywnPGLWjgAeA51jmZxCisUcOZAE+upaxh5L/jJTnrM8uq/vm
	j9qRA75VAeZjVuPkNbk1pEDu0pxHDGqW6R1YD8eb2FS9UkPsfRGbUOB/RDpQGufJ
	8c3fri5s4imKk5/yw4l6WZX1HxWLxG16N1HoHX+IzH+xtwwIoHllCnAY4EiLAcDu
	pDO7aREUgG5qdqxgRgpyHJoDWr33aDzs9XvYTP8q05YUK1ZageSOBTMYq730N0PE
	g8bNhGf73oRAeNwNPlROYAlxZ2W5rSvg9vwi9FcuuCX+Seiw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2kvr2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:13:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3989b317c31so1184097a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789463624; x=1790068424; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9dwifGImnX4dM8K8VZM7oeH8+hHXIPklVooVtSjSum8=;
        b=AYj7x8IsVWL9kgtn4rsi2FrcwaP8+YA2IZXP38Yro80qaxD4JXDpU1BPidzDITgH7C
         dweE7J1r/V+FjRFANcMNq8rwT06zlTm06fJKolsOdj2Slyzynwq10NS/4TDpC3QKZeyr
         eYV9VAkj9JVzyRvz7nQ8D27KztAuXYS33FnTrN3Tgq4SzwvnN8TJ6rXC0dr7XiVkdYac
         jNSxjCF+XR44f9c08HIEweIf8bFQ9OFrpc9uHo294N5aYOxFGbvjuX6Wizq5X+Yba3Uc
         hegSvdxnOBcPO2a78ZcIplwiZ+R2kTolyC1BsA53A4wKIM8grzwpROMmoJojHzNc9H4N
         RJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463624; x=1790068424;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9dwifGImnX4dM8K8VZM7oeH8+hHXIPklVooVtSjSum8=;
        b=GfvVIy2+vwAQJxLX0dA/wNoKgpvKgy1dvSzoYShYRgAhic0AyTG+TNtYj39IGI1B5b
         3FzVvdMzKSpSu465k3LKQonjWopoOJ+ipEtOJkcSY0mPpjksuZBa+Exvk42gk0dCo0J1
         WXs6GkIh2aO7v8DG8qCeP4VnhejybJnha6mtLW+sXnJynUawTBdR75/f+A5rjQkRq4aX
         HuHhW0eKKP7e1GWJ9Opf40752ZRGI4hKOAbsNIM1vttsKuO1LDOr4whSBHc8WHi/Auv7
         vmeRkLpiPF5mEdxxltj3JPNBHPw8hrX+u9YidhwCgO+HTOOGQLUSKnZdGlJbHCB5QbZM
         Yi4w==
X-Gm-Message-State: AFuF++mQBICOpBj9sjKnaDhYc8PftS3EtbOnVYyNOyD/WWvbpoxy7Us/
	30r1Q2gXOrBrP3aGiZoojX65e2z8sDosN/rIXOkZqfJlWQgRS8eFsAd4uD4GwRTEbCw2RbEesLs
	v4oLLepBVYqJOHbYZfK6cbEMxIx9kC/CuyjDZyk6K3VGYTGHFL96F3JQte9755DjOqaM8l6NIeI
	W0/LbosQ==
X-Gm-Gg: AYBFou3tSV9o9NYAsIbEBlGO0Cy9ymhSr6shy7UzdE4L8P6oFasuQyKXv3UUJ5dZR/6
	9St8/vgQgsfMaiWovyM1vdozo0CLo9rZm49p6GvdIkiG1Gyy+/Pjin6QIHFn6gqUd4AtaX6iWRn
	DJzGd/wMf62VmUXPn+qdv/E5/aSL59t09Nhq1UnGj0ebwa/6h22EOCM5cSesIomTE9bK5SnEe9b
	td94cYkdYpCZtC8o/GKGJAHCFZ4+o/8PabWrA3Rh4Ud8A8JIACWMdOW0OFvjIsuMfhG/ZVrk/P5
	iyROkvNUcCcpHjJC7oEzIqssavCxbIULpNRdRGTDkGvGEUbG0CAonOXylnzn+gX3JOQZx/QKj0t
	w6jY2JeKQXYtCvhAWJj87x07Lj7zNoDwmerDnq5ARXnKlT+s=
X-Received: by 2002:a17:90b:2742:b0:39d:e1f2:3400 with SMTP id 98e67ed59e1d1-39dec24fbedmr8677783a91.5.1789463624481;
        Tue, 15 Sep 2026 02:13:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2742:b0:39d:e1f2:3400 with SMTP id 98e67ed59e1d1-39dec24fbedmr8677722a91.5.1789463623817;
        Tue, 15 Sep 2026 02:13:43 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14390c0be29sm3493044c88.9.2026.09.15.02.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:13:43 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH BlueZ 0/2] monitor: Fix heap-buffer-overflows triggered by
 HCI devcoredump
Date: Tue, 15 Sep 2026 02:13:19 -0700
Message-Id: <20260915-fix_heap_overflow-v1-0-8fc39dbcb303@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8MqWoC/yWM2wqDMBQEf0X2uYF4hfSxn9FSxMtaTxEjSbWC+
 O/G9nGWndng6YQe12iD4yJe7BggvkRo+mp8UUkbGIlOCm3iXHWylj2rqbQLXTfYr8poUhq2Rhc
 pgjc5htOv+cBtmHnH8z/7uX6z+Zw97PsBV7L1CHwAAAA=
X-Change-ID: 20260915-fix_heap_overflow-4e93e9ed9063
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: pT0LYJa84ByIhI2-uG7XF8zKu0OAI1f3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEzMSBTYWx0ZWRfX2gtPVNeMZaxC
 u2RIprmci+9qPorQuhN1S+N7ddoFO0fcRK+AkxwLsiYUDNAjgOppZScaFrjqh76ZGuFEQ2ZeuEJ
 Ct9dGIO/Al5mlJPiagef1QLlajv1Zwo0uP2AJOtW9VdBZ1Wei3l0gqkk+G6SwSgZ0kOqMnw2nr3
 3tw+DpfPxzvpHTmn4rlvgwlZUx+CN9G5pMC4zLe9ZuPfBtWoBor5gY3+BmASVqMHxlQvw33BLXH
 shsjOd778hRN8avpGFw6sBkt3djZDGy0MJDPRozi7EIiLeFXhPzOKw8WsAp7g1wZnYAttzX5mdt
 GHAo8bcl0iba8tniaNYLghJr4CAnZe34AbQ/ucKowusN49ZzQiZ0FyQVGUSlst1Wyu2IKd7DO5c
 K50Rmnhkf9qTEERa5Wj3hSa1U8BYMW74RE/XhHV9zi2NmerJI0cUpD5TSktC8AW67FysIKUUgX2
 WOqznhnwoi8WFyU6xdA==
X-Proofpoint-GUID: pT0LYJa84ByIhI2-uG7XF8zKu0OAI1f3
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa90c49 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_JzRFIxVR0lBK_BtMuYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEzMSBTYWx0ZWRfX/Vj2+k/GXeoR
 +WxW49Oyy29x5XjEQ9ZVfO6Juwc07M9hdeULRyuE6Q0ZnOrji4syIL+I1v/R+nXJQvUXZ/RMoOr
 CzpJzmXA16A4oG1JYUrBF2Ic3UMWpjM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150131

This series fixes heap-buffer-overflows in btmon and btmon-logger
triggered by HCI devcoredump.

---
Previous discussion link:
https://lore.kernel.org/all/20260913-misc_fix-v1-2-558c1e4028b9@oss.qualcomm.com

---
Zijun Hu (2):
      monitor: Fix btmon heap-buffer-overflow triggered by HCI devcoredump
      tools: Fix btmon-logger heap-buffer-overflow triggered by HCI devcoredump

 monitor/control.c    | 3 +++
 tools/btmon-logger.c | 3 +++
 2 files changed, 6 insertions(+)
---
base-commit: c8e2b951b07fc9b84fa7f3e70dcde2b61aab3ad8
change-id: 20260915-fix_heap_overflow-4e93e9ed9063

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

