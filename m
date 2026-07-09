Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB33B19D1
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577705; cv=none; b=Z3INtr/rKTJBJFlraUeYX/RaLSNgtZgfkD5bw47zn9Q4umXp79pXyuK7oGYCdcudam7YiS8kQTTkdw9BKG89zQPBNMWiyWQEC62L43GoUKCNbidRb5MCwGXqLrxAf8PZn70sg4EdqDS9+rTREjWnPB93Zc9RCbdAJYkTW67SmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577705; c=relaxed/simple;
	bh=XeWFoF/uEGpvH2lsClWMGh83wTJ9TX1YAleRtgAb4AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwXIgpVqZplOGr2vAUB2wdubYyA+yoXLt5B1lEexEnTWb+YjC9Hk7Eu6xbwrma1sPRp51nfseiniye+Gwbe9sl0dqlyGOj+AsRlqs++5gttlE+bsjonbtDK3rtuFhGN33VOQmT9uKhIaAaR/u9OAMfp2On/o3pttXR3gYvNU5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFYeloHK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFDM7tHJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFYeloHK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TFDM7tHJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960H81972672
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 06:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PeeUD7VmyWaFraJ2KJ4DxT+YhPBzVuce+sFMauLHtIM=; b=DFYeloHKycpFrpB9
	TK23KAO3CXzLXN5m9ExkNkOPjgpJN9YkgN1Oh9CZ63mKgVzAzIDMwyTDRuJ4n+K4
	y1Jjn2xQxCS5ANYZg4BB1IPzmzXlWWjU4Xlrb00pt6DQTWwVbJ21l6H3CtHjOWbU
	l4JN5FgvBxI2zdZtm0ip2f1ECriiILOKbDdNR8URR8qqXeIT26CJ0GUltsXLgOxf
	wCYJppVO6VWxM7KKHZy2o7ikVfDFXG2bOOwL0FH/PLeboet+n3M2zGUYaLjZKUg0
	bTdc4cASw11gBk47mWmIL8kqRXk5ZjKJqSZ9gn+3zwbMrTgkG4xPwzaIkEJOCP1L
	7euXYg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vt482-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:15:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485928eac8so111302b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577703; x=1784182503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PeeUD7VmyWaFraJ2KJ4DxT+YhPBzVuce+sFMauLHtIM=;
        b=TFDM7tHJluNKuUAkE+X2kdI31zJXLoZd64mKQTc18Uy5LiLM1NlCLSn/brZsRSOSPG
         fpsI0b/02uOhc1fmpaJW5gQ2lidT22FgPfXkqA1u0hJYRBhxXArljfNg6AEiyWvBq8c2
         1A671g9oy8gS6wdXqngqTWJzYhaC+CFjgN/AaiJgjy5VvZR9It666Y53dcYFDEQ22cpR
         jFgBO1X8Gycc5DBUbLMGLFkCko+937el2fFmj7Lz6zYy/ZLdPNz8wmm9Yw8FBJm2kfaq
         IBzO3xRNsac3DLeWC/lk1LMR48BKVKLpTq7WYbwdknr0/LckAvCU/jp+v4CNiPEiOqbA
         c7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577703; x=1784182503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeeUD7VmyWaFraJ2KJ4DxT+YhPBzVuce+sFMauLHtIM=;
        b=sduyPYMSZVs3+uxSLOKGRZrEp9jKL6SHmdYQhSk/qUHourRskDTMhvm1yri1haf2m6
         cTcsw06Zwbkn8gvjgTLVENhdrePQhAWZsMydOv1a/OivsiP4RgkkgW/tF0/Oc1JrHlV7
         wWJa8TJxijDjlayVHfXOO8/IcM3G4K6MeBaEmoppkOU/mfwbHygD66AYSER0dlGjGmk1
         jXkRSTigV6Lodf1mYYMyu1VZHf1t0PNeNQ+458R6aYIt7XE8arV8hFhPkK7YMNb8PpkS
         Hj1/fDDXYo+j3yLt5pUsq84MgpfLoyGKEe1fipYL7/XFH0Y374++v/gw07KVtd0VM27o
         8OeA==
X-Forwarded-Encrypted: i=1; AHgh+RqU01eDl+EM2AveZbcIY2zImQC8KpLu9fXbHivtTXG5GBcjmVmX3GSKTGKjVYCHWdToJJUWIQDIoZ+icdPG9Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6p3q7Od0TGfD7TMHuFnF8B5bs3Rl/fwkW4xNFiJy8EJ3UzlZ
	iwYF+Nfj/R9Tl+V0ZhScMSNIcXpfl1ynMFjIEvvAXRSouCErmmfRu2UxKblHp0QMhDHaLh3WcOa
	FcEccM+ItNstB8mqZQh3zStwDDHnB4u+rrUT+n1W+NeT1ajn6LeYP3j7fz+XSJ1KYbWLLHsE=
X-Gm-Gg: AfdE7ckTwmny04J6Thl6TToPqtyc5CVfVEfHyoWISixVMsBRHyijHv+m0nPUM7r0D2C
	IWad9RIq7d0/0PDtI3eSRGkVCiwHQTSqF+GhRbnlTsHbsbS7Ob7tcN4hLWI80pe2TbsFIjA+2Yi
	gdFbIeYDHRIU/x2MZqWmLM6XvuAAjrkImQym0iM2SzZ/d4CKFj0uMtb4+xshdnohpnPkSyewfwB
	EX1gn9OGaacnjk7MbDDE9DCUN0Lg4E8JqDfhoAWOT5GIuqBul+UdckGQ//tm+lF8F/hkPSlScHl
	PZh3ThYZwNFBBWw0tk4GPdMGH67PqXFigfk0SqW1BVVvcRhBkotBkcIHCp9yRJun+uZbhgcvzgj
	rVRpo1EXspBUgctJzHM52w8iUc9pmysBlXW7SL6PCHyobe3o2GGYLGSXh1A==
