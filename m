Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C7187346
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791436692; cv=none; b=jkhA9PG2ydcrwRTg0thuZCyUVyloeD0ncfJR2DgTX1XmSDJCFdAkG0uJQ5Yb/uMR6EAcG53B+Vk2JuskDGsnou9dF81OhHahpM+gM3T2IF7QcZY+u7VBjPIQ1uOZzh/3oBJdM8FxZoAu0LqkVbas/DTJOMbiUZtkk+vVOj8g1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791436692; c=relaxed/simple;
	bh=K25jnv2p4L1k4pPo64hCRP+kpLFkxyB8fVdBs7e2h8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OuEroLhQv9+SppxsZYsqJZ2dCeQZbYkuvQNmaGhqIPvKpZ8wISFN31H6jd9XfjkxqZQSLqHolJzMPhJDB7Os3oLZwwLYQfSISXRatz6xb65+VEk+2IVwb+tiB3OJMvbk/EUJUzmtSpozxj/MbxA+pUA/XST9apTCjtWRYLEvkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCtPmrYC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCtPmrYC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db18e5cb56so22089535ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 22:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791436689; x=1792041489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DpTgnww+452bruhm0n4E4Dy06w8HMJjZi8g9dGEf8PM=;
        b=LCtPmrYCTZlh9YURxerZZV8fLpdYqv14BdBefV8iyP5XH2sRjImFEFWZthVyTy7D2i
         J3B+ene6l9qlwP0V5cpeS5DD6dMjfZRPtQuXOXcCt7RuTvIPBI+6FiLfpDUlduYTB2Bk
         KB9j3KHUed2zlaGLIOYMoRADkqOsz3LvBoBob1w5vWA8Z6nyOnECOi+4JPNlsGuqxuCm
         08BRrmMyRqATeFd2yXj+GaoN3oKyrNcouOdSUaYBbu50iEwcr+NUCTvlPx8wkVKgla6a
         td8G5b1O7tYKVHh+OGz6Xn6mwMxaQkCp/AXWfrtQzcWjP9wAcS+kx+8GQNt31HTc0n7t
         fclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791436689; x=1792041489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DpTgnww+452bruhm0n4E4Dy06w8HMJjZi8g9dGEf8PM=;
        b=mbKGeF6ZRXo32pv0MqY7u2g+PDTtTimEIsdqsoK2UD54hTXRiS8G6+KrNvmENk6uMe
         sFrq9qj8OflX/w6B7LTBL3RE4uzstPnI0b0bsiNHu1NdUK690Q+h3BVg+KhV8L9F89/Z
         RAZB1J1Q60vzl3vPQKTIFCIw+vCD46vRe9Rx9YBW25wQ56/9LHF9/2Rt5OptA3l/Hb+0
         cYpNlV5Gqtrn4XhMIb8N3AclySEeu+dtcyuAGGu+aJMZ1GzPRoKgmkVd9AQoeHU91u9Q
         ZpfXLr6PSnaw/mB43b64BlSXSv6yTWxVbnWuRShuJuXMz/kPX/c4ZTjgf/Yja8cOsRgR
         +lDg==
X-Gm-Message-State: AFq9FYKD0v6an8+CVe8Ha2q5LMMKLNLykHsspeq7gIZerffXB4/YbamE
	OL0XnsULV1H9RPAnRJy1d7PVeTaB5ou3kTxtURHFMIQ5cqzwRLp7gYb81XBGPw==
X-Gm-Gg: AYBFou1/afbi/c7dcUKILmKdMyvUXogrSNBqPQh0CwbdorN0s5gVO5/tKI1DpgVNUGb
	lSP3fo5mTuBiSbf2/M61hFK7C+w35tV7MbrGcyDHfoeCbAQLLW/u6DbCg/tTH/+OjneJ7lrAyFq
	trC9Y6MXJbLeoOot5O0En6TaRM0FJAFzChWD6Y8dxNOJ/CYxmbyGSEq8KEAhj0lX5F6Gis4Zes9
	Kv3wtm7rabNoMRapgpwKA38JzHcYTUZmjRCZM3wliPPrEuKFoyZErI819Z79NeIQKXxtLYSh0PY
	6b3jqFqVTVTWhzp5HQjo4cfwgxJsaH/kdWDgx7662CJUBNknCepHpYB+JjdR3nFdfxg+9MHiIA3
	XDJCgOd8EqDuburwTmrc7jJNekuUpC3EbWiPRCiWLVdgH2YZsJLVjW3WsVPV1FBYY8mNEdgmkKI
	HmaeUItZgYgD4475zfAFW6pYHko/vni/d/L7e6UTM7zhgmm7fdLC/kPvhjnGfA/H15yk0rbtJyR
	qvdTQ==
X-Received: by 2002:a17:90b:164d:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3ab04135113mr533585a91.41.1791436689169;
        Wed, 07 Oct 2026 22:18:09 -0700 (PDT)
Received: from dungbv.. ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a92d6161sm2349155a12.16.2026.10.07.22.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:18:08 -0700 (PDT)
From: Bui Viet Dung <dungvn2345@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bui Viet Dung <dungvn2345@gmail.com>
Subject: [PATCH] Bluetooth: selftest: Pin module for selftest debugfs file operations
Date: Thu,  8 Oct 2026 12:18:03 +0700
Message-ID: <20261008051803.526248-1-dungvn2345@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open debugfs file retains its file_operations pointer in the
debugfs proxy state. However, test_smp_fops in net/bluetooth/smp.c and
test_ecdh_fops in net/bluetooth/selftest.c have no .owner set to
THIS_MODULE.

As a result, full_proxy_open_regular() calls fops_get() which succeeds
without taking a reference to the bluetooth module. When CONFIG_BT=m
and selftests are enabled, a userspace process can open either
/sys/kernel/debug/bluetooth/selftest_smp or
/sys/kernel/debug/bluetooth/selftest_ecdh and keep the file descriptor
open while the module is unloaded (rmmod bluetooth).

When the userspace process subsequently closes the descriptor,
full_proxy_release() accesses the already unmapped file_operations
structure, triggering a kernel oops in full_proxy_release():

  BUG: unable to handle page fault for address: fffffbfff8056f03
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:full_proxy_release+0x8e/0x140
  Call Trace:
   <TASK>
   __fput+0x39f/0xa60
   fput_close_sync+0xff/0x200
   __x64_sys_close+0x8c/0xf0
   do_syscall_64+0x115/0x6a0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

The issue was discovered via manual code audit of net/bluetooth/smp.c
and net/bluetooth/selftest.c.

Set .owner = THIS_MODULE on test_smp_fops and test_ecdh_fops so that
debugfs keeps the module pinned until the file descriptors are closed.

Fixes: 64dd374eac15 ("Bluetooth: Export SMP selftest result in debugfs")
Fixes: 6de50f9fdb60 ("Bluetooth: Export ECDH selftest result in debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>
---
 net/bluetooth/selftest.c | 1 +
 net/bluetooth/smp.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index ae5b44bb9d3d..cdfc40e0016b 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -188,6 +188,7 @@ static ssize_t test_ecdh_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations test_ecdh_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= test_ecdh_read,
 	.llseek		= default_llseek,
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2df303f6a38f..81d255525fe0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3696,6 +3696,7 @@ static ssize_t test_smp_read(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations test_smp_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= test_smp_read,
 	.llseek		= default_llseek,
-- 
2.43.0

