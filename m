Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197342902A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118636; cv=none; b=nxlV/XgzMN/UC60pdYB+TuHW/subf/mFFyowfpLfk/shwKwox2h0ytn8yyN7fhO9FJJqEZqKjHVcsDBQiTjukxphnUkOOtNEpNwCK696G4fpirkJAHN5rTGj/SEhlEYvH4PhOycbJp3uv7Ue7drnZQ5SlejWUb26IXNiRWsumpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118636; c=relaxed/simple;
	bh=xr7IZ1c7NwmZA4RQrJXLfJ6PojPblLJHcTykBtNdaFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjM7MgiNyTz8LBVIppqdX3IRMh9KqfnkdbXQTHIYzbox272wm1kF5gTUXh1lNfIJGLEQBXLv8LUSDqlTYN9uWxTbO1VwG7OgyI17A7IMId4PFlW1iwZYJlVABRw5pqMZs+0Qer1r0omuGfSuFlr/sxuC4KFD+lolVmNCw5ZDkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8/y8qwP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VmEWF6ro; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8/y8qwP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VmEWF6ro"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRiWD1680007
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Aug 2026 16:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TFIH3uLfCuh
	r9Xp/AxmNBdE75An+xiOuj1/gYyyJOIY=; b=T8/y8qwPOUL+NGo3bCJNdirmiV9
	r+vucJ1z1/c9+4NRWkxwWC/6FmJ0+ef+3KxzmX2+ywjChS2v8lFzpjLkLBrksBdY
	P2puK+JJy4c9zT9Pu6TPpmJ9vyzQbGXuinkQei2q06Y/mxobqMCA5jgQAPL18+KW
	7ekRMYfjyo0Ov8yh4pOq/tN+V9wNRPA5lEBEj+bXbyiC47xc/04mmIr39uYWKVED
	Wbhw3tZcCw4uBE5VVPd5Y80XOMr57RuSsmA0etS2UAKS1X3FtGCH2rxLkXz9FLie
	G2Dx9hhXo6aKBUpJEhRh9vwXx52w3yGzb0jadj8btOlTerJC8TzWQabIQQg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwgewgk4s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 16:03:53 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c2ae99c28cso513317e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786118632; x=1786723432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFIH3uLfCuhr9Xp/AxmNBdE75An+xiOuj1/gYyyJOIY=;
        b=VmEWF6ror4CMiMMt/ABsgesHj/Mvxf9ixNDa1G7v3Otw7uxOtc9IW4LZvg2yLqV+hV
         hvfDZhlJJpLzxrAn+hYhFmsZQZd3WTimXT4SEbrjmE0BQJrejttE1G89SCgkF1VOGhRG
         6PQJJzwaILLVHEmbhwGYJSJtZ9Y279SlwwVbMa7LZR0dhAgN3Od5YoI1vpy4tLALM5FH
         dtjXUMrFlZaKdMStmQAV7GBFVu/0anO9Ua5Zg7Ay6V0iedAldTMWMq3NFBel9swpOhG9
         Xvzvu2F8fEKZvzForl65o7wG/PrPme7ACGO/bSs7kV0hjolu+zmJ3M+94sSvk2ldHKk0
         9r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118632; x=1786723432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFIH3uLfCuhr9Xp/AxmNBdE75An+xiOuj1/gYyyJOIY=;
        b=VFkrqah9GO/YCKf6MdxEar1gfi4dyf5AZOObPSQOt1/j25QdZZ9tkCrbwIZjK7xfAY
         xZjgUo+f/pHGpLhFlJESAM8Xa564up2JWtdc+Xt79naaRY+I5Lhi+qNsfhdLXWY0Fygq
         rJL1/8hB+Wku7UzYOWpRdMd16/bkH8bykFgGej8FWXvd9MxzUmHts2if7MXIhoifDW5i
         Nav485yhWf5hz1iAZnH1ZgP8LlTklyUcuYuCeslLehuiR8Glji1M9Q0MvG3VxgzTTBuZ
         6eL7I1le1knSRhAwwkxZz8/jG+wVY+KH79ADmrkRAzpxmprYLFgwktwm3UJ2NitQd3vW
         MzHA==
