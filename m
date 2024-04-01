Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80875249E4
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998154; cv=none; b=ckrf9WAsiVo/rLzcuCuJceS9+YKCSuBRG6CcRTjPaHExcpFOqtoIIJgdwY421tNhlZGQ5FdSVjYDQZm5kDAUE9plKWU5G/AbEccADweQt3sRU9vf4Ajjr3Cl/JZucM1zZgH8m/bmdCwE2mMUW1UNQ50C8NDAvVRF0OwvNwwxsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998154; c=relaxed/simple;
	bh=9gVCugrtMVlxFl0fvxh1v0DkRcOwHPfTloU3gfeVGpE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tnget050Uqdz9cd8ezvgkN9MUSMJ65HPAHlcwHbncwYrW4t61+fDxHqxIb/rNkdZEHnvrYsPu8dguBeb9yy7QyHFF/qd2R6RnXAscNf8FG0GAaKdB0Yt5LXsfWcD9/JvXduPZTwEqvxnAvrZPWQ5wyhIjOx1vFMDKgsXRc2TI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d096c4d663so465164739f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 12:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998151; x=1712602951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kDZew4ve18Pfr/WRK0uNVQv+L79Eyyay4NBpvHc3H0=;
        b=SKx9SRYh8GNT0nyIVAJ9x0Y3IkECzJibuifOVIxxq2wPLDbr7IkG0DNCZRP6cXDhAH
         sCowfpPxmA0FZO7eipl0Y77scOPotW3Zb3Ok+ZtT7EyWOpvEh71dfDu9+he/HFNtzJ2I
         XZPtv+uhaxpLMU/lN3CxJ9/Qg0nU7b0GJdPWyqNTyV2/eGLMn7t0tnGMvoANWslWgV5Y
         fCQxAOF4dwVYBzV9on6ucCa7vYpa9nEvibNcOvjkOCQGCKMkDXykr10OgRGMVFWo2/jm
         iG6NkOIcAuLDdyYLtJ0PKKLL4WBbeD4z5LTQ/o/hMfnW2DcPa83HU1bmjvIGdBfAigzm
         Oimw==
X-Forwarded-Encrypted: i=1; AJvYcCUNbJfznfQZZlkaL73yth0IQ0LoKGJjjKBTbPPaJzs+V4jHzCMRLQW6palwwwYQAHRcCcOgSVBkprH248ep03ttriXjU7I2UEbrB9slsNUi
X-Gm-Message-State: AOJu0Yz7PgJGdCCJxJLZAf/QtQBMBVzqeSVDL41/2tulpV2xYTSyylt4
	ezczzrDh7Bk4RrnBcbmJohTyqXCM52LiPCNVWiBHsqMJSZU/W2W4DTtOBwUbLfHFDyvDK29s6ML
	iz/hwfG1mJtLgi5PLusD1qdX3d52gxQkhcRk9nz5wVmxGDYy6cUzRUO8=
X-Google-Smtp-Source: AGHT+IGPdUoeo2l8+p6J+8T0SDvD3uXH+t5qJvwMHr/CxnKGVczBxzShD1ENUG53XJAvp7t+LPn3vcoSC9dy0b3io7FCKAdWBG3z
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1641:b0:47e:c8fb:e9e7 with SMTP id
 a1-20020a056638164100b0047ec8fbe9e7mr423957jat.2.1711998151394; Mon, 01 Apr
 2024 12:02:31 -0700 (PDT)
