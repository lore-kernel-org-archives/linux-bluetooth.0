Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400C3FF89F
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944078; cv=none; b=N2lrkPdjF2R5k4/k6IrN6fbKqNoiAu0GeLzNnJ5V4Jbko4Z7hJnlR+QvuEVUvP5Hg+WXMh11akoJKH1Nlj9hZROyqRPzd2lb60yLf+dQEtv6qRGgeS0wlMl0FOSgb1x4hANvm3mlPQSPkPwOk79pku1AuTtdaZi9FiFg1Lfxpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944078; c=relaxed/simple;
	bh=jSxYyjOejAAZA2FaAP8P+Jr9deDf0VpvQdsQTARJpBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lA9U3jP1iViSv+jbvGcOKtxK6Hx0UlfxBuvoChzaGRotMHIOg6mcuh9slTevGTIdqoOZKSiakOdxcP3Tr7nOx4oiNc6JCfe0RDfyWva8IK1CD3wb/ItigxWH4JZ+vNTNaTE5U4ZFrgJV15tmHhLBbICNpauG12LIZHoaLYWvjj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iO10ROJJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ii/menTi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iO10ROJJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ii/menTi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D98rBT793131
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d00HTewu/Xd8G958NgUSJI8ohMNYGbRnkLXKGtAo/Hk=; b=iO10ROJJXhWbUsJu
	3u75FC5FnWUBdkIbUD+1hj/1EakmIXtCDxV9L3MlZDPmOAZcEe5Z/ATnr9BlQIVS
	G0h4RlqvglMpJcOAPYjB37qXA5W21m3cZY4EjFDq36uxGdbk8oCIFKBiSDZAhcPC
	7tSmWgFHctUPmuRY3cMUZDUC4nCSK0bkE/4IBW0c6utoDyYhxmRhnJzEI0vG7CqY
	3YB5+M9SM5rhPblV6QsveMRYYpaF2Azbdv1UQrkQsEZtvqpvJcOn1CJHlURqfn1e
	W9wSXIwifuxVKQkVbRd2D+evvwRPgj313FRoBwa8jhyTPrcF5qqJ/qlj9KiW4IOX
	TOtn4Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qrkew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-384cb1637c2so855764a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783944074; x=1784548874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d00HTewu/Xd8G958NgUSJI8ohMNYGbRnkLXKGtAo/Hk=;
        b=ii/menTiXGDhsnAleTbSSULE8nc1j91aQ9XBAqQ9a9173NtyDioSVeGV7JAl/jF39I
         RTINcRCbNCTlvOYUmG8UyG31MdjL+efmRlFuHcJ3LHSguILcvlTLliqLEp6V40Wm48IY
         oUTi6Hkc8q6CPwNDtuWD4oMX7VEwYjrLYpufC19IXGMJoUv+A3RwfO/dZOS+ODi4wGAA
         JUDGDqmDtT5PYJqqiyuoODhT0A4FENAPSdk0UE6lMyuDy10BNb/Hrk2YFaBC35lyccAk
         uobYvYhATlzfYmvqLPO86bVFPqkksQqcrZE4T86Cyv/8nDQg4wtZIVdPtiTd9I+ObSIs
         QUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944074; x=1784548874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d00HTewu/Xd8G958NgUSJI8ohMNYGbRnkLXKGtAo/Hk=;
        b=KmNeEi5rXutMnTijJ7EaXgCSfeZrS8xnLuKI4WYXGjTr9avIH/dGsQZ+8+d7DBPCji
         yYpd0z2VhEwyCQ+dfp49+U/jQw528bCW9rfJUmOQBKcRpOhyPrhil4mLiFY9D/PZVMIa
         0ZrV+4jMvbGYB1RD1yjr6XC8U4ZAxSlhSG3x4dfvR1VIRMxMGopt+PAFazVZTJoDf/mo
         udRyVPdT9yojdgfSB1KQ79mSjrtf7ryCNEErlUmzdPB9OFpp08oxkRLpkzOKJoTh7BWp
         yTQKmf6uiRCO+QGvoyA1Ruu+f+dqG+plfx0OYJOlZPpVsFZOkaw2Zn1ngeZltpRimWZd
         PDug==
