Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E953A8746
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451210; cv=none; b=uKhvmt3nv5Lj4veua0DoFrkTxJJ0VqlIAJbGoFNu/xq+gUX9dQOT1ODSYs055nc4mn0eyXaSf6fRQetbeOevXMEs+X4x3XImUQ+ZA4qqnziL6D5ivWAHdQzIhXl56gLjGrfl6K6jhXpZf+AL8vqc8D787QCzoZck+HTiW95/HCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451210; c=relaxed/simple;
	bh=l/Gk01hGJg5kUh6ChWLEKuHFQ9rggF8h29m1ZgMwtfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezIfrnLp3dbdyCPD7i4wBBOqyza9aConsGR4vbnEGKyYHTj7tQRaD6KxPFLi0b8Pdc2Ow7LZY5/JFTdoYWt9+XY4IeV2XZqs5JpfYrH+y7HCYjz/d7CtCb5orRhfUTvXomWddOuOsLFXgwOja/fi0BlqLBMj1shnPw/b4Y9uXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgQuQDKv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T3ep0IzA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgQuQDKv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3ep0IzA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2imgZ4181709
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ssOA6Sr9m4gdmZekHWnuBAc3GlXZcD9QEaIV9uWjRxk=; b=CgQuQDKvpyj+x/WK
	CAUYbrIitGxcez3mJEanDq28Nv8TmeH5qxPD62pt2THnsPANT0kGAu+fYDU8LYBz
	GUxGijcPfBj9/IRMWrNTrZwyOcyv6dXWVy+amcgQi7sDbpR0SqGaJObhtcySl6h0
	xK2c8ugvp6EmwaqpozXt2o1QWZ+hzKRnV17S6Sq4+mxjGVJgDfswuTMH4tSl9d4g
	GP70fPnWZIDlFl3I6WnD2FSGAuatFNKnJARVAR86U8TxrkKUpAGbCL4UUFki2/Hk
	Fum+ZHDUwbq64VH9E2cv4D6Gf9BVpVZqDTF7aiJkim8nHDPbC3ilUAmK4S9rgd2q
	bs2bzQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f17s8jvv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c01418329so44884eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451206; x=1783056006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssOA6Sr9m4gdmZekHWnuBAc3GlXZcD9QEaIV9uWjRxk=;
        b=T3ep0IzA2KHbNHni8OqI8W5L3KxiZdszb5eKjFLBMF4BYtvezs6arIbrjE9pM5vMIi
         hGfrAhHXqK76zJ5d56+zvmDCRJNRJHwR3diKBYZOqaXFKOrg+/RQFJs+L4+NEDWPpyuC
         47OITrIC/F0Cy5rtabSsMaMnYnJy3JRtaL/qwea2nJi4Op7785vKSrZ1SZsyUYrQIdjk
         hGz6OSo7RrOu+WdC77Xh8+4zD7CQs9EfN06l68M9lA7M5CfcpxaSgVz0xg9b3ooGKOgC
         TXY4zkaZR9b19xF4bTPGTcZY8oufptwDl3/WqduMGq3Lb9RQCntHtgPXdUOxCfeTuTk5
         x+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451206; x=1783056006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssOA6Sr9m4gdmZekHWnuBAc3GlXZcD9QEaIV9uWjRxk=;
        b=rHQ3YZB3j8Dk8OdlrFVgIv1/UREGDS1fTmkVeDsEzdFKbSWB/nF6uIQRHacwyzbU3F
         ysMWyjScyJq0PV0+CqjjkXCFD86bWX+469gqoT1PYFbfeiW0pPsV9EjcelVIGZFaBfZh
         MbT16MOhx3sUnMopoxqCY2c85Mqy1VzHddjh0FSCWUp5yGGlmQG+wBYRHZhPIYnKVizU
         pH3dZqidB/LiTJDVWRJKl+3SCJevOEjyTRn8wfUdylIVZprKIwhjTrTa/x6RaFuKZ9JI
         halApksVZSyvEGMaehSYIIUAFz59jj1HT8YSbPh5xepkb5nNpXdP31gm0O9F7bJu/hag
         8Xvw==
X-Forwarded-Encrypted: i=1; AHgh+RqaPaHlRWo9aL5OzUQ/N+xKHmXdEs9/s7ahWIyf2PY7LShnZ66Vc4qqaqPF/5rtGAPTOb9OkFUhJA5tpR5zxRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6x/yInPe+eY3mv1yEhrVg2gqvqHMyjUiGrsk6tq0ejMETrbU
	T3keaKPctaBbrWqDUwEb1cAOqdIsMm1+jp+rD5eiTsd8Mg6sxUca/vbXbEFcFZnOHkBvJ1D/NMU
	3J1EEN4Rt9qlC90JoR5yXa3E4CINwm1tEgX3T3ZvWtoRczkrWNDQMptJ/zxMbiaPjnljo2/A=
