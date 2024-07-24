Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A7158211
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827103; cv=none; b=KJ1CnoSm3K4/Zm8wLoebJkAqODOOp3t0SGr8h9CALSj2Q9Ai2OCqhB8h25RX5ddBKkWMelWBfIFtMEnwWrL7WbUFgravw645YLHkxXBR7BUfzO2AGRj/LchI3TX0VLHotITVwTQYaYC4zM8GySWs01zzzj6kCqnigaspC0fGd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827103; c=relaxed/simple;
	bh=F/KOJ3mKSfeOCZQbhXBJmwffOQkcBP+ECPPdb7BJJ7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uq13Slb1Bi6ErEff4HyufNQBGoTXLRk77wr9H1gKu3FfDxKP8PIkCsAO//xF5gsF/PHTRxJ+XiGBow+cniz6pUIc/081WFzHxOZ/BRVDG+RlHsl4AbNyLL+Ojlqg+LF96UhmVkMLgKRy5jm9Twge9VdbtZ8FjrmCJ78h8VHONE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8152f0c63c4so104334839f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 06:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827101; x=1722431901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9OLYAO0oAZgU3ZQkkdEML/gOHWNdnZu6zW9bwNbKa8=;
        b=JWOrjaw7cr5oavO4JLr8SOwBfj+jHs5vVdzP3eOjL8G4fbmSwXEtTg8153WF1f89pe
         3d8mZfYQyPLPFEIgAmic1Fb1gRZjLGYjZZ6CAQw5smVqv8pKbrvnhoQubQgODqDMQxSJ
         xG4bEzeTbZavs3sMzvDY5tN6ygZi/qFotc5ro1AeCRHVHilPYnUiS/akkSKMJA1sa5Al
         hsOwMupzydEhCdUVud4AxtqtibTmSqc+BZds/TV4cmjP1fRUDbQDmm21+8h0u3OL9M9i
         67svLhW2XUFy+DH/ucZI2GVWvOE55FoGJuKPz5QsHx1mFb/8D/LJBztIbUVFLzfpZlI0
         WZLw==
X-Forwarded-Encrypted: i=1; AJvYcCWPPOC04Rf2W4kY9Z03PDgYCsw2WW0XAl9kOZR2quC44dMbXdn3/D5DUy5LlakTNcxq0blkE+gb4ydokbJPqD35Jj5sd84S7+hQ8q+PeQyC
X-Gm-Message-State: AOJu0YyxXdtyizdoxSajoaJUJ3WUq1+7STAERBMHXCDV+8V4C/b1dn2r
	5SIFo1nPepIZk0EvHWEGx6VmgyxRFcot5/hZmwuN6Nz8mxCNhPbxX2SO6KodNdOIsT4Zdt/CdQs
	W2Ru3f+n1DpLXsWZP7KFezIP14jKaffynATdIFBqTkQTeCDXGR7ZrCx4=
X-Google-Smtp-Source: AGHT+IEFttKXpBqlDhq5Hg2s0McqaO3xxn3g7bNmAxNEOOv9JvpkhmiGNGjT1kexde9AqgilxHa1uj7D/vapJukx9BLM6aO38W/q
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8625:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4c28fd69265mr94135173.3.1721827101371; Wed, 24 Jul 2024
 06:18:21 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be000d061dfe1c55@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in l2cap_sock_resume_cb
From: syzbot <syzbot+52115a16e7eac723d587@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13550ec3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4129de17851dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=52115a16e7eac723d587
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/105004175f16/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d8a81aaa129/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52115a16e7eac723d587@syzkaller.appspotmail.com

Bluetooth: hci2: ISO packet for unknown connection handle 0
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_resume_cb+0xd0/0x130 net/bluetooth/l2cap_sock.c:1697
Write of size 8 at addr 0000000000000518 by task kworker/u33:6/5222

CPU: 1 PID: 5222 Comm: kworker/u33:6 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 l2cap_sock_resume_cb+0xd0/0x130 net/bluetooth/l2cap_sock.c:1697
 l2cap_security_cfm+0x78d/0x11d0 net/bluetooth/l2cap_core.c:7354
 hci_encrypt_cfm+0x194/0x720 include/net/bluetooth/hci_core.h:2041
 hci_encrypt_change_evt+0x554/0x10f0 net/bluetooth/hci_event.c:3649
 hci_event_func net/bluetooth/hci_event.c:7445 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7497
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4029
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
