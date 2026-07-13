Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212E406817
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944079; cv=none; b=iAh2uOL4JJNj0Xc2LAWkicluXbPkhoSWGadlLFbWuFrDtA1fereshyQOxYb6mnzNUBvdmV8c39lC2QW6oa7beNEVccsgYh+jDFQxNRqc87xji+c2ZeK8RoBnPSwLAAemzc+PuSlppV5JbyLEXne3CspkxDA02eI1HW2XwRuU3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944079; c=relaxed/simple;
	bh=a2PZCKgMozftb8Rdw0wNvZ7OU0sGK62FgsY6GG8JGv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLeDicKf4hppBZpFOzHsN00B8SfPTadEccNXRqLE28Wu6JDx/ilxOZ+dYgyCNJrVPViPfXxFWYpLeuiemgImOufx+RCEOnU20ztzkwt16W/a/Dp4rQH9rCJZr0vvj89VRJXxeJoeurWiEzO+7qS1H7m7nIfGHtsSTgTMFXzBGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hks1Bxz3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VhimCaX2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hks1Bxz3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VhimCaX2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DB5OY9668676
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JsU701QL4lDEulR3VWKt2tUunQwNh+vRfwX2nlUv/g0=; b=hks1Bxz3Rsc4YSlT
	rNJqCAy0EfYAIBDFfkbntM7UV0ntQikRmQEq1eZ2iIT3c2lBn9Wgp/7qx5cXbymo
	QAqH0lwHu8SLs8JH9/gZ86Jz/LaewOnYsJ5YR0l8cCgGp1MrQUldjcEt0KVZOANX
	xiW/Afj/p5ezUoWmAewDYFwMANFJ/YJW/3+1FnQgLWUYcwDjIKl16JCzy+3zqFh4
	z1NEROzzaU8YNptgTAb5GZkE7kdEZ4wZ3XW7z46Gzqoh6V6bM3Xzk4eOqVlLvkXV
	ShHoO17KbS5fqbSM83abafmv9QCD8u8u6Lp2SZXblFp5xs/Vkfxwsl+vgCS3CPZI
	0z2Law==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm2ddf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3883dc4ad23so1269943a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783944076; x=1784548876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JsU701QL4lDEulR3VWKt2tUunQwNh+vRfwX2nlUv/g0=;
        b=VhimCaX28KsIxxt8ZKWUBvR4ayI6G4jsSNiEHwXXZT0IE0621A6d9oH3ar+zYImGuI
         ZiBAnvxGGgHyqAwxYJjes9z5o+ntSMecgkdLJAa39IfOdKL43kE8HxnxDhluZ+J+wKyA
         NepUFgtHfH8gZvAoKrPaND7xQQ9PJPf+YgeHFpYpJVjc4z1BCWiOsONIfyVTkiv+RIhi
         f12LYE49oSMOGkjrh7wpHF5HKKXAOAU6lK3LhjLZFdQpBo2dMbDSwgPI1noCfKuensGp
         yKW3jFd930AGg8dLpH9CdgBYBCkGWZ3SIx8Pev0M8eRFLzTXMryXbsECcKCY2TiMlKyH
         YhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944076; x=1784548876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JsU701QL4lDEulR3VWKt2tUunQwNh+vRfwX2nlUv/g0=;
        b=OYZ7gadD2vJNa/2KCSmUcDR7bpBKjK6evRq6xcQaO+IYThLMB3DHvIxpl8A5QMyRR+
         2fUsq5uIJzaEyGIqr4TLOEN8lkI8wTXMxi74mCdH7s+N3ZU+HwgsOZsA8AW3MBf4MX/c
         pKQCpaw7lF0TmlbcPBDPOfYtBllzJT16YNOTayJwaS6osJhEEoYgb93xl3i5Q2MfXCji
         Q9onAi0OOnshuMYTIOtH/mN3LBGq7c4C2kWOnMA++8PnmgG8VdZ5pjCaGWYcIW7N1zm3
         UceajEaA1fnYa/frZaLXoMP/sNMqiDBzdowkEmS/7Z0Nte6hjj4gZMaLiMHf/GxBLwhc
         uE0A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7VoYc82Is/x+g2+L9wYwdcO2lX/mmhgghaGpllnnrEI04t4Y/HjyJ1lC7F/fw+69v72MX0NQZjpbtoNlg3R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdNVK9gDeLT4trCeeUcHywKLfDM2fHowNIwAUjLnFvWJ8jShsf
	Fvcin8JVg2r4lEZ+Q5iWp1Rn25yy8cpvqJz8hIaun+6rWBsE0Je7GizyeSNZKrEJULjQQHJp2Lt
	buKIaLkyidonKvbYQ3wfKU8dusdzn+ulfE9kE/4pFNbqMW5l6Xp0lj65pYthWuyNV+DsAoI4=
