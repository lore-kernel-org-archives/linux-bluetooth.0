Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FB3B14B7
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577711; cv=none; b=Hw3oWLpB0zJ/rqdi0IfNfe7L5RjdOU8dg+5KhxfGAynLWrJKphjOYbtxG8Be51VF+9hftq/I+B4OlsTQbk0J1Ax5H14s6wmWTM174rWfoVGUKg1RvJyhAv2rZHag6xbAS8TKfXn5mXZGDAwZxO5MF4suTyKUGlNBwfkx2riaiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577711; c=relaxed/simple;
	bh=vAT2op3GeYOs5jtKoEYPy7S+lSLv1YtTuIdvEqN2aCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHgLosOflUN8mzs0iNINqru/OhPIOERMFBEdvIKQ9qz/GfQJMQghDjHyT70qKvl9yO7+9rrLXM1z10w5cNXWP+zgd0nFZSEA431T2Zeb6SwyvIGjzbvyyU9kJ3L//HKtqjb1QOg/s8jwX26RvoyrWfAjWUSYkdFockcLt6To7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WPILdBdO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DW4Hyk1s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPILdBdO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DW4Hyk1s"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696061C712317
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 06:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbbKiazUVD5cwK4PPJImkmqi9k4hdklkNRQYcPhkEvg=; b=WPILdBdONmIjkxKX
	2fkg0gckiVw6a1X3Wq5o6pOvz+xo6Emyh8Et9b23/cf1KTOtu426WAouXal+8zE7
	kLsDZblrRHcuaxulqlgRuWqCXwC9g03k3JxXp8nMTPv8/ABn6K7IMqx3k12XscoW
	p8gswZ5Y0nlVQISo8EOsitjdXJ1I9+8B92R0LpDXbb2I7YmrxMkxiA34VYp2binA
	kgnRlH4AF6WMpEd1sSMqMkgiX/9at30hn/eAqXkfctfppzgofoKW4yE9g3aQHron
	0BxzfAtbDxPBBrLPdwggCUuKhl2PABRwE5Za1KomV1II5hFgrtYBxiojeGyHuATu
	cVOT1g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vg831-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:15:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8481b4200c5so337279b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577709; x=1784182509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KbbKiazUVD5cwK4PPJImkmqi9k4hdklkNRQYcPhkEvg=;
        b=DW4Hyk1sMtNKtFlgUPHHuFENBNT1R8GOEst2caMmVmFvTgclHQeJ/UYN3vHe0iTntJ
         5x4j7CI0m/Ncu1gApvqFXDO1IrpskaNJFi/8i+lKjRRAZRQjlzLToXnUo3S/qQIq9ZuW
         DJJz7EkP14lbcd3ds56zZcHP6LgsYMIkgPcU78qGwhpvmr0mUjtfxbkRSSJ55noQtE4V
         p0ddsrEa5xCPtYsTFjynERSnJDRLA+mJsCO/FOr6Fueln4HpIRuhqcGL968Cs2MB7tqL
         mePH+IFru5j7UpH3B9iVZwXGANxpWK9nD2zdML0a25E3w4uRB8gIWQxf5HmQmv1ueV1t
         iPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577709; x=1784182509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbbKiazUVD5cwK4PPJImkmqi9k4hdklkNRQYcPhkEvg=;
        b=drdAnBFBsRLG1A1LmuSRu7zU/RaK6zjF18T3vBjsZ5oejJ73EERrglk5r3tkU5Asc/
         kX1YhWs4xTMwU8ppIyYhZLIa//+pxOUPUeiErlr6LzO2XUF7pBST7uuM1QLPN+rH+KTg
         aaCl7Q0bydjv+OVnjojs8EHMRmt4iviVT/DKTSpoPmjRAdyD+f3Zcr3cJJIrPkbjILjq
         rmosK6/LCXP/ujHZjyo4T38TtNlk0jaS5yxIqydakCv1GcsPiyvMH1FBb+0hXVvYhJA8
         pLKff+nXZ9zzqNUqngXimt9wW3CjfHxnozDPRpP9togcxQ0DMkBWpLWAFPC0BreKg+RP
         SfsA==
X-Forwarded-Encrypted: i=1; AHgh+RomEhcUX8daj/+tWlHvGP07XHeuvMeXzE6IUoUgSdEjLzso4SOUTUzzculHX3HT9T2/8vYpGPtPh0cdKX+leGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW65cGYUDbB/BTo+wSaAmfEGcJJPynYCVmvNracL02b23Ma0bJ
	P0o0WMm3RE5RQSzv2Xi0/z2eM+6gg/78pCaQypnZWAUKBXtVo9rwbqpi5Sgq1D43u6TGdK5XlsV
	BEIzxq/zTfjQeA1XyAZyKrXQ0NOHVtvq6cWz4ER5FpzGFBEJSe4hBSUq2N0yQMoWHDEAMsl0=
