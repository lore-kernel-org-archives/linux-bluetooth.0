Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E402403AF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944077; cv=none; b=jCSp7wsyHbg6whOw2uje+HxDeP7A00t1G+jz8fborX/YYYqP5b9WcvgNt1/r9Ar3gW11soV09jGx+hm+JcWCiWa5DyR+OjiL7HQblFpHKJkeVgRpn2l0MLs1xivR/etg14oUaaAcSmkqLOOzivQGd3fvkmzVB7jY9J9R62fv2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944077; c=relaxed/simple;
	bh=v2VPPn9r3a5HW+0KYV2Aibm+FgSJEKNHvOt+PvAJ2eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGSmYeawI1HnlVJ3n7/soxs+IEpH8/8RZ13tiHl8Z8tSqKH1/OhfUelQ26LE4T40fUWKVdnn5HzVFKvq3jBblHOQQBW2bekUS5l8DaMes6QslXEaqtbdAPAJKoo3uvoC5w87vXqREpjVZAYXo/WDi0x5Lb4rzFDWN3x37ZbxjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S9w4aq6W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CuxTf1TT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S9w4aq6W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CuxTf1TT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DB81nc732256
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9e5fn0QlVpwC9iuI8X0RWBXIW8Yj0IcMsX3EQSmYsN4=; b=S9w4aq6W2T5PA/bs
	9Ulx02EEZzbMcfOt0H4NZ9FzCvh3tz/ZmSY7iF4aMUlLzd9a8Q+KmX7c8JsKbJXa
	MJqtgD9pzLkxPS/QQMFrC+yrQMZ6GOmu8kfREIlOySOd6FGKsqzg32l5dzIp0Nw1
	3sXcdvpiMJC0Kra/nmPm55citvGGaeCto/6eIVX05SYdk+yNn04ARDeqnWux8Uz5
	wgbNoOyhuAiPaQrg9Cl4EzgCd/2yxnxtSgYavA8mPtVFCCgudpzwuhZhfFlgQtts
	Ukl5WTYySINSw7MjOhSaiN7gDZ0/q61Bvvw3LuxgjlEfUcpb8IhdqtY1Fd7GGbjm
	qbeKJw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3acpv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c888c687c21so306479a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783944075; x=1784548875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9e5fn0QlVpwC9iuI8X0RWBXIW8Yj0IcMsX3EQSmYsN4=;
        b=CuxTf1TT8OSzBL4TrkT5b0i3dZ+rEUnQR43NQQ2g6S83gsW1R60Ks2ZTsq7Cop2Z9H
         hlQglOuSUd9zk50piJSKdkwZ6+hQi5mS1rMhYG1KqZS5J8kw7OWHKnQdVXUh5hwL9VUC
         0FdMoGwrxZDyIt5ipEbWPp6nULsrj7/6EK3E2Clu5+GMV/P/iOQ0EHdMPm3rcIJz6MHt
         vruU4GmFuh2AdXb3GOKJ0PUyimn5OvJGDJMi6t2AzeRITTQKxn9+cUMRS9S0+E6KaMsB
         CRtzLL9YawYBuJ6f/rtO1tFw4pqahnnY2FcfAFZNK+ARGapDa2k2sYgOl+uMuQNQfNgI
         U6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944075; x=1784548875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9e5fn0QlVpwC9iuI8X0RWBXIW8Yj0IcMsX3EQSmYsN4=;
        b=SEGC3qf7EdrcAlQEBCHEMC/t2cyclHXMG/IgW5ELUiEdd98Cg4t1Rj198Sn+ZuZAN+
         6QNxu8KJAF41aDBbklViXCwR3uqZI3HNJyXwJd2jIFmB48SzO+UDbo5YYTB+8aSgae1C
         wMEkDbOISxsWN6h94kpC1AQK1/42QS1QTx1MzAkK19MabvsNJbeE5SYkRkbE6ScDiJ5Y
         8OIdIkcl0lB5Rqj+Kb1YcvH4epzNbMyYROW10hpHIJznTojIYNqGvv1uBWu2S5V3Yw0d
         23FkRbS4oMGfZlT01ks7rPebvBOj8fNZW+aeSkNE968gxOn91j5mKoOHolNwq5qMwQLy
         sHeA==
X-Forwarded-Encrypted: i=1; AHgh+RrGh+G3PZk2ax5+q1E/6E9EGE7Cd+eje9GpChT3ndybir1BJ0V5wyLcmX+yHMuhTPaC4XvPz2R5zsHgrtCqNOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmI5HZVzEBZgOwazuq4Q+uUV17MRiOEnPu2EAt1l7harnaXBI
	6gzJoaqMkITEvpkjHcFV+JamnxN/8SGe2Oupg0tHk1D7Ciyfgq9yUjFeA41xLEVKL87If8SOXnk
	4II87iqy/6o/DdVR2I0DU4ROmD0IR5BzKQ39H5/bpW60pYqmq0rqYe/7w0kRJt1F1qk3ifcc=
