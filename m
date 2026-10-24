Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792821823;
	b=wHPpAps+ac207QwwuMRPtTimNH1LraU6n6spKghZTB3rKggcbq+nqnzsXAl26Ws74uJj
	 PY4jKVazR9N4E1IkErcbPsZJw/oybe4SNuvCiSHE+1NbKVkZGo4FDa5EZeEARUCGL8nwW
	 jISgLlMAT/d9MoWdNofDEx3O8wjiLiO09RVFp1IGpost8Ce6ntdoKlVBowp13zSzXQDUE
	 sEfJad9jSCLTURPJIfeo+5XW+0RYasamdjk9ZspuLmNo4Yw9pqkeG6TgqYzeSiSNukTyA
	 q0loTtz64D2YtX8jguOttzDy/WreyCmvvC7hUikkLHtPf2QAmiL9ozVfd3W4k77O0DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792821823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=synWqYbmp4TKDqP3tt+5+3H7Yv3rlDcxUAHgND7ZObE=;
	b=r/K4ARlZDC/fjOaltNuQeRxwHTregVmst3bJ4hKMqjGMFs+jwi27BqK1G054KKDh5hrq
	 dompeiSwHmjK+kGIDsSFHOIdXA461WaFq06P290GSbswr1gHAEMUjFY3og4RdTW0+tE1a
	 oDG0ACPsn6g1+rIT62PfgC++75PTPGlqQbIWZVLMe5li/oJX2RtVZ2CX1x5bEY8rxHnBd
	 yaaKNCAFFKCQ2AQhtudlrYqHlbojeCSqvvzlvPgJhRgdAbIYteSfRHIhSl2TCTE7V7p25
	 7NzLi6o3mpxhX04c438nwpn9KyRyda3q3J2IIdDjNK8W5q6UVuN/DuTqv6jXM9pEing==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NS9s0YHL;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DC606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 06:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D74DC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NS9s0YHL
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso877321a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 23:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792821822; x=1793426622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=synWqYbmp4TKDqP3tt+5+3H7Yv3rlDcxUAHgND7ZObE=;
        b=NS9s0YHLEKDzxHQNG8GHrW2G4rAOvB/28sje2wIMzZaZkOpOBIv/eWcH3e/chqKhyf
         4KBQ4gdD3eo1JBwX2a5pLI7US07RUWHN1jkY/OJWd6gby7Nh2oLopKIR1kLhm93xAoD7
         mCGYBckEahJiX8edFjwimSM9AdiASHdV+4yclpHRTQdTffrnKhsl57fBn2Lm7xO/sIYo
         5imsdmYG3gp09rQYdC88AQX2dezzf6Ek126++SHEVFttBM0hKHq2HngVdFQTJZQ8u8Ni
         4KDcQRbm28CGReSZpD0/i05TbTmPWyXRS1vCiMRIT0kAbZeVhOpmHwsUVl3OvjZtROkl
         tqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792821822; x=1793426622;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=synWqYbmp4TKDqP3tt+5+3H7Yv3rlDcxUAHgND7ZObE=;
        b=vvYiUGlm1L9XZ1ZiSxnUQzEUv7kS61mMD06IKoTM6g50lvtDtpwbK6WhNT3jH1n2Md
         vzbgWNhSQ08cE5Ly5l50SkGe10ohwAIzRtskRARR3tfVqSGSXFGf0SvlyyPG9tvskQ8P
         Ut4NJrV3sRaxd+nWbaZVefuh/hiuuMXxr8aw1P/i6Nyg8ZdAiH/qtI6sN1Lqr8CSw7gl
         sL9Zi0AyEqETctNfQk8Y57dbd14x6Decow/PDgwmMg2pBygS+KqFTm1XAeyAXjbgOxBc
         s9kyy74u0GtEPS+Lmyy/agvq5te0UOn+TDiUXhShJ1LEjH3UpSn2d6tDetQX18Z/D9KT
         8lqg==
X-Gm-Message-State: AFq9FYIKE75CQf1DrlYntldIMYa/EHsENSNhV0GfgeD3EHFOZ8I+RZJq
	4ozmr6NW9GouB40Lu8WTRZHHTO5bw2J0RttWLYxlBhyRZNuJsDNqe4JKfwSUvHna