X-Gm-Gg: AfdE7clpMy+cFqFxTbe9XBQKZg71Vk5de0+TSK77R3c+j83rOjTZ1ax7nRItywR/yt7
	zV2txgu3zAYI/t0GfRRzELRxuyvc2NTgQ4CQVGPRJmzAUcSDx3iVXGd9kE+kfpMwmz1Bfz4OcgH
	X/mIfqWNvaXB/PrtXqO6rVp7KSHzDE5oSmEEB9pcVpPzE2HfR98MD6KRpal2L9MHMx0fKhCT4Ms
	l6vDt4fiGemftR3C2b9pMK1Qb4YKcEAv54H0H8uk6HM6ttARTpl8P81b63bALvM8IQxp4mLOVuJ
	uG1+dUqPyu95ejU25sLF2mYCUPOF+raYLqchnOUxAai11kJbTZxNOVM/3TFZ9y8YahJxocqG3HC
	B/K1Ry9wmF4WOOA8r6o+6+2CiB+9aYVkuDmvo81ZvnuNAFKEenSFIQqG+Vg==
X-Received: by 2002:a17:90b:3c4a:b0:381:96a2:14d8 with SMTP id 98e67ed59e1d1-38dc7c45e51mr6071809a91.8.1783944076128;
        Mon, 13 Jul 2026 05:01:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4a:b0:381:96a2:14d8 with SMTP id 98e67ed59e1d1-38dc7c45e51mr6071761a91.8.1783944075577;
        Mon, 13 Jul 2026 05:01:15 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm74577772eec.31.2026.07.13.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:01:14 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 05:01:14 -0700
Subject: [PATCH v2 4/5] Bluetooth: btusb: Make btusb_recv_{event,acl}()
 take struct hci_dev *
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-btusb_prep_qcc2072-v2-4-bbcb651285f2@oss.qualcomm.com>
References: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
In-Reply-To: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: EIWsnGYItVSytZSMQyS9V_B9YazH0jRL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX3Ue1hYzFwIHl
 Qun/ZCzm792PLjeknFRz9w/lEURO3xzxY/se0PDrq+9x2b5ppjvKrTYIlVdASYe8Scq5Mb8tP0f
 QQxeCylg9vlIsOG4Z37b2Y8IzAzq+UEJTcythnJaqyt4SxvFk8Nmb1KX9ftX1BpP1TUXEVQTaqO
 utTogtVJVJTNpqeJWbhH7jS2fMyv7rEhXbF3S0r5lnZPLI3oJ2ddGIFa+JokKtuO3zs8Exsvrjg
 gg773pJhx5btVTgllENqqbh9mFTc6KINST7ggj977F14TuZFsIjErZuQCkrqxZc1JNPeZQ0vFib
 RpG5nCHCmbc/RbmXQqylfsK44q9seX7Du56fbfGsyR3R3EEfNmXlZZ96ugRhrdj8pd39GqL7YAU
 QL8SAlERTgUAe0ECT+GKzF8em6UXnryZYqjxplJt2H8Nud76UpghiO1+/gv5vJVbfJ0lfRtcDg5
 MHq50jE6dy2nOfxQRQg==
X-Proofpoint-GUID: EIWsnGYItVSytZSMQyS9V_B9YazH0jRL
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54d38d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=JDCWVgv_UVR-pCJ6T6sA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX/z3+ahnVr1Us
 crHLQIlXC2xDb2GC8b36xuLz7if9+hds/6dkLIMOdL2zGXN8oYl+cosfQvYXbMc0NC9+7kWcywZ
 LPmbDfp9uLyFLkLot2KSEvRISppnpCs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130125

Vendor-specific files need to hand BT frames back to btusb after
filtering out non-BT frames, but these helpers take struct btusb_data *,
which is private to btusb.c:

  int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
  int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)

Change both to take struct hci_dev * so btusb and vendor files can share
them.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9c3a6d7d8f1e..f4f911c3de52 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1253,14 +1253,16 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
-static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
+static int btusb_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
 	if (data->intr_interval) {
 		/* Trigger dequeue immediately if an event is received */
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
-	return data->recv_event(data->hdev, skb);
+	return data->recv_event(hdev, skb);
 }
 
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
@@ -1320,7 +1322,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 			}
 
 			/* Complete frame */
-			btusb_recv_event(data, skb);
+			btusb_recv_event(data->hdev, skb);
 			skb = NULL;
 		}
 	}
@@ -1331,13 +1333,15 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
-static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
+static int btusb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
 	/* Only queue ACL packet if intr_interval is set as it means
 	 * force_poll_sync has been enabled.
 	 */
 	if (!data->intr_interval)
-		return data->recv_acl(data->hdev, skb);
+		return data->recv_acl(hdev, skb);
 
 	skb_queue_tail(&data->acl_q, skb);
 	schedule_delayed_work(&data->rx_work, data->intr_interval);
@@ -1392,7 +1396,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			btusb_recv_acl(data, skb);
+			btusb_recv_acl(data->hdev, skb);
 			skb = NULL;
 		}
 	}

-- 
2.34.1

