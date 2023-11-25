Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D53CB5
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Nov 2023 05:18:23 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cfa28ab0f3so19155115ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Nov 2023 05:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700918302; x=1701523102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3woomzQ8vmDo/vvebKLz9E6d9x/Edw/g418bVAMqXbQ=;
        b=bauyfB88yFr4xsgP6xjFJYlbgLUmePREPZ678mbvAhYd7/p+5SH7dFzn8xb+gaO4hd
         vAHBi67EV4n8WZuMwhIuJ5jrXjmIHs0vwG06QbZHUMHr7xc6pbjhHc/VcLhqX1gndVO6
         1T+7N+rLs6+Hy/UehJlFkPvGM3qcVA0atFgbXKICKkOj4OHx1yxhvLVx0EPOwO0Wljbl
         KTTAKJwrR2cvd6Zhhanb0w6ELOpF+EKMM7Icyp++K52Zp4GTOt0bhGnFIvHmqMwOlChe
         nBDcHe/9cXfpPa1t7sAFHZzxdzIzIMmlB8GJzDTy5y8LqAABSWa959XN4MZhOjFz4ge/
         2psQ==
X-Gm-Message-State: AOJu0Ywx2kYbGWUspgi5D4FJVXGrrUkCCZW9IfbgGmjFmYCFg+Ujf/X4
	dHvB7o0UkGnF6X4LSHE7db9Vi/mgsXSYxP7hf7bPOmcuo20B
X-Google-Smtp-Source: AGHT+IG8LZ7k7h+8r2sG0mhVtEMSGx26qqRGimpLrgciIkMVT0yRqeyoHVRYL0fHjfDmYGHgOqgl4c7zJjP9ZuMDMq8646rx92ye
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:2308:b0:1cf:75b0:42fc with SMTP id
 d8-20020a170903230800b001cf75b042fcmr1356608plh.4.1700918302598; Sat, 25 Nov
 2023 05:18:22 -0800 (PST)
Date: Sat, 25 Nov 2023 05:18:22 -0800
In-Reply-To: <000000000000a135c0060a2260b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037f0f3060af9e763@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1678a3cce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d54c08e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160ef1a4e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com

Bluetooth: hci0: hardware error 0x00
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
Read of size 8 at addr 0000000000000078 by task kworker/u5:1/4455

CPU: 1 PID: 4455 Comm: kworker/u5:1 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: hci0 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xd9/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:182 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:188
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 ida_free+0x218/0x2e0 lib/idr.c:511
 hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
 hci_conn_del+0x78c/0xe10 net/bluetooth/hci_conn.c:1183
 hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2643
 hci_dev_close_sync+0x5a7/0x1160 net/bluetooth/hci_sync.c:5021
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
 hci_error_reset+0xa6/0x190 net/bluetooth/hci_core.c:1059
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