X-Received: by 2002:a05:6a00:b47:b0:82f:99c5:868d with SMTP id d2e1a72fcca58-84842fce286mr4285707b3a.4.1783577702620;
        Wed, 08 Jul 2026 23:15:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:b47:b0:82f:99c5:868d with SMTP id d2e1a72fcca58-84842fce286mr4285685b3a.4.1783577702174;
        Wed, 08 Jul 2026 23:15:02 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm8146032b3a.57.2026.07.08.23.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:15:00 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 23:14:59 -0700
Subject: [PATCH 2/6] Bluetooth: coredump: Allow drivers to pad dump header
 to fixed size
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-btusb_prep_qcc2072-v1-2-d835b187fd01@oss.qualcomm.com>
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: c8ZUElJsDSzYvjDrQHURW37Ag9rXg2gG
X-Proofpoint-ORIG-GUID: c8ZUElJsDSzYvjDrQHURW37Ag9rXg2gG
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4f3c67 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=yQAzOZDq_a3C0jIT-HgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfXzeCcz+3UKF62
 kBdezNmk6+kAath0C1wmPLyGL1wIKnFQBXUYvjicfMtjQv6cieg2q8GjibysGsRDLt5dQ/vOTL4
 hN28CGwbzPlgX3xkbq3tzgt6Cg8jow/8HpauBh4hg4STPEAZHbXEYwa48d4IaXpaL29nhDOObhl
 W/88gzmOuwMmn9vkWKHfIdPpWf+zESzEDnHwfXTf1R5uL3ibMS+GRjRK7uDz3uIzRNHDIrgbUPJ
 0H2DOzV/tL8deIwVhF0+6RnSnhuQ1JwcQXgoRug6yhW/txY+2npDYck5WlUqyodBVCdyljujLpu
 gfadGEYFfhdlD5F8eRpwYp+wlXn9BtuTYlm/UH4Mf1L6lx6MmyAb4saRztuFwZG8EdjVvAcKZbC
 GAGShBGWpTwTMJhXEIMQNQC9f6SHJqgWg0B2meji1s39a/YmK31JQSswCgjQ3AtSiI0Klu7/VQ3
 COW4wR26j3O+toMthVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX4PkGKXVRauk1
 Q6JJhEvoz6pUAt5608jFMZLZJWL8oTnkJVI9SVnKrS5glhh9U7r0C0S9nqtWYfL6zcM/LVipzDf
 CXECG+3aiISf0IxUpaOQMC3UUWJxLNc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090055

To let a driver easily separate header and data in the generated
coredump, allow a vendor driver to pad its header to a fixed size by:
 - exposing MAX_HCI_DEVCD_HDR_SIZE as the max header size
 - exposing HCI_DEVCD_HDR_END as the header-ending marker

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/coredump.h | 4 ++++
 net/bluetooth/coredump.c         | 7 ++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index ab85a6adfffd..b668277bdb76 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -8,6 +8,10 @@
 
 #define DEVCOREDUMP_TIMEOUT	msecs_to_jiffies(10000)	/* 10 sec */
 
+/* total size shared by coredump and driver's dmp_hdr() */
+#define MAX_HCI_DEVCD_HDR_SIZE	512
+#define HCI_DEVCD_HDR_END	"--- Start dump ---\n"
+
 typedef void (*coredump_t)(struct hci_dev *hdev);
 typedef void (*dmp_hdr_t)(struct hci_dev *hdev, struct sk_buff *skb);
 typedef void (*notify_change_t)(struct hci_dev *hdev, int state);
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 3d4c2194ef43..c77bf511679d 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -34,8 +34,6 @@ struct hci_devcoredump_skb_pattern {
 		   hci_dmp_cb(skb)->pkt_type, \
 		   hci_devcd_state_name(hdev->dump.state))
 
-#define MAX_DEVCOREDUMP_HDR_SIZE	512	/* bytes */
-
 static int hci_devcd_update_hdr_state(char *buf, size_t size, int state)
 {
 	int len = 0;
@@ -63,7 +61,6 @@ static int hci_devcd_update_state(struct hci_dev *hdev, int state)
 
 static int hci_devcd_mkheader(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	char dump_start[] = "--- Start dump ---\n";
 	char hdr[80];
 	int hdr_len;
 
@@ -74,7 +71,7 @@ static int hci_devcd_mkheader(struct hci_dev *hdev, struct sk_buff *skb)
 	if (hdev->dump.dmp_hdr)
 		hdev->dump.dmp_hdr(hdev, skb);
 
-	skb_put_data(skb, dump_start, strlen(dump_start));
+	skb_put_data(skb, HCI_DEVCD_HDR_END, strlen(HCI_DEVCD_HDR_END));
 
 	return skb->len;
 }
@@ -154,7 +151,7 @@ static int hci_devcd_prepare(struct hci_dev *hdev, u32 dump_size)
 	int dump_hdr_size;
 	int err = 0;
 
-	skb = alloc_skb(MAX_DEVCOREDUMP_HDR_SIZE, GFP_ATOMIC);
+	skb = alloc_skb(MAX_HCI_DEVCD_HDR_SIZE, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 

-- 
2.34.1

