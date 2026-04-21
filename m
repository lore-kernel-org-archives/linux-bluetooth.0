Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5F37A481
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791343; cv=none; b=j+4Vb5gGMaGXGlMhQrKYXYB47SKFOIK7ZaeBG9W8D51rxASNBVm/b6NQ692/RneyWzn9XQNhNyJZyV5O8T0GwVHkeUr+v/d5CoSNrOjsgjYe+9qVO+nbx/Xfy6QzSci7wMOhHfOLN1nJx5JWQkPs5xlv/wEdE9Lj17ke4HuSKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791343; c=relaxed/simple;
	bh=od8k5xtV8e4Z8osMhk6ok0xld4V4tOQnYwSKkBmiVjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvbxLCb5rH9sklpvfOoM/+6hUsCfFIIcv+dFr8lnhMXIc+d+caK60ETXWoGfme7x+/QDqGq/SsC6mV2Ek0ELvHyemORokSl1vksDEgLd3rKV3GtBF+FVdDelS+k4/uaBKhaSB/TTsXW68kog2kvs1lST0e5H/covFIVCVdhCn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/n9NTRo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/n9NTRo"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a6cf8242so32632301cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791340; x=1777396140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH0BlHlhoxLNNnKqBxOSLzwEDmUvu7SwzB/nxXf7+zI=;
        b=W/n9NTRoiXVLa8Mde0//RZjs4bm4ZQf4bJU/6+AfVwf6i2bOzPKtV4r5Vgatslfy2/
         60//YJY7/KNBD1nwWnXe/FjQvyOf+4ue+1ccls6PgVg40jkU3EhX1kvEYY0lez0QMIOP
         dvbRE/M6nzVb5Y8rJ373v618dJE3xr0YoMcWNhQeH07cmB2eDRiL8b5xVQryurmYwK5F
         7TLdwxtpRYVjvYEg7tqAyUOtJds/kYeM4j3O39CNyIlqDam5CZkxR8kaJI5wvmN4Q94o
         lakEa3LOhzI5OE5Der/KEpdN76v2WP5EtJXKL3D/mKFRxC3b7czx987oFJ9+XrWK522z
         hdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791340; x=1777396140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wH0BlHlhoxLNNnKqBxOSLzwEDmUvu7SwzB/nxXf7+zI=;
        b=MZReXX2Swvh/1KnydpcxhO3T8CT9KsrqUinB0ws0tTlKOwz3+djHSG24mrZSO7mZ+b
         JYYS/cAZj366IiZIzWro3yHwEtEKIpfGywRSfV7u2aoXLjKmGTppm9tWmXq3Pfb/49Qy
         LUD1qIbdw8PN7fPlr8uyDaSd21hH+VMAdCWogg6TZIYC+tV/Ln9C/F/XA/fI3rkxTAMk
         IunVoR+EPc4CqXZklx7XeifkNyjp3hk+KsD7ISiRnz0DJcycuYCad4EzlnUS6MDXOQPd
         EwUPUdoRdsuZHUUmozrFZzfzCfZXmiOlLFhyyjeu7kXe2aicdXuYi3ug8l3z0dxOOqsy
         eBgg==
X-Forwarded-Encrypted: i=1; AFNElJ/KiKhpEdH/3NXoZAOpoPZmoPDb4MLXVf84cG4gMq6aAeHvWXCxPjStMGAPFOqMo9A1fJr9aQkxMvk6aawBo94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhtBe0PcCoVxRpeTpGiLanMlLKqG2GAx4a/obxJs0up+K5lro
	Rg7+sq2/X4Mp0IcyiuRlkCyZEXvPDopiXPUFtG+gbpRHBRBQqZHP4/J1
X-Gm-Gg: AeBDieujTwpbxGbdF4Fu3nPQgW1YLE9WC5CyIT5w8V05LhhJeI4dqgUr+Bn3mLPOxu7
	kA/iNTTQxkKkZcwpS/a644hdfnArV3vk19MY/3vnrvFOMvjFJF0PN/jWp9aTskzj3yIIlL4S2Fe
	ANQsTpVyP/t9YvRzrvwp93oRvql6eNHLV5DNf35WxMHk3uZEobR1FVNIhybxKjJNkPDaPwYnM9v
	pKH/lHvalvXARkRB2UPg1BXHsgWktgumVWVC+QY3C2EqpEbXK3kjy5JOXEGKKvFNdLH6PXI9AzI
	CyBnpGSCmeNRJbZBGLyVMTng1mvARVv7cOKBS87NCozCSL5AigZvocXGVdCu+lIRoaUDiTgC4Wl
	UkobmsRv3AImwK5oH9fsKGVHhY3xRiqymf460QZtlKmkyIBlmo2gtX9J0ZVZwGe3nK7GilwhuDg
	nBS9xF6MVHLTxVTKoCIAV8oYXUkqxMvNeCcSBx/rO6fK6YM7LwZUwmz0FFh84d2lUBHiUMudh5O
	5q3uWIHoD2Qkrkiw6p2AsDsM8vfP60=