X-Gm-Gg: AfdE7cnvrG8qelgYsoYNrvd93xA7bfnOMg2dZAJXyjkFc/EimYVm8SraVw5YR07+kPq
	QJrEkQYB1q4Mo5kVOv8V8eRdbZ14UTs077ApabFp4IVPcXXSR7zsfKWz/xp2iKJHmfrWWXd8xna
	X6QDOJff81BJ3e2j++u5yskou7k7klAuboQxCaUGQ6EOXztpJa8+vZFK0TApd38a7tPAxwBmEw8
	KDnRiQNGNaiKEKFpznqTlRcygGoaveKJbYBk6YurbVyE+SOfwYaWt7irVMEtE8mlOjWqpCbzYp0
	BwcW23/TmJW0mSAXv+5Zf1MNGpYPt6euHGkDDVJPf0ZN7same0rIQWaOVWmue8l77ykDi8a5UJJ
	bI14DS978Wnh93Xn0EdRjckPBkxwhP8spK5bh9kF6c/B4quzwH80FHSlrOQ==
X-Received: by 2002:a05:6a00:9284:b0:843:468d:780d with SMTP id d2e1a72fcca58-84855d6d7b0mr2156507b3a.3.1783577708617;
        Wed, 08 Jul 2026 23:15:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:9284:b0:843:468d:780d with SMTP id d2e1a72fcca58-84855d6d7b0mr2156472b3a.3.1783577708178;
        Wed, 08 Jul 2026 23:15:08 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm8146032b3a.57.2026.07.08.23.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:15:03 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 23:15:01 -0700
Subject: [PATCH 4/6] Bluetooth: btusb: Add wrappers
 btusb_recv_{event,acl}_hdev()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-btusb_prep_qcc2072-v1-4-d835b187fd01@oss.qualcomm.com>
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX/Cj3HHGCJ+tq
 ZKZDgbNBDHETkYYrb4rBr06BTa1gAtLKYdQuYH514r2s/5FgQKaS1wDpzulwu+ULJmmGY57zgvl
 xXBkn+SJO22lcXS9Jibo8oxDs2/JpoioG1/xkCjNztqvHciL+OTR7wyRi31gmQ25DErr3yaF+MK
 Qh4d9ihzQjVMu/e1KqX00qMhj47foMafPoIAygcKiDMLwTObjaR+LmZSloikhTk+ycWeXmnImby
 jxXIQK2GqQ6i3bViMJ5Ro2ro4tY4XbBEJhm8lVx7i/FFp4TOmhaChSzY5xi1dVMnfcYZ1u3ENJw
 iOdHM0NHGHd/Sm18VnVyhen3/FA1RPTyCYmNt6RMnU4lVY3gXWpk//wsZClblnjXi9+Acz6LX36
 NSclkyFpF+XxVpnyLN8AdU4VPgQ5Y9q9k5prtao+aKtz60e7zCTpdCHpYI7kqJcEI6cTJwGUT6z
 uMYp+vV/Debm4OHi5/Q==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f3c6d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=G9higz8Yj4j_C8bf5iUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfXxGNhulPDL63e
 HjIDGRNYGOrpRdjV7c+vrF8AWqOybq/Vkb1/V+MP80r8afvF/DyC+gUDhW+iJUwMaGt8wrMkigm
 BwsDF+TKwN271sHNRdbm5cx/a8l+p88=
X-Proofpoint-ORIG-GUID: 7lpNNfP1UMarnNn6nd-B8eLRKWUiLlit
X-Proofpoint-GUID: 7lpNNfP1UMarnNn6nd-B8eLRKWUiLlit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090055

Vendor-specific files need to hand BT frames back to btusb for reporting
upwards after filtering out non-BT frames, but the existing helpers take
struct btusb_data *, which is private to btusb_main.c:

  int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
  int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)

Add two wrappers taking struct hci_dev * so they can be used from
vendor files.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e5642d966153..d8f076baf3dd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1261,6 +1261,14 @@ static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 	return data->recv_event(data->hdev, skb);
 }
 
+static int __maybe_unused btusb_recv_event_hdev(struct hci_dev *hdev,
+						struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	return btusb_recv_event(data, skb);
+}
+
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -1343,6 +1351,14 @@ static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
 	return 0;
 }
 
+static int __maybe_unused btusb_recv_acl_hdev(struct hci_dev *hdev,
+					      struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	return btusb_recv_acl(data, skb);
+}
+
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;

-- 
2.34.1

