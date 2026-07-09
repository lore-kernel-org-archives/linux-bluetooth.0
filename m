Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6C439344
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578178; cv=none; b=SyQzsJPX5jx+Bx2FF/t539NSA5ZVGjtjmSnVy6P2FAKHI+/doMa+7OJZpUPeG/dsT2bbOUH5DT73PumeS9UVy0f+NLOpjFUDFlBD+/Gb9fPkRXDPa9xKT+qldXHHCXuId5D2TeKwrYijXivuCGNypcrnumP+ETbOqVsAsXXt42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578178; c=relaxed/simple;
	bh=wuSlAl66usvu0PLcpR4fJ5qbWuXweuGPE9gIWrR8Xw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JATbT5mgjYEKF0EwSj8v22iOm+uYrojoETsWByet/XG5H9T4VbF4DJILOtqDDtKykbDfYbgpvI7fIrC94ZLXT08hUyPDYM85Gcqfq3sARv2vfYeIrV3OULo6+W7Jkxpou5wn1sqlx9KHcp/3ATA+zFUmlKwiT8zL3h3xtuKFDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzX+4NxR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzX+4NxR"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1225786a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783578176; x=1784182976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/p//Mh6rAQJnJjEivwgC/TetVxw3EfDCqsDUKKx0Uo=;
        b=XzX+4NxRMlCmYIgkgqxf+85eSGYSHHWcedEH5FHR9TTHd5k1hWfJtbUtDRMYXH4D0r
         Ae33hZvF989c+8jinJuu2nPFKwY0TSH10DJOKeiSGkngWQ2jo9/KTwaEOYyFeMBEJp5S
         xqkQ10gbsw0ztJP/GFR83jf6cunyQLsQwu+bhSF896qFD2DxlKWhoDrRnmS1Iyu9mRjk
         Wf56y9mYEYl5VhVvWji9QqYXXhjhOfHqkgOi3n6lugQgu7hqhT4fHZhe9WiMIoE88wBT
         Ap3BW217zD8H3ZokiIwCjxRseotWqfJSz7fJRhOHmbGM1VFK6sk1pRszltTHqWjE9DGi
         ayDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578176; x=1784182976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/p//Mh6rAQJnJjEivwgC/TetVxw3EfDCqsDUKKx0Uo=;
        b=UErUrHcbNlVgrESmw9GD7ohebNR1vYFfy3K/P0qP445cQvaP6+HJYJ1He/z5LKMMhO
         cIPG6y7ddIBugUUARWFxDvJdXFlMpg2R/u77jlCntGzTl4B5/DZzKW6QigNBL64Ym2C6
         JeHmdKiVbK8SZ/9KRuvcIRiiQj0zbpNJSLyZ7QsnbhuBhQ/5vAAs3fzCFywGm4pDgI/o
         0yb/iAXI20J3skbthK1Y92agkiOh7DzPTHum6VK4jsqMtzxD8RS2ObvhhAExJmgJG82X
         IBzJeBNhO9UGTiakEP2EWVBuy1cYPkYO9858rtIgpj73gZQgXScJZGIQlRgIzCK1OtSz
         8B2w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6f0zz5+lfLbQEo3fnLIEfpdR+cUipiJiYlO1zrdnPcZ07euz53/MYYsmZqg18+Q6gcCWq0qSUlxArMgdnllM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgf19ONNeFZqkOzFQYhMdwm98LBusBqJ/yy3i5KtVXZJ+PAnj
	cimwF6MiZIcPjrKH66X8zkee7b1hXqigNxFf1NsxAQyYzpvBQrtVUE/z
X-Gm-Gg: AfdE7cmlTq4sZ6RrZQdGpJIVEZa3IIGObkLFFSqBlZ7+K+d3qGKd0mHEE27qAat+AFv
	higvKNs+CjylQGRz1qytPgDgfLB3J4z1pV3CZmMZJza2qugNyPnky3ETyJCYDzuptrmfne4LF7k
	hOdCKTwBk0Xyf0xzFn0/Zd4iplXeUiYA5hO01k5+Ibo/4fpEtvumn08AIIYKIc0Bt7y2eS7RUz4
	bf32vXXTSmJEKj/gSYXiZAIHebN/gIJRisCYGaOa0/NOLtQdiA++hp/VwNegxO7tEwMTAlpJHlM
	0/Pm7L1Otuy96fl/nTBoxNwT1IxN3jVNz6xuKS0+QGJWdcVuPK5od/9R9dhJ/fIl8phbN8vcmqo
	PNpzGP6cQnaLGYDzEfco887NL0P0yUknFbZgppjOOCmDSqu1iVIod3Vb2s1781IL2MhT/xIU52P
	FLfKaqs0kQ8NybRXSAe2NQS/ip8vyJaz1D
X-Received: by 2002:a17:90b:4c41:b0:387:e0bb:5801 with SMTP id 98e67ed59e1d1-3894278d1d9mr6359228a91.40.1783578176229;
        Wed, 08 Jul 2026 23:22:56 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:ea9b:46f2:6d0c:46c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5564f58csm620730a91.8.2026.07.08.23.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:22:55 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] Bluetooth: hci_qca: Clear memdump state on invalid dump size
Date: Thu,  9 Jul 2026 14:22:50 +0800
Message-ID: <20260709062250.4166128-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qca_controller_memdump() allocates qca->qca_memdump before processing
the first dump packet. For a sequence-zero packet it then disables IBS,
marks memdump collection active, and reads the advertised dump size.

If the controller reports a zero dump size, the error path frees the
local qca_memdump object and returns without clearing qca->qca_memdump
or undoing the collection state. A later memdump work item initializes
its local pointer from qca->qca_memdump and skips allocation when that
pointer is non-NULL, so it can operate on freed memory. The stale
collection and IBS-disabled flags can also leave waiters or later
transmit handling blocked behind an aborted dump.

Clear the saved pointer and memdump state before returning from the
invalid-size path, matching the cleanup used when hci_devcd_init() fails.

A static analysis checker reported the stale memdump state, and manual
source review confirmed the invalid-size failure path.

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b2d1ee3a3d115..1222f97800f4a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1087,6 +1087,10 @@ static void qca_controller_memdump(struct work_struct *work)
 			if (!(qca_memdump->ram_dump_size)) {
 				bt_dev_err(hu->hdev, "Rx invalid memdump size");
 				kfree(qca_memdump);
+				qca->qca_memdump = NULL;
+				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
+				clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				clear_bit(QCA_IBS_DISABLED, &qca->flags);
 				kfree_skb(skb);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
-- 
2.51.0

