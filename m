Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E65388390
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969706; cv=none; b=q5V1XmVIsorDDDingFgRL+N/jO2F2PLWlvFkXE7gppRCtXqec7fvGWNYba9xbqM0EzT2y3AQIpbmfnrOg8TVJKqnvkyVwNAAIzpqA8Tk6w6EaxeRj/wlfr92AwDrqcaCMHaFXHutUXmSpCixuaX0zsxEmhNl51UFbBtbRbSj4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969706; c=relaxed/simple;
	bh=3gOwQ2Veh3ermpnFQs85a7ka/v3tpSUQ9crEUy28sgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNvO3CD6fRsXd+QK7jHgdlarh8lMRGIYhqOb+uVJY/hr8ofAPBcAtHZT1m4QeLbvajQaCZuKVK1THnKkpuONEaNq6/phuzhX2LIZi/XRIiJaN23u57BAco7m5exAkRDxbzheuJsVXzvl4muQk/JpdeiXJ56oGgQ/3gZzoHFkd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Va9P2BlA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kXdW8//Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Va9P2BlA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kXdW8//Z"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4m02Y704275
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pQ5dLwxvUjCjqtpx0GNX+yrJf8Z4XMgfa2yK6gqTwU8=; b=Va9P2BlAX3WQFpRq
	Aq13rcHJMlxX/rMCd0kdt9PnRTmmuvuzYkX89jsM2PcTUJgN/yFlIyEusH598q2f
	eKQJmQtLoqBpWr7aTi9QSIvAzLEm678SWX6a+Xxm3ZJ/D6gzf8HH/JI0qpx8ZkOC
	lDbHD9xfI7JZ0VaobnX0VJWPs9h+4CxjnsoE9zQtdCWbA2axCbGTogF86lvJ+E8s
	FvtqgSZKKlY2E6n7nc7UvpP08cs1/9gpYcPxmk88DgIVIF5F5Rsq/GYE2E6dk9mh
	teCJuIIGnRFFl91+Ay0F88n3h4lc9PNT/9abJp8klZZenqmqXwWRFZAzAJlolLOA
	Siaj3Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpee8d23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:55:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ced1ed870fso2599415ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969703; x=1785574503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQ5dLwxvUjCjqtpx0GNX+yrJf8Z4XMgfa2yK6gqTwU8=;
        b=kXdW8//ZsXaJ9GLBvSqgI8XslfDOHxlOHtAf1x/1HZSY8P4BRVmH6yRFmXAe9+wntk
         XG8MjpV0j3fCDLvEE+4YZZlEhDWBviE9bfdwwTa/ghFcyud20oHmvoo5mHn30ijEjXur
         tucNRhviJfx10mp6NA/2vYzavttqGJRUUOarCDrtPf6ev9tQJ4KmOPPL/AxhVllW0aRF
         oXLxzun33V9WO7p+QiYYbnpx64vYJ0inhUyCjmmrq2cXvz004S+y67Xrpjr1nMWrnU1G
         6+CHSXX1ZjU3KSCeUTh4J9UQRpYNe4jKPfITfIrkT1kLMADfYc+YkAxzTHvvIsEzuUyF
         QM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969703; x=1785574503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQ5dLwxvUjCjqtpx0GNX+yrJf8Z4XMgfa2yK6gqTwU8=;
        b=eQhgJrfSM6caGVeyMxbTbdCLEZTqaKGrdp9WEOVEBkHCo7BeckswXZ+6J56ip0/LuB
         BOokzCExI1Lj3gLUIgxV3MJRHsUKEnkqdnQ3QyUaxwamkdYdF/7IuLX8VgmBM3C8xlSH
         1hQOv8l+Z/wNZvVqh6uPy9XUdaLdBGzXcQ6o++uuWULNSpAGukNS2hwu59xqjqVNcbH6
         KKrwLTA04pXmSQkKLSK0RK2uNBEUFIjhra1ivUDwNqKfD8AKezdgzYHpAlCMljg9A3QM
         uGfOyxt0PkNrWLocPsWB58ADtcCv2mP25Nxue063eSl20rwZz4QQ53JElrDXJxmYV888
         qzDA==
X-Forwarded-Encrypted: i=1; AHgh+RrOu/D46xw1PJiPrd9Bl+xm9TEjiLY56vfOnTnpOgxNHBi1BfpzTueiYsb3zih18V4uPLSYSwXwGjFuqfppXN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGa50x5Pmd/aC6UAOocCXAqgbCCW/sTZDHLhoCugfvtsTaDMaZ
	jzV3JM1kuQRiv56hZ+e6OgcCDj6VShFeOV/+utyHD+NfYj58wTnVHzPAiTAzevbFFUhsMzaaRdR
	bRfGhnqPOnYUPuc0qrjl5KXte02gj8VGX/s9iGgocFMSb9XZzEb7Gfd1kV9SGTuX/WT0Kpec=