X-Gm-Gg: AfdE7cn9/QmqlWfVLs5Gn70ySAfaULg1hyd9WCfR+zfOhuKu5HYpjOhztIM6LErsEPi
	+Adfn21SqOvUYTOUBVfAWuF6rlFM92RkPUloPkKHyBSB3inb2a7u5TQJW0WwSMkoiFDW8/KaRSv
	xUfy+QVlPKRKcqinv7Yd5FHhpcy2XYQpIazSFdJ/iAmn+IE1TDQWaVZGENqWIObSxo5j9OAeakf
	lPIyJatRiyclpbeEUGEmlFBlvbOsFjforxZ/3GTW9ItYD44PZiu2rIAll27fxI+GWGwy/HQrEMq
	2tGaMvWf9UAzCRPlOz+PL2d/2Ej2/QO4Oqzihs1Up38kEI6iNYHO1bw4K+e6aMgG5mJGIh+qcZ4
	AoHkM17cbVqLRq2sQ7K7ac0rQnDIU8wfP49Z4nl3jWvUAOfvfo6af9ywRoQ==
X-Received: by 2002:a05:7300:2211:b0:30b:f3b8:3e7d with SMTP id 5a478bee46e88-30c84c9c952mr2313350eec.4.1782451205686;
        Thu, 25 Jun 2026 22:20:05 -0700 (PDT)
X-Received: by 2002:a05:7300:2211:b0:30b:f3b8:3e7d with SMTP id 5a478bee46e88-30c84c9c952mr2313328eec.4.1782451205124;
        Thu, 25 Jun 2026 22:20:05 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:20:02 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:56 -0700
Subject: [PATCH v2 11/12] Bluetooth: btusb: Reduce a redundant assignment
 in btusb_probe()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-11-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: PPWpxL6IHqyQlF1UBfO_gflso4H-FOWX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX1E86PYVcolbA
 GDUd0SnQUvWSp7i0bglqwpAr+Lh9LxUxO2zySOmp+Q1yNr6q2iqp+TIC2V64m/6w6rGqm7TDTBH
 2mTmPbsnZNcN5fPqYU4kXR+bgK1itTc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfXwxsVTSnDPN/I
 7QZ61TOFUdvjS2sFIXdBoq8B5RJq4qRvpzy7YMa8qhxSgl7fp0gGHsqW1mxvaCKJf18cI2ijco+
 DjFghrv0/Ya5c7TmGunJV6dVtySu4eu0FlAT6mKCvuPy/ef5EAsBhcGJQCu2vUqUejVQPARhOb9
 IcOvhs5eBcrA+F13E4DcWAON6V+lkwd8RgO+d5qljarEq7gOHSlP0Vlc+ELAVYJxfDrVAob3f8b
 z3+W0uHQvAq8FQPjzF7mTmktya7WIedHAN+kR3bZSIY3XVLGBdHEovwMCnRu4vlTjDCAkyQFUC4
 nS9aZR2Vvh7VJJ4RGIEt4vCmo1iwZ+U6qTaTAFpoxKatvtyaUSBxRXP79dPrp6jWZEKxoqe170t
 O1ntF1JSRyVG8LMBruJIS7IAA8k70m94X/Rta7s/5BCdEePUm0iIIilAj5m3CMSIHZ+z042XMV1
 KdEekxJE+NUWlQ2IPgQ==
X-Authority-Analysis: v=2.4 cv=GKo41ONK c=1 sm=1 tr=0 ts=6a3e0c06 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gj2qSTqXcDC7yxDT8GEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: PPWpxL6IHqyQlF1UBfO_gflso4H-FOWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

Initialize @priv_size at declaration rather than separately:
- Simpler: one statement completes both declaration and assignment.
- More flexible: the variable is immediately usable from that point,
  so any new priv_size += can be freely inserted without caring about
  where the separate priv_size = 0 sits.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 25bbee8f5d93..d2e15a91584f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4090,7 +4090,7 @@ static int btusb_probe(struct usb_interface *intf,
 	struct btusb_data *data;
 	struct hci_dev *hdev;
 	unsigned ifnum_base;
-	int err, priv_size;
+	int err, priv_size = 0;
 
 	BT_DBG("intf %p id %p", intf, id);
 
@@ -4161,8 +4161,6 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
-	priv_size = 0;
-
 	data->recv_event = hci_recv_frame;
 	data->recv_bulk = btusb_recv_bulk;
 

-- 
2.34.1