X-Gm-Gg: AYBFou1zrI8Go7DHLJnhjMl5/+jIjnmqF9D9XEdNGY6aYci99TaJRC6G8rtbZXfw5Kh
	hKDkdRjGwClxvWgieJ9Nju6mSPLXZbT7RFFS8mJYy1p8nXjGMiUQkPKVz7FlO1YdhMP/MhbriPQ
	hyzSifJKdNakc3ZLpOYM2oVI5E1BXSbBwDHrFFxfi6If7dL3WOSv6R8Tqz8vaoDMUY4FhnPwnBQ
	xy6nsTFgrIoP3weAPLnnw78YzvjQLeNsLFDmMwD3GdCKP8Wgckmn52mgIeEaRld5/yxXOdMKbz2
	LUd5MinYToE92uT0jTzX3rpZfQOeWC5vUxEwn63ZQQh6NKKELBpEx2PmruEGLCZKkwqe/gpf3Fd
	kEFgHodXCzyHx6OvmmizbFCcZHq77XJqEE7EEF9z+Jj4kqt0t69UwQ9B5TgNITqNXbQ7i1sAwOV
	HhG5scBv9+IkJDi+dYtTFmr76OwGSW886BxdH/FrOmevHmFXvPja/nyBVKGr8C0xoidmOb+ukzX
	wQ9vE4m3PzOVR80e5xxJZE+sb5ZbYpoSpiVxcUOsf9KZQFao2o=
X-Received: by 2002:a17:90b:2d45:b0:3ac:9259:122c with SMTP id 98e67ed59e1d1-3adeae6d89dmr1071274a91.40.1792821822050;
        Fri, 23 Oct 2026 23:03:42 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebae0094sm1664019a91.10.2026.10.23.23.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:03:41 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3] Bluetooth: Create debugfs directory before running selftests
Date: Sat, 24 Oct 2026 14:03:35 +0800
Message-Id: <pm-bluetooth-objects-candidate-0188-v11-36d2c5e734fec40a3363@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Selftest debugfs files must be removed before the module storage
containing their file operations is freed. With CONFIG_BT=m, bt_init()
calls bt_selftest() before creating bt_debugfs. test_ecdh() and
run_selftests() therefore pass a NULL parent to debugfs_create_file(),
publishing selftest_ecdh and selftest_smp at debugfs root. bt_exit()
removes only the bluetooth directory, leaving these files behind.

