Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FA35677E
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174647; cv=none; b=BrfbdazwZKVeu7cNTzbagZkf9GEv3cLAmVLxcLtJKCjjS9AWyCuxOUDsXI+0OWiMN8bBEX9dXyKHBjHjmAQUT3yUFDCOTpcizp5B16D/Mh5+gYp0yZeZihT7lMXpVFO54eVQClXJ9BxoX788L+soy0KE+2GXbZ9JdukUpJ4gwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174647; c=relaxed/simple;
	bh=DRHa9OxqmG0hqQkN3OjoAsvq0C1PoJ5DD6C02q6PgG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CfT7magcbwmOxQZlkRR+v3pU2e29GycGemopmlkPC80T59OV+kK7oq9ro4joGM8SKfaG9ZPtBfUtHnTNBKI3e0QBSS6MK8dUkmz9O4nv39CA334XDxMzhixLmkYyeCKxWlaRnM1yLhoLQVdceZ93hQbZUXqy99TPWlnnl9RvLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69da719e003so7598260eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 13:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780174644; x=1780779444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d41PyxmaHtCW6N2ZBxhSTJMRc5koTfgrZJzQd8AhWwk=;
        b=ZQbKzyg2Zl4G/vx5jFaWcMwXIgJLh2i+zAvPsomzh8TAF3PL2Bn6rxogmR5hc4Ylhe
         VtJSbeX96K16HieAIT8TDGcVtVrlJglwc1HVwFXu4RiA6x29BDvTVT7xCKBiDqeaOnhr
         pYoNX690Ls/Ea+VifucHK0oMERI3EXRbFToQypqtiVMoPQBDSPMD6xVrN25KiR4fHndj
         rKhaUrEffcXJHkckIKhPBqU7OH0ouAKmtU8/j5tDzrt1Y4KwUZaWhRkCXkJWSPeXTabq
         lqOedlx2S1ThecHnyLxcDvhb/jsZSOv92JMcvwTWywk480gY3Gp5QSMoABcFYk2oo23r
         brcA==
X-Gm-Message-State: AOJu0YwK/Vwsi1CkbDOAEp9SEx0FWbG2LO+xjwVFY18Vj191QSom7Jvh
	fitmE+W0t0lXFHxwl+8H1yhnuHdzsTQ3rQ61mEYN/f3SkcAvA8KGPcJ6r9oyq3mAswpRQPnON2T
	XNXN3dqk1xl0Pp6eE3S+qUUKsgJGJ8UsCjjyjKaC6UGM2MWGMvOr2RWaj8uzgrA==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2018:b0:694:9252:1992 with SMTP id
 006d021491bc7-69e102af1c9mr2310903eaf.0.1780174643704; Sat, 30 May 2026
 13:57:23 -0700 (PDT)
Date: Sat, 30 May 2026 13:57:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1b4f33.fbc46276.d3ed.045a.GAE@google.com>
Subject: [syzbot] [bluetooth?] memory leak in init_srcu_struct_fields
From: syzbot <syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f377d0025eb0 Merge tag 'sh-for-v7.1-tag2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1737bb48580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9645c21cfd1d3e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=535ecc844591e50588a5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164ed748580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e6576c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5d8163677f58/disk-f377d002.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf2fcdb8200b/vmlinux-f377d002.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9fb70799318/bzImage-f377d002.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888111f49600 (size 512):
  comm "syz.0.17", pid 5937, jiffies 4294945495
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 6e7d3fde):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __kmalloc_cache_noprof+0x371/0x480 mm/slub.c:5414
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    init_srcu_struct_fields+0x2c0/0x350 kernel/rcu/srcutree.c:207
    hci_alloc_dev_priv+0x37/0x680 net/bluetooth/hci_core.c:2453
    hci_alloc_dev include/net/bluetooth/hci_core.h:1763 [inline]
    hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:644 [inline]
    hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:720 [inline]
    hci_uart_tty_ioctl+0x173/0x460 drivers/bluetooth/hci_ldisc.c:774
    tty_ioctl+0xaca/0xd60 drivers/tty/tty_io.c:2801
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object (percpu) 0x607e4d93d800 (size 384):
  comm "syz.0.17", pid 5937, jiffies 4294945495
  hex dump (first 32 bytes on cpu 0):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 593bdea7):
    pcpu_alloc_noprof+0x7c7/0xed0 mm/percpu.c:1896
    init_srcu_struct_fields+0x2eb/0x350 kernel/rcu/srcutree.c:224
    hci_alloc_dev_priv+0x37/0x680 net/bluetooth/hci_core.c:2453
    hci_alloc_dev include/net/bluetooth/hci_core.h:1763 [inline]
    hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:644 [inline]
    hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:720 [inline]
    hci_uart_tty_ioctl+0x173/0x460 drivers/bluetooth/hci_ldisc.c:774
    tty_ioctl+0xaca/0xd60 drivers/tty/tty_io.c:2801
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object (percpu) 0x607e4d93d980 (size 384):
  comm "syz.0.18", pid 5940, jiffies 4294945497
  hex dump (first 32 bytes on cpu 0):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 593bdea7):
    pcpu_alloc_noprof+0x7c7/0xed0 mm/percpu.c:1896
    init_srcu_struct_fields+0x2eb/0x350 kernel/rcu/srcutree.c:224
    hci_alloc_dev_priv+0x37/0x680 net/bluetooth/hci_core.c:2453
    hci_alloc_dev include/net/bluetooth/hci_core.h:1763 [inline]
    hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:644 [inline]
    hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:720 [inline]
    hci_uart_tty_ioctl+0x173/0x460 drivers/bluetooth/hci_ldisc.c:774
    tty_ioctl+0xaca/0xd60 drivers/tty/tty_io.c:2801
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88811d010a00 (size 512):
  comm "syz.0.19", pid 5951, jiffies 4294945502
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 2d3d1dd8):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __kmalloc_cache_noprof+0x371/0x480 mm/slub.c:5414
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    init_srcu_struct_fields+0x2c0/0x350 kernel/rcu/srcutree.c:207
    hci_alloc_dev_priv+0x37/0x680 net/bluetooth/hci_core.c:2453
    hci_alloc_dev include/net/bluetooth/hci_core.h:1763 [inline]
    hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:644 [inline]
    hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:720 [inline]
    hci_uart_tty_ioctl+0x173/0x460 drivers/bluetooth/hci_ldisc.c:774
    tty_ioctl+0xaca/0xd60 drivers/tty/tty_io.c:2801
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object (percpu) 0x607e4d93db00 (size 384):
  comm "syz.0.19", pid 5951, jiffies 4294945502
  hex dump (first 32 bytes on cpu 0):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 593bdea7):
    pcpu_alloc_noprof+0x7c7/0xed0 mm/percpu.c:1896
    init_srcu_struct_fields+0x2eb/0x350 kernel/rcu/srcutree.c:224
    hci_alloc_dev_priv+0x37/0x680 net/bluetooth/hci_core.c:2453
    hci_alloc_dev include/net/bluetooth/hci_core.h:1763 [inline]
    hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:644 [inline]
    hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:720 [inline]
    hci_uart_tty_ioctl+0x173/0x460 drivers/bluetooth/hci_ldisc.c:774
    tty_ioctl+0xaca/0xd60 drivers/tty/tty_io.c:2801
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:597 [inline]
    __se_sys_ioctl fs/ioctl.c:583 [inline]
    __x64_sys_ioctl+0xf4/0x140 fs/ioctl.c:583
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