X-Received: by 2002:a05:622a:aa46:10b0:50e:423e:2882 with SMTP id d75a77b69052e-50e423e40b5mr173188071cf.51.1776791340368;
        Tue, 21 Apr 2026 10:09:00 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb92db861sm13134471cf.5.2026.04.21.10.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:08:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 1/2] Bluetooth: virtio_bt: clamp rx length before skb_put
Date: Tue, 21 Apr 2026 13:08:44 -0400
Message-ID: <20260421170845.3469513-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421170845.3469513-1-michael.bommarito@gmail.com>
References: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
 <20260421170845.3469513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtbt_rx_work() calls skb_put(skb, len) where len comes directly
from virtqueue_get_buf() with no validation against the buffer we
posted to the device. The RX skb is allocated in virtbt_add_inbuf()
and exposed to virtio as exactly 1000 bytes via sg_init_one().

Checking len against skb_tailroom(skb) is not sufficient because
alloc_skb() can leave more tailroom than the 1000 bytes actually
handed to the device. A malicious or buggy backend can therefore
report used.len between 1001 and skb_tailroom(skb), causing skb_put()
to include uninitialized kernel heap bytes that were never written by
the device.

The same path also accepts len == 0, in which case skb_put(skb, 0)
leaves the skb empty but virtbt_rx_handle() still reads the pkt_type
byte from skb->data, consuming uninitialized memory.

Define VIRTBT_RX_BUF_SIZE once and reuse it in alloc_skb() and
sg_init_one(), and gate virtbt_rx_work() on that same constant so
the bound checked matches the buffer actually exposed to the device.
Reject used.len == 0 in the same gate so an empty completion can
no longer reach virtbt_rx_handle().

Use bt_dev_err_ratelimited() because the length value comes from an
untrusted backend that can otherwise flood the kernel log.

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
overflow in USB transport layer"), which hardened the USB 9p
transport against unchecked device-reported length.

Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
Cc: stable@vger.kernel.org
Cc: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v3:
- split off the per-pkt-type header-length check into its own
  patch (2/2) per Luiz's request; this patch now only covers the
  used.len vs buffer-size hazard and the len == 0 path

Changes in v2:
- validate used.len against VIRTBT_RX_BUF_SIZE (the 1000 bytes
  actually exposed to the device via sg_init_one()) rather than
  skb_tailroom(), which can exceed 1000 due to slab padding
- reject used.len == 0 before virtbt_rx_handle() reads the
  pkt_type byte, so zero-length completions can no longer pull an
  empty skb into hci_recv_frame()
- switch the error log to bt_dev_err_ratelimited() because the
  length value comes from an untrusted backend that can otherwise
  flood the kernel log

 drivers/bluetooth/virtio_bt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 76d61af8a275..2c5c39356a1c 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -12,6 +12,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #define VERSION "0.1"
+#define VIRTBT_RX_BUF_SIZE 1000
 
 enum {
 	VIRTBT_VQ_TX,
@@ -33,11 +34,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 	struct sk_buff *skb;
 	int err;
 
-	skb = alloc_skb(1000, GFP_KERNEL);
+	skb = alloc_skb(VIRTBT_RX_BUF_SIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-	sg_init_one(sg, skb->data, 1000);
+	sg_init_one(sg, skb->data, VIRTBT_RX_BUF_SIZE);
 
 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
 	if (err < 0) {
@@ -227,8 +228,15 @@ static void virtbt_rx_work(struct work_struct *work)
 	if (!skb)
 		return;
 
-	skb_put(skb, len);
-	virtbt_rx_handle(vbt, skb);
+	if (!len || len > VIRTBT_RX_BUF_SIZE) {
+		bt_dev_err_ratelimited(vbt->hdev,
+				       "rx reply len %u outside [1, %u]\n",
+				       len, VIRTBT_RX_BUF_SIZE);
+		kfree_skb(skb);
+	} else {
+		skb_put(skb, len);
+		virtbt_rx_handle(vbt, skb);
+	}
 
 	if (virtbt_add_inbuf(vbt) < 0)
 		return;
-- 
2.53.0

