Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBA396D2E
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807270; cv=none; b=AbGTT7Vd360rX0861qPqHUWrqVWgEPrqfaQfMvFUc6qqNu9gUaGNOn8GGQxNU/hmwio8cvkCIplcH2Nf+Qr1pRX6HvN1bkbmjLn4pbqti9inB6f/LRvqhljKN/KTMImBilhGb2YvNf+hXM/7LigWJBJavvTPSXDeFmnvXlOKpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807270; c=relaxed/simple;
	bh=T8p9x7YcHH4RBi5k9EYCafGeHl5JeFf5qbbqC19P2CE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u4RZJx9hfidOsnkghoohlg6uvrAHlB305JoyArMNYIAj0dlWpKajqQVnc8vhzcNI0rMKIjgEmQ8jTjgLBgjO1ENj1JXnMpajwaaGHlJqQMukFtJrE2eSz0ho4KTSMMx6jEYqTRqmoP8ouTe4kNXDZRUID1jEX9qc3p+AxHXb65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65b153371efso2074772eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 09:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807268; x=1768412068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXJ9WC2NmU9YEErBDW4d1c4BSngY0akKh966eavx5Fk=;
        b=qqqC8Fk9UIPTDjT5yynDpUsxbQcWYUt+ug0IkDaAsC6itQs/pVZNp2Ubhxu0yzElvF
         6hI6WfmAHqPdPnY4rJU+orUZbz+IIHguWe1iVNQbAq0WRfy5rOGygzFsXEsykTEG8mAL
         +S/tmqzyhZ0pNH6DV0odMoR3HwyABF/DP8o6f9MZbufTVMTo7a79c3D9JdH3t1jcPNMO
         Rm0EY3Mndu2rw0jDf5OUh27564vb/oGg97JRF61DMUivCRUS7TEIEDejG044XvxWou8M
         gLDPuHfhWAYOX+dmLZOf38zSDi98Jg2BCqsgHJdI4FMUtHydBOPzLGEd+Lj5rHbPSvMZ
         QV2A==
X-Forwarded-Encrypted: i=1; AJvYcCWsRrWjZBBRy/PG1Nd5RTWEUN0G57Ar+vwSsX5thnSbjUh7v7ERwWdp617sKI0RKtBVhsEXLiPuaLC+3y5ujSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSjL8878Sfhh8jiueAUgLtzA4ZTuoHhoCwZ9urV7nw2fM+H0S
	r2g3osM25pUU8l9Hk5IojH432iY5RLH7f9mUwxHjg1I2iGvR5zBGfgoFGHKynJcUZABBL51g5Gg
	u1MmUL1dCwckIOaAU0kDBUWOq/HmwtsDUyZdxRh4hmIuJBRcC4uFxf+hfka0=
X-Google-Smtp-Source: AGHT+IH4AnecHwe1eU+seiZT8AASstncmzFKC7GVs7sp+BqLT+rUYXqD/TFtAndib/yxC1B/VhUmEO2OoS2WpKMEmKAy6Syz4FVi
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e645:0:b0:65b:299f:8947 with SMTP id
 006d021491bc7-65f481e96e9mr3009818eaf.14.1767807267978; Wed, 07 Jan 2026
 09:34:27 -0800 (PST)
Date: Wed, 07 Jan 2026 09:34:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e9923.050a0220.1c677c.0370.GAE@google.com>
Subject: [syzbot] [batman?] [bluetooth?] memory leak in skb_clone (3)
From: syzbot <syzbot+6e76aa21aaf2d8be6034@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	marek.lindner@mailbox.org, netdev@vger.kernel.org, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a26e7032d7d Merge tag 'core-bugs-2025-12-01' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116a9512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf343972ee89096
dashboard link: https://syzkaller.appspot.com/bug?extid=6e76aa21aaf2d8be6034
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179be192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cd92b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f4ff8b7d65f/disk-4a26e703.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2fbb585ef1ac/vmlinux-4a26e703.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfdc58db78d3/bzImage-4a26e703.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e76aa21aaf2d8be6034@syzkaller.appspotmail.com

2025/12/03 00:25:54 executed programs: 5
BUG: memory leak
unreferenced object 0xffff88811a1e1100 (size 240):
  comm "kworker/u9:0", pid 51, jiffies 4294944590
  hex dump (first 32 bytes):
    90 50 50 42 81 88 ff ff 90 50 50 42 81 88 ff ff  .PPB.....PPB....
    00 00 00 00 00 00 00 00 00 50 50 42 81 88 ff ff  .........PPB....
  backtrace (crc eed28d2d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    skb_clone+0xae/0x2b0 net/core/skbuff.c:2050
    __skb_tstamp_tx+0x3a0/0x4c0 net/core/skbuff.c:5636
    hci_conn_tx_queue+0x11c/0x1d0 net/bluetooth/hci_conn.c:3026
    hci_send_conn_frame net/bluetooth/hci_core.c:3086 [inline]
    hci_sched_acl_pkt net/bluetooth/hci_core.c:3701 [inline]
    hci_sched_acl net/bluetooth/hci_core.c:3726 [inline]
    hci_tx_work+0x437/0x570 net/bluetooth/hci_core.c:3820
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x2af/0x2e0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

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
