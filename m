Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CE1C5D61
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738440442; cv=none; b=Z7XaU43KzE/Do+fQZZoVFTxw4GbmazRhDQ02wrLbZgeaTjUEfqUpLaY14heP+FHlacyq94wplwA+BSrKSE39i9Jo3x1G3sezDMWVD3MnI/cwnEkzi7329ObQq5Pz/WMu5WXKX5wy0vFOvPtRa4mjZNLqdIyKSp+Czza6FPl0rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738440442; c=relaxed/simple;
	bh=0TWQkdmSLts7OZYB8JmVvACAKQ+qwoQ5FA1jyXORT7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R+WpmXvFf693ekOfaj7AG4hgm1zGni2akuFFMgTCpKnRkct31ecpQcYTtlzCXUWZ03/2mSt+G+BF+NqwMUfLg8Rgdpp1Q2xMwvVuZyPKECci7iwvOLem365aFBESdhEWu3qapsvDxvYkLnIIw+k73uISD2vILKTdACaZurC8Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d0225c44e8so13590815ab.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 12:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738440440; x=1739045240;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmunsVXpgq26h1vcA+xik7F3qdt3ISWM15Sf3kvt1f0=;
        b=dQor1V9yN33mcYFpGyEXfMItV5/T5WxYxMLFgjVjhDXkaWEgFxzGjiR8tDKoG7l808
         0tc7nHRF1R1J4B8MtssLX1acnAA/xS1U/BA3p01qoHhIaRKYjctq2FYsPXKfr5DlsOTK
         7bg612+IOm2sr4KEIPYC11MLDKh2Q/AG53YwrrFAfFDNlQ/C6JXZ44WT3uSK43q+eVHc
         QaQo/agEn30hDwNTSQjmKkuPYPjljjxozaa9v2fYOOAJQMtTS/h+1xVF0mqzV9+G4IYB
         DrchMFO4RLBX1aE0WZp3vZId35+yJ36k7rSj6YoWlcP4tJrPUVQR7I+S7xmQn+gfaxcT
         psRA==
X-Forwarded-Encrypted: i=1; AJvYcCWu8rUnJohBSq4Lk61S8a2GG+aFZbyBdMOahT+SwRAHJeiYxptFDh5zMevJl0wru394ZSkS8of3l0LO6F58ytQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nTIxFBjX2slzTW3vi049+cOy91ozSizGXd1VZEH83Yv7vVXM
	2ScJD6WkTg3JPl59eZlbJIUMVZ9eW3Npuzc3RAMpMaKAjMCgHrI02HafcGnhG2SrxEfHd6xE9Hd
	EFSLjAhJPjuqs44cOdIZSLU0egH11enUsW5yLQjgmd5WJH4td9W6YRLI=
X-Google-Smtp-Source: AGHT+IF7ValMb/YQnPFC8c1mTsjjphh3LXyWkH/IfsyRS5BUpAD6U2I7bt5tY/abemBu7WFEWzb0gU9jHrL6C7+h6Dv0w9YcJ4oK
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d01fc4f0bemr39594995ab.15.1738440440105; Sat, 01 Feb 2025
 12:07:20 -0800 (PST)
Date: Sat, 01 Feb 2025 12:07:20 -0800
In-Reply-To: <6770d05c.050a0220.2f3838.04a0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679e7ef8.050a0220.163cdc.0025.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in full_proxy_write
From: syzbot <syzbot+422b07c3add2219bc947@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    60c828cf80c0 Merge tag 'for-linus-hexagon-6.14-rc1' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=147d55f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e51aa3d0038bbe1
dashboard link: https://syzkaller.appspot.com/bug?extid=422b07c3add2219bc947
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16decb24580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133f8eb0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/409123921db5/disk-60c828cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a0ca4f206436/vmlinux-60c828cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/643b9310a68b/bzImage-60c828cf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+422b07c3add2219bc947@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in full_proxy_write+0x101/0x3f0 fs/debugfs/file.c:394
 full_proxy_write+0x101/0x3f0 fs/debugfs/file.c:394
 vfs_write+0x48a/0x1540 fs/read_write.c:677
 ksys_write+0x240/0x4b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:739
 x64_sys_call+0x3161/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __debugfs_file_get+0xe59/0xef0 fs/debugfs/file.c:120
 full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
 do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
 vfs_open+0x53/0x5b0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x56a1/0x6250 fs/namei.c:3989
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __debugfs_file_get+0xdff/0xef0 fs/debugfs/file.c:118
 full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
 do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
 vfs_open+0x53/0x5b0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x56a1/0x6250 fs/namei.c:3989
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 __debugfs_file_get+0x31d/0xef0 fs/debugfs/file.c:101
 full_proxy_open_regular+0x67/0xa00 fs/debugfs/file.c:447
 do_dentry_open+0x1bdd/0x26b0 fs/open.c:955
 vfs_open+0x53/0x5b0 fs/open.c:1085
 do_open fs/namei.c:3830 [inline]
 path_openat+0x56a1/0x6250 fs/namei.c:3989
 do_filp_open+0x268/0x600 fs/namei.c:4016
 do_sys_openat2+0x1bf/0x2f0 fs/open.c:1427
 do_sys_open fs/open.c:1442 [inline]
 __do_sys_openat fs/open.c:1458 [inline]
 __se_sys_openat fs/open.c:1453 [inline]
 __x64_sys_openat+0x2a1/0x310 fs/open.c:1453
 x64_sys_call+0x36f5/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5782 Comm: syz-executor269 Not tainted 6.13.0-syzkaller-09950-g60c828cf80c0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