Commit 64aabf94ecccb ("Bluetooth: selftest: Pin module for selftest debugfs
file operations") already gives both tables a module owner in
bluetooth-next. With debugfs and either selftest enabled, unloading
Bluetooth without any open descriptors still leaves the root entries
pointing at the old module. A later open permits the following ordering:

    Module init/unload                Reader
    bt_init()
      bt_selftest()
        publish selftest files at root
      create bluetooth directory
    bt_exit()
      remove bluetooth directory
    free_module()
                                      open root selftest file
                                        full_proxy_open_regular()
                                          __debugfs_file_get()
                                            read real_fops members

Here free_module() completes before the reader opens the file. Debugfs
active-user tracking still permits access because the root entry was
never removed. The open reads freed file operations before it can acquire
the owner reference, which can cause a kernel fault.

Create bt_debugfs before running the selftests so their result files are
covered by the existing recursive cleanup on initialization failure and
module exit. On selftest failure, jump directly to the directory cleanup
without running cleanup for subsystems that have not been initialized.
Removing the result files revokes new opens and drains active operations
before module storage is freed.

Before the selftest file operations gained module owners, reading a held
root ECDH descriptor after unload produced the Oops below. The owner
reference closes that held-descriptor window; removing the root entries
also closes the remaining post-unload open window.

Oops report as below (preceding and following console output omitted):

    BUG: unable to handle page fault for address: fffffbfff805758f
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 1a7ff6067 P4D 1a7ff6067 PUD 1a7ff2067 PMD 100ad6067 PTE 0
    Oops: Oops: 0000 [#1] SMP KASAN NOPTI
    CPU: 3 UID: 0 PID: 424 Comm: cat Not tainted
    7.2.0-rc6-pmb-bt-functional-v1+ #2 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
    1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    RIP: 0010:full_proxy_read+0x103/0x180
    Code: fc ff df 48 c1 e9 03 80 3c 01 00 0f 85 82 00 00 00 48 b8 00 00 00
    00 00 fc ff df 49 8b 5d 00 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02
    00 75 70 48 8b 43 18 48 89 ef 48 8b 34 24 4c 89 f9 4c 89
    RSP: 0018:ffff88810d95fcf0 EFLAGS: 00010212
    RAX: dffffc0000000000 RBX: ffffffffc02bac60 RCX: 1ffff110220d5080
    RDX: 1ffffffff805758f RSI: 0000000000000004 RDI: ffffffffc02bac78
    RBP: ffff888116e98700 R08: 0000000000000001 R09: ffffed1021b2bf8f
    R10: 0000000000000003 R11: ffff888110d59d00 R12: ffff8881085a82f0
    R13: ffff8881106a8400 R14: 0000000000040000 R15: ffff88810d95fea8
    FS:  00007fadb62ba780(0000) GS:ffff8881fdc22000(0000)
    knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: fffffbfff805758f CR3: 0000000106a42001 CR4: 0000000000770ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ? __pfx_full_proxy_read+0x10/0x10
     vfs_read+0x1a0/0xc20
     ? __pfx_vfs_read+0x10/0x10
     ksys_read+0x111/0x200
     ? __pfx_ksys_read+0x10/0x10
     ? irqentry_exit+0xbe/0x820
     ? srso_alias_return_thunk+0x5/0xfbef5
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7fadb634c687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8
    fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f
    1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007ffd26510c30 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
    RAX: ffffffffffffffda RBX: 00007fadb62ba780 RCX: 00007fadb634c687
    RDX: 0000000000040000 RSI: 00007fadb6214000 RDI: 0000000000000000
    RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 00007fadb6214000
    R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000040000
     </TASK>
    Modules linked in: [last unloaded: bluetooth]
    CR2: fffffbfff805758f
    ---[ end trace 0000000000000000 ]---

Set bt_debugfs to ERR_PTR(-ENODEV) after initialization cleanup. A NULL
parent would make later built-in selftests and 6lowpan initialization
publish files at debugfs root. An error parent makes those creations
fail safely and is also rejected by existing IS_ERR_OR_NULL checks.

Fixes: 6de50f9fdb60 ("Bluetooth: Export ECDH selftest result in debugfs")
Fixes: 64dd374eac15 ("Bluetooth: Export SMP selftest result in debugfs")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v3:
- Address the NULL-parent cleanup issue raised by Sashiko:
  https://sashiko.dev/#/patchset/94464
- Store ERR_PTR(-ENODEV) after initialization cleanup so later debugfs
  creation fails safely.
- Clarify that the module-owner fix is already present in bluetooth-next.

Changes in v2:
- Address the stale bt_debugfs pointer concern raised by Sashiko:
  https://sashiko.dev/#/patchset/87920
- Clear bt_debugfs after initialization cleanup.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0188-v7-e3c91e5159902df34c8c@gmail.com
Link to v2: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0188-v10-ad807db51e45722aae62@gmail.com

Module-owner prerequisite: already merged in bluetooth-next
  https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=64aabf94ecccb1120a63b4ee5a6761871a181a41

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393d..3b8c3ecb7cc52 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -935,11 +935,11 @@ static int __init bt_init(void)
 
 	BT_INFO("Core ver %s", VERSION);
 
+	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
+
 	err = bt_selftest();
 	if (err < 0)
-		return err;
-
-	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
+		goto cleanup_debugfs;
 
 	bt_leds_init();
 
@@ -983,7 +983,9 @@ static int __init bt_init(void)
 	bt_sysfs_cleanup();
 cleanup_led:
 	bt_leds_cleanup();
+cleanup_debugfs:
 	debugfs_remove_recursive(bt_debugfs);
+	bt_debugfs = ERR_PTR(-ENODEV);
 	return err;
 }
 