X-Gm-Gg: AfdE7ckr2QsQ0y655S6YHrVD5uo0zKohQvCEhh9chWYbJrCH3tTxRYZb10zhV6nVXD2
	jgtJItZHZMm8KHFuyozzFurjVPqYh1Ww5icOWGHBmO3mcdFa4ErnTha2OZ5+NCWs9/kgJzgCm3K
	KOLS0SklQyChPDKDve6KNFPvnZzPCMeiU1+nHXq5EUV6oS6Fi9TBeiSJAsY38x0PXMhjC5Os3Z1
	wKPXZM8viTV+89ZBxSXVPwfNk+ZDjUYM+emSCdudlFB84uE3tfYm0Y6XPF+WJaqS+VfQUcLeR8D
	LY/zp1kFLZLVFtNOJ5GiVlABVNFLwwXdXaiFkPaK7vAGMZ5ovfZKPHMepNWTW7HYhbuJv08Tkry
	3408yVGgADHjm53WEringxzZfZ/9cCk4e7Aa3DB4RI6FLbc0VMy4RGJNo6g==
X-Received: by 2002:a17:90a:7307:b0:38e:bfe:81e6 with SMTP id 98e67ed59e1d1-38e0bfe9036mr731717a91.1.1783944075004;
        Mon, 13 Jul 2026 05:01:15 -0700 (PDT)
X-Received: by 2002:a17:90a:7307:b0:38e:bfe:81e6 with SMTP id 98e67ed59e1d1-38e0bfe9036mr731703a91.1.1783944074597;
        Mon, 13 Jul 2026 05:01:14 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm74577772eec.31.2026.07.13.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:01:14 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 05:01:13 -0700
Subject: [PATCH v2 3/5] Bluetooth: btusb: Add an indirect recv_intr() hook
 to btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-btusb_prep_qcc2072-v2-3-bbcb651285f2@oss.qualcomm.com>
References: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
In-Reply-To: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfXyiviysKnLlir
 /G99qZxl0KM9dRzl66RVEyDfPtgvoe7iTQO8f1WIFgBf3pjzf5+3siXzTcFNqa+NbQ+zrlbd9/d
 HGJJt4kEcrcqI/czRG0ZIwWsyVzGVlsIikvNZJcFeJkqqBk/j8u6JbTu2bBdRAyPvVh10CW8x1p
 gelWmqES6+q3ME15kvaiUmrD8y9pDDeDwRnBHzIGZPtuTUNCPk0kL6EnQNxtOqAvywgvwFECnLL
 UIVxiGqQF+/aKm9MSp53BQ8LKsGamJfV5PCbZ+P4vst7k6N3fzJYlP0Y/9H4dduaZwfpcYQHkdB
 fSnDppdiX/cZE1aExGmR/7p5M1YDwJgQELsefg7rx6U3rJ7jWAnbFhLpEblVaLZT4o+ToXQ/5ej
 xKDg45WjEmQRhZ/ECcP3+U4Xsrm7MM9a51VfrDRCIGCfQO6tk3gU1lLZoqHS8i3UhQN3/m0nFgN
 8YkThi+fc4Lun/7/zPA==
X-Proofpoint-ORIG-GUID: qVZVmAbqAabZ9vhhUIP5WbBLULAgFbBL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfXzV26lXpDIG0w
 o/6IzJmywJn/nCP2S64s2FQX30j+yvgwdoqrDG0NzF8XS2U/ibWJyX45keqzf3gNlQVmrwAeDQH
 07+/dCOO/Kopfie26BJ3xrLV0/lZVEM=
X-Proofpoint-GUID: qVZVmAbqAabZ9vhhUIP5WbBLULAgFbBL
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54d38b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=j0w3eOB3VtzsIZiBwfcA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130125

Allow a vendor driver to assemble and handle its non-BT frames from the
interrupt endpoint.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c3193ec2d52..9c3a6d7d8f1e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1032,6 +1032,7 @@ struct btusb_data {
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_intr)(struct btusb_data *data, void *buffer, int count);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
@@ -1504,7 +1505,7 @@ static void btusb_intr_complete(struct urb *urb)
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (btusb_recv_intr(data, urb->transfer_buffer,
+		if (data->recv_intr(data, urb->transfer_buffer,
 				    urb->actual_length) < 0) {
 			bt_dev_err(hdev, "corrupted event packet");
 			hdev->stat.err_rx++;
@@ -2711,7 +2712,7 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	 * same way as the ones received from the interrupt endpoint.
 	 */
 	if (btintel_test_flag(hdev, INTEL_BOOTLOADER))
-		return btusb_recv_intr(data, buffer, count);
+		return data->recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
 }
@@ -4174,6 +4175,7 @@ static int btusb_probe(struct usb_interface *intf,
 	spin_lock_init(&data->rxlock);
 
 	data->recv_event = hci_recv_frame;
+	data->recv_intr = btusb_recv_intr;
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {

-- 
2.34.1

