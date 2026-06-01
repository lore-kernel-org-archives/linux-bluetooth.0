Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A21A6831
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 03:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284286; cv=none; b=Av6QIQqJGxqlDWvAW0qhQYXa1SDLiF0UcKY2u3ba7F03TOXpZxAFX/Yms+m3IH5/w6Jqy+3X7RykjDtMCrQsD9mJC6NN8ZKNg+LJyCfBfrgNirsULYdwfKg1Hy8shywiovPC5CGAwFe+OwcncVsizD2v8Lc6uD4iK1Z4y5CQzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284286; c=relaxed/simple;
	bh=c8OHIWdW5KtCDLu2gIdGYisjPKY2vYNoogHbTcvTRX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMVb474TSfVLGq/WstYXJ5AGZZv8eg0bOf7REPYsWh7QeiSPUPkYM4V7aHW2ZXDOpkfenveb0Gr+/F3hXpqy9nIje+nT1oGVzlMaE4dA+dEdx0xUYz7ArarcU8oH+kHENyJqkNhuF5QYgz6WWjN45MY5Lu48RRWGef0zR2MGa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKfYPlfN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKfYPlfN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36da8439078so576933a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 20:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780284284; x=1780889084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4dMC+pAKiTiksbUrTbV7Eqz26IiY/5xTAEwUgp8af8=;
        b=BKfYPlfNV308qE8RaPElB3aM+q/Ry/RKLvt+8H893dUmw07XCuL9jEASnJzKVNZEpp
         G9fZSR2aHNgetUQJUZACYKcTJiIr/Yw0odoki/kapO8O5xLU512i2URR2oDgFFF7THQj
         CK8dDp9as74AZ0sz1IiWJF7tHVwchq2BSyC0I/icIwU8p9q+X37SGk3qfpgsiKE4uTnQ
         LPs/7SOXTRniV8BKKIgxXXYXCwiFPAH86aTGvBmK1Q6cyQR6MnEGy/5CNwtZhNUOmv6K
         fcqgymQGSHsWo2wfxr+6HCGmWEwS7/G0Grq4Kybzjp0OFc2vNH3Uw5d31QQPh2iRAjiU
         oW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780284284; x=1780889084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4dMC+pAKiTiksbUrTbV7Eqz26IiY/5xTAEwUgp8af8=;
        b=OwsgM19Md4f8wsJNJ96m38wod1LuGfb+RQ/zYW77Sua+mNuHRDgCYvunH9rztG04bA
         udDgGN25L9r0LnZHCCGrMCLXVHDTcCJWHl48bWPdzWy0NsEZS3+EkvPf0ssTIyiZDtRT
         cP5Z+XLgi8e6vtG9rzLeQCLUMKdhV9/0Dvz5IsYp7UISX6wSnQuZ7SvjAV+YfpwPk1Rq
         J5oGIQ1QaspaqxoyKja2OrQUKvGpCJoSpMBHGTQG7cGAo5BRF8VOwECavYr4MAnej+oM
         FZzxmJ08GgaPzrjiEjLVrRkWxFkZUYghn6NDwxGGYtQ1b6HnBR6nvZ+wFUAJRYLUzFMW
         ycDg==
X-Gm-Message-State: AOJu0YyUvFGEw3Rn5ajUnZhU/O3mN+09sYA6ZvrFgIL5v1Ahlk4ROM9r
	nFvC+He0bPI2ZWx/JDhVDxiojajQK/XzUtNMEan5AsAjbMcN/4hvdw0M
X-Gm-Gg: Acq92OHYF4vEYZy+BgvCf2OA7iQiHwjfyfkaRwEiaLucpRF7pLbGsjuykVVP7V33hLU
	pOxrYAvG1ewosgV7Lj2xnCoAlAmxROIiW2hEcPSlhfYAnleRBa/7zD6xdmeHel2Wnr5+JUMa1G5
	Wzi2Zgb0brJB/w/vGVntsIoSF7CaMUENtJTh/F4aViz10ne+/WiKNQcVY9HyefkTisq/VevZEg5
	SOlZl/WwXFoRKk0acm28c5IIPCIPjyp51Sz+sJZ7DOzvxRcirMSgonTA52yd21aNCxdWaswLa7u
	GnTiZxeQZ9/4GZg9f9bE8VUrzot7y3xwEfPU5FvvYqgu4OhBQF/9bRKxn3FyAc5uxnsMuo09HOO
	JDsQAF75j/y8+phu3zGz5MG7RR54gEWLh5Y4raPF1YxQnie6xvFZ/qk9AUJ6xClE/4pT+37melL
	p9YGrXdGNvsFZKr8rJzRb/6pG5Pz4rCeFo5V0MO9di6sRoaGIWrd+uX60oABmOK7gn+qs6hgnRo
	myzh2Lyfq0JhH87ab5Kc+nN7WYnwA==
X-Received: by 2002:a17:90b:574e:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-36d635b9e97mr7101461a91.3.1780284284445;
        Sun, 31 May 2026 20:24:44 -0700 (PDT)
Received: from rustle-HP-Pavilion-Laptop-14-dv2xxx.. ([49.205.241.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36d654999a0sm6696674a91.0.2026.05.31.20.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 20:24:43 -0700 (PDT)
From: Bharath Reddy <kbreddy.rpbc@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Bharath Reddy <kbreddy.rpbc@gmail.com>,
	syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Subject: [PATCH v5] Bluetooth: fix memory leak in error path of hci_alloc_dev()
Date: Mon,  1 Jun 2026 08:54:26 +0530
Message-Id: <20260601032426.119034-1-kbreddy.rpbc@gmail.com>
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
Changes in v5:
 - Removed trailing whitespace in the version history to fix GitLint error

Changes in v4:
 - Included patch version history

Changes in v3:
 - Added missing curly braces to the if/else block in bt_host_release()
   to resolve a checkpatch.pl warning
 - Added Fixes and Closes tags

Changes in v2:
 - Fixed a NULL pointer dereference caused by v1
 - Moved cleanup_srcu_struct() to the fallback (unregistered) branch
   of bt_host_release() instead of unconditionally calling hci_release_dev()

Changes in v1:
- Initial patch (failed because it bypassed the HCI_UNREGISTER check)

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

