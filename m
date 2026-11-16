Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846920;
	b=sDm3oOtztqSeQ6CKCCCSE/uOYEsNtsv8E4SZlxGGeMiyxnfO+KpOBg5HlZnheEXkCN/X
	 Xng3X01SGn9gElLyC8Xw5592W1QNAyy5lOwb+gFu46qtk6yxRw8lb7f454RnqrgKKgWFS
	 VSjY5zCIeTjEuqC3+i2LZLXnhl2CgyaYNo/3UJLyf+pS5y2/1MyuTBA6KRbgVtQjdEVRm
	 +BF5N2aMZ/Gs2KwFa0FpFLAM/cxdL1Y8kPbiGZiMZer6bsuXeJ2pXyIAHeyHNFsryS50b
	 NoY/0VFiGESccMaCUKMXWG/VDOL8+Pd7VlF+qw/A0iJEuNxC/DtEChqEX9aWW++FNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846920;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=r5btRg3TqToxM2rgsequ5t5+wR9SSFwRBSngheUfYuQ=;
	b=K3orMbZO4hJiI6IS5QGTGGeZ6JT2RnKCVtJ5+vOM1eJN3E5OquqBgPcAr0dtSZpLUZLH
	 i69UjTYl2ILEyCdElC+gOUQRimHav6HSf+3bnw20LOzcfMpvV8Z2VOltfWp+IK2Y3YNEm
	 /fs2A35HVpazuPufpk4rF93P/1A8XRdNTFcwLZjPGpip25rw7K95X15xusq6hXshBhCyl
	 RSCylt39U9THdn9wKz4EEjxCx+0zYuTapIvs/0BNOpUYpexAtGjGuddJnZZLd6syz/FOI
	 DYB3aq7Dgfg0BvzEKEUg0FsNidyGPEw0BSN79MAp86e5td0U8ZBFaAX2MO3Q3JvvqDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=Xk6E4nnr;
	arc=none smtp.remote-ip=79.135.106.111
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC9606A323;
	Mon, 16 Nov 2026 16:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FFC9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=Xk6E4nnr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794846917; x=1795106117;
	bh=r5btRg3TqToxM2rgsequ5t5+wR9SSFwRBSngheUfYuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xk6E4nnrh1qqQIBubbt5QkfjQZp7wzIPAO15gzxc1NcVsh1Ysygbd0L2R/LQDxUF2
	 2qkP+nSvhpMQ70O5lkRal+kIpg1hnU8hf64/rfZY9dQTX/gIu7tp2V5sLreRSWX1wJ
	 xwY+WmgOVNax40SN0vEtMcyN1Ho6U/cdAUAvOfHkeJBV6JX+PYuYdYp5PtOHa0DBnf
	 e8kwHtNtizLiXdABT2xJslBmz1D38nYe7KNjMUmxc8zegzfURuBnt2WR/2gp/+e1E0
	 dAmaBxXJGPS57yiyxYrzEamf/hGcX53Lf83mX6quVEYmHDWD7W9XmHlVqt6lVgztxl
	 /T1xA8xJTgjyQ==
X-Pm-Submission-Id: 4jStkq4QFYz2ScWg
From: Michael McAllister <me@michaelmcallister.org>
To: markus.probst@posteo.de, luiz.dentz@gmail.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH v2] Bluetooth: hci_mrvl: Leave the serdev port lifetime to hci_serdev
Date: Mon, 16 Nov 2026 16:35:14 +0000
Message-ID: <179484691454.54083.14464729860702732145.marvell-serdev-v2@michaelmcallister.org>
In-Reply-To: <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
References: <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
 <179467295519.97469.5747232754111917783.marvell-serdev-v1-1@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

hci_uart_register_device_priv() opens the port before calling mrvl_open(),
so Marvell opens it twice. Likewise, mrvl_close() closes it before the
transport closes it again during unregister or registration error cleanup.

Remove the extra calls and let hci_serdev own the port lifetime. This also
avoids failing probe when serdev rejects a second open with -EALREADY.

Fixes: be70e5e774a6 ("Bluetooth: hci_mrvl: Add serdev support")
Reported-by: Markus Probst <markus.probst@posteo.de>
Closes: https://lore.kernel.org/341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de/
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Hi Markus,

This just drops the non-standard trailer that checkpatch flagged. No
code changes from v1; still looking for a test on Marvell hardware.

Thanks,
Michael

Changes in v2:
- Drop the Assisted-by trailer. AI assistance was used for v1.

 drivers/bluetooth/hci_mrvl.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index 5798a8db0..def19907c 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -57,7 +57,6 @@ struct hci_mrvl_pkt {
 static int mrvl_open(struct hci_uart *hu)
 {
 	struct mrvl_data *mrvl;
-	int ret;
 
 	BT_DBG("hu %p", hu);
 
@@ -75,17 +74,7 @@ static int mrvl_open(struct hci_uart *hu)
 
 	hu->priv = mrvl;
 
-	if (hu->serdev) {
-		ret = serdev_device_open(hu->serdev);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
-err:
-	kfree(mrvl);
-
-	return ret;
 }
 
 static int mrvl_close(struct hci_uart *hu)
@@ -94,9 +83,6 @@ static int mrvl_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
-	if (hu->serdev)
-		serdev_device_close(hu->serdev);
-
 	skb_queue_purge(&mrvl->txq);
 	skb_queue_purge(&mrvl->rawq);
 	kfree_skb(mrvl->rx_skb);
-- 
2.39.5