Date: Mon, 01 Apr 2024 12:02:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab9af106150da113@google.com>
Subject: [syzbot] [bluetooth?] memory leak in corrupted (2)
From: syzbot <syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1605e039180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25b176ce9d4c8dbf
dashboard link: https://syzkaller.appspot.com/bug?extid=e1c69cadec0f1a078e3d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c59af9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/69179c757379/disk-39cd87c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/adff5d3652af/vmlinux-39cd87c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b614bf284a7d/bzImage-39cd87c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888109ffe280 (size 640):
  comm "syz-executor.0", pid 5071, jiffies 4294942273
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 01 1a 0c 01 02 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc d037fcd3):
    [<ffffffff8165cfec>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8165cfec>] slab_post_alloc_hook mm/slub.c:3802 [inline]
    [<ffffffff8165cfec>] slab_alloc_node mm/slub.c:3845 [inline]
    [<ffffffff8165cfec>] kmem_cache_alloc_node+0x28c/0x330 mm/slub.c:3888
    [<ffffffff84337006>] kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:577
    [<ffffffff8433aa85>] __alloc_skb+0xd5/0x220 net/core/skbuff.c:668
    [<ffffffff84a79b1b>] alloc_skb include/linux/skbuff.h:1313 [inline]
    [<ffffffff84a79b1b>] bt_skb_alloc include/net/bluetooth/bluetooth.h:489 [inline]
    [<ffffffff84a79b1b>] hci_prepare_cmd+0x2b/0xb0 net/bluetooth/hci_request.c:219
    [<ffffffff84a7a147>] hci_req_add_ev net/bluetooth/hci_request.c:253 [inline]
    [<ffffffff84a7a147>] hci_req_add+0x57/0xe0 net/bluetooth/hci_request.c:273
    [<ffffffff84a0c231>] hci_scan_req+0x41/0x70 net/bluetooth/hci_core.c:73
    [<ffffffff84a79550>] __hci_req_sync+0x70/0x3c0 net/bluetooth/hci_request.c:128
    [<ffffffff84a79aa7>] hci_req_sync+0x67/0xa0 net/bluetooth/hci_request.c:204
    [<ffffffff84a117d3>] hci_dev_cmd+0x3f3/0x550 net/bluetooth/hci_core.c:790
    [<ffffffff84a5436c>] hci_sock_ioctl+0x3ec/0x6f0 net/bluetooth/hci_sock.c:1153
    [<ffffffff843227d2>] sock_do_ioctl+0x82/0x1a0 net/socket.c:1222
    [<ffffffff843249fe>] sock_ioctl+0x14e/0x480 net/socket.c:1341
    [<ffffffff817356f6>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff817356f6>] __do_sys_ioctl fs/ioctl.c:904 [inline]
    [<ffffffff817356f6>] __se_sys_ioctl fs/ioctl.c:890 [inline]
    [<ffffffff817356f6>] __x64_sys_ioctl+0xf6/0x150 fs/ioctl.c:890
    [<ffffffff85089f05>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff85089f05>] do_syscall_64+0xa5/0x1e0 arch/x86/entry/common.c:83
    [<ffffffff8520012b>] entry_SYSCALL_64_after_hwframe+0x72/0x7a

BUG: memory leak
unreferenced object 0xffff88810c96b300 (size 240):
  comm "kworker/u9:1", pid 4479, jiffies 4294942273
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc b92bbddd):
    [<ffffffff8165c6c1>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8165c6c1>] slab_post_alloc_hook mm/slub.c:3802 [inline]
    [<ffffffff8165c6c1>] slab_alloc_node mm/slub.c:3845 [inline]
    [<ffffffff8165c6c1>] kmem_cache_alloc+0x271/0x310 mm/slub.c:3852
    [<ffffffff84341f6a>] skb_clone+0xaa/0x190 net/core/skbuff.c:2063
    [<ffffffff84a0cbdb>] hci_send_cmd_sync net/bluetooth/hci_core.c:4220 [inline]
    [<ffffffff84a0cbdb>] hci_cmd_work+0x1db/0x200 net/bluetooth/hci_core.c:4240
    [<ffffffff812ec200>] process_one_work+0x290/0x630 kernel/workqueue.c:3254
    [<ffffffff812ed22d>] process_scheduled_works kernel/workqueue.c:3335 [inline]
    [<ffffffff812ed22d>] worker_thread+0x2bd/0x510 kernel/workqueue.c:3416
    [<ffffffff812fb36c>] kthread+0xfc/0x140 kernel/kthread.c:388
    [<ffffffff811582b5>] ret_from_fork+0x45/0x60 arch/x86/kernel/process.c:147
    [<ffffffff81002efa>] ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243



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
