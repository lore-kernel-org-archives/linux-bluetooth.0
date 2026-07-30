Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8438356755
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376657; cv=none; b=LFO7kGVW6KKLJ6XPcxjTcZVnWDZkYbgBH+/Y9g6mu6G7G0y3dgpXK2IJkVhpcLYYU00mKfvhIf6CqvRMrPg4K0NH0QwXxNcGE2us8pXNF9cE6geKoeYVbYElgEfkWVzg9qGQJFIZmGhOnbqG7RoGmotyu6daSigECjvSeRFZkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376657; c=relaxed/simple;
	bh=Ct8MfeV31xOtWhmPuTKVZE9NC9CbdhP2uRpqj91BgLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHePDQpEL4RICX9wScsfz7yUgYD00KjS8eOdCJhaQkMmiiT4mK1egSNzqJaZphJ+CUv+eKn0QZJ4VO0cMXbscFYrbKrdGzdq/kV1WAJzbYmZFFFSoHtBSqHR1+8Q8NIxNEj4RAp3pzufNOEzlpKWhqPs2i52Fvc8uF30X0drsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQc2WCq7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQc2WCq7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1378746a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785376655; x=1785981455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNWLepsnEnVO3PpkI3NsSJdXHfAFdVecGNbn3wVErdw=;
        b=CQc2WCq7q8rNUJ5kk+z0WxWxBtkVUePXL0Pah74jQN78aZ16SOV2sjthTtI4GReiuG
         KKg1UR3/cX9YiIv1zgRWdEjBpyDgkEP3FrbTHqJy5lQvIy81INerzx77EKHnbYhUiCkv
         QEKtO8xcP/ApK4FomEI1wRG6JFcS/3qLuQP+H4a1RraPnJ3Gf15WC4Ht7qgWzbOAP3Ag
         YXx/8IzfuQh8cYXhUwr6NFojyowygRWomAYBaRrwMLDTx9C1PFAJwLydht3o2vpS5uM0
         Jy9P0vwPjlt3+fzdUZFQpeQdlBygAP47zEHpzJNfeuK8lBUtvPVc3CM+mkzzQg/YHtZZ
         YMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785376655; x=1785981455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xNWLepsnEnVO3PpkI3NsSJdXHfAFdVecGNbn3wVErdw=;
        b=k/VX1YEaCDMt5ZRHiJ+/oW3iP85AJBDpubF1zHlpqtyWwr+CkEZth23AZLvz3Uk4Jy
         /pdPlP0hO/F9BmihM44cEC8abW1sjKFH3/Ng5Q06M/6hioXG01QYy34uxXQisri/1i1/
         /uDkKfD7JowgUhM71Cxoui00DI2OpKEzPK4ABaMJ+p3Xb5bNnG5MHwOznM0Z3Zb1a35C
         YqA4XB/P5sfmn2YjMWrxmnPLEmmp52x4QGDKZP6L5jjo66OQKP4Iq+uA/HZDZchNqDwo
         /YAYk4Xhb2m+WAdR8+Nv1NcTxCRVCxfAsym8csU+4rfBRdP/Qk72E5oj77d9HxD6wxy8
         OpnA==
X-Gm-Message-State: AOJu0YzwwWuymBXlVayzQ93WXciSLO8Hq7HYf4qeg3mBOiX+HsNaVCYE
	aev0i7NW8s8lOx5wBYAuR82EncX5jj6CLfngRCL+B41gxDeS4W+E+MxU
X-Gm-Gg: AR+sD11IdHKGMqzNxXGdOLYoZUcV7bFVhvXH5wyUJ6CyYdAyqfQ3bH5S6gRLGxl132J
	W9ZRihgSFUH7gZYd5Y8oJjtZE6f5ZVtdgzGmGAR7wGacZJgNbR5EcSw3RWtUCmKZ6jj1YO5cFKE
	H4T8wm4w6j4gPt4YzVKPK7CSy0Z41KG6ZDExPOqkF4eSCRzS+qcQ0fg/kYqIrIbJGX6LN+k2NK/
	rs9BDV5siYvze7mxr7geQ8GYI+z2CuCtvjNbbXRgIiwO+296WHvwd2fIx0+RbL+LRJw9eH0Wsbq
	9mCOO0UBSfOoP/dHCiVCG64Y17c4neHx40PA12mVxPYbEJceMpRDhbo5fkfWnJc5tbczqny7JES
	Htb0mVPALgiC4qiak+SlDuPVVKGTn3Oc98CI3oPbVO9lEr6d1zm1CRR3v92EphohjY9VVjzOrq2
	DdBW1TwkxxSRPRVnWEnEi84xGZsqpB6n+FxuV/F65BzoH6GDMY/fUm/9Ie6bWY+AFi8o39nAwjB
	a7CazZZsI2I8soSgvX0/lshyhqUZpLRaX6a+7VVmKbQqbS/H4JGSg==
X-Received: by 2002:a17:90b:2785:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-38f9bd80dcbmr705590a91.15.1785376655014;
        Wed, 29 Jul 2026 18:57:35 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b4a8a28sm198066a91.8.2026.07.29.18.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 18:57:34 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH v2] Bluetooth: virtio_bt: avoid OOB read of build info string
Date: Thu, 30 Jul 2026 10:57:28 +0900
Message-ID: <20260730015728.2798952-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715121628.1590321-1-sammiee5311@gmail.com>
References: <20260715121628.1590321-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtbt_setup_zephyr() sends the Zephyr vendor command 0xfc08 (Read
Build Information) and hands the response to bt_dev_info() and
hci_set_fw_info() as a "%s" string starting at skb->data + 1, without
checking the length. A backend that answers with status only leaves that
pointer past the end of the received data, so the walk reads adjacent
slab memory until it meets a NUL. Those bytes reach the kernel log and
the firmware-info debugfs file.

To fix this, print the string with a bounded "%.*s" limited to
skb->len - 1. A short or unterminated response then prints as much as
arrived instead of failing setup.

This mirrors commit dd068ef04412 ("Bluetooth: bpa10x: avoid OOB read of
revision string in bpa10x_setup()"), which fixed the identical pattern.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
v2: shortened the subject to fit the list's 80-character limit
    tightened the message

v1: https://lore.kernel.org/linux-bluetooth/20260715121628.1590321-1-sammiee5311@gmail.com/

 drivers/bluetooth/virtio_bt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..c20d54088c8c 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -120,9 +120,13 @@ static int virtbt_setup_zephyr(struct hci_dev *hdev)
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
+	/* Bounded print: the backend controls skb->len. */
+	if (skb->len > 1) {
+		int len = skb->len - 1;
 
-	hci_set_fw_info(hdev, "%s", skb->data + 1);
+		bt_dev_info(hdev, "%.*s", len, (char *)(skb->data + 1));
+		hci_set_fw_info(hdev, "%.*s", len, skb->data + 1);
+	}
 
 	kfree_skb(skb);
 	return 0;
-- 
2.43.0

