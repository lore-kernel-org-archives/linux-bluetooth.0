Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599C282F17
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768986; cv=none; b=lecRBwP2czGoHa9tJEDf3Vam8h2jTAEy95Jx7lE8k5YdFjfl8KtAYjbGZzb1tlv6T8wgdwTmgc2A+3qXsJgEou0BUtImpZlDcK9PbOrRhp149HtdhPAY4ypdGdniztMsHxKZW+4LIhPLLSusDMcZo20JoORdWpeNipM+RFSHdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768986; c=relaxed/simple;
	bh=SjndRYxvKlucuzhSl/Et9RXRsD3s7qzpoy66zb9VckU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tX9dLITi9rRpkf8ntNbbLdWD3SlSFmx4yNNE6vUBYOLuKF2HsPKY0z+2WgWHgiBa9SFUlCzjqLIFMAnwVfxpXbF9kwIjgomExeMY4RaTcHgPejknnmNVptRfnop55sbDcZqSssnN0RlaW9uDdVtUbPwqvcPvjy2x2HClpDHlKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9iQxT8t; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9iQxT8t"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1617692a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 18:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791768984; x=1792373784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=58RvUtIJXJi9ud+t74OJxLmHyx0690fk445lrk/OQuw=;
        b=i9iQxT8t4c6E2M0IpcyJTJVotVbuboF0NBeSuPQZHm1bY6pP0BnACE86hwBpFnWsdd
         zeoCrrvGXb/+tsFJCM/4iU8Xq5FRXclWJ2BM1huzfSN1sf/yVZVC1HamotT8CupKEynx
         Whbz/ULfPupSFhBtE0B4KUzbDxUEgB78miEipdmKJFYyauALl4qHMYRC2XawUAqvDr/L
         FX5cPKKIdTIXg5bi0LToShDcXGWV7juCgetiKCUoiLPBhsASx4DTwsh0JQT/TNRuOmUn
         n7SQot9PtJDQbwSoSlhtWXvLkZ3Ce2CS1ewEE38RfzRNpaaA5AXbkMbd0DLY/tlR7ZUV
         WD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791768984; x=1792373784;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=58RvUtIJXJi9ud+t74OJxLmHyx0690fk445lrk/OQuw=;
        b=aKG/+uUDW0WXd/c2WYoYiN95F4k6BcV35+s5VSXLwYb3+teiXxE7BGCNt5HPm+ClWH
         OZZweH7AC1vqpbKhQ+jmI5afUXmFb83D+4wygAfLAYOSzRXm6LwFRGjwYbxDL+tzSv+u
         eq69rhw/vxl+IGhrCe/EVg7t5BLRkxDtkwMvAMoIfeN4U6FMQQE37RWXoQGWASLwZN0q
         yZ5+5BV52Jx70UE1EtmtSTRaRf6Yo0PYrMOOS9RnkQZPC/unu5FEQ3dUtBm7Eajtzjdr
         v3BxpZE5v0Vqm9iJfFyhxQjLdid5CC4RLVEv7370V1mVomS+3ofvgdZOivLLEjp6Hln3
         hi3g==
X-Gm-Message-State: AFq9FYKlYXAM69u53mXnsNWOmROz/QtSDldic7uHepKM7ZxllwvavnAu
	p+bDP8eeKQbF9kVrI/7Klj3qPusniwDTQ18rr3PIAx6fAB7szpyO6B0X
X-Gm-Gg: AYBFou2/Qx8i5p7Yyhu4m8GCjZyZptO+YygdpUkRLeA9vfCTG+Lp2dLvRWaeBIsd3pG
	p6mm4L6RB4OYrbNAWLDhczOJUWzFMcg1gt4W8gCDvXF1tpvVbb5sSqIuotyZ9aTD0kpt6Fg5iw9
	1oZjILQhY8PwEM/O1H0Z6Lsi+UX4Tw6TUktnwrteEeGmEkvl64JAZLCANxd9xaaFcQKgCScJEy8
	Oo8pdF/hDOOKSruE33ufVOlVYybgypHnrTsTduQ+MNX88JMEkQ0hYoVGjrYrEovD3FI+RbaT+DH
	G5SxcEbHAGf0giEI44VbfGGpsUjCIdbZIiioj92V0iJGIq2XFKfP82GHUUT4ntDW12rBFKMmrPD
	nDBdypZRSY3kwRCMzN3rWGrFfTx+Kq9MmCaQD6Z9vU+8VN1ytxGD2ULmsPsXLJwUdfk2vFdsbag
	9BLnuQyUjMrwLeFJ7D3eUiNlU7WtVt8iYDho8lnXZnjZogrZr8uP1sHI4qxnTweYhgvA==
X-Received: by 2002:a17:90a:d44d:b0:3a2:bb9f:f87d with SMTP id 98e67ed59e1d1-3ab3a9f2d87mr4714779a91.21.1791768983998;
        Sun, 11 Oct 2026 18:36:23 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0332sm15201192a91.3.2026.10.11.18.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 18:36:23 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: Create debugfs directory before running selftests
Date: Mon, 12 Oct 2026 09:36:18 +0800
Message-Id: <pm-bluetooth-objects-candidate-0188-v7-e3c91e5159902df34c8c@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Selftest debugfs files must be removed before the module storage
containing their file operations is freed. With CONFIG_BT=m, bt_init()
calls bt_selftest() before creating bt_debugfs. test_ecdh() and
run_selftests() therefore pass a NULL parent to debugfs_create_file(),
publishing selftest_ecdh and selftest_smp at debugfs root. bt_exit()
removes only the bluetooth directory, leaving these files behind.

Both file operations tables have a module owner, so an open descriptor
prevents normal unload. However, with debugfs and either selftest enabled,
unloading Bluetooth without any open descriptors leaves the root entries
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

Fixes: 6de50f9fdb60 ("Bluetooth: Export ECDH selftest result in debugfs")
Fixes: 64dd374eac15 ("Bluetooth: Export SMP selftest result in debugfs")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393dd493de4250332aaadc6d94ddd3a..30354cf6565fc62eb76f1952b965f2aab9f08fd6 100644
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
 
@@ -983,6 +983,7 @@ static int __init bt_init(void)
 	bt_sysfs_cleanup();
 cleanup_led:
 	bt_leds_cleanup();
+cleanup_debugfs:
 	debugfs_remove_recursive(bt_debugfs);
 	return err;
 }
