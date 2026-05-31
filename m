Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1E34DCE3
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251186; cv=none; b=ByVLLJr2/LF4BAAg14QHxOGZty7Bu4X9vS7yMtigwD/Dfs3F4QmIgI+gQ2WAkPTJ2ZBaZNvie/Ztc+lx6qL11O0EQtwj4aQJ9lTnfDwspvanwI1iEYNFbbUKF+vr1i+ObRgK7L+fuo+wq15WP6D43POJlBilmarDfMTWuPUJyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251186; c=relaxed/simple;
	bh=41lcXDK3u0Fs7rJePyR/4+UxqWAqtTx1zyL031IDj7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gSnqXQXWIitAEl196hfBQ10CRhCfLrzWeXD2WFFUkggLQjtLxhWeuEflj5WTXl+lr3RsRV+UtHAy9laJ67BwZlDNWTGe6ff+hicPS7l5HZF4IL9pXMblkphDv0krWO6SR1KsRg/ViseIbGBQm5iN1GCoACqQ03bs+x/AXCE2VVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrhJQ5j+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrhJQ5j+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c3543590so3695485ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780251184; x=1780855984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqKS7J7jIzI3/kIylXsI0Us8WHcLqW9oZuoMrN6OAq0=;
        b=qrhJQ5j+9tPeBXQCZfQNKy1Fr0PUO05/WekRl9Ov55xxqlhYg/J9st9qfFFzL86KTm
         yIP+9qLbkjVY76UNuqB0ami7FXgP0Oa6jVu0+QCUsiJ3i+/TeP1yX62lADT9DWUTrZQN
         YPeKPEu6d3gWUsEr7T+jw/p7LrWgViTDaTbkFFs6ma3UBmnB2QpBb4rghQ012usr8NkZ
         mHJ2lFvwrzsP4nBAVNhaBDOp0jOr63OdAFSjU1GUjIqGT67cvl7mqaK7OkJkTr4WqWjN
         /q6x/8LJ7mzGSM0nWZVfh9dBWwxpMem1KKkB7stoZj55WXFGJPuXOTelWy4bgXYKi6zb
         WldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780251184; x=1780855984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqKS7J7jIzI3/kIylXsI0Us8WHcLqW9oZuoMrN6OAq0=;
        b=eEfff5hO0KK21bN8a63uNkeerf2PRKmMzAix7c+6lk774bRxDwE1as+SX8OsTNRu0/
         gJG/e6wBLl1T9oy6BcsyWFCF0gs2vqXDHfy67LB5ZwUTyKtB32ppgRlkSbs6n6l5qJX1
         3pe0WASTb/CLFxSbfPdpqIpaTRM175fLBI/SW84qNZEJo3+Lh3Z7u1Lmw8hAuIR45lAn
         P32UX8/gZSgdhB65iPtMrBNF4gZjSLkkCOEZfS4moXLppvgLosTIVRifaXOJ24ivrdcG
         C281eu1AOy3odaJETEuFC3NXMYeZ8PRzZCL9qi0oa9Im+uU9eTki6RFkhEKBtD1FBx5k
         ATUQ==
X-Gm-Message-State: AOJu0Yzq/XFtf1IC8wYvy/TNxpP5Khf8Zt6VPJh+bF2Vu80opZKw9GOU
	NxWrY4u5LC1Z3Bx7asmjKXD/U4lI89+YmgAcwYd8eIHuw9DUJgPL4Khw
X-Gm-Gg: Acq92OGTWRTGXgyYyOxP1yVJq/7pfhFgSKiCoGcYdneR6p+g4YbIVuv5UOI2Kw/Wl7h
	2Vgg0P9wFI4IqMkXiBzVYcOp3zYi6LwHlyOsQHgsLw601iAzon64lbmT2hPb238uaPeK5EDPTrl
	PF9k4mxWshJKL955l3iQNMQDd8miHX0P0gGt949wMXvKqetS36KaClxiXfiIIuEs/Qa+1x7T0EN
	kf0qegRPXQXWIUCdEv8HEChvWjJUIedYoBu0U79782++AuYb3aUhHTvIlyfNFybODW8330Wdl3s
	fF6h63QKqKYl825v4P34IP5QlgdaeDm6E0EokxubXYx4yi8mjWUCMorH4MxurwgZgesanhd00/S
	9y7ctLjV3FuNJG4BWILZONchq+dLpBqZizcROSVmTT6X8cj6ezBdSpLlq/kVV89Wy6YaC05UN5G
	s1esaAe5X3mn+5X1FMzJXMJMuBk060auYkuYi1qvorrUPPGioBo84gRn5ebmFyJzABB7b56lXQg
	05HrPDSDiT9/p4KMQMbLtqf7J8CF1ypCItbdsTk
X-Received: by 2002:a17:903:3d0b:b0:2c0:a9b3:bdc6 with SMTP id d9443c01a7336-2c0a9b3bf60mr62784395ad.30.1780251184248;
        Sun, 31 May 2026 11:13:04 -0700 (PDT)
Received: from rustle-HP-Pavilion-Laptop-14-dv2xxx.. ([49.205.241.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23915adcsm78099575ad.0.2026.05.31.11.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:13:03 -0700 (PDT)
From: Bharath Reddy <kbreddy.rpbc@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Bharath Reddy <kbreddy.rpbc@gmail.com>,
	syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Subject: [PATCH v3] Bluetooth: fix memory leak in error path of hci_alloc_dev()
Date: Sun, 31 May 2026 23:42:41 +0530
Message-Id: <20260531181241.105655-1-kbreddy.rpbc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Early failures in Bluetooth HCI UART configuration leak SRCU percpu
memory.

When device initialization fails before hci_register_dev() completes,
the HCI_UNREGISTER flag is never set. As a result, when the device
reference count reaches zero, bt_host_release() evaluates this flag as
false and falls back to a direct kfree(hdev).

Because hci_release_dev() is bypassed, the SRCU struct initialized
early in hci_alloc_dev() is never cleaned up, resulting in a leak of
percpu memory.

Fix the leak by explicitly calling cleanup_srcu_struct() in the
fallback (unregistered) branch of bt_host_release() before freeing
the device.

Reported-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=535ecc844591e50588a5
Tested-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Fixes: 1d6123102e9f ("Bluetooth: hci_core: Fix use-after-free in vhci_flush()")
Signed-off-by: Bharath Reddy <kbreddy.rpbc@gmail.com>
---
 net/bluetooth/hci_sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..8957ce7c21b7 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -83,10 +83,12 @@ static void bt_host_release(struct device *dev)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		hci_release_dev(hdev);
-	else
+	} else {
+		cleanup_srcu_struct(&hdev->srcu);
 		kfree(hdev);
+	}
 	module_put(THIS_MODULE);
 }
 
-- 
2.34.1