X-Gm-Message-State: AOJu0YzoHa1ImaUi8MngFAwzwWHpWouVKj1o1PRfiUwFZONxy1JqEUbK
	/yGTsXjROfXzYqwJORkfZ4kJytAzppa8Glo/h2QIMFzCYu8ivzBmafj9EyH/8RgGZq5adwQtMdf
	XcmEcHYVotlGZwh1WQ3nt9lZcH+om8UbEFuYIdSPF4FuUZVPI+uF0lR8QtHCRmDD5axyWtcQ=
X-Gm-Gg: AR+sD11J1EKPqs5M7F2Co7sPOz4nBWxjobYWXqVgcsFGUC1FvY4MpeV4WDlrjyU8Abo
	VimcdIRUg6r2/f9r44B5m5TasUak/m7cSgotVew5JtVY1lDndG7vabUCxhT7q0smsxM4H5IJDY7
	fIfYQeTMZ76VH7ojlADe/cMT1BZoCHbNQWKWmksUfV4h5dXZ5cCBNYbaWYogRZhKfVvDFZrFh7i
	UADPPAkj2O0x3CdBPZeuHS8QLhyl4L+z37qHMy87KdOP4SMmrEZC78QJ9vNZl0CjCU2pKyX5tDl
	vl4jejRAmdasjDx/u6dEXqBxAaNZh54LWsp35EJ6GIrhqdqQEobE021yt/znwBCTE3PS/Jv6zBR
	PUnaeQYOQaQNLoR+NRTtUyQBErk8gdd0=
X-Received: by 2002:a05:6122:4b10:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5c40959e017mr602878e0c.13.1786118632264;
        Fri, 07 Aug 2026 09:03:52 -0700 (PDT)
X-Received: by 2002:a05:6122:4b10:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5c40959e017mr602841e0c.13.1786118631762;
        Fri, 07 Aug 2026 09:03:51 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a2b1f1sm71367466b.12.2026.08.07.09.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:03:50 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: [PATCH 2/2] Bluetooth: virtio: process RX buffers in virtqueue callback
Date: Fri,  7 Aug 2026 18:03:25 +0200
Message-ID: <20260807160325.1921-3-igor.skalkin@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX3YHMkoH/ASJc
 RJ3C5vjRzcI+N3p4OFVXQh9yGemKeVZXtYnxs8hvT/0i90koOwJ59560eW809j/NrfDxFNghKuD
 sYIqaAbCLm08KKt1/zDWSsAqh3sDxuU=
X-Authority-Analysis: v=2.4 cv=N5cZ0W9B c=1 sm=1 tr=0 ts=6a7601e9 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Ya1WsiqdJGzvDigZ0kQA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: 0cG9skG8dxKbYYG9-PiwTWvN-qnOkHYZ
X-Proofpoint-ORIG-GUID: 0cG9skG8dxKbYYG9-PiwTWvN-qnOkHYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX09wcgYR3Er0B
 P0IgTcc5eJQf2/dXJGboc3ocQR+duOj3HXTqiklqgUTCBAFZYOMuiUaRFVHMUsVcvLZpTJMhace
 gnDkiCWOULl8umJWGnxA+8tkOEC9/zEYxw57OTpHYntQjSQkmo+LtmypKCF/ZSfPpHwoP+WQxPZ
 3RhBWd0uvo9XBvsOeg0QZIlkAL8RiVj7ODGupTULW0D+O8YguMZ3Fo4wpn4Q3dk8hDAtQ0iunIc
 jzH00tOFAPvq9JUBohg6CxtBC7yFDfOCp+l0WazSYlHlTGP3de3PZXzLDGzA3oZu1A27pXreQeL
 KggMNc6EF9FlntPWBsZhzISChu9DALuGVmJmVBj/9x9qCG4T9k+IiWdXAZin1eFpBqSh6V5o1tE
 LDOYD2tmd7A4VuVVp88ujXo10dEJAV7J/terLsRvcOLBhReZ3VtZKiBOhre28JKY6K3D4MiLBt7
 NZ8E8gRyvtUrcNa/TGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070125

