Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6BD280
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Nov 2023 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3CE1710
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 23:31:25 -0800 (PST)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3b2ef9a0756so9564049b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 23:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699428685; x=1700033485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuwi9LoRNPTnGg3HnHKZq0zKA0LoMB0CPtFduQXuLnQ=;
        b=oIbzL1/Nu+IJBaobbl3EsqSm7YaE8yVVVADC6UX7neQoNsNi2Av+IUEZ3MG3JjV4Eu
         9C/oFuQBSXYLmVQgA4JDogpkCIf1UT1DbbCIXhPMj891COBT9D2h/Fr6yFfn67PSUBty
         MXu2oFA3wAXACfg7a/pIbPfP/Txn0Anum2VI9/wsgxIJVKsoeJfFTLQx23QKWEYQXi+z
         HFjDo3KlpdzcJ4qaJpKBARMJW6k6yxdL09QaX+kTXD6a/FlY7ujsiCHJ2cMBH5zkuWyT
         GdGEv5W7OcBLnsQNwUK7+TEurcww1LUn5FWHIlr9UcFGkMUZTq6JP1rYjnloqW3G0i1F
         Y0zA==
X-Gm-Message-State: AOJu0Yw7abpqGmACgftZIFJijpykH3ANQWOTSBLxqILSUtZAZxySNnDM
	IEBWineKJa4J6RPM5eo2FM37SkQDiG9IJpea1Wj82NO4vwcF
X-Google-Smtp-Source: AGHT+IEJ7qbPqNyyendRvdsmZ95KHEi3UZN3+kxGz3GzpP7lUukkN3OUzXgY++/jrVX5SVi81Vr7omj7zSTjrlo8DLlTUWltytTS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:21a2:b0:3a9:b964:820e with SMTP id
 be34-20020a05680821a200b003a9b964820emr592188oib.3.1699428685033; Tue, 07 Nov
 2023 23:31:25 -0800 (PST)
Date: Tue, 07 Nov 2023 23:31:24 -0800
In-Reply-To: <00000000000057faf606067f1f32@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017b74d06099f1375@google.com>
Subject: Re: [syzbot] [bluetooth?] memory leak in prepare_creds (4)
From: syzbot <syzbot+2a478080bd86d36bb5ea@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10740c7b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecfdf78a410c834
dashboard link: https://syzkaller.appspot.com/bug?extid=2a478080bd86d36bb5ea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d8fd7f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107b137f680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bb27a01f17c/disk-13d88ac5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb496feed171/vmlinux-13d88ac5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4da22719ffa/bzImage-13d88ac5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a478080bd86d36bb5ea@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.113' (ED25519) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888107c20600 (size 192):
  comm "syz-executor418", pid 5027, jiffies 4294942544 (age 13.100s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81630798>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81630798>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81630798>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81630798>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81630798>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81630798>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff812e0d5b>] prepare_creds+0x2b/0x4e0 kernel/cred.c:269
    [<ffffffff812e17c4>] copy_creds+0x44/0x280 kernel/cred.c:373
    [<ffffffff812927ba>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
    [<ffffffff8129487b>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
    [<ffffffff81294e6c>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888107470a80 (size 16):
  comm "syz-executor418", pid 5027, jiffies 4294942544 (age 13.100s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 c3 87 00 81 88 ff ff  ................
  backtrace:
    [<ffffffff8163331d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163331d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163331d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163331d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157e81b>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157e81b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1020
    [<ffffffff82364631>] kmalloc include/linux/slab.h:604 [inline]
    [<ffffffff82364631>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82364631>] lsm_cred_alloc security/security.c:577 [inline]
    [<ffffffff82364631>] security_prepare_creds+0x121/0x140 security/security.c:2950
    [<ffffffff812e1059>] prepare_creds+0x329/0x4e0 kernel/cred.c:300
    [<ffffffff812e17c4>] copy_creds+0x44/0x280 kernel/cred.c:373
    [<ffffffff812927ba>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
    [<ffffffff8129487b>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
    [<ffffffff81294e6c>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
    [<ffffffff84b67d8f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b67d8f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