X-Gm-Gg: AR+sD13jGwUDfO5eq/YO+Dr4tszkAdCSn3QYVqPiYyIq8xeqa6JiR9nw8mDPios3sbf
	VYWo0m1X8hyLiaih4yoVBLCweMiepk+1xPzXaBBbRgzJ9QFtFzhCm8NI5+W3D7m23PpXq0VJsWa
	mxg33rszwzvVsSQqEFZw12EgUVI5YmaQKVmkNZlb9m4Cu2NDGOQSzHBup9cjRhLh9UEaTj6hQr+
	tHmYP28PWpuhDqi6heLOTtdtPcg/gBz7Q2RNpYTQDi+MLd6XPUaNsR507dN24Mwqa1SKAxv/Hp4
	Ulg1GTXB7D8LsL2fQoj1ue34EMdXvXOZLvcKcAAxMnwwlO3Un7DrFL+Zlgng0uOT08Md2Inc5mD
	Q9V9yhBHzLJvJkx8v8k4q6g0iU0MZ0qlSvd+nS9VDsHw6d/s=
X-Received: by 2002:a17:902:d491:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2cfde7901b2mr14124435ad.2.1784969702698;
        Sat, 25 Jul 2026 01:55:02 -0700 (PDT)
X-Received: by 2002:a17:902:d491:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2cfde7901b2mr14124225ad.2.1784969702276;
        Sat, 25 Jul 2026 01:55:02 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:55:01 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:49 -0700
Subject: [PATCH 11/11] Bluetooth: hci_core: Don't treat
 HCI_DRV_PKT/HCI_DIAG_PKT as unknown type
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-11-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=Jr3Bas4C c=1 sm=1 tr=0 ts=6a6479e7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bbCMvEgGTdwX0zQgW7YA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX7FLus84vqx1i
 UZcBDkIcSY44zkHVfQTN1s6RR2UeVc811KXzMclcdZrjrS/MdoNd9fahDIz2oPnuWC/jgsQR0Vr
 nVvsBl/9JnFjEKMCQk3uh8bpvh+qMoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX8VBGv46bmY+f
 XCf9iGgaFBsk9UVYBmQl+lbRVtT0YrFbeJR0fM2l6/fc9T1UAZaXfcv2dgo12WCQsLK9Q6czShd
 FLTIFJZ69yZob1zjJGT/yF6Q+WZd71l2rI3dboeO5RMOFsuhrNXzUX+qrR1qJ4A1bTgIF8+d09F
 TL7pxA9iBcXUnrKFWWADKUWoGZA0vsnAkIYMkrrKcrVQ4IA7LsjDp1dtgJCbwc8EPJUr89fJMgI
 kxy3Ebbz9ztbtNEqrTBWKq4PradAliz9oiVhe80LRhg6Mrz+qKi01dW/nVzlK3JiEEORRQfqr92
 Um/WbkNCLJIxGhwofE7IR1DFeru3KanIjrKBqM6zGgLQ9KHfl2InNxw6tCmfcA2Bp+LXenVNSzA
 ctZIZP7758t/guYm3XNVCw2IkFx+1hZXxxFptASgtRDmF99FTgACxBIgMVOFqlyftrdaBUbYeqI
 dh1hf6AzgFlNdhuvBRw==
X-Proofpoint-ORIG-GUID: 2hJtuSNpDCXMFvoOLid47zyWuyrM84ki
X-Proofpoint-GUID: 2hJtuSNpDCXMFvoOLid47zyWuyrM84ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Both HCI_DRV_PKT and HCI_DIAG_PKT reach hci_rx_work(), and leverage
the default switch case to free them silently. Relying on the default
case is prone to mislead readers into thinking either that:

1) they never arrive at hci_rx_work(), and the function does not
   handle them at all; or
2) they are unknown packet types, which normally fall into the
   default switch case.

Fix by giving both their own switch cases that free them explicitly.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260719-fix_hci_rx_work-v1-1-2d7fdeed3640@oss.qualcomm.com

Changes since previous version:
- Improve commit title and message.
---
 net/bluetooth/hci_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d5adf882509..85f1b44fed9b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4051,16 +4051,24 @@ static void hci_rx_work(struct work_struct *work)
 			hci_scodata_packet(hdev, skb);
 			break;
 
 		case HCI_ISODATA_PKT:
 			BT_DBG("%s ISO data packet", hdev->name);
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
 		}
 	}
 }
 
 static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)

-- 
2.34.1