The RX virtqueue is sized for many in-flight descriptors (64 on
virtio-bt-pci), but the driver only ever posts a single buffer:
virtbt_open_vdev() posts one buffer at open, and the RX callback
replenishes exactly the one buffer it just consumed before kicking
again. The device can never have more than one RX descriptor
available, so every received frame serializes behind a full
kick/interrupt/workqueue round trip before the next one can even be
queued.

Drain all completed RX buffers from the virtqueue callback and pass
valid frames directly to hci_recv_frame(). Populate the RX ring until
it is full and replenish each consumed buffer in callback context with
GFP_ATOMIC. Keep a worker solely to retry refills with GFP_KERNEL
after an atomic allocation failure.

Serialize callback, refill, and teardown access to the RX virtqueue so
a refill cannot race with device removal.

Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
---
 drivers/bluetooth/virtio_bt.c | 137 ++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 30 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 96f21501e..cb42b322b 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -23,24 +23,39 @@ enum {
 struct virtio_bluetooth {
 	struct virtio_device *vdev;
 	struct virtqueue *vqs[VIRTBT_NUM_VQS];
-	struct work_struct rx;
+	struct work_struct rx_refill;
+	/* Serializes RX virtqueue operations and teardown. */
+	spinlock_t rx_lock;
 	struct hci_dev *hdev;
+	unsigned int rx_buf_count;
+	bool stopped;
 };
 
-static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
+static int virtbt_add_inbuf(struct virtio_bluetooth *vbt, gfp_t gfp)
 {
 	struct virtqueue *vq = vbt->vqs[VIRTBT_VQ_RX];
 	struct scatterlist sg[1];
 	struct sk_buff *skb;
+	unsigned long flags;
 	int err;
 
-	skb = alloc_skb(VIRTBT_RX_BUF_SIZE, GFP_KERNEL);
+	skb = alloc_skb(VIRTBT_RX_BUF_SIZE, gfp);
 	if (!skb)
 		return -ENOMEM;
 
 	sg_init_one(sg, skb->data, VIRTBT_RX_BUF_SIZE);
 
-	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
+	spin_lock_irqsave(&vbt->rx_lock, flags);
+	if (vbt->stopped) {
+		err = -ESHUTDOWN;
+	} else {
+		/* The lock serializes RX callback and refill worker producers. */
+		err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_ATOMIC);
+		if (!err)
+			vbt->rx_buf_count++;
+	}
+	spin_unlock_irqrestore(&vbt->rx_lock, flags);
+
 	if (err < 0) {
 		kfree_skb(skb);
 		return err;
@@ -56,10 +71,20 @@ static int virtbt_open(struct hci_dev *hdev)
 
 static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
 {
-	if (virtbt_add_inbuf(vbt) < 0)
+	struct virtqueue *vq = vbt->vqs[VIRTBT_VQ_RX];
+	int err;
+
+	if (!virtqueue_get_vring_size(vq))
 		return -EIO;
 
-	virtqueue_kick(vbt->vqs[VIRTBT_VQ_RX]);
+	do {
+		err = virtbt_add_inbuf(vbt, GFP_KERNEL);
+	} while (!err);
+
+	if (!vbt->rx_buf_count)
+		return err;
+
+	virtqueue_kick(vq);
 	return 0;
 }
 
@@ -70,9 +95,15 @@ static int virtbt_close(struct hci_dev *hdev)
 
 static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
 {
+	unsigned long flags;
 	int i;
 
-	cancel_work_sync(&vbt->rx);
+	spin_lock_irqsave(&vbt->rx_lock, flags);
+	vbt->stopped = true;
+	virtqueue_disable_cb(vbt->vqs[VIRTBT_VQ_RX]);
+	spin_unlock_irqrestore(&vbt->rx_lock, flags);
+
+	cancel_work_sync(&vbt->rx_refill);
 
 	for (i = 0; i < ARRAY_SIZE(vbt->vqs); i++) {
 		struct virtqueue *vq = vbt->vqs[i];
@@ -83,6 +114,10 @@ static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
 		cond_resched();
 	}
 
+	spin_lock_irqsave(&vbt->rx_lock, flags);
+	vbt->rx_buf_count = 0;
+	spin_unlock_irqrestore(&vbt->rx_lock, flags);
+
 	return 0;
 }
 
@@ -234,31 +269,17 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 	hci_recv_frame(vbt->hdev, skb);
 }
 
-static void virtbt_rx_work(struct work_struct *work)
+static void virtbt_rx_refill_work(struct work_struct *work)
 {
 	struct virtio_bluetooth *vbt = container_of(work,
-						    struct virtio_bluetooth, rx);
-	struct sk_buff *skb;
-	unsigned int len;
-
-	skb = virtqueue_get_buf(vbt->vqs[VIRTBT_VQ_RX], &len);
-	if (!skb)
-		return;
-
-	if (!len || len > VIRTBT_RX_BUF_SIZE) {
-		bt_dev_err_ratelimited(vbt->hdev,
-				       "rx reply len %u outside [1, %u]\n",
-				       len, VIRTBT_RX_BUF_SIZE);
-		kfree_skb(skb);
-	} else {
-		skb_put(skb, len);
-		virtbt_rx_handle(vbt, skb);
-	}
+						    struct virtio_bluetooth, rx_refill);
+	bool kick = false;
 
-	if (virtbt_add_inbuf(vbt) < 0)
-		return;
+	while (!virtbt_add_inbuf(vbt, GFP_KERNEL))
+		kick = true;
 
-	virtqueue_kick(vbt->vqs[VIRTBT_VQ_RX]);
+	if (kick)
+		virtqueue_kick(vbt->vqs[VIRTBT_VQ_RX]);
 }
 
 static void virtbt_tx_done(struct virtqueue *vq)