X-Forwarded-Encrypted: i=1; AHgh+RoSE2TlA9D2C9Oy+Bo8ZZx0HmgLHw7SC9IZ87e2AXwkAgv7y2m9xEgNqZxe4amluD2vRwIgrvL+cMf469hwcVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4M7+Sn633GqyKkKr2yCdrzdvwYBkueGBIFVPbz0ZlNivO13KR
	Uk0j66yIA/BhJmTkM9i4OFtKCev68DxzhzSnWUbVHbnO8Zqrl1UwtVeH2iluEAOF7Jhv7nc+QfG
	XKtZrK4pDz2bp6abNBjqJHFIdTwRl/dPoE+TJYDzC9wAED2hsKtYursBulA0X3fS3NnyNTcaYz2
	ftRK+n0LyI
X-Gm-Gg: AfdE7cmPKnYveuRrXCKJm/3Lp9ps+pA9K4iFb9UUAes266u9GHZitGFZIHpyX1pAVtA
	vi9bcON+8PUR/QPHpR4W0uAotbDdMAktXJEwQUJ03MVqq3shYnOVtXS9kFGGgpWd6X5TyoKuZDb
	sST045Inf86o2ssmxTraa+xk4VXOwkPc+CXvdKLssQ/eNZFB3bfPVfZ+OSd19xLYDloL1kULtci
	Mf6lUkioaufa2UYpq0VaDFVQWnAdll3Kyx15y07Uovu5vE8JdNeJpjLAWmptk0MPn8WYQJ8loMF
	G3TU411YDtk5I73GR9tzZBm1O3mCJ1NOprfJVa1RJHdgBINK1IFNT4FQsVs+PdndvUQpbYhaK6F
	l1ac3I9IsR6pw2IGqVvxxTHjv9cF+WJ33lVaVC0/NOB6c1l1Ljkutk8PxKA==
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id 98e67ed59e1d1-38dc760604fmr6411025a91.0.1783944074317;
        Mon, 13 Jul 2026 05:01:14 -0700 (PDT)
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id 98e67ed59e1d1-38dc760604fmr6411019a91.0.1783944073924;
        Mon, 13 Jul 2026 05:01:13 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm74577772eec.31.2026.07.13.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:01:13 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 05:01:12 -0700
Subject: [PATCH v2 2/5] Bluetooth: coredump: Allow drivers to pad dump
 header to fixed size
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-btusb_prep_qcc2072-v2-2-bbcb651285f2@oss.qualcomm.com>
References: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
In-Reply-To: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX28GXMTmL5CUs
 nLWKziJWJkDngts1unuDKTVDHDUsjzadHTEEg8v6YH/cyXzRgN9y+nDTQsjsSVpgknUDs9Sk7KD
 nNRIKsFp184EjC4ynI3hATRyO+QPQt5ATn7PB6fAqiZKEdcNuKpU4N3JO73CgnKusQspQlk3RJH
 SuBsLaWOFZVWa8O5nkYNSaEdPn4KBrxVtb+QFofNTrbs9DRPKAWWjzeFmsU998w8f43r/crIM1t
 CwkUy7PedNN6aV8uHciAy+Ji/d9E1d8InTkgx/+ein2jo9n1cjnEerQc4+KMzLR/1FBLeKeQfl5
 lgsHbfveNwNFa9BCc2F+tKm2O4lo23xModyvAdR4yflFpf99/ccIto80OXVasSYsK/XX56c3xbJ
 FCH/3/W1fFVZC0p0wda8lmjHKlyq6RuHKqgwedCOtD2nYW2rXIHyOCQL9NNB75pG+ZhTzHx92jp
 a1OenUY3xZgEjQjO2Qg==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54d38b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yQAzOZDq_a3C0jIT-HgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: T_tgw7U91HvpmVhDHHTFgRs7z0nXQ7N9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX82/izh4qevDk
 iVwK08Hn8eaIdNFXzh2GVa75GsP8MaSjJTPuE9uiibTYSredb6rdoUqO0yep1uUVzKWo0Ba8/1s
 bSSIuG6FGB5l1UDJUda0D7jzdjQVAeE=
X-Proofpoint-ORIG-GUID: T_tgw7U91HvpmVhDHHTFgRs7z0nXQ7N9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130125

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
index 913bbba559f8..af444b48b82d 100644
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

