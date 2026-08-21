Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43382AD16
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334240; cv=none; b=sRA0w88p7PLHrormXFrS4Sv/2N1y0D9EMW9xVejoeEly+TKTCPUi5hOS5UlgoPahEabmo0vAKlbE5pe9dx7Ngi9E7I82/CkLMZYycjCBo7nuRrnWNMq2w/rNb9mSQWmIMqR19kdFcDLZ5tp6y1VdI24o3suu07uTEqUIqHqHyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334240; c=relaxed/simple;
	bh=1YsJ7ksa1YipJTG/qy+dRbYTRJMnqobsZQmDtSFI+yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NA/sB+uN4nBLy0A02PMdT95ygGlbZLQ0MTi9dPabN/HTV7wWqo0FrXn1JQ45QNq8dIwbTewIlXyuTYrWXeKsMq5a8K8rYm2HTUa7LO0x8ZgqGUVt9kTTiEH6LUd7pYvG1zJIH8yLfahYQO6KrIwqJIOSrzpuzbahcqSA02H+l4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXO7T0Kn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXO7T0Kn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d590f4c291so2252405ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334238; x=1787939038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d4XPHY3EdrQhoSP9Mewu3YMM7UcphGVKy0m9IRB6RUo=;
        b=sXO7T0Knu28AgXThpZdYuYdvi8Sj8heeNFIjiio/Jv7edUKMGlc7KZVGDoqTITPcQI
         8YSALPuq/o2rpzVUpFw73XmbImUJnGTk80mYV3/c09oDf/2HAmKk3u+/EFDOfAR/jkTP
         3nG5IC6DC20cV8PfWmFBo9NDmqabONS161ps62TMvZzw8qBII9XlJIRcGnlKWGkNqGMQ
         Zvbira4PD8fROC0eBp+mb6PvG+Y86r2vQKUqjZf6sFNAqcXuiZ5hCYoz3hulcCoJuPza
         NWmwUdYfeEGnSwjuol2K/xjtEz+o7cskAV6XLfkoQFBzmX4MPyYYJyo1N+DsjmEF+4Xi
         seDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334238; x=1787939038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d4XPHY3EdrQhoSP9Mewu3YMM7UcphGVKy0m9IRB6RUo=;
        b=iO/Yxg03/7VWetgB7msV/FFe+GW+Qtm2ycY1ATQHHns38jHMXj+6eMMThxtiYtBrOU
         cdueF7VW+KwcbRn/J/yFYZ2fUkxYrTu/cHBO+G1yK/vkTBlC5YvdATZQrbChLNv9Pigp
         udqwD/m7D7fHdEz+CvANZHlX3wp6vtjiysQZToJ6Ur5BZtx+bNPln4sCUnUhZ8oV6YR+
         V+/cZf/hT4cXvNmNXWZ8ZlQt0gRsXqANEcowcNeneDSwd2Ug6Hj11C44kHRSLGrSm2yI
         5PfvZTz6prAxRSlQrWKE6aQ8fJPm9KP9CaDZQ3wk2yCNLyOjGOLpnZGROrtdqmRY/p5E
         ZGMQ==
X-Gm-Message-State: AFuF++mEyl39bs4kZY5rkA9JlpJJPhdWhV2KqvBwEYhqp0PIvRXwY3s4
	jeK39wyaZp31bVyrLpYOlKu98Xi7eWsIDO97grLgOj8PI+BsxwO/oEeC
X-Gm-Gg: AR+sD10EEB9Exx18x4faEGtRdUkC0TRvVXDw1K6S3mbCBykvFNfo5lJ7+yDqkyLkoi+
	vII1lxLbTyuNE02aVJn0rvQ9x7nWt3vJLPXiO3jraUbALR+4oZQSjYeImC9kWbHndC9eTW3jn+J
	ZMpZcjmraRxLDUKiXWBH3T2MAzp3MlLoFR6w3V9o92RVd/THp3pJsbt6QLjT6s9MBh/o+7+eXn1
	kQwY5z0PS552z3PI7aFH8wv0FG4qlwDOHEBVb+bjA3PbVdgPwr1umOsJ+o2BvZEsv5KNupsAdqY
	I1jQO0p3hb/BzI7SEJ1xeBmZnNEr+KPMK9SvUHe4Pl+LTHzd40af6U0waz6P3u2tqQGvuu4jGm7
	HwYlnZuhLhshd0ipTYsqjB3M5+hpKUCmEbxAELypprFitXU5nZZn2eI6j/VmSZNDCoLgbnDbwQG
	ldeeJXdHHZ2t0x1MTb3hGGRZ1IHP8tb/DnbBYZW2asuAr3mE/6Ls/l1wgWyQ66HZqUfLVhaEW9k
	hFXYTg82GY/k+oRKYPmfOfGRXdQlvmKpaoTlJm9O9Ty6OJQsGJC7iwOqWpuZhTJaw==
X-Received: by 2002:a17:903:120b:b0:2c9:8287:fd0d with SMTP id d9443c01a7336-2d64b049900mr72346765ad.3.1787334238059;
        Fri, 21 Aug 2026 10:43:58 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm26039466eec.3.2026.08.21.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:43:57 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Serialize local codec list cleanup
Date: Sat, 22 Aug 2026 01:43:50 +0800
Message-ID: <20260821174350.3034506-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_dev_close_sync() clears hdev->local_codecs after releasing hdev->lock.
Codec list additions and both traversals in sco_sock_getsockopt() use that
lock, but the close path does not. A close and BT_CODEC query can therefore
interleave as follows:

  hci_dev_close_sync()          sco_sock_getsockopt()
                                hci_dev_lock()
                                fetch codec entry
  hci_codec_list_clear()
    kfree(entry)
                                read entry->id

The reader then accesses an entry which the close path has freed. KASAN
reported:

  BUG: KASAN: slab-use-after-free in sco_sock_getsockopt+0xfa0/0xfe0
  Read of size 1 at addr ffff8881001c3450
  Call Trace:
   sco_sock_getsockopt+0xfa0/0xfe0
   do_sock_getsockopt+0x537/0x7b0
   __sys_getsockopt+0xf2/0x170
  Allocated by task 92:
   hci_codec_list_add.isra.0+0x2c/0x440
   hci_read_codec_capabilities+0x224/0x590
   hci_read_supported_codecs+0x2c2/0x640
  Freed by task 92:
   kfree+0x131/0x3c0
   hci_codec_list_clear+0xd8/0x160
   hci_dev_close_sync+0x92a/0xfa0

Take hdev->lock around the clear operation at its existing point in the
close path. This makes the clear wait for active readers and prevents a new
traversal until the list is empty without changing teardown ordering.

Fixes: b938790e7054 ("Bluetooth: hci_codec: Fix leaking content of local_codecs")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_sync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b5897545d795..da748e14e5f3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5648,7 +5648,9 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
+	hci_dev_lock(hdev);
 	hci_codec_list_clear(&hdev->local_codecs);
+	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
 	return err;
-- 
2.43.0