@@ -273,8 +294,63 @@ static void virtbt_tx_done(struct virtqueue *vq)
 static void virtbt_rx_done(struct virtqueue *vq)
 {
 	struct virtio_bluetooth *vbt = vq->vdev->priv;
+	bool cb_enabled = true;
+	bool kick = false;
+
+	for (;;) {
+		struct sk_buff *skb;
+		unsigned int len;
+		unsigned long flags;
+
+		spin_lock_irqsave(&vbt->rx_lock, flags);
+		if (vbt->stopped) {
+			spin_unlock_irqrestore(&vbt->rx_lock, flags);
+			return;
+		}
+
+		if (cb_enabled) {
+			virtqueue_disable_cb(vq);
+			cb_enabled = false;
+		}
+
+		skb = virtqueue_get_buf(vq, &len);
+		if (skb)
+			vbt->rx_buf_count--;
+
+		if (!skb) {
+			if (kick) {
+				spin_unlock_irqrestore(&vbt->rx_lock, flags);
+				kick = false;
+				virtqueue_kick(vq);
+				continue;
+			}
+
+			if (virtqueue_enable_cb(vq)) {
+				spin_unlock_irqrestore(&vbt->rx_lock, flags);
+				return;
+			}
+			cb_enabled = true;
+		}
+		spin_unlock_irqrestore(&vbt->rx_lock, flags);
 
-	schedule_work(&vbt->rx);
+		if (!skb)
+			continue;
+
+		if (!len || len > VIRTBT_RX_BUF_SIZE) {
+			bt_dev_err_ratelimited(vbt->hdev,
+					       "rx reply len %u outside [1, %u]\n",
+					       len, VIRTBT_RX_BUF_SIZE);
+			kfree_skb(skb);
+		} else {
+			skb_put(skb, len);
+			virtbt_rx_handle(vbt, skb);
+		}
+
+		if (virtbt_add_inbuf(vbt, GFP_ATOMIC) < 0)
+			schedule_work(&vbt->rx_refill);
+		else
+			kick = true;
+	}
 }
 
 static int virtbt_probe(struct virtio_device *vdev)
@@ -307,7 +383,8 @@ static int virtbt_probe(struct virtio_device *vdev)
 	vdev->priv = vbt;
 	vbt->vdev = vdev;
 
-	INIT_WORK(&vbt->rx, virtbt_rx_work);
+	INIT_WORK(&vbt->rx_refill, virtbt_rx_refill_work);
+	spin_lock_init(&vbt->rx_lock);
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-- 
2.53.0

